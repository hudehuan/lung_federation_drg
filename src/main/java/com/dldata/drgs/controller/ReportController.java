package com.dldata.drgs.controller;

import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.utils.MD5Util;
import com.dldata.drgs.utils.SysConfig;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by 倪继文 on 2016/8/27.
 */
@Controller
@RequestMapping(value = "/HBI")
public class ReportController {


    @Autowired
    SysConfig sysConfig;

    @Autowired
    SysMenuService sysMenuService;

    @Autowired
    SysUserInfoService sysUserInfoService;

    @RequestMapping(value = "/loadBiKsy")
    @ResponseBody
    public String loadBiKsy(@CookieValue(value = "userid",defaultValue = "") String userId,String biIds) throws Exception{
        String[] ids = biIds.split(",");
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userId, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"),"utf-8");
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);

        String hbiName = prop.getProperty("hospitalName","");
        String biIp = prop.getProperty("HBIURL","");;
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        prop.load(bf);
        for (String id : ids) {
            Map<String,String> map = new HashMap<String,String>();
            String softKey = GetHBIParam(id,userInfoEntity.getLoginName(),hbiName);
            map.put("id",id);
            map.put("softkey",softKey);
            mapList.add(map);
        }

//        map.put("id",id);
//        map.put("biIp",biIp);
//        map.put("biqtuser",userInfoEntity.getLoginName());
//        map.put("softKey",softKey);


        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping("/toHBIday")
    @ResponseBody
    public String sendPost( String path) throws IOException {
//        byte[] data = jsonStr.getBytes();
        java.net.URL url = new java.net.URL(path);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setConnectTimeout(5 * 1000);// 设置连接超时时间为5秒
        conn.setReadTimeout(20 * 1000);// 设置读取超时时间为20秒
        // 使用 URL 连接进行输出，则将 DoOutput标志设置为 true
        conn.setDoOutput(true);

        conn.setRequestProperty("Content-Type", "text/xml;charset=UTF-8");
        // conn.setRequestProperty("Content-Encoding","gzip");
//        conn.setRequestProperty("Content-Length", String.valueOf(data.length));
        OutputStream outStream = conn.getOutputStream();// 返回写入到此连接的输出流
//        outStream.write(data);
        outStream.close();// 关闭流
        String msg = "";// 保存调用http服务后的响应信息
        // 如果请求响应码是200，则表示成功
        if (conn.getResponseCode() == 200) {
            // HTTP服务端返回的编码是UTF-8,故必须设置为UTF-8,保持编码统一,否则会出现中文乱码
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            msg = in.readLine();
            in.close();
        }
        conn.disconnect();// 断开连接
        return msg;
    }

    @RequestMapping(value = "/GetReport")
    public String getReport(@CookieValue(value = "loginname",defaultValue = "") String loginName,
                            @CookieValue(value = "userid",defaultValue = "") String userId,
                            HttpServletRequest request,HttpServletResponse response,Model model){
        String GUID = request.getParameter("GUID") == null ? "" : request.getParameter("GUID");
        String lx = request.getParameter("lx") == null ? "" : request.getParameter("lx");
        //String HBIVer = request.getParameter("HBIVer") == null ? "" : request.getParameter("HBIVer");

        String yccs = request.getParameter("biyccs") == null ? "" : request.getParameter("biyccs");
        String menuCode = request.getParameter("MenuCode") == null ? "" : request.getParameter("MenuCode");
//        if (yccs != "" && yccs.indexOf("[Value_JG_GID]") >= 0)
//        {
//            if (OnLineUserInfo.IsAdminUnit)
//                yccs = yccs.replace("[Value_JG_GID]", OnLineUserInfo.UnitCode);
//            else
//                yccs = yccs.replace("[Value_JG_GID]", new TGrassUnitInfoResponse().GetDataByCode(OnLineUserInfo.XzqhCode, OnLineUserInfo.UnitCode).GID.Value.ToString());
//        }


        //HttpSession session = request.getSession();
        //String loginName = (String) session.getAttribute("loginname");

        String HBIType = request.getParameter("HBIURL") == null ? "HBIURL" : request.getParameter("HBIURL");
        //InputStream in = null;
        InputStreamReader in = null;

        try {
            Properties prop=new Properties();
            in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
            BufferedReader bf = new BufferedReader(in);
            prop.load(bf);

            String URL = prop.getProperty(HBIType, "");
            String hbiName = prop.getProperty("hospitalName","");

            System.out.println("R:"+hbiName);
            SysUserInfoEntity sysUserInfoEntity = sysUserInfoService.getUserInfoByUserID(userId,sysConfig.SysCode);
            loginName = sysUserInfoEntity.getLoginName();
            String softKey = GetHBIParam(GUID,loginName,hbiName);

            String[] HBIInfo = GetHBIInfo(lx);
            String strPage = HBIInfo[1];

            SimpleDateFormat df=new SimpleDateFormat("yyyyMMddHHmmssSSS");
            String rand = df.format(new Date().getTime());
            String rptSRC = URL + "/" + strPage + "?biqtuser=" + loginName + "&id=" + GUID + "&softkey=" + softKey + "&biyccs=" + yccs + "&rand=" + rand;
            //针对自定义表单部份，将当前人员的权限传过去，传参名为“btn”，一共有添加、修改、删除和审核四个权限。用“1”表示有权限，无权限用“0”表示。
            if (lx.equals("5"))
            {

                //String userId = (String)session.getAttribute("userid");
                //查询用户的菜单权限
                rptSRC += "&fid=" + GUID;
                List<SysRoleMenuEntity> roleMenuEntities = sysMenuService.getUserMenuPower(userId,menuCode);
                if(roleMenuEntities.size()>0){
                    SysRoleMenuEntity entity = roleMenuEntities.get(0);
                    rptSRC += "&btn=" + (entity.getIsAdd() ? '1':'0') +
                                         (entity.getIsEdit() ? "1":"0") +
                                         (entity.getIsDel() ? "1":"0") +
                                         (entity.getIsCheck() ? "1":"0");

                }
            }

            model.addAttribute("rptSRC",rptSRC);
        }
        catch (IOException ex){

        }
        finally {
            if(in != null) {
                try {
                    in.close();
                } catch (IOException var9) {
                    ;
                }
            }

        }

        return "GetReport";
    }


