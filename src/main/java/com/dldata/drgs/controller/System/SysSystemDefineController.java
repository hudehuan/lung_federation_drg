package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysSystemDefineEntity;
import com.dldata.drgs.service.System.SysSystemDefineService;
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
 * Created by admin on 2016/10/28.
 */
@Controller
@RequestMapping(value = "/SystemDefine")
public class SysSystemDefineController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysSystemDefineService systemDefineService;

//    @RequestMapping(value = "/gotoSystemDefine")
//    public String gotoSystemDefine(Model model,HttpServletRequest request,HttpServletResponse response) {
//        List<SysSystemDefineEntity> systemDefine = new ArrayList<SysSystemDefineEntity>();
//        systemDefine = systemDefineService.getAllSystem();
//        if (systemDefine.size() >0 ) {
//            model.addAttribute("systemDefine",systemDefine);
//        }
//        return "System/SysSystemDefine";
//    }

    @RequestMapping(value = "/getAllSystemDefine")
    @ResponseBody
    public List<SysSystemDefineEntity> getAllSystemDefine(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysSystemDefineEntity> systemDefine = new ArrayList<SysSystemDefineEntity>();
        String result;
        try{
            systemDefine = systemDefineService.getAllSystem();

        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllSystemDefine() 方法失败 】异常："+ex.getMessage());
        }
        return systemDefine;
    }

    @RequestMapping(value="/save")
    public void save(SysSystemDefineEntity systemDefineEntity,HttpServletRequest request, HttpServletResponse response)throws Exception{
            String result;
            try {
                if (systemDefineEntity.getId().equals("")) {
                    systemDefineEntity.setId(UUID.randomUUID().toString());
                } else {

                systemDefineService.save(systemDefineEntity);

                }
                result = "{\"success\":true,\"msg\":\"保存成功！\"}";
            } catch (Exception ex){
                result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
                logger.error("【执行"+this.getClass().getName()+".saveDictionary() 方法失败 】异常："+ex.getMessage());
            }
            StringUtil.writeToWeb(result, "html", response);
    }
}
