package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2017/5/12.
 */


@Controller
@RequestMapping(value = "/v_customformtemplatepreview")
public class V_CustomFormTemplatePreview {

    @Autowired
    private CustomFormTemplateService customFormTemplateService;


//    @Autowired
//    public MemberService memberService;
//
//    @Autowired
//    private DemoService demoService;


    @RequestMapping(value = "/toPreview")
    public String toPreview(String templateId,Model model){
        CustomFormTemplateEntity entity = customFormTemplateService.getTemplateById(templateId);

        model.addAttribute("dataId","");
        model.addAttribute("templateId",templateId);
        model.addAttribute("tableId",entity.getFormId());
        model.addAttribute("entity",entity);
        model.addAttribute("title","用户自定义表单预览");

        return "customform/v_CustomFormTemplatePreview";
    }


//    @RequestMapping(value = "/toEdit")
//    public String toEdit(String templateId,String tableId,String dataId,Model model){
//
//        //根据数据ID，得到tableId
//
//
//        // templateId和tableId 暂时放在数据表中，以后要移到审核表中去获取
//        //String templateId  = "";
//        //String tableId = "";
//        CustomformtestEntity testEntity =  demoService.getOne(dataId);//暂时在数据表中去查询，以后改到审核表去获取
//
//        CustomFormTemplateEntity entity = customFormTemplateService.getTemplateById(templateId);
//
//        model.addAttribute("dataId",dataId);
//        //model.addAttribute("templateId",membersEntity.getTemplateid());
//        //model.addAttribute("tableId",membersEntity.getTableid());
//
//        model.addAttribute("templateId",templateId);
//        model.addAttribute("tableId",tableId);
//
//
//        model.addAttribute("entity",entity);
//
//        return "customform/v_CustomFormTemplatePreview";
//    }



    @RequestMapping(value = "/toAdd")
    public String toAdd(String tableId,Model model){

        //新增时，通过tableId,得到当前表单下激活的模板
        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getFormActivtyTemplateByFormId(tableId);
        if(customFormTemplateEntity==null){

            return "error";
        }

            String templateId  = customFormTemplateEntity.getId();
            CustomFormTemplateEntity entity = customFormTemplateService.getTemplateById(templateId);

            model.addAttribute("dataId","");
            model.addAttribute("templateId",templateId);
            model.addAttribute("tableId",tableId);
            model.addAttribute("entity",entity);


            return "customform/v_CustomFormTemplatePreview";




    }



}
