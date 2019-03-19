package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */

@Controller
@RequestMapping(value = "/V_SysRoleMenu")
public class V_SysRoleMenuController {


    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;


    @RequestMapping(value = "/toList")
    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                         Model model,HttpServletRequest request,HttpServletResponse response){
        model.addAttribute("titlename", "角色权限管理");

        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "System/SysRoleMenu";
    }
}
