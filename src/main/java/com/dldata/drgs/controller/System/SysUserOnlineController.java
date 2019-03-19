package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysStaffEntity;
import com.dldata.drgs.entity.SysUserOnlineEntity;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.service.System.SysUserOnlineService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysUserOnline")
public class SysUserOnlineController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysUserOnlineService sysUserOnlineService;

    @Autowired
    SysStaffService staffService;

    @Autowired
    SysConfig sysConfig;

//    @RequestMapping(value = "/gotoUserOnline")
//    public String gotoUserOnline(Model model){
//        model.addAttribute("titlename","在线用户列表");
//        return "System/SysUserOnline";
//    }


    @RequestMapping(value = "/getAllUserOnline")
    @ResponseBody
    public String  getAllUserOnline(HttpServletRequest request, HttpServletResponse response)throws Exception{

        List<SysUserOnlineEntity> sysUserOnline = sysUserOnlineService.getAllUserOnline();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysStaffEntity> staffEntities = staffService.getAllStaff();
        String result;
        try{
            if (sysUserOnline.size() > 0) {
                sysUserOnline.forEach((u)-> {
                    Map<String,String> map = new HashMap<String, String>();
                    map.put("userId",u.getUserId());
                    map.put("loginTime",u.getLoginTime().toString());
                    map.put("sysCode", u.getSysCode());
                    map.put("userName","");
                    staffEntities.stream().filter(s -> s.getId().equals(u.getUserId())).limit(1).forEach(s -> {
                        map.put("userName", s.getName());
                    });
                    mapList.add(map);
                });
            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllUserOnline() 方法失败 】异常："+ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public String findByCondition(String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysStaffEntity> staffEntities = staffService.getAllStaff();
        List<SysUserOnlineEntity> sysUserOnline = sysUserOnlineService.findByCondition("%" + condition + "%");
        String result;
        try{
            if (sysUserOnline.size() > 0) {
                sysUserOnline.forEach((u)-> {
                    Map<String,String> map = new HashMap<String, String>();
                    map.put("userId", u.getUserId());
                    map.put("loginTime", u.getLoginTime().toString());
                    map.put("sysCode", u.getSysCode());
                    map.put("userName","");
                    staffEntities.stream().filter(s -> s.getId().equals(u.getUserId())).limit(1).forEach(s -> {
                        map.put("userName", s.getName());
                    });
                    mapList.add(map);
                });
            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".findRoleByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/update")
    public void updateUserOnline(@CookieValue(value = "userid",defaultValue = "") String userid,
                                 HttpServletRequest request, HttpServletResponse response)throws Exception{


        HttpSession session = request.getSession();

        //String userid = (String)session.getAttribute("userid");

        String sysCode = sysConfig.SysCode;
        SysUserOnlineEntity userOnlineEntity = new SysUserOnlineEntity();

        try {
            userOnlineEntity = sysUserOnlineService.getUserOnlineD(userid, sysCode).get(0);
        }
        catch(Exception ex){

        }
        userOnlineEntity.setSessionId(session.getId());
        userOnlineEntity.setLoginTime(new Timestamp(new Date().getTime()));


        try {
            sysUserOnlineService.updateUserOnline(userOnlineEntity);
        }
        catch (Exception ex){

        }

    }

    @RequestMapping(value = "/upUserOnLine")
    public void upUserOnLine(@CookieValue(value = "userid",defaultValue = "") String userid,
                             @CookieValue(value = "syscode" ,defaultValue = "")String sysCode,
                             HttpServletRequest request, HttpServletResponse response)throws Exception{


        HttpSession session = request.getSession();

        //String userid = (String)session.getAttribute("userid");

        SysUserOnlineEntity userOnlineEntity = new SysUserOnlineEntity();

        try {
            userOnlineEntity = sysUserOnlineService.getUserOnlineD(userid, sysCode).get(0);
        }
        catch(Exception ex){

        }
        userOnlineEntity.setSessionId(session.getId());
        userOnlineEntity.setLoginTime(new Timestamp(new Date().getTime()));


        try {
            sysUserOnlineService.updateUserOnline(userOnlineEntity);
        }
        catch (Exception ex){

        }

    }
}
