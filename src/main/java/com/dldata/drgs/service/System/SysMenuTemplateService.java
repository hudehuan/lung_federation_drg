package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysMenuTemplateEntity;
import com.dldata.drgs.repository.System.SysMenuTemplateDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2017/1/24.
 */
@Component
@Transactional
public class SysMenuTemplateService {

    @Autowired
    private SysMenuTemplateDao sysMenuTemplateDao;

    public void save(SysMenuTemplateEntity sysMenuTemplateEntity){
        sysMenuTemplateDao.save(sysMenuTemplateEntity);
    }


    public List<SysMenuTemplateEntity> findAllByTid(String tid){
        return sysMenuTemplateDao.findAllByTid(tid);
    }


    public SysMenuTemplateEntity findById(String id){
        return sysMenuTemplateDao.findOne(id);
    }


}
