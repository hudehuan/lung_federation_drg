package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SystemFunctionEntity;
import com.dldata.drgs.repository.System.SystemFunctionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/12/13.
 */
@Component
@Transactional
public class SystemFunctionService  {

    @Autowired
    private SystemFunctionDao systemFunctionDao;

    public List<SystemFunctionEntity> findAllFunctonByStatus(boolean status){
        return systemFunctionDao.findAllByStatus(status);
    }

    public List<SystemFunctionEntity> findAllFuncton(boolean status,String search,String type){
        return systemFunctionDao.findAllBy(status,search,type);
    }

    public void save(SystemFunctionEntity systemFunctionEntity){
        systemFunctionDao.save(systemFunctionEntity);
    }

    public SystemFunctionEntity findOne(String id){
        return systemFunctionDao.findOne(id);
    }
}
