package com.dldata.drgs.controller.customform;


import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import com.dldata.drgs.entity.SjsbFormShLogEntity;
import com.dldata.drgs.entity.SjsbFormStepCheckListEntity;
import com.dldata.drgs.entity.SysStaffEntity;
import com.dldata.drgs.service.customform.SjsbFormFlowStepService;
import com.dldata.drgs.service.customform.SjsbFormShLogService;
import com.dldata.drgs.service.customform.SjsbFormStepCheckListService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2016/11/2.
 */
@Controller
@RequestMapping(value = "/CustomFormShLog")
public class CustomFormShLogController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    SjsbFormShLogService sjsbFormShLogService;


    @Autowired
    SjsbFormFlowStepService sjsbFormFlowStepService;

    @Autowired
    SysStaffService sysStaffService;


    @Autowired
    SjsbFormStepCheckListService sjsbFormStepCheckListService;




    @RequestMapping("/getLogListByCheckID")
    @ResponseBody
    public String getLogListByCheckID(String formID,String dataID){

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();


        List<SjsbFormShLogEntity> shLogEntities =sjsbFormShLogService.getFormShLogByFormIDDataID(formID,dataID);
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntities = sjsbFormFlowStepService.getfindAll();
        List<SysStaffEntity> sysStaffEntities = sysStaffService.findByCondition("%%");
        shLogEntities.forEach(sh -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("id",sh.getId());
            map.put("checkTime",sh.getSjtime().toString().substring(0,10));
            map.put("shStatus",sh.getStatus().toString());
            map.put("shsm",sh.getSm());
            map.put("stepName","");
            sjsbFormFlowStepEntities.stream().filter(step -> step.getId().equals(sh.getStepId())).limit(1).forEach(step -> {
                map.put("stepName",step.getName()==null?step.getId():step.getName());
            });
            map.put("checkUser","");
            sysStaffEntities.stream().filter(staff -> staff.getId().equals(sh.getUserId())).limit(1).forEach(staff -> {
                map.put("checkUser",staff.getName()==null?staff.getId():staff.getName());
            });
            mapList.add(map);
        });
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }


    @RequestMapping("/dobohui")
    public void dobohui(String dataID,String checkID,String formID,String flowID,String stepID,String sm,
                        @CookieValue(value = "userid", defaultValue = "") String userId,
                        @CookieValue(value = "username", defaultValue = "") String username,
                        HttpServletRequest request,HttpServletResponse response)throws Exception{
        String result="";


        //驳回时，删掉全部的审核提交
        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = sjsbFormStepCheckListService.getEntityByID(checkID);
        sjsbFormStepCheckListEntity.setChecktime(new  Timestamp(new Date().getTime()));
        sjsbFormStepCheckListEntity.setCheckUserName(username);
        sjsbFormStepCheckListEntity.setCheckUserId(userId);
        sjsbFormStepCheckListEntity.setFormStatus(3);
        sjsbFormStepCheckListService.save(sjsbFormStepCheckListEntity);

        //增加审核日志记录
        SjsbFormShLogEntity sjsbFormShLogEntity = new SjsbFormShLogEntity();
        sjsbFormShLogEntity.setId(UUID.randomUUID().toString());
        sjsbFormShLogEntity.setFormId(formID);
        sjsbFormShLogEntity.setDataId(dataID);
        sjsbFormShLogEntity.setSjtime(new Timestamp(new Date().getTime()));
        sjsbFormShLogEntity.setUserId(userId);
        sjsbFormShLogEntity.setFlowId(flowID);
        sjsbFormShLogEntity.setStepId(stepID);
        sjsbFormShLogEntity.setStatus(3);//1审核 2审核结束 3驳回
        sjsbFormShLogEntity.setSm(sm);


        sjsbFormShLogService.save(sjsbFormShLogEntity);
        result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }




    @RequestMapping("/fanbo")
    public void fanbo(String dataId,@CookieValue(value = "userid", defaultValue = "") String userId,
                      HttpServletRequest request,HttpServletResponse response)throws Exception{
        String result;
        try{
            //chekeList数据
            SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = sjsbFormStepCheckListService.getCheckFormByDataID(dataId);
            //审核流程全部步骤
            List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntity = sjsbFormFlowStepService.getStepByFlowID(sjsbFormStepCheckListEntity.getFlowId());
            boolean iscount = false;
            //用户对该数据的审核记录
            List<SjsbFormShLogEntity> userShLogs = sjsbFormShLogService.findByUserIdDataId(userId, dataId);
            if(userShLogs.size()>0){
            //得到用户已审核步骤
            List<SjsbFormFlowStepEntity> userShLog = new ArrayList<SjsbFormFlowStepEntity>();
            for(int j=0;j<sjsbFormFlowStepEntity.size();j++){
                int k = 0;
                for(int i=0;i<userShLogs.size();i++){
                    if(userShLogs.get(i).getStepId().equals(sjsbFormFlowStepEntity.get(j).getId())){
                        k++;
                    }
                }
                if(k%2==1){
                    userShLog.add(sjsbFormFlowStepEntity.get(j));
                }
            }

            //有数据，但没有审核记录  userShLog.size() 为0 表示有过审核但已撤销
            if(userShLog.size()>0){
                //通过审核的最后一个步骤
                SjsbFormFlowStepEntity nowShStep = new SjsbFormFlowStepEntity();
                SjsbFormFlowStepEntity oldShStep = new SjsbFormFlowStepEntity();
                if(sjsbFormStepCheckListEntity.getFormStatus()==2){

                    if(userShLog.get(userShLog.size()-1).getId().equals(sjsbFormStepCheckListEntity.getStepId())){
                        nowShStep = sjsbFormFlowStepEntity.get(sjsbFormFlowStepEntity.size()-1);
                        iscount = true;
                    }
                }else{
                    for (int i=0;i<sjsbFormFlowStepEntity.size()-1;i++){
                        //判断审核通过审核的最后一个步骤
                        if(sjsbFormStepCheckListEntity.getStepId().equals(sjsbFormFlowStepEntity.get(i+1).getId())){
                            if(userShLog.get(userShLog.size()-1).getId().equals(sjsbFormFlowStepEntity.get(i).getId())){
                                nowShStep = sjsbFormFlowStepEntity.get(i);
                                iscount = true;
                            }

                        }
                    }
                }

                //修改审核状态
                if(iscount){
                    //添加审核记录
                    SjsbFormShLogEntity s = new SjsbFormShLogEntity();
                    s.setId(UUID.randomUUID().toString());
                    s.setFormId(sjsbFormStepCheckListEntity.getFormId());
                    s.setDataId(sjsbFormStepCheckListEntity.getDataId());
                    s.setSjtime(new Timestamp(new Date().getTime()));
                    s.setUserId(userId);
                    SysStaffEntity staffEntity = new SysStaffEntity();
                    staffEntity = sysStaffService.getStaffByID(userId);
                    s.setUserName(staffEntity.getName());
                    s.setFlowId(sjsbFormStepCheckListEntity.getFlowId());
                    s.setStepId(nowShStep.getId());
                    s.setStatus(4);
                    s.setSm("撤销审核");
                    sjsbFormShLogService.save(s);
                    sjsbFormStepCheckListEntity.setStepId(nowShStep.getId());
                    sjsbFormStepCheckListEntity.setFormStatus(1);
                    sjsbFormStepCheckListService.save(sjsbFormStepCheckListEntity);

                    result = "{\"success\":true,\"msg\":\"操作成功！\"}";
                }
                else{
                    result = "{\"success\":false,\"msg\":\"已通过下一步审核，无法撤销！\"}";
                }
            }else{
                result = "{\"success\":false,\"msg\":\"审核已撤销！\"}";
            }
            }else {
                result = "{\"success\":false,\"msg\":\"数据非本人审核，无法撤销！\"}";
            }
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".fanbo() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


}
