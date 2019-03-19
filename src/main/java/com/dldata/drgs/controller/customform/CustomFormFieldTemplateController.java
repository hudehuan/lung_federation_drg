package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.entity.CustomFormFieldTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormFieldService;
import com.dldata.drgs.service.customform.CustomFormFieldTemplateService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Controller
@RequestMapping(value = "/CustomFormFieldTemplate")
public class CustomFormFieldTemplateController {


    @Autowired
    JdbcTemplate jdbcTemplate;


    @Autowired
    private CustomFormFieldTemplateService CustomFormFieldTemplateService;

    @Autowired
    private CustomFormFieldService CustomFormFieldService;


    @RequestMapping(value = "/getAllByTemplateId")
    @ResponseBody
    public List<Map<String,String>> getAllByTemplateId(String templateId){

        //
        //
        List<CustomFormFieldTemplateEntity> tempfieldlist = CustomFormFieldTemplateService.getAllByTemplateId(templateId);

        if (tempfieldlist.size()==0)
            return  null;


        List<CustomFormFieldEntity> fieldlist = CustomFormFieldService.getAllFieldByFormId(tempfieldlist.get(0).getFormId());

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        fieldlist.forEach(
                (p) -> {
                    Map<String, String> tmpmap = new HashMap<String, String>();
                    tmpmap.put("Id","");
                    tmpmap.put("fieldZhname",p.getFieldZhname());
                    tmpmap.put("fieldCode",p.getFieldCode());
                    tmpmap.put("fieldtype",p.getFieldType());
                    tmpmap.put("b_controlType",p.getControlType());
                    tmpmap.put("b_dataSql",p.getdataSql());
                    tmpmap.put("controlType","");
                    tmpmap.put("dataSql","");

                    //如果修改了表单基本字段就需要自动同步修改
                    tempfieldlist.stream().filter(s -> s.getFieldId().equals(p.getId())&&
                            (!s.getFieldCode().toLowerCase().equals(p.getFieldCode().toLowerCase())||
                                    !s.getControlType().toLowerCase().equals(p.getControlType().toLowerCase()))).limit(1).forEach(
                            s-> {
                                if(!p.getControlType().equals("字典SQL表格控件")&&
//                                        !p.getControlType().equals("PID0SQL树控件")&&
//                                        !p.getControlType().equals("LENSQL树控件")&&
                                        !p.getControlType().equals("字典SQL下拉控件")){
                                    s.setdataSql("");
                                }
                                s.setFieldCode(p.getFieldCode());
                                s.setControlType(p.getControlType());
                                CustomFormFieldTemplateService.save(s);
                            });

                    //如果升级了个性化不存在字段就需要自动增加个
                    if (tempfieldlist.stream().filter(s -> s.getFieldCode().equals(p.getFieldCode())).count()==0) //没有数据
                    {
                        tmpmap.put("Id",UUID.randomUUID().toString());
                        CustomFormFieldTemplateEntity fieldTemplateEntity = new CustomFormFieldTemplateEntity();
                        fieldTemplateEntity.setId(tmpmap.get("Id"));
                        fieldTemplateEntity.setFormId(p.getFormId());
                        fieldTemplateEntity.setTemplateId(templateId);
                        fieldTemplateEntity.setFieldId(p.getId());
                        fieldTemplateEntity.setFieldCode(p.getFieldCode());
                        fieldTemplateEntity.setControlType(p.getControlType());
                        fieldTemplateEntity.setJs("");
                        fieldTemplateEntity.setdataSql(p.getdataSql()==null?"":p.getdataSql());
                        tmpmap.put("controlType", fieldTemplateEntity.getControlType());
                        tmpmap.put("dataSql", fieldTemplateEntity.getdataSql());
                        CustomFormFieldTemplateService.save(fieldTemplateEntity);
                    }
                    else {
                        tempfieldlist.stream().filter(s -> s.getFieldCode().equals(p.getFieldCode())).limit(1).forEach(
                                (s) -> {
                                    tmpmap.put("Id", s.getId());
                                    tmpmap.put("controlType", s.getControlType());
                                    tmpmap.put("dataSql", s.getdataSql());
                                }
                        );
                    }
                    mapList.add(tmpmap);
                }
        );
        return mapList;
    }

