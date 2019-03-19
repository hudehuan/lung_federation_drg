package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysKsEntity;
import com.dldata.drgs.entity.SysUserKsEntity;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysUserKsService;
import com.dldata.drgs.utils.StringUtil;
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
import java.util.*;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysUserKs")
public class SysUserKsController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysUserKsService userKsService;

    @Autowired
    SysKeShiService keShiService;

    @RequestMapping(value = "/getAllUserKs")
    @ResponseBody
    public String getAllUserKs(String userid, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                               HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<SysUserKsEntity> userKs = userKsService.getAllUserKs(userid,sysCode);
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysKsEntity> sysKsEntities = keShiService.getAllKeShi();
        String result;
        try {
            userKs.forEach((p) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("id",p.getId());
                map.put("name","");
                map.put("xh","");
                sysKsEntities.stream().filter(ks -> ks.getId().equals(p.getKsid())).limit(1).forEach(ks -> {
                    map.put("name", ks.getName());
                    map.put("xh", ks.getXh().toString());
                    mapList.add(map);
                });
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllUserKs() 方法失败 】异常：" + ex.getMessage());
        }

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/save")
    public void save(String userid, String ksid,
                     @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     HttpServletRequest request,
                     HttpServletResponse response) throws Exception {
        String result;
        SysUserKsEntity userKs = new SysUserKsEntity();
        try {
            if (userKs.getId() == null) {
                userKs.setId(UUID.randomUUID().toString());
            }

            List<SysUserKsEntity> userKsEntities = new ArrayList<SysUserKsEntity>();
            userKsEntities = userKsService.getAllUserKs(userid,sysCode);
            if (userKsEntities.size() > 0) {
                for (SysUserKsEntity u : userKsEntities) {
                    if (u.getKsid().equals(ksid)) {
                        result = "{\"success\":false,\"msg\":\"科室已存在！\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            userKs.setKsid(ksid);
            userKs.setUserid(userid);
            userKs.setSysCode(sysCode);
            userKsService.save(userKs);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveUserKs() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
        //return "System/SysUserInfo";
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            userKsService.deleteById(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserKs() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


//    private class UserKs {
//        private String id;
//        private String name;
//        private Integer xh;
//
//        public String getId() {
//            return id;
//        }
//
//        public void setId(String id) {
//            this.id = id;
//        }
//
//        public Integer getXh() {
//            return xh;
//        }
//
//        public void setXh(Integer xh) {
//            this.xh = xh;
//        }
//
//        public String getName() {
//            return name;
//        }
//
//        public void setName(String name) {
//            this.name = name;
//        }
//    }
}
