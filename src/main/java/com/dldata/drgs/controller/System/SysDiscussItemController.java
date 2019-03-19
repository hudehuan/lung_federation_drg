package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysDiscussItemEntity;
import com.dldata.drgs.service.System.SysDiscussItemService;
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
@RequestMapping(value = "/SysDiscussItem")
public class SysDiscussItemController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysDiscussItemService discussItemService;

//    @RequestMapping(value = "/gotoDiscussItem")
//    public String gotoDiscussItem(Model model) {
//        model.addAttribute("titlename","讨论交流反馈表");
//        return "System/SysDiscussItem";
//    }

    @RequestMapping(value = "/getAllDiscussItem")
    @ResponseBody
    public List<SysDiscussItemEntity> getAllDiscussItem(HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<SysDiscussItemEntity> disItem = new ArrayList<SysDiscussItemEntity>();
        String result;
        try{
            disItem = discussItemService.getAllDiscussItem();
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDiscussItem() 方法失败 】异常："+ex.getMessage());
        }
        return disItem;
    }

//    @RequestMapping(value="/gotosave")
//    public String gotoSave(){
//        return "System/SysDiscussItemEdit";
//    }
    @RequestMapping(value = "/save")
    public String save(SysDiscussItemEntity disItem,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;
        try {
            if (disItem.getId().equals("")) {
                disItem.setId(UUID.randomUUID().toString());
            }
            discussItemService.save(disItem);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveDiscussItem() 方法失败 】异常："+ex.getMessage());
        }
        //StringUtil.writeToWeb(result, "html", response);
        return "System/SysDiscussItem";
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                           HttpServletResponse response)throws Exception{
        String result;

        try {
            discussItemService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteDiscussItem() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
