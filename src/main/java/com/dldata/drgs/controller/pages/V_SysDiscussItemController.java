package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_SysDiscussItem")
public class V_SysDiscussItemController {


    @RequestMapping(value = "/gotoDiscussItem")
    public String gotoDiscussItem(Model model) {
        model.addAttribute("titlename","讨论交流反馈表");
        return "System/SysDiscussItem";
    }


    @RequestMapping(value="/toEdit")
    public String toEdit(){
        return "System/SysDiscussItemEdit";
    }
}
