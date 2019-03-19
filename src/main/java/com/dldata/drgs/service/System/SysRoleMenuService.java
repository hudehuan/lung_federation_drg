package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.repository.System.SysRoleMenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysRoleMenuService {

    @Autowired
    SysRoleMenuDao sysRoleMenuDao;

    public List<SysRoleMenuEntity> getMenuByRoleID(String roleId){

        return sysRoleMenuDao.getMenuByRoleId(roleId);

    }

    public void save(SysRoleMenuEntity entity){
        sysRoleMenuDao.save(entity);
    }
}
