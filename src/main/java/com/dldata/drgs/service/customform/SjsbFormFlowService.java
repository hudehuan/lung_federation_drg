package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.SjsbFormFlowEntity;
import com.dldata.drgs.repository.customform.SjsbFormFlowDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/1.
 */

@Component
@Transactional
public class SjsbFormFlowService {

    @Autowired
    private SjsbFormFlowDao sjsbFormFlowDao;

    public SjsbFormFlowEntity findOne(String id){
        return sjsbFormFlowDao.findOne(id);
    }


    public List<SjsbFormFlowEntity> getFormFlowByFormID(String formID){return sjsbFormFlowDao.getByFormID(formID);}

    public List<SjsbFormFlowEntity> getFlowByFormIDnull( ){
        return sjsbFormFlowDao.getFlowByFormIDnull();
    }

    public SjsbFormFlowEntity getFormFlowByID(String id){
        return sjsbFormFlowDao.findOne(id);
    }

    public List<SjsbFormFlowEntity> findByXh(int xh,String formId){
        return sjsbFormFlowDao.findByXh(xh, formId);
    }

    public List<SjsbFormFlowEntity> findByName(String name,String formId){return sjsbFormFlowDao.findByName(name,formId);}



    public void save(SjsbFormFlowEntity sjsbFormFlowEntity){sjsbFormFlowDao.save(sjsbFormFlowEntity);}

    public SjsbFormFlowEntity getSjsbFormFlowByID(String id){return sjsbFormFlowDao.findOne(id);}

    public List<SjsbFormFlowEntity> getfindAll(){return sjsbFormFlowDao.findAll();}


}
