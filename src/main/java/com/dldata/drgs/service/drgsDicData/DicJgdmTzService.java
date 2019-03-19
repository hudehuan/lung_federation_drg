package com.dldata.drgs.service.drgsDicData;

import com.dldata.drgs.entity.DicJgdmTzEntity;
import com.dldata.drgs.repository.drgsDicData.DicJgdmTzDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/09/15.
 */
@Component
@Transactional
public class DicJgdmTzService {

    @Autowired
    private DicJgdmTzDao dicJgdmTzDao;

    public List<DicJgdmTzEntity> getAll(){
        return dicJgdmTzDao.getAll();
    }

    public DicJgdmTzEntity findByJgdm(String jgdm){
        return dicJgdmTzDao.findByJgdm(jgdm);
    }

    public List<DicJgdmTzEntity> findJgdmByUseridRole(String userid){
        return dicJgdmTzDao.findJgdmByUseridRole(userid);
    }

    public void save(DicJgdmTzEntity d){
        dicJgdmTzDao.save(d);
    }
}
