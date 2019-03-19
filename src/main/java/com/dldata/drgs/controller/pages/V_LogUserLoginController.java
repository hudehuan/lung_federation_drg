package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_LogUserLoginController")
public class V_LogUserLoginController {


    @RequestMapping(value = "/gotoLogUserLogin")
    public String gotouserLogin(Model model) {
        model.addAttribute("titlename", "在线用户列表");
        return "Log/LogUserLogin";
    }

}
