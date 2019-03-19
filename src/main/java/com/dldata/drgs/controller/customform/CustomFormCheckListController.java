package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.service.System.SysUserKsService;
import com.dldata.drgs.service.customform.*;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by 吴岳峰 on 2017/6/3.
 */
@Controller
@RequestMapping(value = "/CustomFormCheckList")
public class CustomFormCheckListController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CustomFormService customFormService;

    @Autowired
    private SjsbFormFlowStepUserService sjsbFormFlowStepUserService;

    @Autowired
    private SjsbFormStepCheckListService sjsbFormStepCheckListService;

    @Autowired
    private SjsbFormShLogService sjsbFormShLogService;

    @Autowired
    private SjsbFormFlowStepService sjsbFormFlowStepService;

    @Autowired
    private SjsbFormFlowService sjsbFormFlowService;

    @Autowired
    private SysUserKsService userKsService;
    @Autowired
    private SysStaffService sysStaffService;
    @Autowired
    private SysKeShiService sysKeShiService;


    //得到表单请求地址
    @RequestMapping("/getCostomFormUrl")
    public void getCostomFormUrl(@CookieValue(value = "dlSSOServerUrl",defaultValue = "") String serverURL,
                                 String dataId, String formId, String formStatus,
                                 HttpServletRequest request, HttpServletResponse response) throws  Exception{
        String result ;
        try{

            String url = serverURL+"/v_customformdata/toEdit?dataId="+dataId+"&tableId="+formId+"&formStatus="+formStatus;
//            Map<String,String> map = new HashMap<String,String>();
//            map.put("url",url);
            result = "{\"success\":true,\"msg\":\""+url+"\"}";//"redirect:"+datasbURL;
        } catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".opensb() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    //获取用户填报的表单
    @RequestMapping("/getCheckListOfUserID")
    @ResponseBody
    public String getCheckListOfUserID(@CookieValue(value = "userid",defaultValue = "") String userid,
                                       String sTime,String eTime){
        List<SjsbFormStepCheckListEntity> SjsbFormStepCheckLists =  sjsbFormStepCheckListService
                .getCheckListByUserIDTime(userid, Timestamp.valueOf(sTime+" 00:00:00"),Timestamp.valueOf(eTime+" 00:00:00"));
        List<SjsbFormFlowEntity> sjsbFormFlowList = sjsbFormFlowService.getfindAll();
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepList = sjsbFormFlowStepService.getfindAll();

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        if (SjsbFormStepCheckLists.size() > 0) {
            for(int i=0;i<SjsbFormStepCheckLists.size();i++){
                Map<String,String> map = new HashMap<String,String>();
                SjsbFormStepCheckListEntity sjsb = SjsbFormStepCheckLists.get(i);
                map.put("id",sjsb.getId());
                map.put("inputTime", sjsb.getInputTime() == null ? "" : sjsb.getInputTime().toString().substring(0,10));
                map.put("dataId",sjsb.getDataId() == null ? sjsb.getId() : sjsb.getDataId());
                map.put("formId",sjsb.getFormId() == null ? sjsb.getId() : sjsb.getFormId());
                map.put("formName",sjsb.getFormName() == null ? sjsb.getId() : sjsb.getFormName());
                map.put("formStatus", sjsb.getFormStatus() == null ? "" : sjsb.getFormStatus().toString());
                map.put("formTypeName", sjsb.getFormTypeName() == null ? sjsb.getId() : sjsb.getFormTypeName());
                map.put("shName", "");
                String fromid  =sjsb.getFlowId();
                if (fromid !=null) {
                    sjsbFormFlowList.stream().filter(p -> p.getId().equals(fromid)).limit(1).forEach(
                            p -> {
                                map.put("shName", p.getName() == null ? p.getId() : p.getName());
                                return;
                            }
                    );
                }


                String stepid  =sjsb.getStepId();
                if (stepid !=null) {
                    sjsbFormFlowStepList.stream().filter(p -> p.getId().equals(stepid)).limit(1).forEach(
                            p -> {
                                map.put("shName",map.get("shName") + " -> " + (p.getName()==null?p.getId():p.getName()));
                                return;
                            }
                    );
                }

                mapList.add(map);
            };


        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }


    //查询用户待审核表单
    //记得要查询用户只能可看科室数据.
    @RequestMapping("/getNoCheckList")
    @ResponseBody
    public String getNonCheckListOfUserID(@CookieValue(value = "userid",defaultValue = "") String userId,
                                          String sTime, String eTime,
                                          @RequestParam(value="formId", required=false) String formId, int formStatus) {


        //得到当前用户有审核权限的流程和审核步骤
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);

        //获取所有的没有审核,审核步聚ID对应的用户是我的数据
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = sjsbFormStepCheckListService.getNoCheckListShUserIDTime(userId, Timestamp.valueOf(sTime + " 00:00:00"), Timestamp.valueOf(eTime + " 00:00:00"));

        List<SysUserKsEntity> sysUserKsList = userKsService.findByUserId(userId, SysConfig.SysCode);
        List<SjsbFormFlowEntity> sjsbFormFlowList = sjsbFormFlowService.getfindAll();
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepList = sjsbFormFlowStepService.getfindAll();





        List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        sjsbFormStepCheckListEntities.forEach(item -> {


            if (formId.equals("") || formId.equals(item.getFormId())) { //如果有formid条件

                Map<String, String> map = new HashMap<String, String>();

                map.put("id", item.getId());
                map.put("dataId", item.getDataId()==null?item.getId():item.getDataId());
                map.put("formId",item.getFormId() == null ? item.getId() : item.getFormId());
                map.put("inputTime",item.getInputTime() ==null?item.getId():item.getInputTime().toString().substring(0,10)); //上报日期
                map.put("inputUserName", item.getInputUserName()==null?item.getId():item.getInputUserName());
                map.put("formTypeName", item.getFormTypeName()==null?item.getId():item.getFormTypeName());
                map.put("formName", item.getFormName()==null?item.getId():item.getFormName());
                map.put("formStatus", item.getFormStatus().toString()==null?item.getId():item.getFormStatus().toString());
                map.put("ShName", "");

                sjsbFormFlowList.stream().filter(p -> p.getId().equals(item.getFlowId())).limit(1).forEach(p -> {
                    map.put("ShName", p.getName()==null?p.getId():p.getName());
                    return;
                });


                sjsbFormFlowStepList.stream().filter(p -> p.getId().equals(item.getStepId())).limit(1).forEach(p -> {
                    map.put("ShName", map.get("ShName") + " -> " +  (p.getName()==null?p.getId():p.getName()));
                    return;
                });

                //只看自己科室数据//配置了
                if (sjsbFormFlowStepUserEntities.stream().filter(p->p.getStepId().equals(item.getStepId()) && p.getIsOnlyKs()).count()>0) { //去掉不可看的部署
                    if (sysUserKsList.stream().filter(p -> (p.getKsid().equals(item.getInputKsId()))).count()>0)
                        listmap.add(map);
                }
                else
                {
                    listmap.add(map);
                }
            }
        });

        return listmap.size() > 0 ? JSONArray.fromObject(listmap).toString() : "[]";
    }


    //查询用户已审核过的表单
    @RequestMapping("/getCheckedList")
    @ResponseBody
    public String getCheckedList(@CookieValue(value = "userid",defaultValue = "")  String userId,
                                 String sTime,String eTime,String all,
                                 @RequestParam (value="formId", required=false) String formId) {

        //得到用户审核表单
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);
        List<SjsbFormFlowEntity> sjsbFormFlowEntity= sjsbFormFlowService.getfindAll();
//        List<SjsbFormEntity> sjsbFormEntity = sjsbFormService.getAllForm("SJSB");
//        List<SjsbFormEntity> userForm = new ArrayList<SjsbFormEntity>();
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        List<CustomFormEntity> userForm = new ArrayList<CustomFormEntity>();
        customFormEntities.forEach(f->{
            Map<String, String> map = new HashMap<String, String>();
            map.put("checked","");
            sjsbFormFlowEntity.stream().filter(ff -> (f.getId().equals(ff.getFormid()))).forEach(ff -> {
                sjsbFormFlowStepUserEntities.stream().filter(us -> (us.getFlowId().equals(ff.getId()))).limit(1).forEach(us -> {
                    map.put("checked","true");
                    return;
                });
            });
            if(map.get("checked").equals("true")){
                userForm.add(f);
            }
        });


        //得到当前用户有审核权限的流程和审核步骤 用审核日志查询 要改

        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = sjsbFormStepCheckListService.getDataInShLogFormIDTime(formId, Timestamp.valueOf(sTime + " 00:00:00"), Timestamp.valueOf(eTime + " 00:00:00"));

        List<SjsbFormShLogEntity> sjsbFormShLogEntity = sjsbFormShLogService.findByUserID(userId);


        List<SjsbFormFlowEntity> sjsbFormFlowList = sjsbFormFlowService.getfindAll();
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepList = sjsbFormFlowStepService.getfindAll();


        List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        sjsbFormStepCheckListEntities.forEach(item -> {
            userForm.stream().filter(uf->item.getFormId().equals(uf.getId())).forEach(uf -> {


//                if (formId.equals("") || formId.equals(item.getFormId())) { //如果有formid条件
                Map<String, String> map = new HashMap<String, String>();
                //可能会有多条数据,只显示第一条数据 SQL已经按日期倒排了
                map.put("lid", "");
                map.put("name", "");
                map.put("checkId","");
                sjsbFormShLogEntity.stream().filter(p -> p.getDataId().equals(item.getDataId())).limit(1).forEach(p -> {
                    map.put("checkId",p.getUserId());
                    map.put("lid", p.getId()); //ID
                    map.put("name", p.getStepId()); //ID
//                        map.put("Sjtime", format.format(p.getSjtime())); //ID
                });
                if (Util.checkNotNull(all) ||map.get("checkId").equals(userId) ) {

                    map.put("id", item.getId()); //ID

                    map.put("dataId", item.getDataId());
                    map.put("formId",item.getFormId() == null ? item.getId() : item.getFormId());
                    map.put("Sjtime", item.getChecktime()==null ?"":format.format(item.getChecktime()));
                    map.put("checkName",item.getCheckUserName()==null?"":item.getCheckUserName());



                    if (!map.get("name").equals("")) {
                        sjsbFormFlowStepList.stream().filter(p -> p.getId().equals(map.get("name"))).limit(1).forEach(p -> {
                            map.put("name", p.getName());
                        });
                    }


                    map.put("inputUserName", item.getInputUserName());
                    map.put("inputTime", item.getInputTime()==null?"":item.getInputTime().toString().substring(0,10));
                    map.put("formTypeName", item.getFormTypeName());
                    map.put("formName", item.getFormName());
                    map.put("ShName", "");


                    sjsbFormFlowList.stream().filter(p -> p.getId().equals(item.getFlowId())).limit(1).forEach(p -> {
                        map.put("ShName", p.getName());
                        return;
                    });


                    sjsbFormFlowStepList.stream().filter(p -> p.getId().equals(item.getStepId())).limit(1).forEach(p -> {
                        map.put("ShName", map.get("ShName") + " -> " +  (p.getName()==null?p.getId():p.getName()));
                        return;
                    });


                    map.put("formStatus", item.getFormStatus().toString());
                    listmap.add(map);
                }
            });
        });

        return listmap.size()>0 ? JSONArray.fromObject(listmap).toString() : "[]";
    }


    @RequestMapping("/dorefresh")
    @ResponseBody
    public String dorefresh(@CookieValue(value = "userid",defaultValue = "") String userId,int formStatus) throws Exception{
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = new ArrayList<SjsbFormFlowStepUserEntity>();
        sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);
        List<SysUserKsEntity> sysUserKsList = new ArrayList<SysUserKsEntity>();
        sysUserKsList = userKsService.findByUserId(userId,SysConfig.SysCode);
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = new ArrayList<SjsbFormStepCheckListEntity>();
        for(int i=0;i<sjsbFormFlowStepUserEntities.size();i++) {
            SjsbFormFlowStepUserEntity t_step = sjsbFormFlowStepUserEntities.get(i);
            String t_flowid = t_step.getFlowId();
            String t_stepid = t_step.getStepId();

            //查询用户待审核的全部表单
            boolean t_isKs =t_step.getIsOnlyKs();

            List<SjsbFormStepCheckListEntity> t_CheckList = new ArrayList<SjsbFormStepCheckListEntity>();
            if(t_isKs){
                for(int a = 0 ;a<sysUserKsList.size();a++){
                    String ksId = sysUserKsList.get(a).getKsid();
                    t_CheckList = sjsbFormStepCheckListService.getNonCheckListByFlowIDStepIDKsID(t_flowid, t_stepid,ksId ,formStatus);
                    sjsbFormStepCheckListEntities.addAll(t_CheckList);
                }
            }
            else{
                t_CheckList = sjsbFormStepCheckListService.getNonCheckListByFlowIDStepID(t_flowid, t_stepid,formStatus);
                sjsbFormStepCheckListEntities.addAll(t_CheckList);
            }

        }

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
//        List<SjsbFormEntity> sjsbFormEntityList = new ArrayList<SjsbFormEntity>();
//        sjsbFormEntityList = sjsbFormService.getAllForm(SysConfig.SysCode);
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        for(int e=0;e<customFormEntities.size();e++){
            String formID = customFormEntities.get(e).getId();

            int count = 0;
            for (int c=0;c<sjsbFormStepCheckListEntities.size();c++){

                if(formID.equals(sjsbFormStepCheckListEntities.get(c).getFormId())){
                    count++;
                }
            }

            if(count>0){
                Map<String,String> map = new HashMap<String,String>();
                map.put("formId",formID);
                map.put("formName",customFormEntities.get(e).getName());
                map.put("count",String.valueOf(count));

                mapList.add(map);
            }
        }

        Map<String,Object> obMap = new HashMap<String,Object>();
        obMap.put("count",sjsbFormStepCheckListEntities.size());
        obMap.put("formCountList",mapList);
        return  JSONSerializer.toJSON(obMap).toString();

    }



    //查询用户有权限审核的表单列表
    @RequestMapping("/getFormOfUserID")
    @ResponseBody
    public List<CustomFormEntity> getFormOfUserID(@CookieValue(value = "userid",defaultValue = "")  String userId){
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = new ArrayList<SjsbFormFlowStepUserEntity>();
        sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);
        List<CustomFormEntity> customFormEntities = customFormService.getAllCustomForm();
        List<SjsbFormFlowEntity> sjsbFormFlowEntities = sjsbFormFlowService.getfindAll();
        //得到用户审核表单
        List<CustomFormEntity> userCheckForm = new ArrayList<CustomFormEntity>();
        sjsbFormFlowStepUserEntities.forEach(us -> {
            sjsbFormFlowEntities.stream().filter(flow -> flow .getId().equals(us.getFlowId())).limit(1).forEach(flow -> {
                customFormEntities.stream().filter(f -> f.getId().equals(flow.getFormid())).limit(1).forEach(f -> {
                    userCheckForm.add(f);
                });
            });
        });
        return userCheckForm;
    }
    @RequestMapping("/doCheckStep")
    public void doCheck(String formID,
                        String id,
                        @CookieValue(value = "userid", defaultValue = "") String userId,
                        HttpServletRequest request,HttpServletResponse response)throws Exception{

        String result="";
//        String checkId;
//        String flowId;
//        String stepId;
        //增加审核记录
        SjsbFormShLogEntity sjsbFormShLogEntity = new SjsbFormShLogEntity();
        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = sjsbFormStepCheckListService.getCheckFormByDataID(id);

        String flowId = sjsbFormStepCheckListEntity.getFlowId();
        String stepId = sjsbFormStepCheckListEntity.getStepId();

        //得到当前用户有审核权限的流程和审核步骤
        Map<String,Boolean>  map = new HashMap<String,Boolean>();
        map.put("isc",false);
        List<SjsbFormFlowStepUserEntity> sjsbFormFlowStepUserEntities = sjsbFormFlowStepUserService.getFlowStepOfUserID(userId);
        sjsbFormFlowStepUserEntities.stream().filter(us -> us.getFlowId().equals(flowId)&&us.getStepId().equals(stepId)).limit(1).forEach(us -> {
            map.put("isc",true);
        });
        if(!map.get("isc")){
            result = "{\"success\":false,\"msg\":\"数据已审核！\"}";
            StringUtil.writeToWeb(result, "html", response);
            return;
        }

        //得到下一步审核步骤ID
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntities = new ArrayList<SjsbFormFlowStepEntity>();
        sjsbFormFlowStepEntities = sjsbFormFlowStepService.getStepByFlowID(flowId);
        SysStaffEntity sysStaffEntity = sysStaffService.findOne(userId);

        if(sjsbFormFlowStepEntities.size()>0) {
            for (int i = 0; i < sjsbFormFlowStepEntities.size(); i++) {
                String t_stepID = sjsbFormFlowStepEntities.get(i).getId();

                //判断当前审核步骤
                if (t_stepID.equals(stepId)) {

                    if(i==sjsbFormFlowStepEntities.size()-1){
                        //当前步骤是最后一步，那么当前这次审核表示结束,修改状态为true，并且更新审核时间
                        sjsbFormStepCheckListEntity.setFormStatus(2);  //结束审核
                        sjsbFormStepCheckListEntity.setChecktime(new Timestamp(new Date().getTime()));

                        sjsbFormShLogEntity.setStatus(2);//0提交审核  1审核中  2审核结束  3驳回
                        sjsbFormShLogEntity.setSm("审核结束");


                        sjsbFormStepCheckListEntity.setChecktime(new Timestamp(new Date().getTime()));
                        sjsbFormStepCheckListEntity.setCheckUserId(userId);
                        sjsbFormStepCheckListEntity.setCheckUserName(sysStaffEntity.getName());
                    }
                    else{
                        sjsbFormStepCheckListEntity.setChecktime(new Timestamp(new Date().getTime()));
                        sjsbFormStepCheckListEntity.setCheckUserId(userId);
                        sjsbFormStepCheckListEntity.setCheckUserName(sysStaffEntity.getName());
                        //当前步骤不是最后一步，更新下一步ID
                        sjsbFormStepCheckListEntity.setStepId(sjsbFormFlowStepEntities.get(i + 1).getId());
                        sjsbFormStepCheckListEntity.setFormStatus(1);

                        sjsbFormShLogEntity.setStatus(1);//0提交审核  1审核中   2审核结束 3驳回
                        sjsbFormShLogEntity.setSm("审核中");
                    }
                }
            }
        }

        //增加审核记录
        sjsbFormShLogEntity.setId(UUID.randomUUID().toString());
        sjsbFormShLogEntity.setFormId(formID);
        sjsbFormShLogEntity.setDataId(id);
        sjsbFormShLogEntity.setSjtime(new Timestamp(new Date().getTime()));
        sjsbFormShLogEntity.setUserId(userId);
        sjsbFormShLogEntity.setUserName(sysStaffEntity.getName());
        sjsbFormShLogEntity.setFlowId(flowId);
        sjsbFormShLogEntity.setStepId(stepId);

        sjsbFormStepCheckListService.save(sjsbFormStepCheckListEntity);
        sjsbFormShLogService.save(sjsbFormShLogEntity);
        result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/getAllCheckList")
    @ResponseBody
    public String getAllCheckList(String startTime,String endTime ,String ks,String formid,String formStatus){
        Timestamp s = Timestamp.valueOf(startTime+" 00:00:00");
        Timestamp e = Timestamp.valueOf(endTime+" 23:59:59");
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = sjsbFormStepCheckListService.getAllDataByTime( s,  e ,  ks,  formid);
        List<SysKsEntity> sysKsEntities = sysKeShiService.getAllKeShi();
        List<SjsbFormFlowEntity> sjsbFormFlowEntities = sjsbFormFlowService.getfindAll();
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntities = sjsbFormFlowStepService.getfindAll();
        List<Map<String,String>> mapList = new ArrayList<Map<String, String>>();
        sjsbFormStepCheckListEntities.stream().filter(c -> formStatus.equals("")||formStatus.equals(c.getFormStatus().toString())).forEach(c -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("dataId",c.getDataId());
            map.put("checkId",c.getId());
            map.put("inputKsId",c.getInputKsId());
            map.put("formId",c.getFormId());
            map.put("inputUserName",c.getInputUserName());
            map.put("inputTime",c.getInputTime()==null?"":c.getInputTime().toString().substring(0,10));
            map.put("inputKs",c.getInputKsId());
            sysKsEntities.stream().filter(k -> k.getId().equals(c.getInputKsId())).limit(1).forEach(k -> {
                map.put("inputKs",k.getName());
            });

            map.put("checkUserName",c.getCheckUserName());
            map.put("checkTime",c.getChecktime()==null?"":c.getChecktime().toString().substring(0,10));
            map.put("step","");
            map.put("form_status",c.getFormStatus()==null?"":c.getFormStatus().toString());
            map.put("formName",c.getFormName());
            if(c.getFormStatus()==1){
                sjsbFormFlowEntities.stream().filter(flow -> flow.getId().equals(c.getFlowId())).limit(1).forEach(flow -> {
                    map.put("step",flow.getName());
                });
                sjsbFormFlowStepEntities.stream().filter(step -> step.getId().equals(c.getStepId())).limit(1).forEach(step -> {
                    map.put("step",map.get("step")+" -> "+step.getName());
                });
            }
            mapList.add(map);

        });
        return mapList.size()>0?JSONArray.fromObject(mapList).toString():"[]";
    }
}
