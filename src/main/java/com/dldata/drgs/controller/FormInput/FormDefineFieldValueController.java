package com.dldata.drgs.controller.FormInput;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.FormDefine.FormDefineFieldService;
import com.dldata.drgs.service.FormDefine.FormDefineService;
import com.dldata.drgs.service.FormInput.FormDefineFieldValueService;
import com.dldata.drgs.service.FormInput.FormDefineValueService;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/9/2.
 */
@Controller
@RequestMapping(value = "/FormDefineFieldValue")
public class FormDefineFieldValueController {

    @Autowired
    FormDefineFieldValueService formDefineFieldValueService;

    @Autowired
    FormDefineValueService formDefineValueService;
    @Autowired
    FormDefineFieldService formDefineFieldService;
    @Autowired
    private SysStaffService sysStaffService;
    @Autowired
    private SysKeShiService sysKeShiService;


    @Autowired
    FormDefineService formDefineService;

    @Autowired
    JdbcTemplate jdbcTemplate;


    @RequestMapping(value = "/toList")
    public String toList(String GUID){
        FormDefineEntity formDefineEntity = new FormDefineEntity();
        formDefineEntity = formDefineService.findOne(GUID);
        String datasbURL ="";
        switch (formDefineEntity.getFg()){
            case 1:
                datasbURL = "/FormDefineValue/toList?GUID="+GUID;
                break;
            case 2:
                datasbURL = "/FormDefineValuehza/toList?GUID="+GUID;
                break;
            case 3:
                datasbURL = "/FormDefineValuehzb/toList?GUID="+GUID;
                break;
        }
        return "redirect:"+datasbURL;
    }

    @RequestMapping("/getDefineFieldValue")
    @ResponseBody
    public String getDefineFieldValue(@RequestParam("tvId") String tvId,@RequestParam("tdId") String tdId){

        //FormDefineValueEntity formDefineValueEntity = formDefineValueService.getDefineValue(tvId);

        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tdId);
        String wdmSql = formDefineEntity.getTableSql();
        List<Wdm> wdmList = new ArrayList<Wdm>();
        if(Util.checkNotNull(wdmSql)) {

            try{
                List rows = jdbcTemplate.queryForList(wdmSql);

                for (int i = 0; i < rows.size(); i++) {                   //遍历
                    Map userMap = (Map) rows.get(i);
                    Wdm wdm = new Wdm();
                    wdm.setDm((String) userMap.get("dm"));
                    wdm.setName((String) userMap.get("name"));
                    wdmList.add(wdm);
                }
            }
            catch (Exception ex){

            }
        }

