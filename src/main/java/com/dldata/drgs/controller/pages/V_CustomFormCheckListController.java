package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.SysUserKsService;
import com.dldata.drgs.service.customform.*;
import com.dldata.drgs.utils.SysConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/V_CustomFormCheckList")
public class V_CustomFormCheckListController {
    @Autowired
    private SjsbFormFlowStepUserService sjsbFormFlowStepUserService;

    @Autowired
    private SjsbFormStepCheckListService sjsbFormStepCheckListService;

    @Autowired
    private SysUserKsService userKsService;

    @Autowired
    private CustomFormService customFormService;
    @Autowired
    private SjsbFormFlowService sjsbFormFlowService;
    @Autowired
    private CustomFormTypeService customFormTypeService;


    @RequestMapping("/toCustomFromSb")
    public String toCustomFromSb(){
        return "customform/v_customFormSb";
    }


    @RequestMapping("/toCustomFormCheckList")
    public String toCustomFormCheckList(Model model,@CookieValue(value = "userid",defaultValue = "") String userId){
        int formStatus =1;
//        model.addAttribute("checkList", );
        List<SysUserKsEntity> sysUserKsList = new ArrayList<SysUserKsEntity>();
        sysUserKsList = userKsService.findByUserId(userId ,SysConfig.SysCode);
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = new ArrayList<SjsbFormFlowStepUserEntity>();
        sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);

        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = new ArrayList<SjsbFormStepCheckListEntity>();
//        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListList = sjsbFormStepCheckListService.getCheckListByUserID()

        for(int i=0;i<sjsbFormFlowStepUserEntities.size();i++) {
            SjsbFormFlowStepUserEntity t_step = sjsbFormFlowStepUserEntities.get(i);
            String t_flowid = t_step.getFlowId();
            String t_stepid = t_step.getStepId();

            //查询用户待审核的全部表单
            boolean t_isKs =t_step.getIsOnlyKs();

            List<SjsbFormStepCheckListEntity> t_CheckList = new ArrayList<SjsbFormStepCheckListEntity>();
            if(t_isKs){
                for(int a = 0 ;a<sysUserKsList.size();a++){
                    String ksId = sysUserKsList.get(a).getKsid();
                    t_CheckList = sjsbFormStepCheckListService.getNonCheckListByFlowIDStepIDKsID(t_flowid, t_stepid,ksId ,formStatus);
                    sjsbFormStepCheckListEntities.addAll(t_CheckList);
                }
            }
            else{

                t_CheckList = sjsbFormStepCheckListService.getNonCheckListByFlowIDStepID(t_flowid, t_stepid,formStatus);
                sjsbFormStepCheckListEntities.addAll(t_CheckList);
            }


        }


        model.addAttribute("noCheckNums",sjsbFormStepCheckListEntities.size());

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        //查询所有的表单,逐个汇总
//        List<SjsbFormEntity> sjsbFormEntityList = new ArrayList<SjsbFormEntity>();
//        sjsbFormEntityList = sjsbFormService.getAllForm(SysConfig.SysCode);
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        for(int e=0;e<customFormEntities.size();e++){
            String formID = customFormEntities.get(e).getId();

            int count = 0;
            for (int c=0;c<sjsbFormStepCheckListEntities.size();c++){

                if(formID.equals(sjsbFormStepCheckListEntities.get(c).getFormId())){
                    count++;
                }
            }

            if(count>0){
                Map<String,String> map = new HashMap<String,String>();
                map.put("formId", formID);
                map.put("formName", customFormEntities.get(e).getName());
                map.put("count", String.valueOf(count));

                mapList.add(map);
            }
        }

        model.addAttribute("FormCounts",mapList);


        List<SjsbFormFlowEntity> sjsbFormFlowEntities = sjsbFormFlowService.getfindAll();
        //得到用户审核表单
        List<CustomFormEntity> userCheckForm = new ArrayList<CustomFormEntity>();
        sjsbFormFlowStepUserEntities.forEach(us -> {
            sjsbFormFlowEntities.stream().filter(flow -> flow .getId().equals(us.getFlowId())).limit(1).forEach(flow -> {
                customFormEntities.stream().filter(f -> f.getId().equals(flow.getFormid())).limit(1).forEach(f -> {
                    userCheckForm.add(f);
                });
            });
        });
        model.addAttribute("checkForm",userCheckForm);
        return "customform/v_customFormCheckList";
    }

    @RequestMapping("/toAllCheckList")
    public String toAllCheckList(Model model){
        List<CustomFormTypeEntity> customFormTypeEntities = customFormTypeService.getAllFormType();
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        List<CustomFormEntity> userForm = new ArrayList<CustomFormEntity>();
        customFormTypeEntities.forEach(t -> {
            customFormEntities.stream().filter(f -> f.getId().equals(t.getFormId())).limit(1).forEach(f -> {
                userForm.add(f);
            });
        });
        model.addAttribute("form",userForm);
        return "customform/v_customFormCheckAllList";
    }

}