    @RequestMapping(value = "/getdatafieldcode")
    @ResponseBody
    public CustomFormFieldTemplateEntity getDatabyFieldcode(String templateId, String fcode) {

        List<CustomFormFieldTemplateEntity> list = CustomFormFieldTemplateService.getAllByTemplateId(templateId);
//只取一条，
        list = list.stream().filter(p -> p.getFieldCode().equals(fcode)).limit(1).collect(Collectors.toList());
        return list.size() > 0 ? list.get(0) : null;
    }


    @RequestMapping(value = "/saveDataSql", method = RequestMethod.POST)
    public void saveDataSql(@RequestParam("str") String sql,
                            @RequestParam("filedCode") String filedCode,
                            @RequestParam("templateId") String templateId,
                            HttpServletRequest request,
                            HttpServletResponse response) throws Exception {
        String result = "";

        try {
            CustomFormFieldTemplateEntity CustomFormFieldTemplateEntity =
                    CustomFormFieldTemplateService.getAllByTemplateIdFieldCode(filedCode, templateId);

            CustomFormFieldTemplateEntity.setdataSql(sql);


            CustomFormFieldTemplateService.save(CustomFormFieldTemplateEntity);
            result = "{\"success\":true,\"msg\":\"成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";

        }
        StringUtil.writeToWeb(result, "html", response);
    }



    @RequestMapping(value = "/saveDatajs", method = RequestMethod.POST)
    public void saveDatajs(@RequestParam("str") String js,
                           @RequestParam("filedCode") String filedCode,
                           @RequestParam("templateId") String templateId,
                           HttpServletRequest request,
                           HttpServletResponse response) throws Exception
    {

        String result = "";

        try {
            CustomFormFieldTemplateEntity CustomFormFieldTemplateEntity =
                    CustomFormFieldTemplateService.getAllByTemplateIdFieldCode(filedCode, templateId);

            CustomFormFieldTemplateEntity.setJs(js);


            CustomFormFieldTemplateService.save(CustomFormFieldTemplateEntity);
            result = "{\"success\":true,\"msg\":\"成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/getSqlData")
    @ResponseBody
    public List<Map<String,String>> getSqlData(
            @RequestParam("fieldCode") String fieldCode,
            @RequestParam("templateId") String templateId,
            @RequestParam(value="mc", required=false) String mc,
            @RequestParam(value="tj", required=false) String tj,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception
    {


        CustomFormFieldTemplateEntity CustomFormFieldTemplateEntity =
                CustomFormFieldTemplateService.getAllByTemplateIdFieldCode(fieldCode, templateId);


        String sql = CustomFormFieldTemplateEntity.getdataSql();

        if (sql.toLowerCase().indexOf("[#val]")>-1)//有联动
        {
            sql = sql.split("\\|")[0];
        }

        if (mc!=null)
        {
            sql=sql.replaceAll("\\[#tj]",mc);
        }
        sql=sql.replaceAll("\\[#tj]","");
        if (tj !=null)
        {
            sql=sql.replaceAll("\\[#val]",tj);
        }
        sql=sql.replaceAll("\\[#val]","");
        List<Map<String,String>> wdmList = new ArrayList<Map<String,String>>();
        if(Util.checkNotNull(sql)) {


            List rows = jdbcTemplate.queryForList(sql);

            for (int i = 0; i < rows.size(); i++) {                   //遍历
                Map userMap = (Map) rows.get(i);
                Map t_map = new HashedMap();
                t_map.put("dm",(String)userMap.get("dm"));
                t_map.put("mc",(String) userMap.get("mc"));
                wdmList.add(t_map);
                if (i>=200) //200退出，没必要太大
                    break;
            }

        }

        return wdmList;
    }

}
