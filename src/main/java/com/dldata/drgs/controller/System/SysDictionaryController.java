package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Controller
@RequestMapping(value = "/SysDictionary")
public class SysDictionaryController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysDictionaryService dictionaryService;

    @Autowired
    SysDictionaryItemService dictionaryItemService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;
//    @RequestMapping(value = "/gotoDictionary")
//    public String gotoDictionary(@CookieValue(value = "userid",defaultValue = "") String userid,
//                                 @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                                 @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                                 Model model,HttpServletRequest request,HttpServletResponse response) {
//        model.addAttribute("titlename","字典表");
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//        return "System/SysDictionary";
//    }

    @RequestMapping(value = "/getAllDictionary")
    @ResponseBody
    public List<SysDictionaryEntity> getAllDictionary(@CookieValue(value = "syscode",defaultValue = "") String sysCode, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysDictionaryEntity> dictionary = new ArrayList<SysDictionaryEntity>();
        String result;
        try{
            dictionary = dictionaryService.getAllDictionary(sysCode);
            if (dictionary.size() > 0) {
                dictionary.forEach((d) -> {
                    if (!d.getSysCode().equals(sysCode)) {
                        d.setDicName(d.getDicName() + "(系统)");
                    }
                });
            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDictionary() 方法失败 】异常："+ex.getMessage());
        }
        return dictionary;
    }

//    @RequestMapping(value="/gotosave")
//    public String gotoSave(@CookieValue(value = "syscode",defaultValue = "") String sysCode, Model model){
//        model.addAttribute("sysCode", sysCode);
//        return "System/SysDictionaryAdd";
//    }

//    @RequestMapping(value = "/toUpdate")
//    public String toUpdate(String did,@CookieValue(value = "syscode",defaultValue = "") String sysCode,Model model) {
//        model.addAttribute("sysCode", sysCode);
//        if(did!=null&&!did.equals("")){
//            SysDictionaryEntity dic = dictionaryService.findOne(did);
//            model.addAttribute("dic",dic);
////            String code = dic.getDicCode();
//            if (!dic.getSysCode().equals(sysCode)) {
//                model.addAttribute("isSys",true);
//            }
//        }
//        return "System/SysDictionaryEdit";
//    }

    @RequestMapping(value = "/save")
    public void save(@CookieValue(value = "syscode",defaultValue = "") String sysCode, SysDictionaryEntity dictionaryEntity,
                     boolean sys, HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            if (!dictionaryEntity.getDicCode().equals("")) {
                if (dictionaryEntity.getDicCode().length() < 3) {
                    result = "{\"success\":false,\"msg\":\"代码长度小于3！\",\"id\":\"#dicCode\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }
            if (dictionaryEntity.getDid().equals("")) {
                if (!sys) {
                    dictionaryEntity.setDicCode(sysCode + dictionaryEntity.getDicCode());
                    dictionaryEntity.setSysCode(sysCode);

                } else {
                    dictionaryEntity.setSysCode("SYS");
                }
                dictionaryEntity.setDid(UUID.randomUUID().toString());
                List<SysDictionaryEntity> dic = new ArrayList<SysDictionaryEntity>();
                dic = dictionaryService.findByName(dictionaryEntity.getDicName(), sysCode);
                if (dic.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名字已存在！\",\"id\":\"#dicName\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                SysDictionaryEntity dicEntity = new SysDictionaryEntity();
                dicEntity = dictionaryService.findByCode(dictionaryEntity.getDicCode(), sysCode);
                if (dicEntity != null) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#dicCode\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = dictionaryEntity.getDid();
                List<SysDictionaryEntity> dictionaryEntities = new ArrayList<SysDictionaryEntity>();
                SysDictionaryEntity oldDicEntity = dictionaryService.findOne(id);
                String oldName = oldDicEntity.getDicName();
                if (!dictionaryEntity.getDicName().equals(oldName)) {
                    dictionaryEntities = dictionaryService.findByName(dictionaryEntity.getDicName(), sysCode);
                    if (dictionaryEntities.size() >0) {
                        result = "{\"success\":false,\"msg\":\"名字已存在！\",\"id\":\"#dicName\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                String oldCode = oldDicEntity.getDicCode();
                SysDictionaryEntity dic = new SysDictionaryEntity();
                if (!dictionaryEntity.getDicCode().equals(oldCode)) {
                    dic = dictionaryService.findByCode(dictionaryEntity.getDicCode(), sysCode);
                    if (dic != null) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#dicCode\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            dictionaryService.save(dictionaryEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveDictionary() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String did,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            dictionaryService.delete(did);
            List<SysDictionaryItemEntity> dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(did);
            if (dictionaryItemEntities != null) {
                dictionaryItemEntities.forEach((d) -> {
                    dictionaryItemService.delete(d.getItemId());
                });
            }
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteDictionary() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysDictionaryEntity> findByCondition(@CookieValue(value = "syscode",defaultValue = "") String sysCode, String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysDictionaryEntity> dictionaryEntities = new ArrayList<SysDictionaryEntity>();
        String result;
        try{
            dictionaryEntities = dictionaryService.findByCondition("%"+condition+"%", sysCode);
            if (dictionaryEntities.size() > 0) {
                dictionaryEntities.forEach((d) -> {
                    if (!d.getSysCode().equals(sysCode)) {
                        d.setDicName(d.getDicName() + "(系统)");
                    }
                });
            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".findDictionaryByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return dictionaryEntities;
    }
}
