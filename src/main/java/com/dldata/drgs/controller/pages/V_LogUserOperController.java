package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_LogUserOper")
public class V_LogUserOperController {

    @RequestMapping(value = "/gotoLogUserOper")
    public String gotoUserOnline(Model model) {
        model.addAttribute("titlename", "在线用户列表");
        return "Log/LogUserOper";
    }
}
