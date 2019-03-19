package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping(value = "/SysDictionaryItem")
public class SysDictionaryItemController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysDictionaryItemService dictionaryItemService;

    @Autowired
    SysDictionaryService dictionaryService;

    @RequestMapping(value = "/getAllDictionaryItem")
    @ResponseBody
    public List<SysDictionaryItemEntity> getAllDictionaryItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysDictionaryItemEntity> dictionaryItem = new ArrayList<SysDictionaryItemEntity>();
        String result;
        try{
            dictionaryItem = dictionaryItemService.getAllDictionaryItem();
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDictionaryItem() 方法失败 】异常："+ex.getMessage());
        }
        return dictionaryItem;
    }

    @RequestMapping(value = "/getAllDictionaryItemById")
    @ResponseBody
    public List<SysDictionaryItemEntity> getAllDictionaryItemById(String did,HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysDictionaryItemEntity> dictionaryItem = new ArrayList<SysDictionaryItemEntity>();
        String result;
        try{
            dictionaryItem = dictionaryItemService.getAllDictionaryItemById(did);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDictionaryItemById() 方法失败 】异常："+ex.getMessage());
        }
        return dictionaryItem;
    }

//    @RequestMapping(value="/gotosave")
//    public String gotoSave(String did,Model model){
//        SysDictionaryEntity dic = dictionaryService.findOne(did);
//        model.addAttribute("did",dic.getDid());
//        model.addAttribute("dicName",dic.getDicName());
//        return "System/SysDictionaryItemEdit";
//    }
//
//    @RequestMapping(value = "/toUpdate")
//    public String toUpdate(String itemId,Model model) {
//        SysDictionaryItemEntity dicItem = dictionaryItemService.findOne(itemId);
//        if (dicItem != null) {
//            model.addAttribute("dicItem",dicItem);
//            if (dicItem.getDid() != null) {
//                model.addAttribute("did",dicItem.getDid());
//                SysDictionaryEntity dic = dictionaryService.findOne(dicItem.getDid());
//                if (dic != null) {
//                    model.addAttribute("dicName",dic.getDicName());
//                }
//            }
//        }
//        return "System/SysDictionaryItemEdit";
//    }

    @RequestMapping(value = "/save")
    public void save(SysDictionaryItemEntity dictionaryItem,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;
        try {
            if (dictionaryItem.getItemId().equals("")) {
                dictionaryItem.setItemId(UUID.randomUUID().toString());
                String did = dictionaryItem.getDid();
                List<SysDictionaryItemEntity> dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(did);
                // 遍历ID为did的字典组中的字典项 找出新增项code是否重复
                if (dictionaryItemEntities != null) {
                    for (SysDictionaryItemEntity dicItem : dictionaryItemEntities) {
                        if (dicItem.getItemCode().equals(dictionaryItem.getItemCode())) {
                            result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#itemCode\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }
            } else {
                String id = dictionaryItem.getItemId();
                SysDictionaryItemEntity dicItem = dictionaryItemService.findOne(id);
                String oldCode = dicItem.getItemCode();
                String did = dictionaryItem.getDid();

                // 如果修改的字典项code改变
                if (!dictionaryItem.getItemCode().equals(oldCode)) {
                    List<SysDictionaryItemEntity> dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(did);
                    // 遍历ID为did的字典组中的字典项 找出新增项code是否重复
                    if (dictionaryItemEntities != null) {
                        for (SysDictionaryItemEntity d : dictionaryItemEntities) {
                            if (d.getItemCode().equals(dictionaryItem.getItemCode())) {
                                result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#itemCode\"}";
                                StringUtil.writeToWeb(result, "html", response);
                                return;
                            }
                        }
                    }
                }
            }

            if (dictionaryItem.getXh() == null) {
                dictionaryItem.setXh(0);
            }
            dictionaryItemService.save(dictionaryItem);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveDictionaryItem() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String itemId,HttpServletRequest request,
                           HttpServletResponse response)throws Exception{
        String result;

        try {
            dictionaryItemService.delete(itemId);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteDictionaryItem() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysDictionaryItemEntity> findByCondition(String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysDictionaryItemEntity> dicItems = new ArrayList<SysDictionaryItemEntity>();
        String result;
        try{
            dicItems = dictionaryItemService.findByCondition("%"+condition+"%");
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".findDictionaryItemByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return dicItems;
    }
}
