package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.entity.SysKsEntity;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysKeShi")
public class SysKeShiController {
    public enum TypeEnum {
        手术科室, 非手术科室, 医技科室,职能部门
    }
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    SysKeShiService sysKeShiService;

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;
    @Autowired
    SysDictionaryService dictionaryService;
    @Autowired
    SysDictionaryItemService dictionaryItemService;
    @Resource(name = "dictionaryConfig")
    DictionaryConfig dictionaryConfig;



    @RequestMapping(value = "/getAllKeShi")
    @ResponseBody
    public String  getAllKeShi(HttpServletRequest request, HttpServletResponse response,
                               @CookieValue(value = "syscode", defaultValue = "") String sysCode)throws Exception{

        List<SysKsEntity> sysKeShi = sysKeShiService.getAllKeShi();
        List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();
        SysDictionaryEntity dic = dictionaryService.findByCode(dictionaryConfig.getKeshiType(), sysCode);
        List<SysDictionaryItemEntity> dictionary = new ArrayList<SysDictionaryItemEntity>();
        if(dic!= null){
            dictionary = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        List<SysDictionaryItemEntity> dictionaryItemEntities = dictionary;
        String result;
        try{
            sysKeShi.forEach(s ->{
                Map<String, String> map = new HashMap<String, String>();
                map.put("id",(s.getId()));
                map.put("xh",(s.getXh().toString()));
                map.put("code",s.getCode().toString());
                map.put("name",(s.getName()));
                if (s.getShortName() != null) {  map.put("shortName",(s.getShortName()));}
                if (s.getWbCode() != null) {    map.put("wbCode",(s.getWbCode()));}
                map.put("ksType","");
                if (s.getBedNums() != null) {     map.put("bedNums",(s.getBedNums().toString()));}
                if (s.getFixedbedNums() != null) {      map.put("fixedbedNums",(s.getFixedbedNums().toString()));}
                if (s.getExtrabedNums() != null) {        map.put("extrabedNums",(s.getExtrabedNums().toString()));}
                if (s.getMz() != null) {        map.put("mz",(s.getMz().toString()));}
                if (s.getZy() != null) {           map.put("zy",(s.getZy().toString()));}
                if (s.getJz() != null) {         map.put("jz",(s.getJz().toString()));}
                dictionaryItemEntities.stream().filter(dicItem -> dicItem.getDid().equals(dic.getDid())).forEach(dicItem -> {
                    if(s.getShortName() != null&&dicItem.getItemCode().equals(s.getKsType().toString())){
                        String a = dicItem.getItemCode();
                        String b = s.getKsType().toString();
                        map.put("ksType", (dicItem.getDicName()));
                    }

                });
                listmap.add(map);
            });
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShi() 方法失败 】异常："+ex.getMessage());
        }
        return listmap.size()>0 ? JSONArray.fromObject(listmap).toString() : "[]";
    }


    @RequestMapping(value="/save")
    public void saveKs(SysKsEntity ksEntity,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;
        try {
            if (ksEntity.getId().equals("")) {
                ksEntity.setId(UUID.randomUUID().toString());
                List<SysKsEntity> ksEntityList = new ArrayList<SysKsEntity>();
                ksEntityList = sysKeShiService.findOneByCode(ksEntity.getCode());
                if (ksEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                ksEntityList = sysKeShiService.findByName(ksEntity.getName());
                if (ksEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                if(ksEntity.getJz() == null) {
                    ksEntity.setJz(false);
                }
                if(ksEntity.getZy() == null) {
                    ksEntity.setZy(false);
                }
                if(ksEntity.getMz() == null) {
                    ksEntity.setMz(false);
                }
            } else {
                String id = ksEntity.getId();
                List<SysKsEntity> ksEntityList = new ArrayList<SysKsEntity>();
                SysKsEntity ks = sysKeShiService.findOne(id);
                String oldCode = ks.getCode();
                if (!ksEntity.getCode().equals(oldCode)) {
                    ksEntityList = sysKeShiService.findOneByCode(ksEntity.getCode());
                    if (ksEntityList.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                String oldName = ks.getName();
                if (!ksEntity.getName().equals(oldName)) {
                    ksEntityList = sysKeShiService.findByName(ksEntity.getName());
                    if (ksEntityList.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                if(ksEntity.getJz() == null) {
                    ksEntity.setJz(false);
                } else {
                    ksEntity.setJz(true);
                }
                if(ksEntity.getZy() == null) {
                    ksEntity.setZy(false);
                } else {
                    ksEntity.setZy(true);
                }
                if(ksEntity.getMz() == null) {
                    ksEntity.setMz(false);
                } else {
                    ksEntity.setMz(true);
                }
            }
            ksEntity.setSatus(1);
            if(!ksEntity.getName().equals("")){
                ksEntity.setPym(StringUtil.getPinYinHeadChar(ksEntity.getName()));
            }
            if(ksEntity.getXh() == null) {
                ksEntity.setXh(0);
            }
            sysKeShiService.save(ksEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveKeShi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            SysKsEntity ksEntity = sysKeShiService.findOne(id);
            ksEntity.setSatus(0);
            sysKeShiService.save(ksEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteKeShi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public String findByCondition(HttpServletRequest request, HttpServletResponse response,String condition,
                                             @CookieValue(value = "syscode", defaultValue = "") String sysCode)throws Exception{

        List<SysKsEntity> sysKeShi = sysKeShiService.findByCondition("%"+condition+"%");
        List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();
        SysDictionaryEntity dic = dictionaryService.findByCode(dictionaryConfig.getKeshiType(), sysCode);
        List<SysDictionaryItemEntity> dictionary = new ArrayList<SysDictionaryItemEntity>();
        if(dic!= null){
            dictionary = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        List<SysDictionaryItemEntity> dictionaryItemEntities = dictionary;
        String result;
        try{
            sysKeShi.forEach(s ->{
                Map<String, String> map = new HashMap<String, String>();
                map.put("id",(s.getId()));
                map.put("xh",(s.getXh().toString()));
                map.put("code",s.getCode().toString());
                map.put("name",(s.getName()));
                if (s.getShortName() != null) {  map.put("shortName",(s.getShortName()));}
                if (s.getWbCode() != null) {    map.put("wbCode",(s.getWbCode()));}
                map.put("ksType","");
                if (s.getBedNums() != null) {     map.put("bedNums",(s.getBedNums().toString()));}
                if (s.getFixedbedNums() != null) {      map.put("fixedbedNums",(s.getFixedbedNums().toString()));}
                if (s.getExtrabedNums() != null) {        map.put("extrabedNums",(s.getExtrabedNums().toString()));}
                if (s.getMz() != null) {        map.put("mz",(s.getMz().toString()));}
                if (s.getZy() != null) {           map.put("zy",(s.getZy().toString()));}
                if (s.getJz() != null) {         map.put("jz",(s.getJz().toString()));}
                dictionaryItemEntities.stream().filter(dicItem -> dicItem.getDid().equals(dic.getDid())).forEach(dicItem -> {
                    if(s.getShortName() != null&&dicItem.getItemCode().equals(s.getKsType().toString())){
                        String a = dicItem.getItemCode();
                        String b = s.getKsType().toString();
                        map.put("ksType", (dicItem.getDicName()));
                    }

                });
                listmap.add(map);
            });
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShi() 方法失败 】异常："+ex.getMessage());
        }
        return listmap.size()>0 ? JSONArray.fromObject(listmap).toString() : "[]";
    }

}
