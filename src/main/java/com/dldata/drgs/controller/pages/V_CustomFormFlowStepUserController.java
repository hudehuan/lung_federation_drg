package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/18.
 */
@Controller
@RequestMapping("/V_CustomFormFlowStepUser")
public class V_CustomFormFlowStepUserController {

    @RequestMapping("/toSeleStepUser")
    public String toSeleStepUser(){
        return "customform/v_customFormFlowStepUser";
    }

}
