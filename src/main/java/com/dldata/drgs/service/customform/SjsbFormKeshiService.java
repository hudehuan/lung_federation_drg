package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.SjsbFormKeshiEntity;
import com.dldata.drgs.repository.customform.SjsbFormKeshiDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/3/17.
 */
@Component
@Transactional
public class SjsbFormKeshiService {

    @Autowired
    private SjsbFormKeshiDao sjsbFormKeshiDao;
    public void save(SjsbFormKeshiEntity sjsbFormKeshiEntity){
        sjsbFormKeshiDao.save(sjsbFormKeshiEntity);
    }

    public List<SjsbFormKeshiEntity> getByFormId(String formId){
        return sjsbFormKeshiDao.getByFormId(formId);
    }

    public List<SjsbFormKeshiEntity> findByKid(String kId){
        return sjsbFormKeshiDao.findByKid(kId);
    }

    public List<SjsbFormKeshiEntity> findByFidKid(String formId,String kid){
        return sjsbFormKeshiDao.findByFidKid(formId,kid);
    }

    public void delete(String id){
        sjsbFormKeshiDao.delete(id);
    }
}
