package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomTypeEntity;
import com.dldata.drgs.service.customform.CustomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/4/20.
 */
@Controller
@RequestMapping(value = "/v_customformtype")
public class V_CustomTypeController {

    @Autowired
    private CustomTypeService customTypeService;

    @RequestMapping(value = "/toList")
    public String toList(){


        return "customform/v_CustomType";
    }


    @RequestMapping("toEdit")
    public String toEdit(String typeId,Model model){
        model.addAttribute("title","表单分类编辑");
        if(typeId !=null && !typeId.equals("")){
            CustomTypeEntity customTypeEntity = customTypeService.findOne(typeId);
            model.addAttribute("entity",customTypeEntity);
        }
        return  "customform/v_CustomTypeEdit";
    }

}
