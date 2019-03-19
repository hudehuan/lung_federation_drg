package com.dldata.drgs.controller.customform;


import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import com.dldata.drgs.entity.SjsbFormFlowStepUserEntity;
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
 * Created by admin on 2016/12/14.
 */
@Controller
@RequestMapping(value = "/CustomFormFlowStep")
public class CustomFormFlowStepController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
//    private String sysConfig = SysConfig.SysCode;

    @Autowired
    private SjsbFormFlowStepService customFormFlowStepService;

    @Autowired
    private SjsbFormFlowStepUserService customFormFlowStepUserService;

    @RequestMapping("/getFormByFlowId")
    @ResponseBody
    public List<SjsbFormFlowStepEntity> getFormByFlowId(String flowId){
        return customFormFlowStepService.getFormFlowByFlowId(flowId);

    }

    @RequestMapping("/getFormByFlowIdnull")
    @ResponseBody
    public List<SjsbFormFlowStepEntity> getFormByFlowIdnull( ){
        return customFormFlowStepService.getFormByFlowIdnull();

    }

    @RequestMapping("/getStepById")
    @ResponseBody
    public SjsbFormFlowStepEntity getStepById(String id){
        return customFormFlowStepService.getStepEntityByID(id);
    }

    @RequestMapping(value = "/saveStep")
    public void saveForm(SjsbFormFlowStepEntity sjsbFormFlowStepEntity,HttpServletRequest request,
                         HttpServletResponse response) throws Exception{
        String result;

        try {
            if (sjsbFormFlowStepEntity.getId().equals("")) {
                sjsbFormFlowStepEntity.setId(UUID.randomUUID().toString());
                List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntityList = new ArrayList<SjsbFormFlowStepEntity>();
                sjsbFormFlowStepEntityList = customFormFlowStepService.findByXh(sjsbFormFlowStepEntity.getXh(),sjsbFormFlowStepEntity.getFlowId());
                if (sjsbFormFlowStepEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"步骤序号已存在！\",\"id\":\"#xh\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                sjsbFormFlowStepEntityList = customFormFlowStepService.findByName(sjsbFormFlowStepEntity.getName(), sjsbFormFlowStepEntity.getFlowId());
                if (sjsbFormFlowStepEntityList.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"步骤名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }else{
                SjsbFormFlowStepEntity sjsbFormFlowStep = customFormFlowStepService.getStepEntityByID(sjsbFormFlowStepEntity.getId());
                if(!sjsbFormFlowStep.getName().equals(sjsbFormFlowStepEntity.getName())){
                    List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntityList = new ArrayList<SjsbFormFlowStepEntity>();
                    sjsbFormFlowStepEntityList = customFormFlowStepService.findByName(sjsbFormFlowStepEntity.getName(), sjsbFormFlowStepEntity.getFlowId());
                    if (sjsbFormFlowStepEntityList.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"步骤名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }

//            sjsbFormFlowStepEntity.setSyscode(sysConfig);
            sjsbFormFlowStepEntity.setShks(null);
            sjsbFormFlowStepEntity.setStatus(true);
            customFormFlowStepService.save(sjsbFormFlowStepEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveForm() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/dele")
    public void delete(String id,HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            SjsbFormFlowStepEntity sjsbFormFlowStepEntity = customFormFlowStepService.getStepEntityByID(id);
            sjsbFormFlowStepEntity.setStatus(false);
            customFormFlowStepService.save(sjsbFormFlowStepEntity);
            List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserList = customFormFlowStepUserService.findByStepId(id);
            customFormFlowStepUserService.deleteYh(sjsbFormFlowStepUserList);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
