package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.Column;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/CustomFormField")
public class CustomFormFieldController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    private CustomFormFieldService customFormFieldService;
    @Autowired
    private CustomFormService customFormService;


    @RequestMapping(value = "/getFieldsByFormId")
    @ResponseBody
    public List<CustomFormFieldEntity> getFieldsByFormId(String formId){
        return customFormFieldService.getAllFieldByFormId(formId);
    }




    @RequestMapping(value = "/getFieldJsonByFormId")
    @ResponseBody
    public Map<String, Object> getFieldJsonByFormId(String formId){

        List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(formId);

        List<Map<String,String>> listmap = new ArrayList<Map<String,String>>();

        for(int i=0;i<customFormFieldEntityList.size();i++) {
            Map map = new HashMap();
            map.put("id", customFormFieldEntityList.get(i).getId());
            //名称,控件类型,字段类型,字段代码
            String name, controltype, fieldtype, code;
            name = customFormFieldEntityList.get(i).getFieldZhname();
            controltype = customFormFieldEntityList.get(i).getControlType();
            fieldtype = customFormFieldEntityList.get(i).getFieldType();
            code = customFormFieldEntityList.get(i).getFieldCode();

            String[] str = new String[]{name, controltype, fieldtype, code};
            map.put("data", str);


            listmap.add(map);

        }
        Map map2 = new  HashMap();
        map2.put("rows",listmap);

        Map<String, Object> returnmap = new HashMap();
        returnmap.put("success",true);
        returnmap.put("json1",map2);
        return returnmap;

    }

    @RequestMapping(value = "/save")
    public void save(CustomFormFieldEntity customFormFieldEntity,
                     HttpServletRequest request,
                     HttpServletResponse response)throws Exception{

        String result = "";

        if(StringUtil.isNullOrSpace(customFormFieldEntity.getId())){
            customFormFieldEntity.setId(UUID.randomUUID().toString());
        }

        try {
            if(customFormFieldEntity.getPkey() == null){
                customFormFieldEntity.setPkey(false);
            }

            customFormFieldEntity.setFieldCode(customFormFieldEntity.getFieldName());
            customFormFieldService.save(customFormFieldEntity);
            result = "{\"success\":true,\"msg\":\"成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }

        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/testField")
    @ResponseBody
    public String testField(String formId) throws Exception{
        String result = "";
        try {
            //得到表单字段
            List<CustomFormFieldEntity> customFormFieldEntities = customFormFieldService.getAllFieldByFormId(formId);

            CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(formId);

            //得到实体类属性
            String entityName = customFormEntity.getCode();
            Class c = null;
            try {
                c = Class.forName("com.dldata.drgs.entity." + entityName);
            } catch (ClassNotFoundException ex) {

            }
            Field[] fields = c.getDeclaredFields();
            String re = "";
            String name = "";
            for (int j = 0; j < customFormFieldEntities.size(); j++) {
                name = customFormFieldEntities.get(j).getFieldZhname();
                boolean isc = true;
                for (int i = 0; i < fields.length; i++) {
                    Field field = fields[i];
                    Method method = c.getDeclaredMethod("get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1));
                    Column column = field.getAnnotation(Column.class);

                    column = column == null ? method.getAnnotation(Column.class) : column;

                    String aa = customFormFieldEntities.get(j).getFieldName();

                    String bb = column.name();
                    if (customFormFieldEntities.get(j).getFieldName().toLowerCase().equals(column.name().toLowerCase())) {
                        isc = false;
                        break;
                    }

                }
                if (isc) {
                    re += "," + name;
                }
            }

            if (!re.equals("")) {
                re = "字段：" + re.substring(1) + " 在数据库表中不存在！";
                result = "{\"success\":true,\"msg\":\"" + re + "\"}";
            } else {
                result = "{\"success\":true,\"msg\":\"测试成功！\"}";
            }
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }
        return result;
    }

}
