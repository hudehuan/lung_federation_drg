package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/31.
 */
@Controller
@RequestMapping(value = "/CUSTOMFORMPage")
public class V_CustomFormPrintController {

    @RequestMapping(value = "/toPrint")
    public String toPrint(String id, Model model) {
        return "customform/v_customFormPrint";
    }
}
