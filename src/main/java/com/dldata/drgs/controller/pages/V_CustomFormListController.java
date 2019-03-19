package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/6/9.
 */
@Controller
@RequestMapping("/V_CustomFormList")
public class V_CustomFormListController {


    @RequestMapping("/toList")
    public String toList(String formId,String listName,Model model) {
        model.addAttribute("formId",formId);
        return "fromList/"+listName;
    }
}
