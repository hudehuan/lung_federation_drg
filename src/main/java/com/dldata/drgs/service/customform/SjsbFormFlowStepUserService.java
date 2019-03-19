package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.SjsbFormFlowStepUserEntity;
import com.dldata.drgs.repository.customform.SjsbFormFlowStepUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/2.
 */
@Component
@Transactional
public class SjsbFormFlowStepUserService {

    @Autowired
    SjsbFormFlowStepUserDao sjsbFormFlowStepUserDao;


    public List<SjsbFormFlowStepUserEntity> getFlowStepOfUserID(String userID){
        return sjsbFormFlowStepUserDao.getFlowStepOfUserID(userID);
    }

    public void save(SjsbFormFlowStepUserEntity sjsbFormFlowStepUserEntity){sjsbFormFlowStepUserDao.save(sjsbFormFlowStepUserEntity);}

    public List<SjsbFormFlowStepUserEntity> findByStepId(String StepId){return sjsbFormFlowStepUserDao.findByStepId(StepId);}

    public void deleteYh(List sList){sjsbFormFlowStepUserDao.delete(sList);}

    public SjsbFormFlowStepUserEntity findById(String id){
        return sjsbFormFlowStepUserDao.findOne(id);
    }

    public void deleteById(String id){
        sjsbFormFlowStepUserDao.delete(id);
    }

    public List<SjsbFormFlowStepUserEntity> findByFlowId(String flowId){return sjsbFormFlowStepUserDao.findByFlowId(flowId);}
}
