package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.CustomFormTypeEntity;
import com.dldata.drgs.entity.CustomTypeEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.CustomFormTypeService;
import com.dldata.drgs.service.customform.CustomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2016/12/7.
 */
@Controller
@RequestMapping("/customFormHome")
public class V_CustomHomePageContoller {


    @Autowired
    private CustomFormService customFormService;

    @Autowired
    private CustomTypeService customTypeService;

    @Autowired
    private CustomFormTypeService customFormTypeService;

    @RequestMapping(value = "/customFormIndex/{userHome}")
    public String goHome(@PathVariable("userHome") String userHome,Model model){

        List<CustomTypeEntity>  customTypeEntities = customTypeService.getAllCustomType();

        List<CustomFormTypeEntity> customFormTypeEntities = customFormTypeService.getAllFormType();
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        List<CustomFormEntity> customFormMenu = new ArrayList<CustomFormEntity>();
        customFormTypeEntities.forEach(formType -> {
            customFormEntities.stream().filter(f -> f.getId().equals(formType.getFormId())).limit(1).forEach(f ->{
                f.setTypeId(formType.getTypeId());
                customFormMenu.add(f);
            });

        });

        model.addAttribute("FormTypes",customTypeEntities);
        model.addAttribute("Forms",customFormMenu);


        return "/customFormIndex/"+userHome;
    }

}
