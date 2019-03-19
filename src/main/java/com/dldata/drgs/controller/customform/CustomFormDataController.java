package com.dldata.drgs.controller.customform;

import com.dldata.drgs.businessmodel.QueryResult;
import com.dldata.drgs.entity.*;
import com.dldata.drgs.repository.common.CommonDao;
import com.dldata.drgs.service.customform.SjsbFormFlowStepService;
import com.dldata.drgs.service.customform.SjsbFormShLogService;
import com.dldata.drgs.service.customform.SjsbFormStepCheckListService;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.Column;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Created by 倪继文 on 2017/5/8.
 */

@Controller
@RequestMapping(value = "/customFormData")
public class CustomFormDataController {


    @Autowired
    private CustomFormFieldService customFormFieldService;

    @Autowired
    private CustomFormService customFormService;

    @Autowired
    private CommonDao commonDao;

    @Autowired
    private SjsbFormStepCheckListService sjsbFormStepCheckListService;

    @Autowired
    private SjsbFormShLogService sjsbFormShLogService;

    @Autowired
    private SjsbFormFlowStepService sjsbFormFlowStepService;


    @RequestMapping("/getAll")
    @ResponseBody
    public List getAll(String tableId)throws Exception{
        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        String entityName = customFormEntity.getCode();
        Class c=null;
        try {
            c=Class.forName("com.dldata.drgs.entity."+entityName);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ClassMain.class.getName()).log(Level.SEVERE, null, ex);
        }


        QueryResult queryResult = commonDao.getScrollData(c,0,Integer.MAX_VALUE);


