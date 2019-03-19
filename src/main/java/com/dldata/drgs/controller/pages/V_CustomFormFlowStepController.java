package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/18.
 */
@Controller
@RequestMapping("/V_CustomFormFlowStep")
public class V_CustomFormFlowStepController {

    @RequestMapping("/toStpeEdit")
    public String toSteoAdd(){
        return "customform/v_customFormFlowStepEdit";
    }

    @RequestMapping("/toSeleYh")
    public String toSeleYh(){
        return "customform/v_customFormFlowStepUser";
    }
}
