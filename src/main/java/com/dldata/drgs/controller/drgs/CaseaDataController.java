package com.dldata.drgs.controller.drgs;

import com.alibaba.fastjson.JSON;
import com.dldata.base.utils.FileUtils;
import com.dldata.base.utils.MD5Util;
import com.dldata.base.utils.security.AesUtil;
import com.dldata.drgs.entity.DicJgdmTzEntity;
import com.dldata.drgs.entity.SysRoleJgdmEntity;
import com.dldata.drgs.entity.SysUserInfoPtEntity;
import com.dldata.drgs.service.System.SysRoleJgdmService;
import com.dldata.drgs.service.System.SysUserInfoPtService;
import com.dldata.drgs.service.drgsDicData.DicJgdmTzService;
import com.dldata.drgs.utils.AESOperator;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 吴岳峰 on 2017/09/13.
 */
@Controller
@RequestMapping("/CaseaData")
public class CaseaDataController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SysUserInfoPtService sysUserInfoPtService;
    @Autowired
    private SysRoleJgdmService sysRoleJgdmService;
    @Autowired
    private DicJgdmTzService dicJgdmTzService;

    @RequestMapping("/postJsonPData")
    public void postJsonPData( String url,String param,String fName,
                               @CookieValue(value = "userid",defaultValue = "")String userid,
                               @CookieValue(value = "syscode",defaultValue = "")String syscode,
                               HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        String jsonpData = "";
        List<SysRoleJgdmEntity> sysRoleJgdmEntities = sysRoleJgdmService.findJgdmByUseridRole(userid);

        DicJgdmTzEntity dicJgdmTzEntity = dicJgdmTzService.findJgdmByUseridRole(userid).get(0);
        if(sysRoleJgdmEntities.size()>1||dicJgdmTzEntity.getRandPass()==null||dicJgdmTzEntity.getRandPass().length()!=6){
            result = "{\"success\":false,\"msg\":\"权限不足，无法下载数据,请联系管理员！\"}";
            StringUtil.writeToWeb(result, "html", response);
            return;
        }

        BufferedReader in = null;
        PrintWriter printOut =null;
        try {
            URL realUrl = new URL(url+"?"+param);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("Content-Type","application/json;charset=UTF-8");//**注意点1**，需要此格式，后边这个字符集可以不设置
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            printOut = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
//            printOut.print(param);
            // flush输出流的缓冲
            printOut.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    conn.getInputStream(),"utf-8"));
            String line;
            while ((line = in.readLine()) != null) {
                jsonpData += line;
            }

//            jsonpData= jsonpData.substring(1,jsonpData.length()-1);
            Map<String,String> map = new HashMap<String,String>();
            JSONObject jsonStr = JSONObject.fromObject(jsonpData);
            JSONObject rowArray = JSONObject.fromObject(jsonStr.get("rows"));
            map.put("jsonP",rowArray.get("row").toString());
            map.put("date",fName);

//            AESOperator.setsKey("dlong"+dicJgdmTzEntity.getRandPass()+"gnold");
            JSONObject jsonObject = JSONObject.fromObject(map);
            final ByteArrayOutputStream byteArrayOutputStreamDest = new ByteArrayOutputStream();
            final String md5Encoder = MD5Util.MD5Encoder("dlong"+dicJgdmTzEntity.getRandPass()+"gnold");
            String password=md5Encoder.toLowerCase().substring(0,16);
            String ivKey=md5Encoder.toLowerCase().substring(16);
            byte[] bytes = jsonObject.toString().getBytes("UTF-8");
            AesUtil.getInstance(password,ivKey).encode(new ByteArrayInputStream(bytes), byteArrayOutputStreamDest);
//            String aesJsonpData = AESOperator.encrypt(jsonObject.toString());    //AES 加密

            /* 写入dat文件 */
            // 相对路径，如果没有则要建立一个新的output。txt文件
            String filepath = request.getSession().getServletContext().getRealPath("");
            File fileUrl = new File(filepath + "\\" + fName + ".dat");
            fileUrl.createNewFile(); // 创建新文件
