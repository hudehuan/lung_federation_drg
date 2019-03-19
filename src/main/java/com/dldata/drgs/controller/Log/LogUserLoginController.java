package com.dldata.drgs.controller.Log;

import com.dldata.drgs.entity.LogUserLoginEntity;
import com.dldata.drgs.entity.SysStaffEntity;
import com.dldata.drgs.service.Log.LogUserLoginService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping(value = "/LogUserLogin")
public class LogUserLoginController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    LogUserLoginService logUserLoginService;

    @Autowired
    SysStaffService staffService;

//    @RequestMapping(value = "/gotoLogUserLogin")
//    public String gotouserLogin(Model model) {
//        model.addAttribute("titlename", "在线用户列表");
//        return "Log/LogUserLogin";
//    }


    @RequestMapping(value = "/getAllUserLogin")
    @ResponseBody
    public String getAllLogUserOper(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<LogUserLoginEntity> logUserLoginEntities = new ArrayList<LogUserLoginEntity>();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        String result;
        try {
            List<SysStaffEntity> staffEntities = staffService.getAllStaff();
            logUserLoginEntities = logUserLoginService.getAllLogUserLogin();
            logUserLoginEntities.forEach((u) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("userId",u.getUserId());

                map.put("id", u.getId());
                map.put("loginIp", u.getLoginIp());
                map.put("loginDate", u.getLoginDate().toString());
                map.put("loginTime", u.getLoginTime().toString());
                map.put("sysCode", u.getSysCode());
                map.put("userName","");
                staffEntities.stream().filter(s -> s.getId().equals(u.getUserId())).limit(1).forEach(s -> {
                    map.put("userName",s.getName());
                });
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllUserLogin() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public String findByCondition(String condition,String startTime ,String endTime,
                                                    HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<LogUserLoginEntity> logUserLoginEntities = new ArrayList<LogUserLoginEntity>();
        String result;
        Timestamp sTime = Timestamp.valueOf(startTime + " 00:00:00");
        Timestamp eTime = Timestamp.valueOf(endTime + " 23:59:59");
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        try {
            logUserLoginEntities = logUserLoginService.findByCondition("%" + condition + "%",sTime,eTime);
            List<SysStaffEntity> staffEntities = staffService.getAllStaff();
            logUserLoginEntities.forEach((u) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("userId",u.getUserId());

                map.put("id", u.getId());
                map.put("loginIp", u.getLoginIp());
                map.put("loginDate", u.getLoginDate().toString());
                map.put("loginTime", u.getLoginTime().toString());
                map.put("sysCode", u.getSysCode());
                map.put("userName","");
                staffEntities.stream().filter(s -> s.getId().equals(u.getUserId())).limit(1).forEach(s -> {
                    map.put("userName",s.getName());
                });
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findRoleByCondition() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

}
