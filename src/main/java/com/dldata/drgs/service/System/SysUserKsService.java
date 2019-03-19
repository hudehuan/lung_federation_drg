package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysUserKsEntity;
import com.dldata.drgs.repository.System.SysUserKsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/8/23.
 */
@Component
@Transactional
public class SysUserKsService {

    @Autowired
    SysUserKsDao userKsDao;

    public List<SysUserKsEntity> getAllUserKs(String userid,String sysCode) {
        return userKsDao.getAllUserKs(userid,sysCode);
    }

    public SysUserKsEntity findOne(String id) {
        return userKsDao.findOne(id);
    }

    public void save(SysUserKsEntity userKsEntity) {
        userKsDao.save(userKsEntity);
    }

    public void delete(SysUserKsEntity userKsEntity) {
        userKsDao.delete(userKsEntity);
    }
    public void deleteById(String id) {
        userKsDao.delete(id);
    }

    public List<SysUserKsEntity> findByUserId(String userid,String SysCode){
        return userKsDao.findByUserId(userid,SysCode);
    }
}
