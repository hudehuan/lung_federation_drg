package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */

@Controller
@RequestMapping("/V_DicIcd10Define")
public class V_DicIcd10DefineController {
    @RequestMapping("/toList")
    public String toList(){
        return "drgsDicData/v_dicIcd10Define";
    }

    @RequestMapping("/toEdit")
    public String toEdit(String id, Model model){
        if(id!=null && !id.equals("")){

        }
        return "drgsDicData/v_dicIcd10DefineEdit";
    }
}
