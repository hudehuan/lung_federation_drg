package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.repository.System.SysRoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysRoleService {

    @Autowired
    SysRoleDao roleDao;
    public List<SysRoleEntity> getAllRole(String sysCode) {
        return roleDao.getAllRole(sysCode);
    }

    public void save(SysRoleEntity roleEntity) {
        roleDao.save(roleEntity);
    }

//    public void delete(String id) {
//        roleDao.delete(id);
//    }

    public SysRoleEntity findOne(String id) {
        return roleDao.findOne(id);
    }

    public List<SysRoleEntity> findByCondition(String condition, String sysCode) {
        return roleDao.findByCondition(condition, sysCode);
    }

    public List<SysRoleEntity> findByName(String name, String sysCode) {
        return roleDao.findByName(name,sysCode);
    }
}
