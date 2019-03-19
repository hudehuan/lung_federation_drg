package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysHomePageEntity;
import com.dldata.drgs.service.System.SysHomePageService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/HomePageInterface")
public class SysHomePageController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysHomePageService sysHomePageService;

//    @RequestMapping(value = "/toHomePageInterface")
//    public String gotoDictionary(Model model) {
//        model.addAttribute("titlename","首页界面表");
//        return "System/SysHomePage";
//    }

    @RequestMapping(value = "/getAllHomePageInterface")
    @ResponseBody
    public List<SysHomePageEntity> getAllHomePageInterface(@CookieValue(value = "syscode",defaultValue = "") String sysCode, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysHomePageEntity> dictionary = new ArrayList<SysHomePageEntity>();
        String result;
        try{
            dictionary = sysHomePageService.getAllHomePageInterface(sysCode);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        return dictionary;
    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public void save(SysHomePageEntity sysHomePageEntity, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            if (sysHomePageEntity.getId().equals("")) {
                sysHomePageEntity.setId(UUID.randomUUID().toString());
                List<SysHomePageEntity> homePageInterfaceList = new ArrayList<SysHomePageEntity>();
                homePageInterfaceList = sysHomePageService.findByName(sysHomePageEntity.getName(),sysCode);
                if (homePageInterfaceList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = sysHomePageEntity.getId();
                List<SysHomePageEntity> ksEntityList = new ArrayList<SysHomePageEntity>();
                SysHomePageEntity homePage = sysHomePageService.findOne(id);
                String oldName = homePage.getName();
                if (!sysHomePageEntity.getName().equals(oldName)) {
                    ksEntityList = sysHomePageService.findByName(sysHomePageEntity.getName(), sysCode);
                    if (ksEntityList.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            sysHomePageEntity.setSysCode(sysCode);
            sysHomePageService.save(sysHomePageEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/toUpdate")
    @ResponseBody
    public SysHomePageEntity toUpdate(String id) {
        SysHomePageEntity sysHomePageEntity = sysHomePageService.findOne(id);
        return sysHomePageEntity;
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                           HttpServletResponse response)throws Exception{
        String result;

        try {
            sysHomePageService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysHomePageEntity> findByCondition(String condition, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                                         HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysHomePageEntity> homePageInterfaceEntities = new ArrayList<SysHomePageEntity>();
        String result;
        try{
            homePageInterfaceEntities = sysHomePageService.findByCondition("%"+condition+"%", sysCode);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".findByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return homePageInterfaceEntities;
    }



//    @RequestMapping(value = "/home/{userHome}/{defaultpage}")
//    public String toUserHome(@PathVariable("userHome") String userHome,@PathVariable("defaultpage") String defaultpage){
//
//        return "/home/"+userHome+"/" + defaultpage;
//    }
}
