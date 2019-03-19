package com.dldata.drgs.service.FormDefine;

import com.dldata.drgs.entity.FormItemTypeEntity;
import com.dldata.drgs.repository.FormDefine.FormItemTypeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/8/12.
 */
@Component
@Transactional

public class FormItemTypeService {

    @Autowired
    FormItemTypeDao formItemTypeDao;

    public void save(FormItemTypeEntity formItemType) {
        formItemTypeDao.save(formItemType);
    }


    public void delete(String id) {
        formItemTypeDao.delete(id);
    }

    public FormItemTypeEntity findOne(String id) {
        return formItemTypeDao.findOne(id);
    }
    public void update(FormItemTypeEntity formItemType) {
        formItemTypeDao.save(formItemType);
    }

    public List<FormItemTypeEntity> getAllFormItemType(String sysCode) {
       return formItemTypeDao.getAllFormItemType(sysCode);
    }

    public String getNewLevel(String sysCode){
        List<FormItemTypeEntity> entities = formItemTypeDao.getNewLevel(sysCode);
        if(entities.size()==0){
            return "001";
        }
        else{
            int n = entities.size()+1;
            return String.format("%03d", n);
        }
    }

    public List<FormItemTypeEntity> getAllPLevel(String sysCode) {
        return formItemTypeDao.getNewLevel(sysCode);
    }

    public String getNextLevel(String cLevel, String sysCode){

        List<FormItemTypeEntity> entities = formItemTypeDao.getNextLevel(cLevel, sysCode);

        if(entities.size()==0){
            return cLevel+"001";
        }else{
            int n = entities.size()+1;
            return cLevel+ String.format("%03d", n);
        }

    }

    public List<FormItemTypeEntity> getAllNextLevel(String cLevel, String sysCode) {
        return formItemTypeDao.getNextLevel(cLevel, sysCode);
    }

    public List<FormItemTypeEntity> findByName(String name, String sysCode) {
        return formItemTypeDao.findByName(name, sysCode);
    }

}
