package com.dldata.drgs.filter;

import com.dldata.drgs.utils.ServerCache;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by 倪继文 on 2016/8/22.
 */
//@WebFilter(filterName = "SSOServerFilter",urlPatterns = "/*")
public class SSOServerFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {





        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String client = request.getParameter("client");
        String ticket = request.getParameter("ticket");
        //String syscode = request.getParameter("syscode");
        Cookie[] cookies = request.getCookies();
        String userid = "";
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                if ("dlsso".equals(cookie.getName())) {
                    userid = cookie.getValue();
                    break;
                }
            }
        }


        String serverurl = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort();

        if (null == client && null != ticket) {
            chain.doFilter(req, resp);
            return;
        }

        if (null != userid && !"".equals(userid)&&null!=client&&!"".equals(client)) {
            long time = System.currentTimeMillis();
            String timeString = userid + time;
            ServerCache.TICKET_AND_NAME.put(timeString, userid);


            StringBuilder url = new StringBuilder();

            url.append(client);
            if (0 <= client.indexOf("?")) {
                url.append("&");
            } else {
                url.append("?");
            }
            url.append("ticket=").append(timeString);
            url.append("&");
            url.append("serverURL=").append(serverurl);
            response.sendRedirect(url.toString());
            chain.doFilter(req, resp);
        } else {
            chain.doFilter(req, resp);
        }


    }

    public void init(FilterConfig config) throws ServletException {
//        WebApplicationContext wc= WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
//        CommonDao commonDao = (CommonDao)wc.getBean("commonDao");
//        StudentEntity studentEntity = new StudentEntity();
//        studentEntity.setAiHao("12345");
//        studentEntity.setId(UUID.randomUUID().toString());
//        System.out.println("nijiwen1");
//        System.out.println(commonDao.toString());
//        commonDao.save(studentEntity);
//        System.out.println();
//        StudentEntity studentEntity1= commonDao.find(studentEntity.getClass(), studentEntity.getId());
//        System.out.println();
//        //commonDao.flush();
//        System.out.println();
//        StudentEntity studentEntity2= commonDao.find(studentEntity.getClass(), studentEntity.getId());
//        System.out.println();
    }

}