package com.dldata.drgs.controller.Login;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.Log.LogUserLoginService;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysUserInfoPtService;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.service.System.SysUserOnlineService;
import com.dldata.drgs.utils.DateUtil;
import com.dldata.drgs.utils.LoginMap;
import com.dldata.drgs.utils.ServerCache;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.pubs.DirectoryConfig;
import com.dldata.drgs.utils.sso.DlSsoConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.security.MessageDigest;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
/**
 * Created by 倪继文 on 2016/8/22.
 */
@Controller
@RequestMapping(value = "/user")
public class UserLoginController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    //SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式

    @Autowired
    SysUserInfoService sysUserInfoService;

    @Autowired
    SysUserOnlineService sysUserOnlineService;

    @Autowired
    LogUserLoginService logUserLoginService;

    @Autowired
    SysUserInfoPtService sysUserInfoPtService;

    @Autowired
    SysDictionaryItemService sysDictionaryItemService;

    @Autowired
    private DirectoryConfig directoryConfig;

    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {


//        String jsonString= "'Id':'','Name':''}";
//        JSONObject fromObject = JSONObject.fromObject(jsonString);
//        List<JSONObject> fromObjectlist=null;
//        fromObjectlist.add(0,fromObject);.

        String result;

        String loginname = request.getParameter("username").trim();
        String loginpwd = request.getParameter("password").trim();
        String client = request.getParameter("client");
        String syscode = request.getParameter("syscode");
        String rememberMe = request.getParameter("rememberMe");

        String dlAdmin = request.getParameter("dlAdmin");
        String xlh = request.getParameter("ukeynum");
        String powerFile = request.getParameter("ukey");
        xlh = xlh.replace("\r\n","");

        String serverurl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

        HttpSession session = request.getSession();
        //根据loginname和syscode查询出在UserOnline表中的最新记录,同一系统不让重复登录
        List<SysUserOnlineEntity> userOnlineEntities = new ArrayList<SysUserOnlineEntity>();
        try {
            userOnlineEntities = sysUserOnlineService.getUserOnlineByLoginName(loginname, syscode);
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            return null;
        }
        //验证loginid 和 password
        SysUserInfoEntity userInfo = null;
        try {
            userInfo = sysUserInfoService.checkUserInfo(loginname,syscode);
            session.setAttribute("userid",userInfo.getId());
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            return null;
        }

        if (userOnlineEntities.size() > 0) {
            SysUserOnlineEntity userOnlineEntity = userOnlineEntities.get(0);

            Timestamp perLogintime = userOnlineEntity.getLoginTime();
            Timestamp nowLogintime = new Timestamp(new Date().getTime());

            long minutes = (nowLogintime.getTime() - perLogintime.getTime()) / (1000);

            if(!userInfo.getLoginName().toLowerCase().equals("admin")){
                if (minutes < 8) {
                    result = "{\"success\":false,\"msg\":\"用户正在使用，请稍后再登录！\"" + "}";
                    StringUtil.writeToWeb(result, "html", response);
                    return null;
                } else {
                    sysUserOnlineService.deleteOnlineInfos(userOnlineEntities);
                }
            }


        }

        if (userInfo == null) {
            result = "{\"success\":false,\"msg\":\"登录名不存在，请重新填写！\"" + "}";
            StringUtil.writeToWeb(result, "html", response);
            return null;
        }

        LoginMap loginMap = new LoginMap();
        if(ServerCache.LOGIN_AND_NAME.containsKey(getIp(request)+userInfo.getId())){
            loginMap = ServerCache.LOGIN_AND_NAME.get(getIp(request)+userInfo.getId());
        }
//        if(loginMap.getLoginTimes()>2){
//            result = "{\"success\":false,\"msg\":\"登录过于频繁，请"+(15-(new Timestamp(new Date().getTime()).getTime()-loginMap.getLastLongTime())/(60*1000))+"分钟后再登录！\"" + "}";
//            StringUtil.writeToWeb(result, "html", response);
//            return null;
//        }

        String pwd = toMD5(userInfo.getLoginName() + loginpwd);
        if (!userInfo.getLoginPwd().equals(pwd)) {
            if(!ServerCache.LOGIN_AND_NAME.containsKey(getIp(request)+userInfo.getId())){
                loginMap.setKey(getIp(request)+userInfo.getId());
                loginMap.setFirstLongTime(new Timestamp(new Date().getTime()).getTime());
            }
            loginMap.setLastLongTime(new Timestamp(new Date().getTime()).getTime());
            loginMap.setLoginTimes(loginMap.getLoginTimes()+1);
            ServerCache.LOGIN_AND_NAME.put(getIp(request)+userInfo.getId(), loginMap);
//            if(loginMap.getLoginTimes()==3){
//                result = "{\"success\":false,\"msg\":\"密码错误，账号被暂停使用，请15分钟后再登录!\"" + "}";
//            }else {
//                result = "{\"success\":false,\"msg\":\"密码错误，请重新填写，" + (3 - loginMap.getLoginTimes()) + "次后将暂停账号\"" + "}";
//            }
            result = "{\"success\":false,\"msg\":\"密码错误，请重新登陆！\"" + "}";
            StringUtil.writeToWeb(result, "html", response);
            return null;
        }

        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userInfo.getId(),syscode);
        SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd");
        String rand = df.format(new Date().getTime());
        String sysUd = directoryConfig.getSys_udun_vali();
        if(!rand.equals(dlAdmin) &&!"dlUdun".equals(sysUd) /*&& sysUserInfoPtEntity != null*/){
            if(sysUserInfoPtEntity == null||sysUserInfoPtEntity.getXlh() ==null ||sysUserInfoPtEntity.getPowerFile() == null){
                result = "{\"success\":false,\"msg\":\"用户未授权！，请联系管理员！\"" + "}";
                StringUtil.writeToWeb(result, "html", response);
                return null;
            }
            if (!sysUserInfoPtEntity.getXlh().equals(xlh)) {
                result = "{\"success\":false,\"msg\":\"U盾设备号不匹配，请联系管理员！\"" + "}";
                StringUtil.writeToWeb(result, "html", response);
                return null;
            }
            if (!sysUserInfoPtEntity.getPowerFile().equals(powerFile)) {
                result = "{\"success\":false,\"msg\":\"授权文件不匹配，请联系管理员！\"" + "}";
                StringUtil.writeToWeb(result, "html", response);
                return null;
            }
        }



        // 如果勾选记住自己，把账号密码写入cookie
        if (rememberMe != null && rememberMe.equals("on")) {
            //创建两个Cookie对象
            Cookie nameCookie = new Cookie("username", loginname);
            //设置Cookie的有效期为7天
            nameCookie.setMaxAge(60 * 60 * 24 * 7);
            nameCookie.setPath("/");
//            Cookie pwdCookie = new Cookie("password", loginpwd);
//            pwdCookie.setMaxAge(60 * 60 * 24 * 7);
//            pwdCookie.setPath("/");
            response.addCookie(nameCookie);
//            response.addCookie(pwdCookie);
        }else {
            //创建两个Cookie对象
            Cookie nameCookie = new Cookie("username", loginname);
            //设置Cookie的有效期为7天
            nameCookie.setMaxAge(0);
            nameCookie.setPath("/");
            Cookie pwdCookie = new Cookie("password", loginpwd);
            pwdCookie.setMaxAge(0);
            pwdCookie.setPath("/");
            response.addCookie(nameCookie);
            response.addCookie(pwdCookie);
        }


        Cookie cookie1 = new Cookie("dlsso", userInfo.getId());
        cookie1.setPath("/");
        response.addCookie(cookie1);

        Cookie cookie2 = new Cookie("syscode", syscode);
        cookie2.setPath("/");
        response.addCookie(cookie2);

        if (userInfo != null) {
            Cookie cookie3 = new Cookie("userid", userInfo.getId());
            //Cookie cookie3 = new Cookie("userid", loginname);
            cookie3.setPath("/");
            response.addCookie(cookie3);

            //创建两个Cookie对象
            Cookie nameCookie = new Cookie(DlSsoConstant.ssoCookieUserName, loginname);
            //设置Cookie的有效期为7天
            nameCookie.setMaxAge(60 * 60 * 24 * 7);
            nameCookie.setPath("/");
            Cookie pwdCookie = new Cookie(DlSsoConstant.ssoCookieUserPass, loginpwd);
            pwdCookie.setMaxAge(60 * 60 * 24 * 7);
            pwdCookie.setPath("/");
            response.addCookie(nameCookie);
            response.addCookie(pwdCookie);

            Class<?> clazz =Class.forName("com.dldata.base.utils.Public");
            Field fieldSESSION_USERID_KEYl = clazz.getDeclaredField("SESSION_USERID_KEY");
            Cookie cookie4 = new Cookie(fieldSESSION_USERID_KEYl.get(clazz).toString(), userInfo.getId());
            cookie4.setMaxAge(60 * 60 * 24);
            cookie4.setPath("/");
            Field SESSION_USERNAME_KEY = clazz.getDeclaredField("SESSION_USERNAME_KEY");
            Cookie cookie5 = new Cookie(SESSION_USERNAME_KEY.get(clazz).toString(), userInfo.getLoginName());
            cookie5.setMaxAge(60 * 60 * 24);
            cookie5.setPath("/");
            response.addCookie(cookie4);
            response.addCookie(cookie5);
        }

        Cookie cookie4 = new Cookie("dlSSOServerUrl", serverurl);
        cookie4.setPath("/");
        response.addCookie(cookie4);


        long time = System.currentTimeMillis();
        String timeString = userInfo.getId() + time;
        //ServerCache.TICKET_AND_NAME.put(timeString, loginname);
        ServerCache.TICKET_AND_NAME.put(timeString, userInfo.getId());

        //保存在在线用户表
        SysUserOnlineEntity userOnlineEntity = new SysUserOnlineEntity();
        userOnlineEntity.setId(UUID.randomUUID().toString());
        userOnlineEntity.setUserId(userInfo.getId());
        userOnlineEntity.setTokenId(String.valueOf(time));
        userOnlineEntity.setLoginTime(new Timestamp(new Date().getTime()));
        userOnlineEntity.setSessionId(request.getSession().getId());
        userOnlineEntity.setSysCode(syscode);

        //保存用户登录日志
        LogUserLoginEntity userLoginEntity = new LogUserLoginEntity();
        userLoginEntity.setId(UUID.randomUUID().toString());
        userLoginEntity.setSysCode(syscode);
        userLoginEntity.setUserId(userInfo.getId());
        userLoginEntity.setLoginIp(getIp(request));
        userLoginEntity.setLoginDate(DateUtil.getSqlDate());
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        String loginTime = dateFormat.format(now);
        userLoginEntity.setLoginTime(Time.valueOf(loginTime));

        try {
            sysUserOnlineService.save(userOnlineEntity);
            logUserLoginService.save(userLoginEntity);

            //HttpSession session = request.getSession();
            //session.setAttribute("syscode",syscode);

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".login() 方法失败 】异常：" + ex.getMessage());
            StringUtil.writeToWeb(result, "html", response);
            return null;
        }

