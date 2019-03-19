package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysSystemDefineEntity;
import com.dldata.drgs.repository.System.SysSystemDefineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/22.
 */
@Component
@Transactional
public class SysSystemDefineService {


    @Autowired
    SysSystemDefineDao sysSystemDefineDao;

    public List<SysSystemDefineEntity> getAllSystem(){
        return sysSystemDefineDao.getAllSystem();
    }

    public void save(SysSystemDefineEntity systemDefineEntity) {
        sysSystemDefineDao.save(systemDefineEntity);
    }
}
