package com.dldata.drgs.utils.sso;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 呵呵 on 2017-07-20.
 */
public class CookieUtil {

    public static String getCookieValue(HttpServletRequest request,String cookieName){
        Cookie[] cookies=request.getCookies();
        if(cookies==null){
            return null;
        }
        for (int i = 0; i < cookies.length; i++) {
            Cookie cookie = cookies[i];
            if(cookieName!=null&&cookieName.equals(cookie.getName())){
                return cookie.getValue();
            }
        }
        return null;
    }

}
