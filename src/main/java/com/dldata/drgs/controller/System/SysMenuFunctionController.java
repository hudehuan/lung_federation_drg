package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SystemFunctionEntity;
import com.dldata.drgs.service.System.SysMenuTemplateDefineService;
import com.dldata.drgs.service.System.SystemFunctionService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by admin on 2016/12/13.
 */
@Controller
@RequestMapping(value = "/sysMenuFunction")
public class SysMenuFunctionController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SystemFunctionService systemFunctionService;

    @Autowired
    public SysMenuTemplateDefineService sysMenuTemplateDefineService;


    @RequestMapping("/getAllFunction")
    @ResponseBody
    public String getAllFunction(String search,String type){
        List<SystemFunctionEntity> systemFunctionEntities = systemFunctionService.findAllFuncton(true,"%"+search+"%","%"+type+"%");
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        systemFunctionEntities.forEach(s -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("id",s.getId());
            map.put("xh",s.getXh()==null?"":s.getXh().toString());
            map.put("name",s.getName());
            map.put("url",s.getUrl());
            String t = "";
            switch (s.getType()==null?"":s.getType()){
                case "function" :
                    t= "功能";
                    break;
                case "System" :
                    t= "系统";
                    break;
                case "sort" :
                    t= "分类";
                    break;
                case "BI" :
                    t= "BI图表";
                    break;
                case "BIolap" :
                    t= "BIolap";
                    break;
                case "comment" :
                    t= "BI评价方案";
                    break;
                case "report" :
                    t= "BI分析报告";
                    break;
                case "form" :
                    t= "自定义表单";
                    break;
                case "excel" :
                    t= "Excel导入";
                    break;
            }
            map.put("type",t);
            map.put("printUrl",s.getPrintUrl());
            map.put("hospitelName",s.getHospitelName());
            map.put("cjrq",s.getCjrq()==null?"":s.getCjrq().toString().substring(0,19));
            map.put("bz",s.getBz());
            mapList.add(map);
        });

        return mapList.size()>0? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping("/getById")
    @ResponseBody
    public String getById(String id){
        SystemFunctionEntity systemFunctionEntity = systemFunctionService.findOne(id);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("id", systemFunctionEntity.getId());
        map.put("name", systemFunctionEntity.getName());
        map.put("url", systemFunctionEntity.getUrl());
        map.put("xh", systemFunctionEntity.getXh());
        map.put("status", systemFunctionEntity.getStatus());
        map.put("sysCode", systemFunctionEntity.getSysCode());
        map.put("type", systemFunctionEntity.getType());
        map.put("printUrl", systemFunctionEntity.getPrintUrl());
        map.put("hospitelName", systemFunctionEntity.getHospitelName());
        map.put("cjrqStr", systemFunctionEntity.getCjrq() == null ? "" : systemFunctionEntity.getCjrq().toString());
        map.put("bz", systemFunctionEntity.getBz());
        return JSONSerializer.toJSON(map).toString();

    }

    @RequestMapping("/save")
    public void save(SystemFunctionEntity systemFunctionEntity,
                     @RequestParam(value="cjrqStr", required=false)  String cjrqStr,
                     HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            if (systemFunctionEntity.getId().equals("")) {
                systemFunctionEntity.setId(UUID.randomUUID().toString());
                List<SystemFunctionEntity> systemFunctionEntityList = systemFunctionService.findAllFunctonByStatus(true);
                for(SystemFunctionEntity s:systemFunctionEntityList){
                    if(s.getXh()==systemFunctionEntity.getXh()){
                        result = "{\"success\":false,\"msg\":\"序号已存在！\",\"id\":\"#xh\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                for(SystemFunctionEntity s:systemFunctionEntityList){
                    if(s.getName().equals(systemFunctionEntity.getName())){
                        result = "{\"success\":false,\"msg\":\"菜单名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }else {
                SystemFunctionEntity systemFunction = systemFunctionService.findOne(systemFunctionEntity.getId());
                if(!systemFunctionEntity.getName().equals(systemFunction.getName())){
                    List<SystemFunctionEntity> systemFunctionEntityList = systemFunctionService.findAllFunctonByStatus(true);
                    for(SystemFunctionEntity s:systemFunctionEntityList){
                        if(s.getName().equals(systemFunctionEntity.getName())){
                            result = "{\"success\":false,\"msg\":\"菜单名称已存在！\",\"id\":\"#name\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }
            }
            if(cjrqStr!=null&&!cjrqStr.equals("")){
                systemFunctionEntity.setCjrq(Timestamp.valueOf(cjrqStr));
            }else{
                systemFunctionEntity.setCjrq(new java.sql.Timestamp(new Date().getTime()));
            }
            systemFunctionEntity.setStatus(true);
            systemFunctionService.save(systemFunctionEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/dele")
    public void dele(String id, HttpServletRequest request,
                     HttpServletResponse response) throws Exception {
        String result;

        try {
            SystemFunctionEntity systemFunctionEntity = systemFunctionService.findOne(id);
            systemFunctionEntity.setStatus(false);
            systemFunctionService.save(systemFunctionEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".dele() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


}
