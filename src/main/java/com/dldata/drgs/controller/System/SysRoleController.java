package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysRole")
public class SysRoleController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    SysRoleService sysRoleService;


//    @RequestMapping(value = "/gotoRole")
//    public String gotoRole(Model model){
//        model.addAttribute("titlename","角色表");
//        return "System/SysRole";
//    }


    @RequestMapping(value = "/getAllRole")
    @ResponseBody
    public List<SysRoleEntity> getAllRole(@CookieValue(value = "syscode",defaultValue = "")String sysCode,HttpServletRequest request, HttpServletResponse response)throws Exception{

        List<SysRoleEntity> sysRole = new ArrayList<SysRoleEntity>();
        String result;
        try{
            sysRole = sysRoleService.getAllRole(sysCode);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllRole() 方法失败 】异常："+ex.getMessage());
        }

        return sysRole;
    }

//    @RequestMapping(value="/toUpdate")
//    public String toUpdate(String id, Model model){
//        SysRoleEntity roleEntity = sysRoleService.findOne(id);
//        if (roleEntity != null){
//            model.addAttribute("role",roleEntity);
//        }
//        return "System/SysRole";
//    }

    @RequestMapping(value="/save")
    public void save(SysRoleEntity roleEntity,@CookieValue(value = "syscode",defaultValue = "") String sysCode,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;
        try {
            if (roleEntity.getId().equals("")) {
                roleEntity.setId(UUID.randomUUID().toString());
                List<SysRoleEntity> roles = new ArrayList<SysRoleEntity>();
                roles = sysRoleService.findByName(roleEntity.getName(), sysCode);
                if (roles.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = roleEntity.getId();
                SysRoleEntity oldRole = sysRoleService.findOne(id);
                String oldName = oldRole.getName();
                if (!roleEntity.getName().equals(oldName)) {
                    List<SysRoleEntity> roles = new ArrayList<SysRoleEntity>();
                    roles = sysRoleService.findByName(roleEntity.getName(), sysCode);
                    if (roles.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            if (roleEntity.getXh() == null) {
                roleEntity.setXh(0);
            }
            if (!roleEntity.getName().equals("") || roleEntity.getName() != null) {
                String pym = StringUtil.getPinYinHeadChar(roleEntity.getName());
                roleEntity.setPym(pym);
            }
            roleEntity.setSysCode(sysCode);
            roleEntity.setStatus(1);
            sysRoleService.save(roleEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveRole() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            SysRoleEntity roleEntity = sysRoleService.findOne(id);
            roleEntity.setStatus(0);
            sysRoleService.save(roleEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteRole() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysRoleEntity> findByCondition(@CookieValue(value = "syscode",defaultValue = "") String sysCode,String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysRoleEntity> roleEntities = new ArrayList<SysRoleEntity>();
        String result;
        try{
            roleEntities = sysRoleService.findByCondition("%"+condition+"%", sysCode);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".findRoleByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return roleEntities;
    }
}
