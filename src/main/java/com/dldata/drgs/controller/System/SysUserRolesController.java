package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.entity.SysUserRolesEntity;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.service.System.SysUserRolesService;
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
@RequestMapping(value = "/SysUserRoles")
public class SysUserRolesController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysUserRolesService userRolesService;

    @Autowired
    SysRoleService roleService;

//    @RequestMapping(value = "/toList")
//    public String toList(String userId,Model model){
//        model.addAttribute("userId", userId);
//        return "System/SysUserRoles";
//    }

    @RequestMapping(value = "/getAllRole")
    @ResponseBody
    public String getAllRole(String uerId,
                                     @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                     HttpServletRequest request, HttpServletResponse response)throws Exception{

        List<SysUserRolesEntity> sysRole = userRolesService.getAllRole(uerId,sysCode);
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysRoleEntity> sysRoleEntities = roleService.getAllRole(sysCode);
        String result;
        try{
            sysRole.forEach((p) -> {
              Map<String,String>  map = new HashMap<String, String>();
                map.put("id",p.getId());
                map.put("name","");
                map.put("xh", "");
                sysRoleEntities.stream().filter(r -> r.getId().equals(p.getRoleId())).limit(1).forEach(r -> {
                    map.put("name", r.getName());
                    map.put("xh", r.getXh().toString());
                    mapList.add(map);
                });
            });
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllRole() 方法失败 】异常："+ex.getMessage());
        }

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value="/save")
    public void saveUserRoles(String uerId, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                              String roleId,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;
        SysUserRolesEntity userRoles = new SysUserRolesEntity();
        try {
            if (userRoles.getId() == null) {
                userRoles.setId(UUID.randomUUID().toString());
            }
            List<SysUserRolesEntity> userRoleEntities = new ArrayList<SysUserRolesEntity>();
            userRoleEntities = userRolesService.getAllRole(uerId,sysCode);
            if (userRoleEntities.size() > 0) {
                for (SysUserRolesEntity u : userRoleEntities) {
                    if (u.getRoleId().equals(roleId)) {
                        result = "{\"success\":false,\"msg\":\"权限已存在！\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            userRoles.setUerId(uerId);
            userRoles.setRoleId(roleId);
            userRoles.setSysCode(sysCode);
            userRolesService.save(userRoles);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveUserRoles() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
        //return "System/SysUserInfo";
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            userRolesService.deleteById(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteUserRoles() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
