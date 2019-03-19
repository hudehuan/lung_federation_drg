package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.repository.System.SysUserInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysUserInfoService {

    @Autowired
    SysUserInfoDao userInfoDao;
    public List<SysUserInfoEntity> getAllUserInfo(String syscode) {
        return userInfoDao.getAllUserInfo(syscode);
    }

    public SysUserInfoEntity save(SysUserInfoEntity userInfo) {
        return userInfoDao.save(userInfo);
    }

    public SysUserInfoEntity checkUserInfo(String loginname,String sysCode){

        return userInfoDao.checkUserInfo(loginname,sysCode);
    }

    public List<SysUserInfoEntity> findByCondition(String condition,String sysCode) {
        return userInfoDao.findByCondition(condition,sysCode);
    }

//    public SysUserInfoEntity findOne(String id,String sysCode) {
//        return userInfoDao.findById(id, sysCode);
//    }


    public SysUserInfoEntity getUserInfoByLoginname(String loginname,String sysCode){

        return userInfoDao.getUserInfo(loginname,sysCode);
    }

    public SysUserInfoEntity getUserInfoByUserID(String userid,String sysCode){

        return userInfoDao.getUserInfoByUserID(userid,sysCode);
    }



    public SysUserInfoEntity findByIdAndSysCode(String id,String sysCode) {
        return userInfoDao.findById(id,sysCode);
    }

    public void delete(SysUserInfoEntity userInfoEntity) {
        userInfoDao.delete(userInfoEntity);
    }
}
