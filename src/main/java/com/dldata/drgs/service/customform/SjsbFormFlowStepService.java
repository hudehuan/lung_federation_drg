package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import com.dldata.drgs.repository.customform.SjsbFormFlowStepDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/1.
 */
@Component
@Transactional
public class SjsbFormFlowStepService {


    @Autowired
    SjsbFormFlowStepDao sjsbFormFlowStepDao;


    public List<SjsbFormFlowStepEntity> getStepByFlowID(String flowID){
        return sjsbFormFlowStepDao.getStepByFlowID(flowID);
    }

    public void save(SjsbFormFlowStepEntity sjsbFormFlowStepEntity){sjsbFormFlowStepDao.save(sjsbFormFlowStepEntity);}

    public SjsbFormFlowStepEntity getStepEntityByID(String stepID){
        return sjsbFormFlowStepDao.findOne(stepID);
    }


    public List<SjsbFormFlowStepEntity> getFormFlowByFlowId(String flowId){return sjsbFormFlowStepDao.getFormByFlowId(flowId);}

    public List<SjsbFormFlowStepEntity> getFormByFlowIdnull(){return sjsbFormFlowStepDao.getFormByFlowIdnull();}

    public List<SjsbFormFlowStepEntity> findByXh(Integer xh,String flowId){return sjsbFormFlowStepDao.findByXh(xh,flowId);}

    public List<SjsbFormFlowStepEntity> findByName(String name,String flowId){return sjsbFormFlowStepDao.findByName(name,flowId);}

    public List<SjsbFormFlowStepEntity> getfindAll(){return sjsbFormFlowStepDao.getfindAll();}

}
