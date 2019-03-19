package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/v_customform")
public class V_CustomFormController {


    @Autowired
    private CustomFormService customFormService;


    @RequestMapping(value = "/toList")
    public String toList(){


        return "customform/v_CustomForm";
    }


    @RequestMapping(value = "/toEdit")
    public String toEdit(Model model, String formId){


        if(!StringUtil.isNullOrSpace(formId)){
            CustomFormEntity entity = customFormService.getCustomFormByFormId(formId);
            model.addAttribute("data",entity);
        }



        return "customform/v_CustomFormEdit";
    }



    @RequestMapping("/toSelectForm")
    private String toSelectForm(String typeId,Model model){
        model.addAttribute("typeId",typeId);

        return "customform/v_CustomFormSelect";
    }

    @RequestMapping("/toCustomFromSb")
    public String toCustomFromSb(){
        return "customform/v_customFormSb";
    }

}
