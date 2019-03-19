package com.dldata.drgs.service.drgsDicData;

import com.dldata.drgs.entity.DicJgdmEntity;
import com.dldata.drgs.repository.drgsDicData.DicJgdmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Component
@Transactional
public class DicJgdmService {

    @Autowired
    private DicJgdmDao dicJgdmDao;

    public void save(DicJgdmEntity s){
        dicJgdmDao.save(s);
    }

    public DicJgdmEntity findOne(String dm){
        return dicJgdmDao.findOne(dm);
    }

    public List<DicJgdmEntity> getAllData(){
        return dicJgdmDao.getAllData();
    }

    public List<DicJgdmEntity> getAllDataByXzqgJglbLikeLeft(String xzqg,String jglb){
        return dicJgdmDao.getAllDataByXzqgJglbLikeLeft(xzqg+"%",jglb+"%");
    }

    public List<DicJgdmEntity> findByXzqg(String xzqg){
        return dicJgdmDao.findByXzqg(xzqg+"%");
    }

    public void delete(String dm){
        dicJgdmDao.delete(dm);
    }

    public List<DicJgdmEntity> findInfoByUserId(String userid){
        return dicJgdmDao.findInfoByUserId(userid);
    }
}
