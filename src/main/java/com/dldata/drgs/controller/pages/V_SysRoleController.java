package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.service.System.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */

@Controller
    @RequestMapping(value = "/V_SysRole")
public class V_SysRoleController {

    @Autowired
    SysRoleService sysRoleService;

    @RequestMapping(value="/toEdit")
    public String toEdit(String id, Model model){
        if(id !=null && !id.equals("")){
            SysRoleEntity roleEntity = sysRoleService.findOne(id);
            if (roleEntity != null){
                model.addAttribute("role",roleEntity);
            }
        }
        return "System/SysRoleEdit";
    }
}
