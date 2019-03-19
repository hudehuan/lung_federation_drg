package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysMenuTemplateDefineEntity;
import com.dldata.drgs.repository.System.SysMenuTemplateDefineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2017/1/24.
 */
@Component
@Transactional
public class SysMenuTemplateDefineService {

    @Autowired
    private SysMenuTemplateDefineDao sysMenuTemplateDefineDao;

    public void save(SysMenuTemplateDefineEntity sysMenuTemplateDefineEntity){
        sysMenuTemplateDefineDao.save(sysMenuTemplateDefineEntity);
    }

    public List<SysMenuTemplateDefineEntity> findByName(String name){
        return sysMenuTemplateDefineDao.findByName(name);
    }

    public List<SysMenuTemplateDefineEntity> findBySearch(String search){
        return sysMenuTemplateDefineDao.findBySearch(search);
    }

    public SysMenuTemplateDefineEntity findOne(String id){
        return sysMenuTemplateDefineDao.findOne(id);
    }
}
