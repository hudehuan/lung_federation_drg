package com.dldata.drgs.controller;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.Util;
import com.dldata.drgs.utils.pubs.DirectoryConfig;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Properties;

/**
 * Created by 倪继文 on 2016/8/22.
 */
@Controller
@RequestMapping(value = "/index")
public class IndexController {


    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysSystemDefineService sysSystemDefineService;

    @Autowired
    private DirectoryConfig directoryConfig;

    @Autowired
    SysUserInfoService sysUserInfoService;

    @Autowired
    SysStaffService sysStaffService;


    @Autowired
    SysConfig sysConfig;

    @Autowired
    SysHomePageService sysHomePageService;


    @Autowired
    SysUserInfoPtService sysUserInfoPtService;

    @Autowired
    private DicJgdmService dicJgdmService;

    @Autowired
    ReportController reportController;

    @RequestMapping(value="/index",method = RequestMethod.GET)
    public String index(HttpServletRequest request,
                        HttpServletResponse response,
                        ModelMap model,
                        @CookieValue(value = "dlSSOServerUrl",defaultValue = "") String serverURL)throws Exception{
//        @CookieValue(value = "loginname",defaultValue = "") String loginname,

        //得到TBZ3的真是路劲，放在全局变量中，在生成TimeTask任务中，定时删除该文件下的全部文件时使用
        DirectoryConfig.SYS =request.getSession().getServletContext().getRealPath("SYS");
        String userName="";
        String userId="";
        HttpSession session = request.getSession();
        session.removeAttribute("bivar");
        userId = (String)session.getAttribute("userid");


        if(userId==null) {
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie : cookies) {
                if ("userid".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if(userId==null){
            try {
                String loginurl = directoryConfig.getLogin_url();
                response.sendRedirect("/user/tologin/"+loginurl+"?syscode="+SysConfig.SysCode);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        if(serverURL.equals(""))
            serverURL = sysConfig.serverURL;

//        if(loginname == null){
//            return "redirect:"+serverURL;
//        }
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userId, SysConfig.SysCode);
        if(userInfoEntity !=null) {
            userId = userInfoEntity.getId();
            //session.setAttribute("userid",userId);
            Cookie cookie = new Cookie("userid", userId);
            cookie.setPath("/");
            response.addCookie(cookie);
            SysStaffEntity staffEntity = sysStaffService.getStaffByID(userId);
            userName=staffEntity.getName();
        }
        model.addAttribute("staffname",userName);
        //model.addAttribute("loginname",loginname);
        model.addAttribute("userId",userId);
        model.addAttribute("bivar",userName+"|@novalue|@novalue|");

        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userId,SysConfig.SysCode);
        String userType = "";
        String indexName = "";
        if(sysUserInfoPtEntity!=null){
            userType = sysUserInfoPtEntity.getUserType();
            switch (userType){
                case "全国":
                    indexName = "全国";
                    break;
                case "省级":
                    indexName = "本省";
                    break;
                case "机构":
                    indexName = "本院";
                    break;
                default:
                    indexName = "首页";
                    break;
            }
        }
        List<DicJgdmEntity> dicJgdmEntityList = dicJgdmService.findInfoByUserId(userId);
        String hosName = "";
        if(dicJgdmEntityList.size()>0){
            hosName = dicJgdmEntityList.get(0).getMc();
        }
        model.addAttribute("hosName",hosName);
        model.addAttribute("indexName",indexName);
        model.addAttribute("userType",userType);
        session.setAttribute("userType",userType);
        session.setAttribute("hosName",hosName);
        session.setAttribute("staffname",userName);
        //查询默认首页，并返回地址
        String userHome = "";
        SysHomePageEntity sysHomePageEntity = new SysHomePageEntity();
        if(userInfoEntity.getHomePageId()!=null) {
            sysHomePageEntity = sysHomePageService.findOne(userInfoEntity.getHomePageId());
            if(sysHomePageEntity != null) {
                if (Util.checkNotNull(sysHomePageEntity.getUrl())) {
                    if(sysHomePageEntity.getUrl().substring(0,5).equals("/HBI/")){
                        userHome =   sysHomePageEntity.getUrl();
                    }else{
                        userHome =  "/HomePageInterface/home" + sysHomePageEntity.getUrl();
                    }
                }
                else{
                    userHome =  "/HomePageInterface/home/default";
                }
            }
            else{
                userHome =  "/HomePageInterface/home/default";
            }
        }else{
            userHome =  "/HomePageInterface/home/default";
        }
        String homePageUrl = directoryConfig.getHome_page_url();
        if(Util.checkNotNull(homePageUrl)){
            userHome= homePageUrl;
        }
//        userHome = "/hubei/V_homePage/toHomePageIndex";
        model.addAttribute("userHome",userHome);



        InputStreamReader in = null;
        try {
            Properties prop = new Properties();
            in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"),"utf-8");
            BufferedReader bf = new BufferedReader(in);
            prop.load(bf);


            String hospitalName = prop.getProperty("hospitalName", "");
            String systemName = prop.getProperty("systemName", "");
            model.addAttribute("hospitalName",hospitalName);
            model.addAttribute("systemName",systemName);

            String biIp = prop.getProperty("HBIURL","");
            model.addAttribute("biqtuser",userInfoEntity.getLoginName());
            model.addAttribute("biIp",biIp);

            String msg = reportController.sendPost(biIp+"/view/systemopt/ajax/AjaxValidateRegister.ashx");
            JSONObject jsonMsg = JSONObject.fromObject(msg);
            Object biHosName = jsonMsg.get("regmc");
            if(!jsonMsg.get("Type").toString().equals("success")||(Util.checkNotNull(biHosName)&&!hospitalName.equals(biHosName.toString()))){
                return "redirect:"+biIp+"/enrollment.aspx";
            }
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
        return "/index/index";
    }

//    @RequestMapping(value = "")
//    public ModelAndView home(ModelMap model,HttpServletRequest request, HttpServletResponse response)throws Exception{
//
//        ModelAndView modelAndView = new ModelAndView();
////        List<SysSystemDefineEntity> sysSystemDefineEntities = new ArrayList<SysSystemDefineEntity>();
//
//        String result;
//        try {
//
////            sysSystemDefineEntities = sysSystemDefineService.getAllSystem();
//
////            if(sysSystemDefineEntities.size()==1){
//                //如果只有定义了一个系统，那么直接跳转到这个系统
//                String loginurl = directoryConfig.getLogin_url();  //sysSystemDefineEntities.get(0).getLoginUrl();//系统登录页面地址
//
//                //子系统地址和端口
////                String client = "http://" + sysSystemDefineEntities.get(0).getRedirectIp() +":"+
////                        sysSystemDefineEntities.get(0).getRedirectPort() + "/"+ sysSystemDefineEntities.get(0).getRedirectUrl() ;
//
//                //子系统系统编号
//                String sysCode = directoryConfig.getSys_code();
//
//                //跳转到登录处理controller
//                String url = "redirect:/user/tologin/" + loginurl+ "&syscode=" + sysCode  ;// + "?client=" + client ;
//                modelAndView.setViewName(url);
//                //return  new ModelAndView(url);
//
//
//
////            }else{
//                //ModelAndView modelAndView = new ModelAndView();
////                modelAndView.setViewName("index");
////                modelAndView.addObject("sysSystems",sysSystemDefineEntities);
//                // model.addAttribute("sysSystems",sysSystemDefineEntities);
//
////                return modelAndView;
////            }
//        }
//        catch(Exception ex){
//            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
//            StringUtil.writeToWeb(result, "html", response);
//
//            logger.error("【执行"+this.getClass().getName()+".home() 方法失败 】异常："+ex.getMessage());
//        }
//
////        ModelAndView modelAndView = new ModelAndView();
////        modelAndView.setViewName("index");
////        modelAndView.addObject("sysSystems",sysSystemDefineEntities);
////       // model.addAttribute("sysSystems",sysSystemDefineEntities);
////
//        return modelAndView;
//    }

}