        List l = queryResult.getResultlist();
        return queryResult.getResultlist();

    }



    /*
    * 编辑数据时
    *
    *
    * **/
    @RequestMapping("/getOneById")
    @ResponseBody
    public Map<String,Object> getMemberEntity(String dataId,String tableId) throws Exception {

        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        String entityName = customFormEntity.getCode();
        Class c=null;
        try {
            c=Class.forName("com.dldata.drgs.entity."+entityName);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ClassMain.class.getName()).log(Level.SEVERE, null, ex);
        }


        //CommonDao commonDao  = new CommonDao();
        Object entity = new Object();
        if(dataId!=null&&!dataId.equals("")){
            entity =  commonDao.findone(c,dataId);
        }
        //返回实体数据
        List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(tableId);

        Map<String ,Object>  datamap = new HashedMap();

        if(entity != null) {
            Field[] fields = entity.getClass().getDeclaredFields();
            for (int i = 0; i < fields.length; i++) {
                Field field = fields[i];
                Method method = entity.getClass().getDeclaredMethod("get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1));
                Column column = field.getAnnotation(Column.class);
                column = column == null ? method.getAnnotation(Column.class) : column;

                for (int j = 0; j < customFormFieldEntityList.size(); j++) {
                    if (customFormFieldEntityList.get(j).getFieldName().equals(column.name())) {
                        Class<?> fieldClass = field.getType();
                        if(fieldClass == java.sql.Timestamp.class){
                            Object o = method.invoke(entity, new Object[0]);
                            if(customFormFieldEntityList.get(j).getControlType().equals("日期控件")){
                                datamap.put(column.name(), o==null?"":o.toString().substring(0,10));
                            } else if(customFormFieldEntityList.get(j).getControlType().equals("日期时间控件")){
                                datamap.put(column.name(), o==null?"":o.toString().substring(0,19));
                            }else {
                                datamap.put(column.name(), o==null?"":o.toString());
                            }
                        }else {


                            Object o = method.invoke(entity, new Object[0]);
                            datamap.put(column.name(), o);
                        }
                        break;
                    }


                }
            }
        }

        Map<String, Object> returnmap = new HashMap();
        returnmap.put("success",true);
        returnmap.put("entity",datamap);
        returnmap.put("customFormFieldEntityList",customFormFieldEntityList);


        return returnmap;

    }



    /**
     * 新增数据时
     *
     *
     *
     * **/
    @RequestMapping(value = "/saveOne")
    public void save(@RequestBody String fieldvalues,String tableId, HttpServletRequest request, HttpServletResponse response,
                     @CookieValue(value = "userid",defaultValue = "")String userId)throws Exception{
        String result="";
        JSONArray array = JSONArray.fromObject(fieldvalues);

        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        String entityName = customFormEntity.getCode();
        Class c=null;
        try {
            c=Class.forName("com.dldata.drgs.entity."+entityName);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ClassMain.class.getName()).log(Level.SEVERE, null, ex);
        }

        List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(tableId);

        Map<String ,Object>  datamap = new HashedMap();
        Field[] fields = c.getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {
            Field field = fields[i];
            Method method=c.getDeclaredMethod("get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1));
            Column column =field.getAnnotation(Column.class);
            column=column==null?method.getAnnotation(Column.class):column;

            for(int j=0;j<customFormFieldEntityList.size();j++){
                if(customFormFieldEntityList.get(j).getFieldName().equals(column.name())){

                    for (int n=0;n<array.size();n++){

                        JSONObject object = (JSONObject)array.get(n);
                        String fieldname = object.get("field").toString();
                        String fieldvalue = "";
                        if(object.has("fieldvalue")) {
                            fieldvalue = object.get("fieldvalue").toString();
                        }
                        if(fieldname.equals(column.name())){
                            //method.invoke(membersEntity,fieldvalue);
                            //Object  o  = method.invoke(membersEntity,new Object[0]);
                            datamap.put(field.getName(),fieldvalue);
                            break;
                        }
                    }
                    break;
                    //datamap.put(column.name(),o);
                }


            }
        }

        Object obj = StringUtil.mapToObject(c,datamap);
        Method method=c.getDeclaredMethod("getId");


        String id = (String)method.invoke(obj);

        if(StringUtil.isNullOrSpace(id)){
            Method setmethod=c.getDeclaredMethod("setId",String.class);
            setmethod.invoke(obj,UUID.randomUUID().toString());
            id = (String)method.invoke(obj);
            datamap.put("id",id);
        }

        //在组合审核功能后，可能会去掉
        // Method setmethod1=c.getDeclaredMethod("setTemplateid",String.class);
        // setmethod1.invoke(obj,templateId);

        //  Method setmethod2=c.getDeclaredMethod("setTableid",String.class);
        //  setmethod2.invoke(obj,tableId);

        //System.out.println("nijiwen2");
        //System.out.println(commonDao.toString());
        try {
            commonDao.save(obj);
            result = "{\"success\":true,\"msg\":\"表单保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"表单保存失败！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping(value = "/saveCheck")
    public void saveCheck(@RequestBody String fieldvalues,String tableId,String shlc,
                          @CookieValue(value = "userid", defaultValue = "") String userId,
                          HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result="";
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntities = new ArrayList<SjsbFormFlowStepEntity>();
        String stepId = "";
        if(shlc.equals("")){
            shlc = null;
        }else {
            sjsbFormFlowStepEntities = sjsbFormFlowStepService.getStepByFlowID(shlc);
            if (sjsbFormFlowStepEntities.size() == 0) {
                result = "{\"success\":false,\"msg\":\"流程未添加步骤，请联系管理员！\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            stepId = sjsbFormFlowStepEntities.get(0).getId();
        }

        JSONArray array = JSONArray.fromObject(fieldvalues);

        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        String entityName = customFormEntity.getCode();
        Class c=null;
        try {
            c=Class.forName("com.dldata.drgs.entity."+entityName);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ClassMain.class.getName()).log(Level.SEVERE, null, ex);
        }

        List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(tableId);

        Map<String ,Object>  datamap = new HashedMap();
        Field[] fields = c.getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {
            Field field = fields[i];
            Method method=c.getDeclaredMethod("get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1));
            Column column =field.getAnnotation(Column.class);
            column=column==null?method.getAnnotation(Column.class):column;

            for(int j=0;j<customFormFieldEntityList.size();j++){
                if(customFormFieldEntityList.get(j).getFieldName().equals(column.name())){

                    for (int n=0;n<array.size();n++){

                        JSONObject object = (JSONObject)array.get(n);
                        String fieldname = object.get("field").toString();
                        String fieldvalue = "";
                        if(object.has("fieldvalue")) {
                            fieldvalue = object.get("fieldvalue").toString();
                        }
                        if(fieldname.equals(column.name())){
                            //method.invoke(membersEntity,fieldvalue);
                            //Object  o  = method.invoke(membersEntity,new Object[0]);
                            datamap.put(field.getName(),fieldvalue);
                            break;
                        }
                    }
                    break;
                    //datamap.put(column.name(),o);
                }


            }
        }

        Object obj = StringUtil.mapToObject(c,datamap);
        Method method=c.getDeclaredMethod("getId");


        String id = (String)method.invoke(obj);

        if(StringUtil.isNullOrSpace(id)){
            Method setmethod=c.getDeclaredMethod("setId",String.class);
            setmethod.invoke(obj,UUID.randomUUID().toString());
            id = (String)method.invoke(obj);
            datamap.put("id",id);
        }

        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = sjsbFormStepCheckListService.getCheckFormByDataID(id);
        String checkID ="";
        if(sjsbFormStepCheckListEntity!=null){
            checkID = sjsbFormStepCheckListEntity.getId();
            List<SjsbFormShLogEntity> sjsbFormShLogEntity = sjsbFormShLogService.getFormShLogByFormIDDataID(tableId,id);
            if(sjsbFormShLogEntity.size()>0){
                sjsbFormShLogService.deleteAllByDataId(sjsbFormShLogEntity);
            }
        }



        //在组合审核功能后，可能会去掉
        // Method setmethod1=c.getDeclaredMethod("setTemplateid",String.class);
        // setmethod1.invoke(obj,templateId);

        //  Method setmethod2=c.getDeclaredMethod("setTableid",String.class);
        //  setmethod2.invoke(obj,tableId);

        //System.out.println("nijiwen2");
        //System.out.println(commonDao.toString());
        try {
            commonDao.save(obj);

            //高危评分
//            String pfArray ="SjsbBdDdzcpfEtEntity,SjsbDbYcpfEtEntity,SjsbDbYcpfCrEntity,SjsbBdDdzcpfCrEntity";
//            if(pfArray.indexOf(customFormEntity.getCode())>-1){
//                sjsbHzpfGwService.save(customFormEntity,datamap,dictionaryConfig.getSjsbGwhzpz(),userId);
//            }

            //保存流程
            sjsbFormStepCheckListService.saveData(tableId,checkID,id,userId,shlc,stepId);

            result = "{\"success\":true,\"msg\":\"表单保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"表单保存失败！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping(value = "/saveSome")
    public void saveSome(@RequestBody String fieldvalues,String tableId,String dataId, HttpServletRequest request, HttpServletResponse response,
                         @CookieValue(value = "userid",defaultValue = "")String userId)throws Exception {
        String result="";
        JSONArray array = JSONArray.fromObject(fieldvalues);

        CustomFormEntity customFormEntity = customFormService.getCustomFormByFormId(tableId);

        String entityName = customFormEntity.getCode();
        Class c=null;
        try {
            c=Class.forName("com.dldata.drgs.entity."+entityName);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ClassMain.class.getName()).log(Level.SEVERE, null, ex);
        }

        Object entity = new Object();
        if(dataId!=null&&!dataId.equals("")){
            entity =  commonDao.findone(c,dataId);
        }

        //返回实体数据
        List<CustomFormFieldEntity> customFormFieldEntityList = customFormFieldService.getAllFieldByFormId(tableId);

        Map<String ,Object>  datamap = new HashedMap();

        if(entity != null) {
            Field[] fields = entity.getClass().getDeclaredFields();
            for (int i = 0; i < fields.length; i++) {
                Field field = fields[i];
                Method method = entity.getClass().getDeclaredMethod("get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1));
                Column column = field.getAnnotation(Column.class);
                column = column == null ? method.getAnnotation(Column.class) : column;

                for (int j = 0; j < customFormFieldEntityList.size(); j++) {
                    if (customFormFieldEntityList.get(j).getFieldName().equals(column.name())) {
                        Class<?> fieldClass = field.getType();
                        if(fieldClass == java.sql.Timestamp.class){
                            Object o = method.invoke(entity, new Object[0]);
                            if(customFormFieldEntityList.get(j).getControlType().equals("日期控件")){
                                datamap.put(column.name(), o==null?"":o.toString().substring(0,10));
                            } else if(customFormFieldEntityList.get(j).getControlType().equals("日期时间控件")){
                                datamap.put(column.name(), o==null?"":o.toString().substring(0,19));
                            }else {
                                datamap.put(column.name(), o==null?"":o.toString());
                            }
                        }else {


                            Object o = method.invoke(entity, new Object[0]);
                            datamap.put(column.name(), o);
                        }
                        break;
                    }


                }
            }
        }
        for (int n=0;n<array.size();n++){

            JSONObject object = (JSONObject)array.get(n);
            String fieldname = object.get("field").toString();
            String fieldvalue = "";
            if(object.has("fieldvalue")) {
                fieldvalue = object.get("fieldvalue").toString();
            }
            datamap.put(fieldname,fieldvalue);
        }


        Object obj = StringUtil.mapToObject(c,datamap);
//        Method method=c.getDeclaredMethod("getId");
//
//
//        String id = (String)method.invoke(obj);
//
//        if(StringUtil.isNullOrSpace(id)){
//            Method setmethod=c.getDeclaredMethod("setId",String.class);
//            setmethod.invoke(obj,UUID.randomUUID().toString());
//            id = (String)method.invoke(obj);
//            datamap.put("id",id);
//        }

        try {
            commonDao.save(obj);
            result = "{\"success\":true,\"msg\":\"表单保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"表单保存失败！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);

    }
}
