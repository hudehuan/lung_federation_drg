package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.SjsbFormStepCheckListService;
import com.dldata.drgs.utils.CreatePDF;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/11/3.
 */
@Controller
@RequestMapping(value = "/CustomFromPrint")
public class CustomFromPrintController {

    @Autowired
    private CustomFormService customFormService;

    @Autowired
    private SjsbFormStepCheckListService sjsbFormStepCheckListService;

    @RequestMapping(value = "/toPDF")
    public String toPDF(String dataId,String formData,String formID,
                        HttpServletRequest request,HttpServletResponse response)throws IOException {

        String result="";
        //当前服务器地址
        String clienturl = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort();

        String filepath=request.getSession().getServletContext().getRealPath("CUSTOMFORM");
        String exepath=request.getSession().getServletContext().getRealPath("static/phantomjs-2.1.1-windows/bin");

//        SysMenuEntity menuEntity = new SysMenuEntity();
//        menuEntity = sysMenuService.fineMenuEntityByCode(menuCode);

//        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = sjsbFormStepCheckListService.getCheckFormByDataID(id);
        CustomFormEntity customFormByFormId = customFormService.getCustomFormByFormId(formID);


        //当前页面打印地址
        String printUrl = clienturl +"/V_CustomFormPrint/toPrint";
        printUrl = printUrl +"?id="+dataId;


        String exeDir=exepath + "/phantomjs.exe ";
        String jsDir=exepath + "/snap.js ";


        String name = StringUtil.getPinYinHeadChar(customFormByFormId.getName());
        // 用当前单病种页面名称命名
        name += "-"+ UUID.randomUUID().toString();

        String htmlName = filepath + "/" + name + ".html";
        String pdfName = filepath + "/" + name + ".pdf";

        String htmlUrl = clienturl + "/CUSTOMFORM/" + name + ".html ";
        String pdfUrl = clienturl + "/CUSTOMFORM/" + name + ".pdf";

        try {
            if(formData!=null&&!formData.equals("")){
//                formData = formData.replaceAll("/static/",clienturl+"/static/");
//                formData = "<html><head><title></title></head>" +
//                        "<body><div><img src=\""+body+"\" style=\"width: 99%; height= 100%;\"></div></body></html>";
//                formData = "<!DOCTYPE html><html>"+body+"</html>";
//                writeHTML(formData, htmlName);
                CreatePDF.createPDFMethodbody(printUrl, htmlName , formData);
            }else{
                CreatePDF.createPDFMethod(printUrl, htmlName);
            }

        }
        catch (IOException ex){
            System.out.println(ex.getMessage());
        }

        //new Thread().run();
        try {
            String command = "cmd.exe /c start /b  " + exeDir + jsDir + htmlUrl + pdfName;// D:\\print.pdf";
            Process child = Runtime.getRuntime().exec(command);

            try{
                child.waitFor();
                int i = child.exitValue();
                if (i == 0) {
                    System.out.println("执行完成.") ;
                    while (!exists(pdfUrl)){
                        Thread.sleep(500);
                    }
                    result = "{\"success\":true,\"pdfurl\":\""+pdfUrl+"\"}";
                } else {
                    System.out.println("执行失败.") ;
                    result = "{\"success\":false,\"msg\":\"打印错误！\"}";
                }
            }
            catch (Exception eee){
                System.out.println(eee.getMessage());
            }

        } catch (IOException e) {
            System.out.println(e.getMessage());
            String s = e.getMessage();
        }

        StringUtil.writeToWeb(result, "html", response);
        return null;
    }

    static boolean exists(String URLName) {

        try {

            //设置此类是否应该自动执行 HTTP 重定向（响应代码为 3xx 的请求）。
            HttpURLConnection.setFollowRedirects(false);
            //到 URL 所引用的远程对象的连接
            HttpURLConnection con = (HttpURLConnection) new URL(URLName)
                    .openConnection();

           /* 设置 URL 请求的方法， GET POST HEAD OPTIONS PUT DELETE TRACE 以上方法之一是合法的，具体取决于协议的限制。*/
            con.setRequestMethod("HEAD");
            //从 HTTP 响应消息获取状态码
            return (con.getResponseCode() == HttpURLConnection.HTTP_OK);

        } catch (Exception e) {

            e.printStackTrace();

            return false;

        }

    }
    private static void writeHTML(String contents,String path) {
        try  {
            path=new File(path).toURI().toURL().toString();
            FileOutputStream fos  =   new  FileOutputStream(path.substring(path.indexOf("/")));
            OutputStreamWriter osw  =   new  OutputStreamWriter(fos,  "UTF-8" );
            osw.write(contents);
            osw.flush();
            osw.close();
            fos.close();
        }  catch  (Exception e) {
            e.printStackTrace();
        }
    }

}
