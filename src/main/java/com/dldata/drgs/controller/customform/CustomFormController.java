package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/CustomForm")
public class CustomFormController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CustomFormService customFormService;

    @RequestMapping(value = "/addFormType")
    public void addFormType(String formId,String typeId , HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(formId);
            customFormEntity.setTypeId(typeId);
            customFormService.save(customFormEntity);
            result = "{\"success\":true,\"msg\":\"表单分类添加成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"添加失败！\"}";
            logger.error("【执行"+this.getClass().getName()+".addFormType() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/getFormByTypeID")
    @ResponseBody
    public List<CustomFormEntity> getFormByTypeID(String typeId){
        List<CustomFormEntity> customFormEntities = customFormService.getFormByTypeId(typeId);
        return  customFormEntities;
    }


    @RequestMapping(value = "/getAllCustomForm")
    @ResponseBody
    public List<CustomFormEntity> getAllCustomForm(){


        return customFormService.getAllCustomForm();

    }

    @RequestMapping(value = "/findBySearch")
    @ResponseBody
    public List<CustomFormEntity> findBySearch(String searchForm){


        return customFormService.findBySearchLike(searchForm);

    }


    @RequestMapping(value = "/save")
    public void save(CustomFormEntity customFormEntity, HttpServletRequest request, HttpServletResponse response)throws Exception{

        String result = "";

        if(StringUtil.isNullOrSpace(customFormEntity.getId())){
            customFormEntity.setId(UUID.randomUUID().toString());
        }

        try {
            customFormService.save(customFormEntity);
            result = "{\"success\":true,\"msg\":\"成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }

        StringUtil.writeToWeb(result, "html", response);

    }



}
