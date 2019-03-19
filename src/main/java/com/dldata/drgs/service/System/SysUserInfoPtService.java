package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.entity.SysUserInfoPtEntity;
import com.dldata.drgs.repository.System.SysUserInfoDao;
import com.dldata.drgs.repository.System.SysUserInfoPtDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */
@Component
@Transactional
public class SysUserInfoPtService {

    @Autowired
    private SysUserInfoPtDao sysUserInfoPtDao;

    public void save(SysUserInfoPtEntity s){
        sysUserInfoPtDao.save(s);
    }

    public List<SysUserInfoPtEntity> getAllInfo(){
        return sysUserInfoPtDao.getAllInfo();
    }

    public SysUserInfoPtEntity getAllByUserId(String userId,String sysCode){
        return sysUserInfoPtDao.getAllByUserId(userId,sysCode);
    }

    public void delete(SysUserInfoPtEntity s){
        sysUserInfoPtDao.delete(s);
    }

    public List<SysUserInfoPtEntity> findByTypeLike(String type,String sysCode){
        return sysUserInfoPtDao.findByTypeLike("%"+type+"%",sysCode);
    }

    public SysUserInfoPtEntity findByWtLoginName(String wtLoginName,String sysCode){
        return sysUserInfoPtDao.findByWtLoginName(wtLoginName,sysCode);
    }

}
