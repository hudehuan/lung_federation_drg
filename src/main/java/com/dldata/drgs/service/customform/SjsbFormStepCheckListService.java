package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.repository.customform.SjsbFormStepCheckListDao;
import com.dldata.drgs.repository.customform.CustomFormDao;
import com.dldata.drgs.repository.customform.CustomFormTypeDao;
import com.dldata.drgs.repository.customform.CustomTypeDao;
import com.dldata.drgs.service.System.SysStaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/11/1.
 */
@Component
@Transactional
public class SjsbFormStepCheckListService {

    @Autowired
    SjsbFormStepCheckListDao sjsbFormStepCheckListDao;

    public List<SjsbFormStepCheckListEntity> getAllDataByTime(Timestamp s, Timestamp e , String ks, String formid){
        return sjsbFormStepCheckListDao.getAllDataByTime( s,  e ,  "%"+ks+"%",  "%"+formid+"%");
    }

    public void save(SjsbFormStepCheckListEntity entity){
        sjsbFormStepCheckListDao.save(entity);
    }

    public List<SjsbFormStepCheckListEntity> getNoCheckListShUserID(String Shuserid){
        return sjsbFormStepCheckListDao.getNoCheckListShUserID(Shuserid);
    }

    public List<SjsbFormStepCheckListEntity> getNoCheckListShUserIDTime(String Shuserid,Timestamp sTime, Timestamp eTime){
        return sjsbFormStepCheckListDao.getNoCheckListShUserIDTime(Shuserid,sTime,eTime);
    }

    public List<SjsbFormStepCheckListEntity> getDataformStatus(int formStatus)
    {
       return sjsbFormStepCheckListDao.getDataformStatus(formStatus);
    }

    public List<SjsbFormStepCheckListEntity> getNonCheckListByFlowIDStepID(String flowID,String stepID,int formStatus){
        return sjsbFormStepCheckListDao.getNonCheckListByFlowIDStepID(flowID, stepID,formStatus);

    }

    public List<SjsbFormStepCheckListEntity> getDataInShLogFormIDTime(String formId,Timestamp startTime,Timestamp endTime){
        return sjsbFormStepCheckListDao.getDataInShLogFormIDTime("%"+formId+"%", startTime, endTime);

    }
    public List<SjsbFormStepCheckListEntity> getNonCheckListByFlowIDStepIDKsID(String flowID,String stepID,String ksID,int formStatus){
        return sjsbFormStepCheckListDao.getNonCheckListByFlowIDStepIDKsID(flowID, stepID,ksID,formStatus);

    }


    public List<SjsbFormStepCheckListEntity> getCheckedListByFlowIDStepID(String flowID,String stepID){
        return sjsbFormStepCheckListDao.getCheckedListByFlowIDStepID(flowID, stepID);

    }


    public SjsbFormStepCheckListEntity getEntityByID(String id){
        return sjsbFormStepCheckListDao.findOne(id);
    }

    public void deleteCheckByID(String id){
        sjsbFormStepCheckListDao.delete(id);
    }


    public List<SjsbFormStepCheckListEntity> getCheckListByUserID(String userID){

        return sjsbFormStepCheckListDao.getCheckListByUserID(userID);

    }

    public List<SjsbFormStepCheckListEntity> getCheckListByUserIDTime(String userID,Timestamp sTime,Timestamp eTime){

        return sjsbFormStepCheckListDao.getCheckListByUserIDTime(userID, sTime, eTime);

    }

    public List<SjsbFormStepCheckListEntity> findAllLikeStatus(String status,String formId){
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = new ArrayList<SjsbFormStepCheckListEntity>();
        if(status.equals("")){
            sjsbFormStepCheckListEntities = sjsbFormStepCheckListDao.findAllLikeStatus(formId);
        }else {
            sjsbFormStepCheckListEntities=  sjsbFormStepCheckListDao.getDataformStatusFormId(Integer.parseInt(status),formId);
        }
        return sjsbFormStepCheckListEntities;
    }

    public List<SjsbFormStepCheckListEntity> getCheckListByUserIDEnd(String userID){

        return sjsbFormStepCheckListDao.getCheckListByUserIDEnd(userID);

    }