    public String GetHBIParam(String strRptGID,String loginName,String hbiName){

        String HBIRegUnitName = hbiName;//sysConfig.getHospitalName();//(AppSettings.GetValue("HBIRegUnit").SameText("null") ? OnLineUserInfo.UnitName : AppSettings.GetValue("HBIRegUnit"));

//        String ssss = sysConfig.getHospitalName();
//        try {
//            String sw = new String(ssss.getBytes("ISO-8859-1"), "utf-8");
//            String sw2 = new String(ssss.getBytes("utf-8"));
//            System.out.println(sw);
//            System.out.println(sw2);
//        }catch (Exception ex){
//
//        }

        String str = "";

        Date newdate = new Date();
        SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd");
        df.format(newdate.getTime());
        str = loginName + "longWebHBI" + strRptGID.toUpperCase() + df.format(newdate.getTime()) + HBIRegUnitName;


        String s=MD5Util.MD5Encoder(str);
        String s1 = MD5Util.MD5Encoder(str).toLowerCase();
        String s2 = MD5Util.MD5Encoder(s1);
        String ss = MD5Util.MD5Encoder(s1).toUpperCase();
        return MD5Util.MD5Encoder(MD5Util.MD5Encoder(str).toLowerCase()).toUpperCase();
    }



    private static String[][] HBIType = new String[][] {
            new String[] {"1","报表","view/dsnreport/vDsnReportPreviewMain.aspx"},
            new String[] {"2","图形","view/dsnreport/vDsnChartPreviewMain.aspx"},
            new String[] {"3","组合页面","view/dsnreport/vPagePreviewMain.aspx"},
            new String[] {"4","对比图形","view/dsnreport/vDsntjPagePreviewMain.aspx"},
            new String[] {"5","自定义表单","view/CustomFrom/vAnalysisFromPreview.aspx"},
            new String[] {"6","excel","view/ExcelExport/vExcelExpViewMain.aspx"},
            new String[] {"7","自定义组合页面","view/Dsnreport/vDsnZhPageZdyPreview.aspx"},
            new String[] {"9","维表编辑","view/marketdata/vweidata.aspx"},
            new String[] {"10","OLAP自定义查询页面","view/OLAP/vDsnOLAPPreview.aspx"}
    };


    public static String[] GetHBIInfo(String lx)
    {
        String[] Result = new String[] { "", "" };
        for (String[] HBIInfo : HBIType)
        {
            if (HBIInfo[0].equals(lx))
            {
                Result[0] = HBIInfo[1];  //HBI调用模块的名称
                Result[1] = HBIInfo[2];  //HBI调用模块的URL地址
                break;
            }
        }
        return Result;
    }



}
