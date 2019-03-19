package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysUserRoles")
public class V_SysUserRolesController {


    @RequestMapping(value = "/toList")
    public String toList(String userId,Model model){
        model.addAttribute("userId", userId);
        return "System/SysUserRoles";
    }

}
