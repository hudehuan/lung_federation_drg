package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysHomePageEntity;
import com.dldata.drgs.repository.System.SysHomePageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/9/8.
 */
@Component
@Transactional
public class SysHomePageService {

    @Autowired
    SysHomePageDao sysHomePageDao;

    public void save(SysHomePageEntity homePageInterface) {
        sysHomePageDao.save(homePageInterface);
    }

    public void delete(String id){
        sysHomePageDao.delete(id);
    }


    public List<SysHomePageEntity> getAllHomePageInterface(String sysCode) {
        return sysHomePageDao.getAllHomePageInterface(sysCode);
    }

    public SysHomePageEntity findOne(String itemId) {
        return sysHomePageDao.findOne(itemId);
    }


    public List<SysHomePageEntity> findByCondition(String condition, String sysCode) {
        return sysHomePageDao.findByCondition(condition, sysCode);
    }

    public List<SysHomePageEntity> findByName(String name, String sysCode) {
        return sysHomePageDao.findByName(name, sysCode);
    }
}
