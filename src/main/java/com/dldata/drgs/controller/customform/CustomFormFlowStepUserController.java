package com.dldata.drgs.controller.customform;


import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.service.customform.SjsbFormFlowStepUserService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by admin on 2016/11/11.
 */
@Controller
@RequestMapping(value = "/CustomFormFlowStepUser")
public class CustomFormFlowStepUserController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SysStaffService sysStaffService;

    @Autowired
    private SysDictionaryService dictionaryService;

    @Autowired
    private SysKeShiService sysKeShiService;

    @Autowired
    private DictionaryConfig dictionaryConfig;

    @Autowired
    private SysDictionaryItemService sysDictionaryItemService;

    @Autowired
    private SjsbFormFlowStepUserService customFormFlowStepUserService;



    @RequestMapping(value = "/getYhByKsid")
    @ResponseBody
    public List<SysStaffEntity> getYhByKsid(String ksid, HttpServletRequest request, HttpServletResponse response)throws Exception{
        List<SysStaffEntity> sysStaffEntityList = new ArrayList<SysStaffEntity>();
        String result;
        try{
            sysStaffEntityList = sysStaffService.findByKsid(ksid);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShi() 方法失败 】异常："+ex.getMessage());
        }
        return sysStaffEntityList;
    }

    @RequestMapping("/getKsStaffBys")
    @ResponseBody
