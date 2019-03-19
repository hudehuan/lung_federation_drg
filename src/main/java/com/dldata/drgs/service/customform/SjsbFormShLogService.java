package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.SjsbFormFlowEntity;
import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import com.dldata.drgs.entity.SjsbFormShLogEntity;
import com.dldata.drgs.entity.SysStaffEntity;
import com.dldata.drgs.repository.customform.SjsbFormShLogDao;
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
 * Created by 倪继文 on 2016/11/2.
 */
@Component
@Transactional
public class SjsbFormShLogService {


    @Autowired
    private SjsbFormShLogDao sjsbFormShLogDao;

    @Autowired
    private SysStaffService sysStaffService;


    public void save(SjsbFormShLogEntity entity){
        sjsbFormShLogDao.save(entity);

    }


    public List<SjsbFormShLogEntity> getFormShLogByFormIDDataID(String formID,String dataID){

        return sjsbFormShLogDao.getFormShLogByFormIDDataID(formID,dataID);
    }

    public List<SjsbFormShLogEntity> findByUserID(String Userid){
        return sjsbFormShLogDao.findByUserID(Userid);
    }


    public void deleteAllByDataId(List<SjsbFormShLogEntity> sjsbFormShLogEntity){
        sjsbFormShLogDao.delete(sjsbFormShLogEntity);
    }

    public SjsbFormShLogEntity findOne(String lid){
        return sjsbFormShLogDao.findOne(lid);
    }

    public List<SjsbFormShLogEntity> findByUserIdDataId(String userId,String dataId){
        return sjsbFormShLogDao.findByUserIdDataId(userId, dataId);
    }

    public List<SjsbFormShLogEntity> findByDataID(String dataID){
        return sjsbFormShLogDao.findByDataID(dataID);
    }

    public void deleteOne(String lid){
         sjsbFormShLogDao.delete(lid);
    }

    @Autowired
    private SjsbFormFlowService sjsbFormFlowService;

    @Autowired
    private SjsbFormFlowStepService sjsbFormFlowStepService;

    public void saveData(String shlc,String dataID,String userID){

        SjsbFormFlowEntity sjsbFormFlowEntity = sjsbFormFlowService.getFormFlowByID(shlc);

        //根据流程ID，得到流程步骤
        List<SjsbFormFlowStepEntity> sjsbFormFlowStepEntities = new ArrayList<SjsbFormFlowStepEntity>();

        sjsbFormFlowStepEntities = sjsbFormFlowStepService.getStepByFlowID(shlc);

        if(sjsbFormFlowStepEntities.size()>0){
            SjsbFormShLogEntity sjsbFormShLogEntity = new SjsbFormShLogEntity();
            sjsbFormShLogEntity.setId(UUID.randomUUID().toString());
            sjsbFormShLogEntity.setFormId(sjsbFormFlowEntity.getFormid());
            sjsbFormShLogEntity.setDataId(dataID);
            sjsbFormShLogEntity.setSjtime(new Timestamp(new Date().getTime()));
            sjsbFormShLogEntity.setUserId(userID);
            SysStaffEntity staffEntity = sysStaffService.getStaffByID(userID);
            sjsbFormShLogEntity.setUserName(staffEntity.getName());
            sjsbFormShLogEntity.setFlowId(shlc);
            sjsbFormShLogEntity.setStepId(sjsbFormFlowStepEntities.get(0).getId());
            sjsbFormShLogEntity.setStatus(0);//0提交审核   1审核     2驳回
            sjsbFormShLogEntity.setSm("提交审核");

            save(sjsbFormShLogEntity);
        }





    }
}
