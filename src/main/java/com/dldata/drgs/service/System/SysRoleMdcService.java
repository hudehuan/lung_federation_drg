package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysRoleMdcEntity;
import com.dldata.drgs.repository.System.SysRoleMdcDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
@Component
@Transactional
public class SysRoleMdcService {

    @Autowired
    private SysRoleMdcDao sysRoleMdcDao;

    public List<SysRoleMdcEntity> findMdcByRoleid(String roleid){
        return sysRoleMdcDao.findMdcByRoleid(roleid);
    }

    public void save(SysRoleMdcEntity s){
        sysRoleMdcDao.save(s);
    }
}
