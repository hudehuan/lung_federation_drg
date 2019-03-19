package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/6/7.
 */
@Controller
@RequestMapping("/V_CustomFormFlowStepUser")
public class V_CustomFormKeshiController {

    @RequestMapping("toFormKeshi")
    public String toFormKeshi(){
        return "customform/v_CustomFormKeshi";
    }
}
