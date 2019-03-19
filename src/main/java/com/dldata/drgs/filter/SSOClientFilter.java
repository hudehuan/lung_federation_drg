package com.dldata.drgs.filter;

import com.dldata.drgs.utils.Public;
import com.dldata.drgs.utils.ServerCache;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.Util;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.concurrent.TimeUnit;

/**
 * Created by 倪继文 on 2016/8/23.
 */
@WebFilter(filterName = "SSOClientFilter",urlPatterns = "/*")
public class SSOClientFilter implements Filter {

//    public SysConfig getSysConfig() {
//        return sysConfig;
//    }
//
//    public void setSysConfig(SysConfig sysConfig) {
//        this.sysConfig = sysConfig;
//    }
//
//    private SysConfig sysConfig;

    public void destroy() {
        System.out.println("过滤器销毁");

    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {



        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        response.addHeader("X-Frame-Options","SAMEORIGIN");
        String client = request.getParameter("client");
        String ticket = request.getParameter("ticket");
        //String syscode = request.getParameter("syscode");
        Cookie[] cookies = request.getCookies();
        HttpSession session = request.getSession();
        String userid = (String)session.getAttribute("userid");
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                if ("dlsso".equals(cookie.getName())) {
                    userid = cookie.getValue();
                    break;
                }
            }
        }


        String serverurl = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort();


//        if (null != userid && !"".equals(userid)&&null!=client&&!"".equals(client)) {
//            long time = System.currentTimeMillis();
//            String timeString = userid + time;
//            ServerCache.TICKET_AND_NAME.put(timeString, userid);
//
//
//            chain.doFilter(req, resp);
//
//
//
//        } else {
//            chain.doFilter(req, resp);
//        }


        String servletPath = request.getServletPath();

        if(servletPath.startsWith("/user/")||servletPath.equals("/")||servletPath.startsWith("/static")){
            chain.doFilter(request, response);
            return;

        }
//        Cookie[] cookies = request.getCookies();
        cookies=cookies==null?new  Cookie[0]:cookies;

        if(userid==null) {
            for (Cookie cookie : cookies) {
                if ("userid".equals(cookie.getName())) {
                    userid = cookie.getValue();
                    break;
                }
            }
        }

        String url = URLEncoder.encode(request.getRequestURL().toString(), "UTF-8");

        String serverURL = request.getParameter("serverURL");
        if(serverURL!=null){
            Cookie cookie = new Cookie("dlSSOServerUrl", serverURL);
            SysConfig.serverURL = serverURL;
            cookie.setPath("/");
            response.addCookie(cookie);
        }else{
            //Cookie[] cookies = request.getCookies();
            //String username = "";
            if (null != cookies) {
                for (Cookie cookie : cookies) {
                    if ("dlSSOServerUrl".equals(cookie.getName())) {
                        serverURL = cookie.getValue();
                        break;
                    }
                }
            }
        }
        serverURL = Util.checkNotNull(serverURL)?serverURL:"/";
        if (userid == null) {
            if (null != ticket && !"".equals(ticket)) {//有票据，那么根据票据，得到对应的用户名
                PostMethod postMethod = new PostMethod(serverURL +"/ticket/getuserid");
                postMethod.addParameter("ticket", ticket);
                HttpClient httpClient = new HttpClient();
                try {
                    httpClient.executeMethod(postMethod);
                    userid = postMethod.getResponseBodyAsString();
                    postMethod.releaseConnection();
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (null != userid && !"".equals(userid)) {
                    if(null!=client&&!"".equals(client)){
                        long time = System.currentTimeMillis();
                        String timeString = userid + time;
                        ServerCache.TICKET_AND_NAME.put(timeString, userid);
                    }
                    session.setAttribute("userid", userid);//如果用户存在那么进入系统
                    Cookie cookie = new Cookie("userid", userid);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    chain.doFilter(request, response);
                } else {
                    response.sendRedirect(serverURL);//如果用户名不存在，就跳到登录认证平台
                }
            } else {
                response.sendRedirect(serverURL);//如果用户名不存在，就跳到登录认证平台
            }
        } else {
            chain.doFilter(request, response);
        }

    }

    public void init(FilterConfig config) throws ServletException {
        Public.SCHEDULEDTHREADPOOLEXECUTOR.scheduleWithFixedDelay(new ServerCache.ClearInvalideCache(),10*1,5*2, TimeUnit.SECONDS);
        System.out.println("过滤器初始化");
    }

}