        List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);


        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);


        //List<Wdm> wdmRemoveList = new ArrayList<Wdm>();

        for (Iterator it = wdmList.iterator(); it.hasNext();) {
            Wdm swdm = (Wdm)it.next();

            int c = 0;
            for(FormDefineFieldValueEntity entity :formDefineFieldValueEntityList){
                String valueWdm = entity.getWdm();
                if (swdm.getDm().equals(valueWdm)){
                    c++;
                }
            }

            if(c==0){
                it.remove();
            }
        }


        List<Map> fieldValueMaps = new ArrayList<Map>();
        for(Wdm wdm :wdmList){
            //创建一行
            String t_wdm=wdm.getDm();
            Map map = new HashMap();
            map.put("wdm",t_wdm);
            map.put("wName",wdm.getName());
            for(int i=0; i< formDefineFieldEntityList.size();i++){
                String t_fdId = formDefineFieldEntityList.get(i).getFdId();
                List<FormDefineFieldValueEntity> t_fieldValueEntityList =  formDefineFieldValueEntityList.stream().filter(t->t.getFdId().equals(t_fdId)).
                        filter(tt->tt.getWdm().equals(t_wdm)).collect(Collectors.toList());
                if(t_fieldValueEntityList.size()>0){
                    map.put("s"+i,t_fieldValueEntityList.get(0).getFdValue());
                }else{
                    map.put("s"+i,"");
                }
                //增加一列

            }

            fieldValueMaps.add(map);
            //增加一行
        }

        String json ="[";
        for(int i=0;i<fieldValueMaps.size();i++){                   //遍历
            JSONObject jo = new JSONObject();
            Map map= (Map)fieldValueMaps.get(i);

            String j = JSONSerializer.toJSON(map).toString();

            if(i<fieldValueMaps.size()-1){j+=",";}
            json += j;

        }
        json +="]";
        //System.out.println(json);
        return json;


    }

    @RequestMapping(value = "/getDefineFieldValueBytdId")
    @ResponseBody
    public String getDefineFieldValueBytdId(@RequestParam("tdId") String tdId,
                                            @RequestParam("cxrqstart") String cxrqstart,
                                            @RequestParam("cxrqend") String cxrqend){

        //先得到自定义字段
        List <FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);

        //再得到主表值
        List<FormDefineValueEntity> formDefineValueEntityList = new ArrayList<FormDefineValueEntity>();
        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        //formDefineValueEntityList = formDefineValueService.getDefineValueByTableId(tdId);
        if(cxrqstart.equals("")||cxrqend.equals("")){
            formDefineValueEntityList = formDefineValueService.getDefineValueByTableId(tdId);
            formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValueByTdId(tdId);
        }else{
            if(cxrqstart.length()==8 && cxrqend.length() == 8){
                String js = cxrqstart.substring(5,7);
                if(js.equals("01")){
                    js = "-01";
                }else if(js.equals("02")){
                    js = "-04";
                }else if(js.equals("03")){
                    js = "-07";
                }else if(js.equals("04")){
                    js = "-10";
                }
                js+="-01";
                cxrqstart = cxrqstart.substring(0,4);
                cxrqstart += js;

                String je = cxrqend.substring(5,7);
                if(je.equals("01")){
                    je = "-03-31";
                }else if(je.equals("02")){
                    je = "-06-30";
                }else if(je.equals("03")){
                    je = "-09-30";
                }else if(je.equals("04")){
                    je = "-12-31";
                }
                cxrqend = cxrqend.substring(0,4);
                cxrqend += je;
            }
            if(cxrqstart.length()==4 && cxrqend.length() == 4){
                cxrqstart = cxrqstart +"-01-01";
                cxrqend = cxrqend +"-12-31";
            }
            if(cxrqstart.length()==7 && cxrqend.length() == 7){
                cxrqstart = cxrqstart +"-01";
                cxrqend = cxrqend +"-20";
            }
            formDefineValueEntityList = formDefineValueService.queryDefineValue(tdId, cxrqstart,cxrqend);
            formDefineFieldValueEntityList = formDefineFieldValueService.queryDefineFieldValue(tdId, cxrqstart,cxrqend);
        }





        List<Map> fieldValueMaps = new ArrayList<Map>();
        //循环主表值，构建记录，再循环字段构建列，构建值属性
        for(FormDefineValueEntity fieldValueEntity : formDefineValueEntityList){

            String t_tvId = fieldValueEntity.getTvId();
            Map map = new HashMap<>();
            map.put("tvId",fieldValueEntity.getTvId());
            map.put("isSh",fieldValueEntity.getIsSh());
            map.put("rq",fieldValueEntity.getRq());
            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if(fieldValueEntity.getInputDate()!=null)
                map.put("inputDate",sdf.format(fieldValueEntity.getInputDate()));
            //map.put("inputDate",fieldValueEntity.getInputDate().toString());

            for(int i=0;i< formDefineFieldEntityList.size();i++){
                FormDefineFieldEntity fieldEntity =formDefineFieldEntityList.get(i);
                String t_fdId = fieldEntity.getFdId();
                List<FormDefineFieldValueEntity> t_FieldValueEntityList = formDefineFieldValueEntityList.stream().
                        filter(t->t.getTvId().equals(t_tvId)).
                        filter(f ->f.getFdId().equals(t_fdId)).
                        collect(Collectors.toList());
                if(t_FieldValueEntityList.size()>0){
                    map.put("s"+i,t_FieldValueEntityList.get(0).getFdValue());
                }else{
                    map.put("s"+i,"");
                }
            }

            fieldValueMaps.add(map);
        }


        String json ="[";
        for(int i=0;i<fieldValueMaps.size();i++){                   //遍历
            JSONObject jo = new JSONObject();
            Map map= (Map)fieldValueMaps.get(i);

            String j = JSONSerializer.toJSON(map).toString();

            if(i<fieldValueMaps.size()-1){j+=",";}
            json += j;

        }
        json +="]";
        //System.out.println(json);
        return json;
    }


    @RequestMapping(value = "/getFormFieldValues")
    @ResponseBody
    public FormDefineValueStructure getFormFields(@RequestParam("tdId") String tdId,@RequestParam("tvId") String tvId){

        FormDefineValueStructure structure = new FormDefineValueStructure();

        List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);
        structure.setFormDefineFieldEntityList(formDefineFieldEntityList);

        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        if(!tvId.equals(""))
            formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);
        structure.setFormDefineFieldValueEntityList(formDefineFieldValueEntityList);


        return structure;

    }





    @RequestMapping(value = "/toInput")
    public String toInput(@RequestParam("tdId") String tdId,
                          @RequestParam("tvId") String tvId ,
                          @RequestParam(value = "wdm",required = false,defaultValue="") String wdm ,
                          @CookieValue(value = "userid", defaultValue = "") String userId,
                          Model model){

        String wdmname = "";
        //首先从表单定义中获取维代码
        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tdId);
        String wdmsql = formDefineEntity.getTableSql();
        List<Wdm> wdmList = new ArrayList<Wdm>();
