package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */

@Controller
@RequestMapping(value = "/V_SysDiscuss")
public class V_SysDiscussController {


    @RequestMapping(value = "/gotoDiscuss")
    public String gotoDictionary(Model model) {
        model.addAttribute("titlename","交流讨论表");
        return "System/SysDiscuss";
    }

    @RequestMapping(value="/toEdit")
    public String toEdit(String id){
        return "System/SysDiscussEdit";
    }
}
