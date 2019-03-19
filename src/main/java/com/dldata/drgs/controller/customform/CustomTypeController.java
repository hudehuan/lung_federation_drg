package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomTypeEntity;
import com.dldata.drgs.service.customform.CustomTypeService;

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
@RequestMapping(value = "/CustomType")
public class CustomTypeController {


    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CustomTypeService customTypeService;


    @RequestMapping(value = "/getAllCustomType")
    @ResponseBody
    public List<CustomTypeEntity> getAllCustomType(){

        List <CustomTypeEntity> customTypeEntityList = null;

        customTypeEntityList = customTypeService.getAllCustomType();

        return customTypeEntityList;
    }


    @RequestMapping(value = "save")
    public void save(CustomTypeEntity customTypeEntity ,HttpServletRequest request, HttpServletResponse response) throws  Exception{

        String result;
        try {
            if (customTypeEntity.getId().equals("")) {
                customTypeEntity.setId(UUID.randomUUID().toString());
                List<CustomTypeEntity> customTypeEntities = customTypeService.findByName(customTypeEntity.getName());
                if (customTypeEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"分类名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                CustomTypeEntity customType = customTypeService.findOne(customTypeEntity.getId());
                if(!customType.getName().equals(customTypeEntity.getName())){
                    List<CustomTypeEntity> customTypeEntities = customTypeService.findByName(customTypeEntity.getName());
                    if  (customTypeEntities.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"分类名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            customTypeService.save(customTypeEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
