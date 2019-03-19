package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysUserRolesEntity;
import com.dldata.drgs.repository.System.SysUserRolesDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysUserRolesService {

    @Autowired
    SysUserRolesDao rolesDao;
    public List<SysUserRolesEntity> getAllRole(String userId,String sysCode) {
        return rolesDao.getAllRole(userId,sysCode);
    }

    public void save(SysUserRolesEntity userRoles) {
        rolesDao.save(userRoles);
    }

    public void delete(SysUserRolesEntity userRolesEntity) {
        rolesDao.delete(userRolesEntity);
    }

    public void deleteById(String id) {
        rolesDao.delete(id);
    }
}