//        if (null != client) {
//            StringBuilder url = new StringBuilder();
//            url.append(client);
//            if (0 <= client.indexOf("?")) {
//                url.append("&");
//            } else {
//                url.append("?");
//            }
//            url.append("ticket=").append(timeString);
//            //url.append("ticket=").append(loginname);
//            url.append("&");
//            url.append("serverURL=").append(serverurl);
//            //return "redirect:"+url;
//            result = "{\"success\":true,\"url\":\"" + url + "\"}";
//
//        } else {
//            //return "redirect:/user/gotologin";
//            result = "{\"success\":true,\"url\":\"/user/gotologin\"}";
//            // result = "{\"success\":true,\"msg\":\"登录不OK！\"}";
//        }

        StringBuilder url = new StringBuilder();

        session.removeAttribute("indexUrl");
        if(sysUserInfoPtEntity != null && sysUserInfoPtEntity.getUserType() != null && (sysUserInfoPtEntity.getUserType().equals("全国")||sysUserInfoPtEntity.getUserType().equals("省级"))){
            SysDictionaryItemEntity sysDictionaryItemEntity = sysDictionaryItemService.findOneByCode(sysUserInfoPtEntity.getUserType());
            if(sysDictionaryItemEntity!=null){
                String dir = directoryConfig.getLogin_dir();
                url.append(dir+"/IndexPage/toIndex/"+sysDictionaryItemEntity.getDicName());
            }else {
                url.append("/index/index");
            }
        }else{
            url.append("/index/index");
        }
        if (0 <= client.indexOf("?")) {
            url.append("&");
        } else {
            url.append("?");
        }
        url.append("ticket=").append(timeString);
        url.append("&");
        url.append("serverURL=").append(serverurl);
        result = "{\"success\":true,\"url\":\"" + url + "\"}";

        StringUtil.writeToWeb(result, "html", response);
        return null;
    }



    @RequestMapping(value = "/tologin/{syspath}/{loginurl}")
    public String gotologin(@PathVariable("syspath") String syspath, @PathVariable("loginurl") String loginurl, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String client = request.getParameter("client");
        String sysCode = request.getParameter("syscode");
        String dlAdmin = request.getParameter("dlAdmin");
        model.addAttribute("dlAdmin", dlAdmin);
        model.addAttribute("client", client);
        model.addAttribute("syscode", sysCode);

        HttpSession session = request.getSession();
        String str = dlAdmin + sysCode + client;
        Object paramsError = session.getAttribute("paramsError");
        if (paramsError != null) {
            model.addAttribute("paramsError", paramsError.toString());
        }

        session.removeAttribute("paramsError");
        String reg = "[a-zA-Z0-9]";
        for (int i = 0; i < str.length(); i++) {
            if (!str.substring(i, i + 1).matches(reg)) {
                session.setAttribute("paramsError", "参数中含有非法字符！");
                response.sendRedirect("/");
                break;
            }
        }

        String name = ""; //用户名
        String password = ""; //密码
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    name = cookie.getValue();
                    model.addAttribute("username", name);  //存用户名
                }
                if (cookie.getName().equals("password")) {
                    password = cookie.getValue();
                    model.addAttribute("password", password); //存密码
                }
            }
        }

        if (StringUtils.isEmpty(loginurl)) {
            return "login";
        } else {
            return syspath + "/" + loginurl;
        }
    }

    public String toMD5(String plainText) {
        StringBuffer buf = new StringBuffer("");
        try {
            //生成实现指定摘要算法的 MessageDigest 对象。
            MessageDigest md = MessageDigest.getInstance("MD5");
            //使用指定的字节数组更新摘要。
            md.update(plainText.getBytes());
            //通过执行诸如填充之类的最终操作完成哈希计算。
            byte b[] = md.digest();
            //生成具体的md5密码到buf数组
            int i;

            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
//            System.out.println("32位: " + buf.toString());// 32位的加密
//            System.out.println("16位: " + buf.toString().substring(8, 24));// 16位的加密，其实就是32位加密后的截取
        } catch (Exception e) {
            e.printStackTrace();
        }
        return buf.toString();
    }

    // 获取客户端IP
    private String getIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
            //多次反向代理后会有多个ip值，第一个ip才是真实ip
            int index = ip.indexOf(",");
            if (index != -1) {
                return ip.substring(0, index);
            } else {
                return ip;
            }
        }
        ip = request.getHeader("X-Real-IP");
        if (org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
            return ip;
        }
        return request.getRemoteAddr();
    }


    @RequestMapping(value = "/wtLogin")
    public void wtLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result;
        String wtLoginName = request.getParameter("wtLoginName");;
        String ukey = request.getParameter("ukeycode");;
        String syscode = request.getParameter("syscode");;

        String ukeyVal = "dldrgswt4";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String dateStr = format.format(date);
        String ukeyMD5 = toMD5(toMD5(wtLoginName+dateStr+ukeyVal));
