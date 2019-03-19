package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.CustomFormTypeEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.CustomFormTypeService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/CustomFormType")
public class CustomFormTypeController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CustomFormTypeService customFormTypeService;

    @Autowired
    private CustomFormService customFormService;

    @RequestMapping("getFormByTypeID")
    @ResponseBody
    public String getFormByTypeID(String typeId){
        List<CustomFormTypeEntity> customFormTypeEntities = customFormTypeService.getFormByTypeId(typeId);
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();

        customFormTypeEntities.forEach(en -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("formTypeId",en.getId());
            map.put("xh",en.getXh().toString());
            map.put("sm",en.getSm().toString());
            map.put("formId","");
            map.put("name","");
            map.put("code","");
            customFormEntities.stream().filter(f -> f.getId().equals(en.getFormId()==null?"":en.getFormId())).forEach(f -> {
                map.put("formId",f.getId());
                map.put("name",f.getName());
                map.put("code",f.getCode());
            });
            mapList.add(map);
        });

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "save")
    public void save(CustomFormTypeEntity customFormTypeEntity ,HttpServletRequest request, HttpServletResponse response) throws  Exception{

        String result;
        try {
            if (customFormTypeEntity.getId().equals("")) {
                customFormTypeEntity.setId(UUID.randomUUID().toString());
                List<CustomFormTypeEntity> customFormTypeEntities = new ArrayList<CustomFormTypeEntity>();
                customFormTypeEntities = customFormTypeService.findByTypeIdXh(customFormTypeEntity.getTypeId(), customFormTypeEntity.getXh());
                if (customFormTypeEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"序号已存在！\",\"id\":\"#xh\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                customFormTypeEntities = customFormTypeService.findByFormId(customFormTypeEntity.getFormId());
                if (customFormTypeEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"表单已存在！\",\"id\":\"#formName\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }

            customFormTypeService.save(customFormTypeEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"操作错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("delete")
    public void delete(String formTypeId,HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            customFormTypeService.deleteOne(formTypeId);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"操作错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }


}
