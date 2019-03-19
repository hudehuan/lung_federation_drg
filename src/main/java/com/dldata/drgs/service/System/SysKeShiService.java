package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysKsEntity;
import com.dldata.drgs.repository.System.SysKeShiDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysKeShiService {


    @Autowired
    SysKeShiDao sysKeShiDao;

    public List<SysKsEntity> getAllKeShi(){return sysKeShiDao.getAllKeShi();}


    public SysKsEntity save(SysKsEntity sysKs){

        return  sysKeShiDao.save(sysKs);
     }


    public SysKsEntity getKeShiById(String id){

        SysKsEntity sysKs = sysKeShiDao.findOne(id);

         return sysKs;
    }

    public SysKsEntity findOne(String id){
       return sysKeShiDao.findOne(id);
    }

    public void update(SysKsEntity sysKs){
        sysKeShiDao.save(sysKs);
   }


    public List<SysKsEntity> findOneByCode(String code) {
        return sysKeShiDao.findOneByCode(code);
    }

    public List<SysKsEntity> findByCondition(String condition) {
        return sysKeShiDao.findByCondition(condition);
    }

    public List<SysKsEntity> findByName(String name) {
        return sysKeShiDao.findByName(name);
    }

    public List<SysKsEntity> getZyKs(){
        return sysKeShiDao.getZyKs();
    }

    public SysKsEntity getKsFromListById(List<SysKsEntity> entityList,String Id){
        SysKsEntity entity=null;
        if(entityList.size()>0){
            List<SysKsEntity> list = entityList.stream().filter(u->u.getId().equals(Id)).collect(Collectors.toList());
            if (list.size()>0){
                entity = list.get(0);
            }
        }

        return entity;

    }

    public boolean checkExistKsFromListById(List<SysKsEntity> entityList,String Id){
        //SysKsEntity entity=null;
        boolean c= false;
        if(entityList.size()>0){
            List<SysKsEntity> list = entityList.stream().filter(u->u.getId().equals(Id)).collect(Collectors.toList());
            if (list.size()>0){
                //entity = list.get(0);
                c = true;
            }
        }

        return c;

    }
}
