package com.dldata.drgs.controller.customform;


import com.dldata.drgs.entity.SjsbFormFlowEntity;
import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import com.dldata.drgs.entity.SjsbFormFlowStepUserEntity;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.customform.SjsbFormFlowService;
import com.dldata.drgs.service.customform.SjsbFormFlowStepService;
import com.dldata.drgs.service.customform.SjsbFormFlowStepUserService;
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
 * Created by 倪继文 on 2016/11/2.
 */

@Controller
@RequestMapping(value = "/CustomFormFlow")
public class CustomFormFlowController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
//    private String sysConfig = SysConfig.SysCode;

    @Autowired
    private SjsbFormFlowService customFormFlowService;

    @Autowired
    private SysKeShiService sysKeShiService;

    @Autowired
    private SjsbFormFlowStepService customFormFlowStepService;

    @Autowired
    private SjsbFormFlowStepUserService customFormFlowStepUserService;




    @RequestMapping("/getFlowByFormID")
    @ResponseBody
    public List<SjsbFormFlowEntity> getFlowByFormID(String formID){
        return customFormFlowService.getFormFlowByFormID(formID);

    }

    @RequestMapping("/getFlowByFormIDnull")
    @ResponseBody
    public List<SjsbFormFlowEntity> getFlowByFormIDnull( ){
        return customFormFlowService.getFlowByFormIDnull();

    }


    @RequestMapping(value = "/save")
    public void save(SjsbFormFlowEntity sjsbFormFlowEntity,HttpServletRequest request,HttpServletResponse response) throws Exception{
        String result;
        try {
            if (sjsbFormFlowEntity.getId().equals("")) {
                sjsbFormFlowEntity.setId(UUID.randomUUID().toString());
                List<SjsbFormFlowEntity> sjsbFormFlowEntityList = new ArrayList<SjsbFormFlowEntity>();
                sjsbFormFlowEntityList = customFormFlowService.findByXh(sjsbFormFlowEntity.getXh(),sjsbFormFlowEntity.getFormid());
                if (sjsbFormFlowEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"序号已存在！\",\"id\":\"#xh\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                sjsbFormFlowEntityList = customFormFlowService.findByName(sjsbFormFlowEntity.getName(),sjsbFormFlowEntity.getFormid());
                if (sjsbFormFlowEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"流程名已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                SjsbFormFlowEntity sjsbFormFlow = customFormFlowService.findOne(sjsbFormFlowEntity.getId());
                if(!sjsbFormFlow.getName().equals(sjsbFormFlowEntity.getName())){
                    List<SjsbFormFlowEntity> sjsbFormFlowEntityList = new ArrayList<SjsbFormFlowEntity>();
                    sjsbFormFlowEntityList = customFormFlowService.findByName(sjsbFormFlowEntity.getName(),sjsbFormFlowEntity.getFormid());
                    if (sjsbFormFlowEntityList.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"流程名已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            if(sjsbFormFlowEntity.getMoren()==null){
                sjsbFormFlowEntity.setMoren(false);
            }
            if(sjsbFormFlowEntity.getQy()==null){
                sjsbFormFlowEntity.setQy(false);
            }
            sjsbFormFlowEntity.setStatus(true);
//            sjsbFormFlowEntity.setSyscode(sysConfig);
            customFormFlowService.save(sjsbFormFlowEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/updateMoren")
    public void updateMoren(String id, HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            SjsbFormFlowEntity sjsbFormFlowEntity = customFormFlowService.getSjsbFormFlowByID(id);
            if(sjsbFormFlowEntity.getMoren().equals(true)){
                sjsbFormFlowEntity.setMoren(false);
            }else{
                sjsbFormFlowEntity.setMoren(true);
                //sjsbFormFlowEntity.setQy(false);
            }

            customFormFlowService.save(sjsbFormFlowEntity);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".updateMoren() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }

    @RequestMapping(value = "/updateQy")
    public void updateQy(String id, HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            SjsbFormFlowEntity sjsbFormFlowEntity = customFormFlowService.getSjsbFormFlowByID(id);
            if(sjsbFormFlowEntity.getQy().equals(true)){
                sjsbFormFlowEntity.setQy(false);

            }else{
                sjsbFormFlowEntity.setQy(true);
                // sjsbFormFlowEntity.setMoren(false);

            }

            customFormFlowService.save(sjsbFormFlowEntity);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".updateQy() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping("/deletelc")
    public void deletelc(String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try{
            SjsbFormFlowEntity sjsbFormFlowEntity = customFormFlowService.findOne(id);
            sjsbFormFlowEntity.setStatus(false);
            customFormFlowService.save(sjsbFormFlowEntity);
            List<SjsbFormFlowStepEntity> sjsbFormFlowStepList = customFormFlowStepService.getStepByFlowID(id);
            List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserList = customFormFlowStepUserService.findByFlowId(id);
            sjsbFormFlowStepList.forEach(s -> {
                sjsbFormFlowStepUserList.stream().filter(u -> u.getStepId().equals(s.getId())).forEach(u -> {
                    customFormFlowStepUserService.deleteById(u.getId());
                });
                s.setStatus(false);
                customFormFlowStepService.save(s);
            });

//            for(SjsbFormFlowStepEntity s : sjsbFormFlowStepList){
//                List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserList = customFormFlowStepUserService.findByStepId(s.getId());
//                customFormFlowStepUserService.deleteYh(sjsbFormFlowStepUserList);
//                s.setStatus(false);
//                customFormFlowStepService.save(s);
//            }
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deletelc() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


}
