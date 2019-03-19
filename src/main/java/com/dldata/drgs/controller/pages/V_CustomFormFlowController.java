package com.dldata.drgs.controller.pages;


import com.dldata.drgs.entity.CustomTypeEntity;
import com.dldata.drgs.entity.SjsbFormFlowEntity;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.customform.SjsbFormFlowService;
import com.dldata.drgs.service.customform.CustomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/5/17.
 */
@Controller
@RequestMapping("/V_CustomFormFlow")
public class V_CustomFormFlowController {

    @Autowired
    private SysKeShiService sysKeShiService;
    @Autowired
    private SjsbFormFlowService customFormFlowService;

    @Autowired
    private CustomTypeService customTypeService;

    @RequestMapping("/toFormFlow")
    public String toFormFlowDefine(Model model){
        List<CustomTypeEntity> customTypeEntities = customTypeService.getAllCustomType();
        model.addAttribute("formTypes", customTypeEntities);
        String typeId="";
        if(customTypeEntities.size()>0){
            typeId = customTypeEntities.get(0).getId();
        }


        model.addAttribute("typeId",typeId);

        return "customform/v_CustomFormFlow";
    }

    @RequestMapping("/toFormFlowChange")
    public String toFormFlowChange(String formId,Model model){
        //查出审核流程
        List<SjsbFormFlowEntity> sjsbFormFlowEntities = new ArrayList<SjsbFormFlowEntity>();
        sjsbFormFlowEntities = customFormFlowService.getFormFlowByFormID(formId);
        model.addAttribute("flows",sjsbFormFlowEntities);
        return "customform/v_customFormFlowSelect";
    }

    @RequestMapping(value="/toEdit")
    public String toEdit(Model model,String id,String formId){
        model.addAttribute("formId",formId);
        if(id!=null&&!id.equals("")){
            SjsbFormFlowEntity sjsbFormFlowEntity = customFormFlowService.getFormFlowByID(id);
            model.addAttribute("sjsbFormFlowEntity",sjsbFormFlowEntity);
        }
        return "customform/v_customFormFlowEdit";
    }
}