//    public String getKsStaffBys(String search){
    public String getKsStaffBys(String search, @CookieValue(value = "syscode", defaultValue = "") String sysCode,
                                HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysStaffEntity> staffEntities = new ArrayList<SysStaffEntity>();

        String result;
        try {
            staffEntities = sysStaffService.findByCondition("%" + search + "%");
            List<SysKsEntity> sysKeShi = sysKeShiService.getAllKeShi();
            staffEntities.forEach((s) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("id", s.getId());
                map.put("name", s.getName());
                map.put("code", s.getCode());
                map.put("userClass","");
                if (s.getUserClass() != null) {
                    String userClass = setDicItemName(dictionaryConfig.getStaffType(), String.valueOf(s.getUserClass()), sysCode);
                    map.put("userClass", userClass);
                }
                map.put("weiyiCode", s.getWeiyiCode());
                map.put("zhiCheng","");
                if (s.getZhiCheng() != null) {
                    String zhiCheng = setDicItemName(dictionaryConfig.getZhiChengCode(), s.getZhiCheng(), sysCode);
                    map.put("zhiCheng", zhiCheng);
                }
                map.put("zhiWei","");
                if (s.getZhiWei() != null) {
                    String zhiWei = setDicItemName(dictionaryConfig.getZhiWeiCode(), s.getZhiWei(), sysCode);
                    map.put("zhiWei", zhiWei);
                }
                map.put("ksId","");
                if (s.getKsId() != null) {
//                    String ksName = keShiService.findOne(s.getKsId()).getName();
                    sysKeShi.stream().filter(ks -> s.getKsId().equals(ks.getId())).forEach(ks -> {
                        map.put("ksId", ks.getName());
                    });
                }
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findByConditionStaff() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }


    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysStaffEntity> findByCondition(String ksid,String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysStaffEntity> sysStaffEntityList = new ArrayList<SysStaffEntity>();
        String result;
        try{
            sysStaffEntityList = sysStaffService.findByKsIdCondition(ksid,"%"+condition+"%");
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getKeShiByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return sysStaffEntityList;
    }






    @RequestMapping("/getKsStaff")
    @ResponseBody
    public String getKsStaff(String search, @CookieValue(value = "syscode", defaultValue = "") String sysCode,
                             String ksId,
                             HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        List<SysStaffEntity> staffEntities = new ArrayList<SysStaffEntity>();

        String result;
        try {
            staffEntities = sysStaffService.findByCondition("%" + search + "%");
            SysKsEntity sysKeShi = sysKeShiService.findOne(ksId);
            staffEntities.stream().filter(s -> sysKeShi.getId().equals(s.getKsId())).forEach((s) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("id", s.getId());
                map.put("name", s.getName());
                map.put("code", s.getCode());
                map.put("userClass", "");
                if (s.getUserClass() != null) {
                    String userClass = setDicItemName(dictionaryConfig.getStaffType(), String.valueOf(s.getUserClass()), sysCode);
                    map.put("userClass", userClass);
                }
                map.put("weiyiCode", s.getWeiyiCode());
                map.put("zhiCheng", "");
                if (s.getZhiCheng() != null) {
                    String zhiCheng = setDicItemName(dictionaryConfig.getZhiChengCode(), s.getZhiCheng(), sysCode);
                    map.put("zhiCheng", zhiCheng);
                }
                map.put("zhiWei","");
                if (s.getZhiWei() != null) {
                    String zhiWei = setDicItemName(dictionaryConfig.getZhiWeiCode(), s.getZhiWei(), sysCode);
                    map.put("zhiWei", zhiWei);
                }
                map.put("ksId","");
                if (s.getKsId() != null) {
//                    String ksName = keShiService.findOne(s.getKsId()).getName();

                    map.put("ksId", sysKeShi.getName());
                }
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findByConditionStaff() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping("/doSeleYh")
    public void doSeleYh(String userId,String stepId,String flowId, HttpServletRequest request,HttpServletResponse response) throws Exception{
        String result;
        try {
            SysStaffEntity sysStaffEntity = sysStaffService.getStaffByID(userId);
            List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserList = customFormFlowStepUserService.findByStepId(stepId);

            for(SjsbFormFlowStepUserEntity s : sjsbFormFlowStepUserList){
                if(s.getUserid().equals(userId)){
                    result = "{\"success\":false,\"msg\":\"医生已存在！\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }
            SjsbFormFlowStepUserEntity sjsbFormFlowStepUserEntity = new SjsbFormFlowStepUserEntity();
            sjsbFormFlowStepUserEntity.setId(UUID.randomUUID().toString());
            sjsbFormFlowStepUserEntity.setUserid(userId);
            sjsbFormFlowStepUserEntity.setUsername(sysStaffEntity.getName());
            sjsbFormFlowStepUserEntity.setFlowId(flowId);
            sjsbFormFlowStepUserEntity.setStepId(stepId);
//            sjsbFormFlowStepUserEntity.setSyscode(sysConfig);
            sjsbFormFlowStepUserEntity.setIsOnlyKs(true);
            customFormFlowStepUserService.save(sjsbFormFlowStepUserEntity);

            result = "{\"success\":true,\"msg\":\"审核医生保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".doSeleYh() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }







    @RequestMapping("/updaOnlyKs")
    public void updaOnlyKs(String id, HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            SjsbFormFlowStepUserEntity sjsbFormFlowStepUserEntity = customFormFlowStepUserService.findById(id);
            if(sjsbFormFlowStepUserEntity.getIsOnlyKs().equals(true)){
                sjsbFormFlowStepUserEntity.setIsOnlyKs(false);
            }else{
                sjsbFormFlowStepUserEntity.setIsOnlyKs(true);
            }
            customFormFlowStepUserService.save(sjsbFormFlowStepUserEntity);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".updaOnlyKs() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/deleUser")
    public void delete(String id,HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            customFormFlowStepUserService.deleteById(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping("/getStepUser")
    @ResponseBody
    public String getStepUser(String stepId,
                              HttpServletRequest request, HttpServletResponse response) {

        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserList = customFormFlowStepUserService.findByStepId(stepId);

        List<SysStaffEntity> sysStaffEntity = sysStaffService.getAllStaffInFromStepUserid(stepId);

        List<SysDictionaryItemEntity> zhiCheng = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiChengCode());
        List<SysDictionaryItemEntity> zhiWei = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiWeiCode());
        List<SysKsEntity> sysKeShiEntity = sysKeShiService.getAllKeShi();
        List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();

        sjsbFormFlowStepUserList.forEach(item->{
            Map<String, String> map = new HashMap<String, String>();

            map.put("id", item.getId());
            map.put("username",item.getUsername());
            map.put("is_only_ks",item.getIsOnlyKs()?"√":"");
            map.put("ksname","");
            map.put("zhi_cheng","");
            map.put("zhi_wei","");


            sysStaffEntity.stream().filter(p->p.getId().equals(item.getUserid())).limit(1).forEach(
                    p->{
                        map.put("zhi_cheng",p.getZhiCheng());
                        map.put("zhi_wei",p.getZhiWei());
                        map.put("ksname",p.getKsId());
                    }
            );

            zhiCheng.stream().filter(p->p.getItemCode().equals(map.get("zhi_cheng"))).limit(1).forEach(
                    p->{
                        map.put("zhi_cheng",p.getDicName());
                    }
            );

            zhiWei.stream().filter(p->p.getItemCode().equals(map.get("zhi_wei"))).limit(1).forEach(
                    p->{
                        map.put("zhi_wei",p.getDicName());
                    }
            );

            sysKeShiEntity.stream().filter(p->p.getId().equals(map.get("ksname"))).limit(1).forEach(
                    p->{
                        map.put("ksname",p.getName());
                    }
            );
            listmap.add(map);
        });


        return listmap.size()>0 ? JSONArray.fromObject(listmap).toString() : "[]";
    }



    private void getDicItem(String code, String name, String sysCode, Model model) {
        SysDictionaryEntity dic = new SysDictionaryEntity();
        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
        dic = dictionaryService.findByCode(code, sysCode);
        if (dic != null) {
            dictionaryItemEntities = sysDictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        if (dictionaryItemEntities.size() > 0) {
            model.addAttribute(name, dictionaryItemEntities);
        }
    }

    private String setDicItemName(String code, String dicItemCode, String sysCode) {
        SysDictionaryEntity dic = new SysDictionaryEntity();
        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
        dic = dictionaryService.findByCode(code, sysCode);
        if (dic != null) {
            dictionaryItemEntities = sysDictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        if (dictionaryItemEntities.size() > 0) {
            for (SysDictionaryItemEntity dicItem : dictionaryItemEntities) {
                if (dicItem.getItemCode().equals(dicItemCode)) {
                    return dicItem.getDicName();
                }
            }
        }
        return "";
    }

}
