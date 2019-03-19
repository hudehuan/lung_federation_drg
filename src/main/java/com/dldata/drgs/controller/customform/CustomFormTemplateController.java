package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.entity.CustomFormFieldTemplateEntity;

import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormFieldTemplateService;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/CustomFormTemplate")
public class CustomFormTemplateController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CustomFormTemplateService customFormTemplateService;


    @Autowired
    private CustomFormFieldService customFormFieldService;


    @Autowired
    private CustomFormFieldTemplateService customFormFieldTemplateService;

    @RequestMapping(value = "/getCustomFormTemplateByFormId")
    @ResponseBody
    public  List<Map<String,String>> getFormTemplateByFormId(String formId) {

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();

        List<CustomFormTemplateEntity>  tempfieldlist = customFormTemplateService.getFormTemplateByFormId(formId);
        tempfieldlist.forEach(
                (s) -> {
                    Map<String, String> tmpmap = new HashMap<String, String>();
                    tmpmap.put("id",s.getId());
                    tmpmap.put("name",s.getName());
                    tmpmap.put("active",s.getActive()?"是":"");
                    tmpmap.put("style",s.getStyle().equals("A")?"Bootstrap":"Table");
                    tmpmap.put("createTime",  s.getCreateTime().toString());
                    mapList.add(tmpmap);
                }
        );
        return mapList;

    }


    @RequestMapping(value = "/save")
    public void save(CustomFormTemplateEntity customFormTemplateEntity, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result = "";


        List<CustomFormFieldTemplateEntity> CustomFormFieldTemplateEntityList = new ArrayList<CustomFormFieldTemplateEntity>();

        List<CustomFormFieldEntity> customFormFieldEntityList = new ArrayList<CustomFormFieldEntity>();
        customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(customFormTemplateEntity.getFormId());

        if (StringUtil.isNullOrSpace(customFormTemplateEntity.getId())) {
            customFormTemplateEntity.setId(UUID.randomUUID().toString());
        }else {
            CustomFormTemplateEntity entity = customFormTemplateService.getTemplateById(customFormTemplateEntity.getId());
            customFormTemplateEntity.setMultilineDiv(entity.getMultilineDiv()==null?false:entity.getMultilineDiv());
            customFormTemplateEntity.setLineDiv(entity.getLineDiv()==null?false:entity.getLineDiv());
            customFormTemplateEntity.setHtml(entity.getHtml()==null?"":entity.getHtml());
            customFormTemplateEntity.setFormjs(entity.getFormjs()==null?"":entity.getFormjs());
            customFormTemplateEntity.setSavejs(entity.getSavejs()==null?"":entity.getSavejs());
        }

        customFormTemplateEntity.setCreateTime(new Timestamp(new Date().getTime()));
        if (customFormTemplateEntity.getActive() == null) {
            customFormTemplateEntity.setActive(false);
        }
        if (customFormTemplateEntity.getStandard() == null) {
            customFormTemplateEntity.setStandard(false);
        }

        if (customFormTemplateEntity.getMultilineDiv() == null) {
            customFormTemplateEntity.setMultilineDiv(false);
        }

        if (customFormTemplateEntity.getLineDiv() == null) {
            customFormTemplateEntity.setLineDiv(false);
        }
        try {
            //先创建模板
            customFormTemplateEntity.setStatus(true);
            customFormTemplateService.save(customFormTemplateEntity);


            List<CustomFormFieldTemplateEntity> tempfieldlist = customFormFieldTemplateService.getAllByTemplateId(customFormTemplateEntity.getId());
            //模板内容已存在  不重复保存
            if(tempfieldlist.size()==0) {  //内容为空，创建模板内容
                //创建模板内容
                for (int i = 0; i < customFormFieldEntityList.size(); i++) {
                    CustomFormFieldTemplateEntity fieldPropertiesEntity = new CustomFormFieldTemplateEntity();
                    fieldPropertiesEntity.setId(UUID.randomUUID().toString());
                    fieldPropertiesEntity.setFormId(customFormTemplateEntity.getFormId());
                    fieldPropertiesEntity.setTemplateId(customFormTemplateEntity.getId());
                    fieldPropertiesEntity.setFieldId(customFormFieldEntityList.get(i).getId());
                    fieldPropertiesEntity.setFieldCode(customFormFieldEntityList.get(i).getFieldCode());
                    fieldPropertiesEntity.setControlType(customFormFieldEntityList.get(i).getControlType());
                    fieldPropertiesEntity.setJs("");
                    fieldPropertiesEntity.setdataSql(customFormFieldEntityList.get(i).getdataSql());
                    //添加到字段属性集合对象中
                    CustomFormFieldTemplateEntityList.add(fieldPropertiesEntity);
                }

                //保存
                customFormFieldTemplateService.saveList(CustomFormFieldTemplateEntityList);
            }

            result = "{\"success\":true,\"msg\":\"成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }

        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping(value = "/clone")
    public void clone(String templateId) {

    }



    @RequestMapping(value = "/active")
    public void active(String formId,String templateId,
                       HttpServletRequest request, HttpServletResponse response) throws Exception{

        String result = "";
        List<CustomFormTemplateEntity> customFormTemplateEntityList = customFormTemplateService.getFormTemplateByFormId(formId);

        for(int i=0;i<customFormTemplateEntityList.size();i++){
            if(customFormTemplateEntityList.get(i).getId().equals(templateId)){
                customFormTemplateEntityList.get(i).setActive(true);
            }
            else{
                customFormTemplateEntityList.get(i).setActive(false);
            }
        }

        try {
            customFormTemplateService.saveEntityList(customFormTemplateEntityList);
            result = "{\"success\":true,\"msg\":\"成功！\",\"formId\":\"" + formId+ "\"}";
        }
        catch (Exception ex){
            result = "{\"success\":true,\"msg\":\"激活失败！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
    }
    @RequestMapping(value = "/savehtml", method = RequestMethod.POST)
    public void saveHtml(@RequestParam("templateId") String templateId,
                         @RequestBody String data,
                         HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result = "";

        JSONArray array = JSONArray.fromObject(data);
        JSONObject tobject = (JSONObject) array.get(0);
        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);

//去掉选中样式
        customFormTemplateEntity.setHtml(tobject.get("html").toString().replaceAll("selectdomcss",""));


        customFormTemplateService.save(customFormTemplateEntity);
        result = "{\"success\":true,\"msg\":\"成功！\"}";


        StringUtil.writeToWeb(result, "html", response);
        //System.out.println("");
    }

    @RequestMapping(value = "/saveformjs", method = RequestMethod.POST)
    public void saveFormjs(@RequestParam("templateId") String templateId,
                           @RequestBody String data,
                           HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result = "";

        JSONArray array = JSONArray.fromObject(data);
        JSONObject tobject = (JSONObject) array.get(0);
        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);

        customFormTemplateEntity.setFormjs(tobject.get("formjs").toString());


        customFormTemplateService.save(customFormTemplateEntity);
        result = "{\"success\":true,\"msg\":\"成功！\"}";


        StringUtil.writeToWeb(result, "html", response);
        //System.out.println("");
    }


    @RequestMapping(value = "/gethtml")
    public void GetHtml(@RequestParam("templateId") String templateId,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {

        CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);
        StringUtil.writeToWeb(customFormTemplateEntity.getHtml()==null?"":customFormTemplateEntity.getHtml(), "html", response);
        //System.out.println("");
    }

    @RequestMapping(value = "/saveTemplateopt",method = RequestMethod.POST)
    public void saveTemplateJS(@RequestBody String templateopt, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result = "";
        JSONArray array = JSONArray.fromObject(templateopt);

        if (array.size() > 0) {
            JSONObject tobject = (JSONObject) array.get(0);
            String templateId = tobject.get("templateId").toString();

            String savejs = tobject.getString("savejs").toString();
            boolean multiline = tobject.getBoolean("multiline");
            boolean line = tobject.getBoolean("line");
            //FormDefineValueEntity valueEntity = formDefineValueService.getDefineValue(tvId);
            //cxrq = valueEntity.getCxrq();
            CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);

            customFormTemplateEntity.setSavejs(savejs);
            customFormTemplateEntity.setMultilineDiv(multiline);
            customFormTemplateEntity.setLineDiv(line);

            customFormTemplateService.save(customFormTemplateEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        } else {
            result = "{\"success\":false,\"msg\":\"保存JS失败！\"}";
        }


        StringUtil.writeToWeb(result, "html", response);
        //System.out.println(templateJS);
    }


    @RequestMapping(value = "/saveClone")
    public void saveClone(String templateId, String name, HttpServletRequest request, HttpServletResponse response) throws Exception{

        String result ;
        try{


            CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);

            List<CustomFormFieldTemplateEntity> CustomFormFieldTemplateEntityList = new ArrayList<CustomFormFieldTemplateEntity>();

            List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(customFormTemplateEntity.getFormId());

            //创建克隆模板
            CustomFormTemplateEntity customFormTemplate = new CustomFormTemplateEntity();
            customFormTemplate.setId(UUID.randomUUID().toString());
            customFormTemplate.setFormId(customFormTemplateEntity.getFormId());
            customFormTemplate.setName(name);
            customFormTemplate.setStyle(customFormTemplateEntity.getStyle());
            customFormTemplate.setActive(false);
            customFormTemplate.setSavejs(customFormTemplateEntity.getSavejs()==null?"":customFormTemplateEntity.getSavejs());
            customFormTemplate.setCreateTime(new Timestamp(new Date().getTime()));
            customFormTemplate.setStandard(customFormTemplateEntity.getStandard());
            customFormTemplate.setXh(customFormTemplateService.getMaxXh(customFormTemplateEntity.getFormId())+1);
            customFormTemplate.setMultilineDiv(customFormTemplateEntity.getMultilineDiv());
            customFormTemplate.setLineDiv(customFormTemplateEntity.getLineDiv());
            customFormTemplate.setHtml(customFormTemplateEntity.getHtml()==null?"":customFormTemplateEntity.getHtml());
            customFormTemplate.setFormjs(customFormTemplateEntity.getFormjs()==null?"":customFormTemplateEntity.getFormjs());
            customFormTemplate.setShenhe(customFormTemplateEntity.getShenhe());
            customFormTemplateEntity.setStatus(true);

            //添加模板字段内容
            customFormFieldEntityList.forEach(f -> {
                CustomFormFieldTemplateEntity fieldPropertiesEntity = new CustomFormFieldTemplateEntity();
                fieldPropertiesEntity.setId(UUID.randomUUID().toString());
                fieldPropertiesEntity.setFormId(customFormTemplate.getFormId());
                fieldPropertiesEntity.setTemplateId(customFormTemplate.getId());
                fieldPropertiesEntity.setFieldId(f.getId());
                fieldPropertiesEntity.setFieldCode(f.getFieldCode());
                fieldPropertiesEntity.setControlType(f.getControlType());
                fieldPropertiesEntity.setJs("");
                fieldPropertiesEntity.setdataSql(f.getdataSql());
                //添加到字段属性集合对象中
                CustomFormFieldTemplateEntityList.add(fieldPropertiesEntity);
            });
            customFormTemplateService.save(customFormTemplate);
            customFormFieldTemplateService.saveList(CustomFormFieldTemplateEntityList);

            result = "{\"success\":true,\"msg\":\"克隆成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveClone() 方法失败 】异常：" + ex.getMessage());
        }

        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/deltemplet")
    public void deltemplet(String templateId,HttpServletRequest request,
                           HttpServletResponse response)throws Exception{
        String result;
        try {
            CustomFormTemplateEntity customFormTemplateEntity = customFormTemplateService.getTemplateById(templateId);
            customFormTemplateEntity.setStatus(false);
            customFormTemplateService.save(customFormTemplateEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"操作异常，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deltemplet() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }

}