    public SjsbFormStepCheckListEntity getCheckFormByDataID(String dataID){
        return sjsbFormStepCheckListDao.getCheckFormByDataID(dataID);

    }

    @Autowired
    private SysStaffService sysStaffService;
    @Autowired
    private CustomFormDao customFormDao;
    @Autowired
    private CustomFormTypeDao customFormTypeDao;
    @Autowired
    private CustomTypeDao customTypeDao;
    //自定义表单保存
    public void saveData(String formID,String checkID,String dataID,String userID,String shlc,String stepId){
//        //得到表单属性
//        SjsbFormEntity sjsbFormEntity = sjsbFormService.getSjsbFormByID(formID);
        CustomFormEntity customFormEntity = customFormDao.findOne(formID);
        CustomFormTypeEntity customFormTypeEntity = customFormTypeDao.findByFormId(formID).get(0);
        int stauts = 0;
        if(!stepId.equals("")){
            stauts = 1;
        }else{
            stepId = null;
        }
        CustomTypeEntity customTypeEntity =  customTypeDao.findOne(customFormTypeEntity.getTypeId());
        SysStaffEntity staffEntity = sysStaffService.getStaffByID(userID);
        SjsbFormStepCheckListEntity sjsbFormStepCheckListEntity = new SjsbFormStepCheckListEntity();
        if(checkID.equals("")){
            sjsbFormStepCheckListEntity.setId(UUID.randomUUID().toString());
            sjsbFormStepCheckListEntity.setFormId(formID);
            sjsbFormStepCheckListEntity.setDataId(dataID);
            sjsbFormStepCheckListEntity.setFlowId(shlc);
            sjsbFormStepCheckListEntity.setStepId(stepId);
            sjsbFormStepCheckListEntity.setFormStatus(stauts);
            sjsbFormStepCheckListEntity.setFormName(customFormEntity.getName());
            sjsbFormStepCheckListEntity.setInputUserId(userID);
            sjsbFormStepCheckListEntity.setInputUserName(staffEntity.getName());
//            if (dataSbrq != null && !dataSbrq.equals("")) {Timestamp.valueOf(dataSbrq)
            sjsbFormStepCheckListEntity.setDataSbrq(null);
//            }
            sjsbFormStepCheckListEntity.setFormTypeId(customFormTypeEntity.getTypeId());
            sjsbFormStepCheckListEntity.setFormTypeName(customTypeEntity.getName());
            sjsbFormStepCheckListEntity.setInputKsId(staffEntity.getKsId());
        }
        else{
            sjsbFormStepCheckListEntity = getEntityByID(checkID);
            //驳回或未提交审核，数据重新填入
            if(sjsbFormStepCheckListEntity.getFormStatus()==3||sjsbFormStepCheckListEntity.getFormStatus()==0) {
                sjsbFormStepCheckListEntity.setFormId(formID);
                sjsbFormStepCheckListEntity.setDataId(dataID);
                sjsbFormStepCheckListEntity.setFlowId(shlc);
                sjsbFormStepCheckListEntity.setStepId(stepId);
                sjsbFormStepCheckListEntity.setFormStatus(stauts);
                sjsbFormStepCheckListEntity.setFormName(customFormEntity.getName());
                sjsbFormStepCheckListEntity.setInputUserId(userID);
                sjsbFormStepCheckListEntity.setInputUserName(staffEntity.getName());
//                if (dataSbrq != null && !dataSbrq.equals("")) {Timestamp.valueOf(dataSbrq)
                sjsbFormStepCheckListEntity.setDataSbrq(null);
//                }
                sjsbFormStepCheckListEntity.setFormTypeId(customTypeEntity.getId());
                sjsbFormStepCheckListEntity.setFormTypeName(customTypeEntity.getName());
                sjsbFormStepCheckListEntity.setInputKsId(staffEntity.getKsId());
                sjsbFormStepCheckListEntity.setChecktime(null);
                sjsbFormStepCheckListEntity.setCheckUserId(null);
                sjsbFormStepCheckListEntity.setCheckUserName(null);
            }
        }
        sjsbFormStepCheckListEntity.setInputTime(new Timestamp(new Date().getTime()));
        sjsbFormStepCheckListEntity.setFgksid(null);
        save(sjsbFormStepCheckListEntity);
    }
}
