package com.dldata.drgs.controller.pages;


import com.dldata.drgs.entity.SjsbFormStepCheckListEntity;
import com.dldata.drgs.service.customform.SjsbFormStepCheckListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/9.
 */
@Controller
@RequestMapping("/V_CustomFormShLog")
public class V_CustomFormShLogController {//V_CheckLog
    @Autowired
    private SjsbFormStepCheckListService customFormStepCheckListService;

    @RequestMapping("/toLogList")
    public String toLogList(String checkID,Model model){

        SjsbFormStepCheckListEntity checkListEntity = customFormStepCheckListService.getEntityByID(checkID);
        String formID = checkListEntity.getFormId();
        String dataID = checkListEntity.getDataId();
        model.addAttribute("formID",formID);
        model.addAttribute("dataID",dataID);
        return "customform/v_CustomFormCheckLog";
    }

    //驳回
    @RequestMapping("/tobohui")
    public String tobohui(String id,Model model) {

        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = customFormStepCheckListService.getCheckFormByDataID(id);

        String checkID = sjsbFormStepCheckListEntity.getId();
        String formID = sjsbFormStepCheckListEntity.getFormId();
        String dataID = sjsbFormStepCheckListEntity.getDataId();
        String flowID = sjsbFormStepCheckListEntity.getFlowId();
        String stepID = sjsbFormStepCheckListEntity.getStepId();

        model.addAttribute("dataID",dataID);
        model.addAttribute("checkID",checkID);
        model.addAttribute("formID",formID);
        model.addAttribute("flowID",flowID);
        model.addAttribute("stepID",stepID);


        return "customform/v_custonFormShLogInfo";
    }
}
