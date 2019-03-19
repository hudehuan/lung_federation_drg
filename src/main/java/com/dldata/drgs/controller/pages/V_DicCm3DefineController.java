package com.dldata.drgs.controller.pages;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Controller
@RequestMapping("/V_DicCm3Define")
public class V_DicCm3DefineController {

    @RequestMapping("/toList")
    public String toList(){
        return "drgsDicData/v_dicCm3Define";
    }

    @RequestMapping("/toEdit")
    public String toEdit(String id, Model model){
        if(id!=null && !id.equals("")){

        }
        return "drgsDicData/v_dicCm3DefineEdit";
    }


}
