package com.dldata.drgs.controller;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.service.System.SysUserOnlineService;

import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.sso.DlSsoConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;

/**
 * Created by 倪继文 on 2016/8/23.
 */
@Controller
@RequestMapping(value = "/userlogin")
public class SysUserLoginController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    SysUserOnlineService sysUserOnlineService;

    @Autowired
    private SysUserInfoService sysUserInfoService;


    @RequestMapping(value = "/logout")
    public void userLogout(@CookieValue(value = "userid",defaultValue = "") String userid,
                           HttpServletRequest request, HttpServletResponse response)throws Exception{

        //HttpSession session = request.getSession();

        //String userid = (String) session.getAttribute("userid");

        String serverURL = "";
        try {
            sysUserOnlineService.deleteByUserID(userid, SysConfig.SysCode);
        }
        catch (Exception ex){

        }



        //session.removeAttribute("userid");
        //session.removeAttribute("loginname");
        //session.invalidate();

        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                if ("userid".equals(cookie.getName())) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    //break;
                }

                if ("loginname".equals(cookie.getName())) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    //break;
                }
                
                if ("dlSSOServerUrl".equals(cookie.getName())) {
                    serverURL = cookie.getValue();
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    //break;
                }
                if (DlSsoConstant.ssoCookieUserPass.equals(cookie.getName())) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    //break;
                }

                if (DlSsoConstant.ssoCookieUserName.equals(cookie.getName())) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    //break;
                }

            }
        }

        String result = "{\"success\":true,\"url\":\""+serverURL+"\"}";
        StringUtil.writeToWeb(result, "html", response);

    }

    @RequestMapping("/toupdatePwd")
    public String toupdataPwd(){
        return "UpdatePwd";
    }

    @RequestMapping("/saveupdatePwd")
    public void saveupdatePwd( HttpServletRequest request, HttpServletResponse response,
                               String loginPwd,String newPwd1,String newPwd2,
                               @CookieValue(value = "userid", defaultValue = "") String userId) throws Exception{
        String result;
        try{
            String sysCode = SysConfig.SysCode;
            SysUserInfoEntity sysUserInfoEntity = sysUserInfoService.getUserInfoByUserID(userId,sysCode);
            String pwd = toMD5(sysUserInfoEntity.getLoginName()+ loginPwd);
            if(pwd.equals(sysUserInfoEntity.getLoginPwd())){
                if(newPwd1.equals(newPwd2)){
                    String newpwd =  toMD5(sysUserInfoEntity.getLoginName() + newPwd1);
                    sysUserInfoEntity.setLoginPwd(newpwd);
                    sysUserInfoService.save(sysUserInfoEntity);
                }else{
                    result = "{\"success\":false,\"msg\":\"两次密码不一样！\",\"id\":\"#newPwd2\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }else {
                result = "{\"success\":false,\"msg\":\"密码错误！\",\"id\":\"#loginPwd\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            result = "{\"success\":true,\"msg\":\"密码修改成功！\"}";
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deletelc() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
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
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return buf.toString();
    }
}
