package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysKsWorkstationEntity;
import com.dldata.drgs.repository.System.SysKeShiWorkStationDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysKeShiWorkStationService {

    @Autowired
    SysKeShiWorkStationDao sysKsWorkstationDao;

    public List<SysKsWorkstationEntity> getAllKsWorkStation(){return sysKsWorkstationDao.getAllKsWorkStation();}


    public SysKsWorkstationEntity save(SysKsWorkstationEntity sysKsWs){

        return  sysKsWorkstationDao.save(sysKsWs);
    }

    public void delete(String id){
        sysKsWorkstationDao.delete(id);
    }

    public void update(SysKsWorkstationEntity sysKs){
        sysKsWorkstationDao.save(sysKs);
    }

    public SysKsWorkstationEntity findOne(String kswId) {
        return sysKsWorkstationDao.findOne(kswId);
    }

    public List<SysKsWorkstationEntity> findOneByCode(String code) {
        return sysKsWorkstationDao.findOneByCode(code);
    }

    public List<SysKsWorkstationEntity> findByCondition(String condition) {
        return sysKsWorkstationDao.findOneByCondition(condition);
    }

    public List<SysKsWorkstationEntity> findByName(String name) {
        return sysKsWorkstationDao.findByName(name);
    }
}
