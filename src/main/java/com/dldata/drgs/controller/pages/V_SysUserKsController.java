package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysUserKs")
public class V_SysUserKsController {


    @RequestMapping(value = "/toUserKs")
    public String toUserKs(String userid, Model model) {
        model.addAttribute("userid", userid);
        return "System/SysUserKs";
    }
}
