package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */

@Controller
@RequestMapping(value = "/V_SysHomePage")
public class V_SysHomePageController {


    @RequestMapping(value = "/toHomePageInterface")
    public String gotoDictionary(Model model) {
        model.addAttribute("titlename","首页界面表");
        return "System/SysHomePage";
    }
}
