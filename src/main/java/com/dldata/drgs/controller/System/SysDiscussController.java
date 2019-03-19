package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysDiscussEntity;
import com.dldata.drgs.service.System.SysDiscussService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
@RequestMapping(value = "/SysDiscuss")
public class SysDiscussController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysDiscussService discussService;

//    @RequestMapping(value = "/gotoDiscuss")
//    public String gotoDictionary(Model model) {
//        model.addAttribute("titlename","交流讨论表");
//        return "System/SysDiscuss";
//    }

    @RequestMapping(value = "/getAllDiscuss")
    @ResponseBody
    public List<SysDiscussEntity> getAllDiscussItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysDiscussEntity> dictionary = new ArrayList<SysDiscussEntity>();
        String result;
        try{
            dictionary = discussService.getAllDiscuss();
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        return dictionary;
    }

//    @RequestMapping(value="/gotosave")
//    public String gotoSave(){
//        return "System/SysDiscussEdit";
//    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(SysDiscussEntity discuss,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;
        try {
            if (discuss.getDisId().equals("")) {
                discuss.setDisId(UUID.randomUUID().toString());
            }
            discussService.save(discuss);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        //StringUtil.writeToWeb(result, "html", response);
        return "System/SysDiscuss";
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                           HttpServletResponse response)throws Exception{
        String result;

        try {
            discussService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteDiscuss() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
