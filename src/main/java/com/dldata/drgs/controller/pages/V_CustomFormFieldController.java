package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/v_customformfield")
public class V_CustomFormFieldController {

    @Autowired
    private CustomFormFieldService customFormFieldService;


    @RequestMapping(value = "/toList")
    public String toList(){
        return "customeform/v_CustomFormField";
    }


    @RequestMapping(value = "/toEdit")
    public String toEdit(Model model,String formId, String fieldId){

        CustomFormFieldEntity entity = null;
        if(!StringUtil.isNullOrSpace(fieldId)){
            entity = customFormFieldService.getFieldByFieldId(fieldId);

        }
        else{
            entity = new CustomFormFieldEntity();
            entity.setPkey(false);
        }
        model.addAttribute("data",entity);
        model.addAttribute("formId",formId);

        return "customform/v_CustomFormFieldEdit";
    }





}