//            BufferedWriter out = new BufferedWriter(new FileWriter(fileUrl));
            FileUtils.writeByteArrayToFile(fileUrl,byteArrayOutputStreamDest.toByteArray(),false);
//            out.write(new String(byteArrayOutputStreamDest.toByteArray(),"UTF-8")); // \r\n即为换行
//            out.flush(); // 把缓存区内容压入文件
//            out.close(); // 关闭文件

//            BufferedInputStream bis = null;
//            BufferedOutputStream bos = null;
//            try {
              /*  String fileName = fileUrl.getName();
                response.setContentType("application/octet-stream");
                response.setCharacterEncoding("UTF-8");
                response.setHeader("Content-disposition", "attachment; filename=" + fileName);

                response.setContentLength((int) fileUrl.length());

                bis = new BufferedInputStream(new FileInputStream(fileUrl));
                bos = new BufferedOutputStream(response.getOutputStream());

                byte[] buff = new byte[2048];
                int bytesRead = 0;
                while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                    bos.write(buff, 0, bytesRead);
                }
                bos.flush();*/
            result = "{\"success\":true,\"msg\":\""+ fName+"\"}";
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！"+e);
            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".postJsonPData() 方法失败 】异常："+e.getMessage());
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(printOut!=null){
                    printOut.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
                /*if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    bis = null;
                }
                if (bos != null) {
                    try {
                        bos.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    bos = null;
                }*/
//            }
//            try {
//                fileUrl.delete();//成功导出后删除文件
//            } catch (Exception e) {

//            }


//        }catch (Exception ex){
//            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
//            logger.error("【执行"+this.getClass().getName()+".downMenu() 方法失败 】异常："+ex.getMessage());
        }


        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/fileDown" )
    public void fileDown( String fName,
                          HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result;
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String filepath = request.getSession().getServletContext().getRealPath("");
        File fileUrl = new File(filepath + "\\" + fName + ".dat");
        try {
            String fileName = fileUrl.getName();
            response.setContentType("application/octet-stream");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);

            response.setContentLength((int) fileUrl.length());

            bis = new BufferedInputStream(new FileInputStream(fileUrl));
            bos = new BufferedOutputStream(response.getOutputStream());

            byte[] buff = new byte[2048];
            int bytesRead = 0;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
            bos.flush();

            result = "{\"success\":true,\"msg\":\"导出成功！\"}";
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".fileDown() 方法失败 】异常："+ex.getMessage());
        }finally {
            try {
                bis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            bis = null;

            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                bos = null;
            }
        }
        try {
            fileUrl.delete();//成功导出后删除文件
        } catch (Exception e) {

        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value="/upJsonPData" ,method = RequestMethod.POST)
    public void upJsonPData(@RequestParam MultipartFile file, String fDate,
                            @CookieValue(value = "userid",defaultValue = "")String userid,
                            @CookieValue(value = "syscode",defaultValue = "")String syscode,
                            HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try{
            SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userid,syscode);
            DicJgdmTzEntity dicJgdmTzEntity = dicJgdmTzService.findJgdmByUseridRole(userid).get(0);
            if(sysUserInfoPtEntity ==null ||sysUserInfoPtEntity.getReport()==null|| !sysUserInfoPtEntity.getReport()){
                result = "{\"success\":false,\"msg\":\"权限不足，无法上传数据，请联系管理员！\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            String jsonpData = new String(file.getBytes(),"UTF-8");
            AESOperator.setsKey("dlong"+dicJgdmTzEntity.getRandPass()+"gnold");
            jsonpData = AESOperator.decrypt(jsonpData);
            Map map = (Map)JSON.parse(jsonpData);
            String jsonp = map.get("jsonP").toString();
            result = "{\"success\":true,\"msg\":\"导入成功!\"}";
        } catch (Exception e) {
            result = "{\"success\":false,\"msg\":\"导入失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".upJsonPData() 方法失败 】异常："+e.getMessage());
            e.printStackTrace();
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
