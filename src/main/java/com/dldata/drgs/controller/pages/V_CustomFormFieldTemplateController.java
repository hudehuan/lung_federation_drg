package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/v_CustomFormFieldTemplate")
public class V_CustomFormFieldTemplateController {


    @RequestMapping(value = "/toList")
    public String toList(String templateId, Model model){
        model.addAttribute("templateId",templateId);
        return "customform/v_CustomFormFieldTemplate";
    }
}
