package com.dldata.drgs.controller.Log;

import com.dldata.drgs.entity.LogUserOperEntity;
import com.dldata.drgs.service.Log.LogUserOperService;
import com.dldata.drgs.utils.BrowseTool;
import com.dldata.drgs.utils.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/LogUserOper")
public class LogUserOperController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    LogUserOperService logUserOperService;

//    @Autowired
//    SysStaffService staffService;

//    @RequestMapping(value = "/gotoLogUserOper")
//    public String gotoUserOnline(Model model) {
//        model.addAttribute("titlename", "在线用户列表");
//        return "Log/LogUserOper";
//    }


    @RequestMapping(value = "/getAllLogUserOper")
    @ResponseBody
    public List<LogUserOperEntity> getAllLogUserOper(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<LogUserOperEntity> logUserOperEntities = new ArrayList<LogUserOperEntity>();
//        List<ShowUserOnline> showList = new ArrayList<ShowUserOnline>();
        String result;
        try {
            logUserOperEntities = logUserOperService.getAllLogUserOper();
            if (logUserOperEntities.size() > 0) {
                logUserOperEntities.forEach((u) -> {
//                    ShowUserOnline userOnline = new ShowUserOnline();
//                    userOnline.setUserId(u.getUserId());
//                    userOnline.setLoginTime(u.getLoginTime());
//                    userOnline.setSysCode(u.getSysCode());
//                    SysStaffEntity staffEntity = staffService.findOne(u.getUserId());
//                    if (staffEntity != null) {
//                        userOnline.setUserName(staffEntity.getName());
//                    }
//                    showList.add(userOnline);
                });
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllUserOnline() 方法失败 】异常：" + ex.getMessage());
        }
        return logUserOperEntities;
    }

    @RequestMapping(value = "/save")
    public void save(@CookieValue(value = "syscode", defaultValue = "") String sysCode,
                     HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        String userName = request.getParameter("userName");
        String url = request.getParameter("url");
        LogUserOperEntity logUserOperEntity = new LogUserOperEntity();
        try {
            String agent = request.getHeader("User-Agent");
//            StringTokenizer st = new StringTokenizer(Agent, ")");
//            st.nextToken();
            //得到用户的浏览器名
            String userbrowser = BrowseTool.checkBrowse(agent);;
            logUserOperEntity.setOptBrowse(userbrowser);

            logUserOperEntity.setId(UUID.randomUUID().toString());
            logUserOperEntity.setOptDate(new Timestamp(new Date().getTime()));
            logUserOperEntity.setSessionId(request.getSession().getId());
            logUserOperEntity.setOptIp(getIp(request));
            logUserOperEntity.setUserName(userName);
            logUserOperEntity.setUrl(url);

            logUserOperService.save(logUserOperEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<LogUserOperEntity> findByCondition(String condition, HttpServletRequest request, HttpServletResponse response) throws Exception {
//        List<ShowUserOnline> showList = new ArrayList<ShowUserOnline>();
        List<LogUserOperEntity> logUserOperEntities = new ArrayList<LogUserOperEntity>();
        String result;
        try {
            logUserOperEntities = logUserOperService.findByCondition("%" + condition + "%");
//            if (logUserOperEntities.size() > 0) {
//                sysUserOnline.forEach((u)-> {
//                    ShowUserOnline userOnline = new ShowUserOnline();
//                    userOnline.setUserId(u.getUserId());
//                    userOnline.setLoginTime(u.getLoginTime());
//                    userOnline.setSysCode(u.getSysCode());
//                    SysStaffEntity staffEntity = staffService.findOne(u.getUserId());
//                    if (staffEntity != null) {
//                        userOnline.setUserName(staffEntity.getName());
//                    }
//                    showList.add(userOnline);
//                });
//            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findRoleByCondition() 方法失败 】异常：" + ex.getMessage());
        }
        return logUserOperEntities;
    }

    // 获取客户端IP
    private String getIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
            //多次反向代理后会有多个ip值，第一个ip才是真实ip
            int index = ip.indexOf(",");
            if (index != -1) {
                return ip.substring(0, index);
            } else {
                return ip;
            }
        }
        ip = request.getHeader("X-Real-IP");
        if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
            return ip;
        }
        return request.getRemoteAddr();
    }

    public String getBrowserName(String agent) {
        if (agent.indexOf("msie 7") > 0) {
            return "ie7";
        } else if (agent.indexOf("msie 8") > 0) {
            return "ie8";
        } else if (agent.indexOf("msie 9") > 0) {
            return "ie9";
        } else if (agent.indexOf("msie 10") > 0) {
            return "ie10";
        } else if (agent.indexOf("msie") > 0) {
            return "ie";
        } else if (agent.indexOf("chrome") > 0) {
            return "chrome";
        } else if (agent.indexOf("opera") > 0) {
            return "opera";
        } else if (agent.indexOf("firefox") > 0) {
            return "firefox";
        } else if (agent.indexOf("webkit") > 0) {
            return "webkit";
        } else if (agent.indexOf("gecko") > 0 && agent.indexOf("rv:11") > 0) {
            return "ie11";
        } else {
            return "Others";
        }
    }
}
