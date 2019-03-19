package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysUserOnline")
public class V_SysUserOnlineController {

    @RequestMapping(value = "/gotoUserOnline")
    public String gotoUserOnline(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "System/SysUserOnline";
    }
}