//        SysStaffEntity sysStaffEntity = sysStaffService.getStaffByID(userId);
//        SysKsEntity sysKsEntity = sysKeShiService.findOne(sysStaffEntity.getKsId());
        if(Util.checkNotNull(wdmsql)) {

            try{
                List rows = jdbcTemplate.queryForList(wdmsql);

                for (int i = 0; i < rows.size(); i++) {                   //遍历
                    Map userMap = (Map) rows.get(i);
                    Wdm w = new Wdm();
                    w.setDm((String) userMap.get("dm"));
                    w.setName((String) userMap.get("name"));
                    wdmList.add(w);

                    //
                    if(!wdm.equals("")&&w.getDm().equals(wdm)){
                        wdmname = w.getName();
                    }
//                    if(wdm.equals("")&&userMap.get("dm").equals(sysKsEntity.getCode())){     //得到本科室维代码和科室名称
//                        wdm = sysKsEntity.getCode();
//                        wdmname = sysKsEntity.getName();
//                    }

                }
            }
            catch (Exception ex){

            }
        }


        List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);

        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        FormDefineValueEntity formDefineValueEntity = new FormDefineValueEntity();
        //String t_wdm = "";
        if(!wdm.equals("")) {
            formDefineFieldValueEntityList= formDefineFieldValueService.getByTvIdWdm(tvId,wdm);
            model.addAttribute("fieldsValue",formDefineFieldValueEntityList);
        }else{
            formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);
        }

        //如果wdm=="" 是增加，需要移除已填写过的wdm
        if(wdm.equals("")){
            for(FormDefineFieldValueEntity entity :formDefineFieldValueEntityList){
                String valueWdm = entity.getWdm();
                for (Iterator it = wdmList.iterator(); it.hasNext();) {
                    Wdm swdm = (Wdm)it.next();
                    if (swdm.getDm().equals(valueWdm)){
                        it.remove();
                    }
                }

            }
        }

        formDefineValueEntity = formDefineValueService.getDefineValue(tvId);
        model.addAttribute("fields",formDefineFieldEntityList);
        //model.addAttribute("wdmList",wdmList);
        model.addAttribute("tdId",tdId);
        model.addAttribute("wdm", wdm);
        model.addAttribute("wdmname", wdmname);
        model.addAttribute("rq", formDefineValueEntity.getRq());
        model.addAttribute("tvId",tvId);
        return "FormInput/FormDefineFieldValue";
    }


    @RequestMapping(value = "/getWdm")
    @ResponseBody
    public List<Wdm> getWdm(@RequestParam("tdId") String tdId,
                            @RequestParam("tvId") String tvId ,
                            @RequestParam(value = "wdm",required = false,defaultValue="") String wdm,
                            @RequestParam(value = "keyword",required = false,defaultValue="") String keyword){

        //首先从表单定义中获取维代码
        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tdId);
        String wdmsql = formDefineEntity.getTableSql();
        if(keyword.equals("")){

        }else{
            wdmsql += " where name like  '%" + keyword + "%'";
        }

        List<Wdm> wdmList = new ArrayList<Wdm>();
        if(Util.checkNotNull(wdmsql)) {

            try{
                List rows = jdbcTemplate.queryForList(wdmsql);

                for (int i = 0; i < rows.size(); i++) {                   //遍历
                    Map userMap = (Map) rows.get(i);
                    Wdm w = new Wdm();
                    w.setDm((String) userMap.get("dm"));
                    w.setName((String) userMap.get("name"));
                    wdmList.add(w);
                }
            }
            catch (Exception ex){

            }
        }
        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        FormDefineValueEntity formDefineValueEntity = new FormDefineValueEntity();
        //String t_wdm = "";
        if(!wdm.equals("")) {
            formDefineFieldValueEntityList= formDefineFieldValueService.getByTvIdWdm(tvId,wdm);
            //model.addAttribute("fieldsValue",formDefineFieldValueEntityList);
        }else{
            formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);
        }

        //如果wdm=="" 是增加，需要移除已填写过的wdm
        if(wdm.equals("")){
            for(FormDefineFieldValueEntity entity :formDefineFieldValueEntityList){
                String valueWdm = entity.getWdm();
                for (Iterator it = wdmList.iterator(); it.hasNext();) {
                    Wdm swdm = (Wdm)it.next();
                    if (swdm.getDm().equals(valueWdm)){
                        it.remove();
                    }
                }

            }
        }

        return wdmList;

    }

    @RequestMapping(value = "/getFieldValueOfWdm")
    @ResponseBody
    public WdmFieldValue getFieldValueOfWdm(String tdId,String tvId,String wdm){
        WdmFieldValue wdmFieldValue = new WdmFieldValue();

        List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);
        wdmFieldValue.setFormDefineFieldEntityList(formDefineFieldEntityList);

        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
        formDefineFieldValueEntityList = formDefineFieldValueService.getByTvIdWdm(tvId, wdm);
        wdmFieldValue.setFormDefineFieldValueEntityList(formDefineFieldValueEntityList);
        return wdmFieldValue;
    }

    @RequestMapping(value = "/saveInput")
    public void saveInput(@RequestBody String fieldvalues,HttpServletRequest request,HttpServletResponse response)throws Exception{

        String result="";
        JSONArray array = JSONArray.fromObject(fieldvalues);


        String cxrq = "";
        if(array.size()>0){
            JSONObject tobject = (JSONObject)array.get(0);
            String tvId = tobject.get("tvId").toString();

            FormDefineValueEntity valueEntity = formDefineValueService.getDefineValue(tvId);
            cxrq = valueEntity.getCxrq();
        }
        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            FieldValue value = new FieldValue();
            String tvId = object.get("tvId").toString();

            value.setTdId(object.get("tdId").toString());
            value.setFdId(object.get("fdId").toString());
            value.setFieldValue(object.get("fieldValue").toString());
            value.setItemId(object.get("itemId").toString());
            value.setWdm(object.get("wdm").toString());
            value.setFdName(object.get("fdName").toString());
            value.setFvId(object.get("fvId").toString());

            String fvId = "";
            //根据tvId,fdId,wdm进行查询  有：进行修改 无：增加
            fvId = formDefineFieldValueService.getByTvIdFdIdWdm(tvId,value.getFdId(),value.getWdm());

            FormDefineFieldValueEntity fieldValueEntity = new FormDefineFieldValueEntity();
            if(fvId.equals("")){
                //新增
                fieldValueEntity.setFvId(UUID.randomUUID().toString());
            }
            else{
                //修改
                fieldValueEntity.setFvId(fvId);
            }
            fieldValueEntity.setTdId(value.getTdId());
            fieldValueEntity.setFdId(value.getFdId());
            fieldValueEntity.setTvId(tvId);
            fieldValueEntity.setWdm(value.getWdm());
            fieldValueEntity.setItemId(value.getItemId());
            fieldValueEntity.setFdValue(value.getFieldValue());
            fieldValueEntity.setFdName(value.getFdName());
            fieldValueEntity.setCxrq(cxrq);

            formDefineFieldValueService.save(fieldValueEntity);
        }

        result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/saveInputHza")
    public void saveInputHza(@RequestBody String fieldvalues,HttpServletRequest request,HttpServletResponse response)throws Exception{

        String result="";
        JSONArray array = JSONArray.fromObject(fieldvalues);

        String cxrq = "";
        if(array.size()>0){
            JSONObject tobject = (JSONObject)array.get(0);
            String tvId = tobject.get("tvId").toString();

            FormDefineValueEntity valueEntity = formDefineValueService.getDefineValue(tvId);
            cxrq = valueEntity.getCxrq();
        }

        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            FieldValue value = new FieldValue();
            String tvId = object.get("tvId").toString();

            value.setTdId(object.get("tdId").toString());
            value.setFdId(object.get("fdId").toString());
            value.setFieldValue(object.get("fieldValue").toString());
            value.setItemId(object.get("itemId").toString());
            //value.setWdm(object.get("wdm").toString());
            value.setFdName(object.get("fdName").toString());
            value.setFvId(object.get("fvId").toString());

            //String fvId = "";
            //根据tvId,fdId,wdm进行查询  有：进行修改 无：增加
            //fvId = formDefineFieldValueService.getByTvIdFdIdWdm(tvId,value.getFdId(),value.getWdm());

            FormDefineFieldValueEntity fieldValueEntity = new FormDefineFieldValueEntity();
            if(value.getFvId().equals("")){
                //新增
                fieldValueEntity.setFvId(UUID.randomUUID().toString());
            }
            else{
                //修改
                fieldValueEntity.setFvId(value.getFvId());
            }
            fieldValueEntity.setTdId(value.getTdId());
            fieldValueEntity.setFdId(value.getFdId());
            fieldValueEntity.setTvId(tvId);
            fieldValueEntity.setWdm("");
            fieldValueEntity.setItemId(value.getItemId());
            fieldValueEntity.setFdValue(value.getFieldValue());
            fieldValueEntity.setFdName(value.getFdName());
            fieldValueEntity.setCxrq(cxrq);

            formDefineFieldValueService.save(fieldValueEntity);
        }

        result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/saveInputHzb")
    public void saveInputHzb(@RequestBody String fieldvalues,HttpServletRequest request,HttpServletResponse response)throws Exception{

        String result="";
        JSONArray array = JSONArray.fromObject(fieldvalues);
        String cxrq = "";
        if(array.size()>0){
            JSONObject tobject = (JSONObject)array.get(0);
            String tvId = tobject.get("tvId").toString();

            FormDefineValueEntity valueEntity = formDefineValueService.getDefineValue(tvId);
            cxrq = valueEntity.getCxrq();
        }
        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            FieldValue value = new FieldValue();
            String tvId = object.get("tvId").toString();
            value.setTdId(object.get("tdId").toString());
            value.setFdId(object.get("fdId").toString());
            value.setFieldValue(object.get("fieldValue").toString());
            value.setItemId(object.get("itemId").toString());
            //value.setWdm(object.get("wdm").toString());
            value.setFdName(object.get("fdName").toString());
            value.setFvId(object.get("fvId").toString());

            //String fvId = "";
            //根据tvId,fdId,wdm进行查询  有：进行修改 无：增加
            //fvId = formDefineFieldValueService.getByTvIdFdIdWdm(tvId,value.getFdId(),value.getWdm());

            FormDefineFieldValueEntity fieldValueEntity = new FormDefineFieldValueEntity();
            if(value.getFvId().equals("")){
                //新增
                fieldValueEntity.setFvId(UUID.randomUUID().toString());
            }
            else{
                //修改
                fieldValueEntity.setFvId(value.getFvId());
            }
            fieldValueEntity.setTdId(value.getTdId());
            fieldValueEntity.setFdId(value.getFdId());
            fieldValueEntity.setTvId(tvId);
            fieldValueEntity.setWdm("");
            fieldValueEntity.setItemId(value.getItemId());
            fieldValueEntity.setFdValue(value.getFieldValue());
            fieldValueEntity.setFdName(value.getFdName());
            fieldValueEntity.setCxrq(cxrq);

            formDefineFieldValueService.save(fieldValueEntity);
        }

        result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }



    @RequestMapping("/deleteDefineFieldValue")
    public void deleteDefineFieldValue(@RequestParam("wdm") String wdm,
                                       @RequestParam("tvId") String tvId,
                                       HttpServletResponse response) throws IOException {
        String result = "";

        try {
            List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = formDefineFieldValueService.getByTvIdWdm(tvId, wdm);

            formDefineFieldValueService.deleteFormDefineFieldValue(formDefineFieldValueEntityList);

            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"键值表单数据删除失败！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);
    }

    public class FieldValue{

        private String tdId;
        private String fdId;
        private String fieldValue;
        private String itemId;
        private String wdm;
        private String wName;
        private String fdName;
        private String fvId;

        public String getwName() {
            return wName;
        }

        public void setwName(String wName) {
            this.wName = wName;
        }

        public String getFvId() {
            return fvId;
        }

        public void setFvId(String fvId) {
            this.fvId = fvId;
        }

        public String getFdName() {
            return fdName;
        }

        public void setFdName(String fdName) {
            this.fdName = fdName;
        }



        public String getTdId() {
            return tdId;
        }

        public void setTdId(String tdId) {
            this.tdId = tdId;
        }

        public String getFdId() {
            return fdId;
        }

        public void setFdId(String fdId) {
            this.fdId = fdId;
        }

        public String getFieldValue() {
            return fieldValue;
        }

        public void setFieldValue(String fieldValue) {
            this.fieldValue = fieldValue;
        }

        public String getItemId() {
            return itemId;
        }

        public void setItemId(String itemId) {
            this.itemId = itemId;
        }

        public String getWdm() {
            return wdm;
        }

        public void setWdm(String wdm) {
            this.wdm = wdm;
        }



    }


    public class Wdm{

        private String dm;
        private String name;

        public String getDm() {
            return dm;
        }

        public void setDm(String dm) {
            this.dm = dm;
        }



        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }

    public class WdmFieldValue{




        public List<FormDefineFieldEntity> getFormDefineFieldEntityList() {
            return formDefineFieldEntityList;
        }

        public void setFormDefineFieldEntityList(List<FormDefineFieldEntity> formDefineFieldEntityList) {
            this.formDefineFieldEntityList = formDefineFieldEntityList;
        }

        private List<FormDefineFieldEntity> formDefineFieldEntityList;

        public List<FormDefineFieldValueEntity> getFormDefineFieldValueEntityList() {
            return formDefineFieldValueEntityList;
        }

        public void setFormDefineFieldValueEntityList(List<FormDefineFieldValueEntity> formDefineFieldValueEntityList) {
            this.formDefineFieldValueEntityList = formDefineFieldValueEntityList;
        }

        private List<FormDefineFieldValueEntity> formDefineFieldValueEntityList;
    }

    public class FormDefineValueStructure{


        private List<FormDefineFieldEntity> formDefineFieldEntityList;
        private List<FormDefineFieldValueEntity> formDefineFieldValueEntityList;

        public List<FormDefineFieldEntity> getFormDefineFieldEntityList() {
            return formDefineFieldEntityList;
        }

        public void setFormDefineFieldEntityList(List<FormDefineFieldEntity> formDefineFieldEntityList) {
            this.formDefineFieldEntityList = formDefineFieldEntityList;
        }

        public List<FormDefineFieldValueEntity> getFormDefineFieldValueEntityList() {
            return formDefineFieldValueEntityList;
        }

        public void setFormDefineFieldValueEntityList(List<FormDefineFieldValueEntity> formDefineFieldValueEntityList) {
            this.formDefineFieldValueEntityList = formDefineFieldValueEntityList;
        }
    }

    @RequestMapping("/getZyKs")
    @ResponseBody
    public List<SysKsEntity> getZyKs(){
        return sysKeShiService.getZyKs();
    }

    @RequestMapping("/getUserInfo")
    @ResponseBody
    public SysKsEntity getUserInfo(@CookieValue(value = "userid", defaultValue = "") String userId){
        SysStaffEntity sysStaffEntity = sysStaffService.getStaffByID(userId);
        return  sysKeShiService.findOne(sysStaffEntity.getKsId());
    }

}