//        String ukeyMD5 = wtLoginName + dateStr + ukeyVal;
        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.findByWtLoginName(wtLoginName, syscode);
        if (sysUserInfoPtEntity != null && ukeyMD5.equals(ukey)) {
            SysUserInfoEntity sysUserInfoEntity = sysUserInfoService.getUserInfoByUserID(sysUserInfoPtEntity.getUserid(), syscode);

            String loginname = sysUserInfoEntity.getLoginName();
            String loginpwd = sysUserInfoEntity.getLoginPwd();
            String client = request.getParameter("client");
            String rememberMe = request.getParameter("rememberMe");

            String dlAdmin = request.getParameter("dlAdmin");
            String xlh = request.getParameter("ukeynum");
            String powerFile = request.getParameter("ukey");
            xlh = xlh==null?"":xlh.replace("\r\n", "");

            String serverurl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

            HttpSession session = request.getSession();
            //根据loginname和syscode查询出在UserOnline表中的最新记录,同一系统不让重复登录
            List<SysUserOnlineEntity> userOnlineEntities = new ArrayList<SysUserOnlineEntity>();
            try {
                userOnlineEntities = sysUserOnlineService.getUserOnlineByLoginName(loginname, syscode);
            } catch (Exception ex) {
                result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
                StringUtil.writeToWeb(result, "html", response);
            }
            //验证loginid 和 password
            SysUserInfoEntity userInfo = null;
            try {
                userInfo = sysUserInfoService.checkUserInfo(loginname, syscode);
                session.setAttribute("userid", userInfo.getId());
            } catch (Exception ex) {
                result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
                StringUtil.writeToWeb(result, "html", response);
            }

            if (userOnlineEntities.size() > 0) {
                SysUserOnlineEntity userOnlineEntity = userOnlineEntities.get(0);

                Timestamp perLogintime = userOnlineEntity.getLoginTime();
                Timestamp nowLogintime = new Timestamp(new Date().getTime());

                long minutes = (nowLogintime.getTime() - perLogintime.getTime()) / (1000);

                if (!userInfo.getLoginName().toLowerCase().equals("admin")) {
                    if (minutes < 8) {
                        result = "{\"success\":false,\"msg\":\"用户正在使用，请稍后再登录！\"" + "}";
                        StringUtil.writeToWeb(result, "html", response);
                    } else {
                        sysUserOnlineService.deleteOnlineInfos(userOnlineEntities);
                    }
                }


            }

            if (userInfo == null) {
                result = "{\"success\":false,\"msg\":\"登录名不存在，请重新填写！\"" + "}";
                StringUtil.writeToWeb(result, "html", response);
            }

            LoginMap loginMap = new LoginMap();
            if (ServerCache.LOGIN_AND_NAME.containsKey(getIp(request) + userInfo.getId())) {
                loginMap = ServerCache.LOGIN_AND_NAME.get(getIp(request) + userInfo.getId());
            }

            String pwd = toMD5(userInfo.getLoginName() + loginpwd);
            if (!userInfo.getLoginPwd().equals(pwd) && !userInfo.getLoginPwd().equals(loginpwd)) {
                if (!ServerCache.LOGIN_AND_NAME.containsKey(getIp(request) + userInfo.getId())) {
                    loginMap.setKey(getIp(request) + userInfo.getId());
                    loginMap.setFirstLongTime(new Timestamp(new Date().getTime()).getTime());
                }
                loginMap.setLastLongTime(new Timestamp(new Date().getTime()).getTime());
                loginMap.setLoginTimes(loginMap.getLoginTimes() + 1);
                ServerCache.LOGIN_AND_NAME.put(getIp(request) + userInfo.getId(), loginMap);
                result = "{\"success\":false,\"msg\":\"密码错误，请重新登陆！\"" + "}";
                StringUtil.writeToWeb(result, "html", response);
            }

            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
            String rand = df.format(new Date().getTime());
            String sysUd = directoryConfig.getSys_udun_vali();
            if (!rand.equals(dlAdmin) && !"dlUdun".equals(sysUd) /*&& sysUserInfoPtEntity != null*/) {
                if (sysUserInfoPtEntity == null || sysUserInfoPtEntity.getXlh() == null || sysUserInfoPtEntity.getPowerFile() == null) {
                    result = "{\"success\":false,\"msg\":\"用户未授权！，请联系管理员！\"" + "}";
                    StringUtil.writeToWeb(result, "html", response);
                }
                if (!sysUserInfoPtEntity.getXlh().equals(xlh)) {
                    result = "{\"success\":false,\"msg\":\"U盾设备号不匹配，请联系管理员！\"" + "}";
                    StringUtil.writeToWeb(result, "html", response);
                }
                if (!sysUserInfoPtEntity.getPowerFile().equals(powerFile)) {
                    result = "{\"success\":false,\"msg\":\"授权文件不匹配，请联系管理员！\"" + "}";
                    StringUtil.writeToWeb(result, "html", response);
                }
            }


            // 如果勾选记住自己，把账号密码写入cookie
            if (rememberMe != null && rememberMe.equals("on")) {
                //创建两个Cookie对象
                Cookie nameCookie = new Cookie("username", loginname);
                //设置Cookie的有效期为7天
                nameCookie.setMaxAge(60 * 60 * 24 * 7);
                nameCookie.setPath("/");
//            Cookie pwdCookie = new Cookie("password", loginpwd);
//            pwdCookie.setMaxAge(60 * 60 * 24 * 7);
//            pwdCookie.setPath("/");
                response.addCookie(nameCookie);
//            response.addCookie(pwdCookie);
            } else {
                //创建两个Cookie对象
                Cookie nameCookie = new Cookie("username", loginname);
                //设置Cookie的有效期为7天
                nameCookie.setMaxAge(0);
                nameCookie.setPath("/");
                Cookie pwdCookie = new Cookie("password", loginpwd);
                pwdCookie.setMaxAge(0);
                pwdCookie.setPath("/");
                response.addCookie(nameCookie);
                response.addCookie(pwdCookie);
            }


            Cookie cookie1 = new Cookie("dlsso", userInfo.getId());
            cookie1.setPath("/");
            response.addCookie(cookie1);

            Cookie cookie2 = new Cookie("syscode", syscode);
            cookie2.setPath("/");
            response.addCookie(cookie2);

            if (userInfo != null) {
                Cookie cookie3 = new Cookie("userid", userInfo.getId());
                //Cookie cookie3 = new Cookie("userid", loginname);
                cookie3.setPath("/");
                response.addCookie(cookie3);

                //创建两个Cookie对象
                Cookie nameCookie = new Cookie(DlSsoConstant.ssoCookieUserName, loginname);
                //设置Cookie的有效期为7天
                nameCookie.setMaxAge(60 * 60 * 24 * 7);
                nameCookie.setPath("/");
                Cookie pwdCookie = new Cookie(DlSsoConstant.ssoCookieUserPass, loginpwd);
                pwdCookie.setMaxAge(60 * 60 * 24 * 7);
                pwdCookie.setPath("/");
                response.addCookie(nameCookie);
                response.addCookie(pwdCookie);

                Class<?> clazz = Class.forName("com.dldata.base.utils.Public");
                Field fieldSESSION_USERID_KEYl = clazz.getDeclaredField("SESSION_USERID_KEY");
                Cookie cookie4 = new Cookie(fieldSESSION_USERID_KEYl.get(clazz).toString(), userInfo.getId());
                cookie4.setMaxAge(60 * 60 * 24);
                cookie4.setPath("/");
                Field SESSION_USERNAME_KEY = clazz.getDeclaredField("SESSION_USERNAME_KEY");
                Cookie cookie5 = new Cookie(SESSION_USERNAME_KEY.get(clazz).toString(), userInfo.getLoginName());
                cookie5.setMaxAge(60 * 60 * 24);
                cookie5.setPath("/");
                response.addCookie(cookie4);
                response.addCookie(cookie5);
            }

            Cookie cookie4 = new Cookie("dlSSOServerUrl", serverurl);
            cookie4.setPath("/");
            response.addCookie(cookie4);


            long time = System.currentTimeMillis();
            String timeString = userInfo.getId() + time;
            //ServerCache.TICKET_AND_NAME.put(timeString, loginname);
            ServerCache.TICKET_AND_NAME.put(timeString, userInfo.getId());

            //保存在在线用户表
            SysUserOnlineEntity userOnlineEntity = new SysUserOnlineEntity();
            userOnlineEntity.setId(UUID.randomUUID().toString());
            userOnlineEntity.setUserId(userInfo.getId());
            userOnlineEntity.setTokenId(String.valueOf(time));
            userOnlineEntity.setLoginTime(new Timestamp(new Date().getTime()));
            userOnlineEntity.setSessionId(request.getSession().getId());
            userOnlineEntity.setSysCode(syscode);

            //保存用户登录日志
            LogUserLoginEntity userLoginEntity = new LogUserLoginEntity();
            userLoginEntity.setId(UUID.randomUUID().toString());
            userLoginEntity.setSysCode(syscode);
            userLoginEntity.setUserId(userInfo.getId());
            userLoginEntity.setLoginIp(getIp(request));
            userLoginEntity.setLoginDate(DateUtil.getSqlDate());
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            String loginTime = dateFormat.format(now);
            userLoginEntity.setLoginTime(Time.valueOf(loginTime));

            try {
                sysUserOnlineService.save(userOnlineEntity);
                logUserLoginService.save(userLoginEntity);

                //HttpSession session = request.getSession();
                //session.setAttribute("syscode",syscode);

            } catch (Exception ex) {
                result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
                logger.error("【执行" + this.getClass().getName() + ".login() 方法失败 】异常：" + ex.getMessage());
                StringUtil.writeToWeb(result, "html", response);
            }


            StringBuilder url = new StringBuilder();

            session.removeAttribute("indexUrl");
            if (sysUserInfoPtEntity != null && sysUserInfoPtEntity.getUserType() != null && (sysUserInfoPtEntity.getUserType().equals("全国") || sysUserInfoPtEntity.getUserType().equals("省级"))) {
                SysDictionaryItemEntity sysDictionaryItemEntity = sysDictionaryItemService.findOneByCode(sysUserInfoPtEntity.getUserType());
                if (sysDictionaryItemEntity != null) {
                    String dir = directoryConfig.getLogin_dir();
                    url.append(dir + "/IndexPage/toIndex/" + sysDictionaryItemEntity.getDicName());
                } else {
                    url.append("/index/index");
                }
            } else {
                url.append("/index/index");
            }
            if (0 <= client.indexOf("?")) {
                url.append("&");
            } else {
                url.append("?");
            }
            url.append("ticket=").append(timeString);
            url.append("&");
            url.append("serverURL=").append(serverurl);
            response.sendRedirect(url.toString());
//            result = "{\"success\":true,\"url\":\"" + url + "\"}";
//            StringUtil.writeToWeb(result, "html", response);
        }else{
            result = "{\"success\":false,\"msg\":\"登录失败!\"}";
            StringUtil.writeToWeb(result, "html", response);
        }
    }

    @RequestMapping(value = "/toList")
    public String toList(){
        return "test";
    }
}
