package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysRoleJgdmEntity;
import com.dldata.drgs.repository.System.SysRoleJgdmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
@Component
@Transactional
public class SysRoleJgdmService {

    @Autowired
    private SysRoleJgdmDao sysRoleJgdmDao;

    public List<SysRoleJgdmEntity> findJgdmByRoleid(String roleId){
        return sysRoleJgdmDao.findJgdmByRoleid(roleId);
    }

    public List<SysRoleJgdmEntity> findJgdmByUseridRole(String userid){
        return sysRoleJgdmDao.findJgdmByUseridRole(userid);
    }

    public void save(SysRoleJgdmEntity s ){
        sysRoleJgdmDao.save(s);
    }

}
