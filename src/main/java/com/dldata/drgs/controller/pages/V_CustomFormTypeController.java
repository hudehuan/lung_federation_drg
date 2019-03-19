package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.CustomFormTypeEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.CustomFormTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/v_customformtabletype")
public class V_CustomFormTypeController {

    @Autowired
    private CustomFormTypeService customFormTypeService;

    @Autowired
    private CustomFormService customFormService;

    @RequestMapping("toEdit")
    public String toEdit(String typeId,String formTypeId,Model model){
        model.addAttribute("title","表单编辑");
        model.addAttribute("typeId",typeId);
        if(formTypeId !=null && !formTypeId.equals("")){
            CustomFormTypeEntity customFormTypeEntity = customFormTypeService.findOne(formTypeId);
            model.addAttribute("entity",customFormTypeEntity);
            if(customFormTypeEntity!=null){
                CustomFormEntity customFormEntity = customFormService
                        .getCustomFormByFormId(customFormTypeEntity.getFormId()==null?"":customFormTypeEntity.getFormId());
                model.addAttribute("formName",customFormEntity.getName());
            }
        }
        return  "customform/v_CustomFormTypeEdit";
    }
}
