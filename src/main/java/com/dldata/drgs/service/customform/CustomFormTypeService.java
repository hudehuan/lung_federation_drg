package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.CustomFormTypeEntity;
import com.dldata.drgs.repository.customform.CustomFormTypeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Component
@Transactional
public class CustomFormTypeService {

    @Autowired
    private CustomFormTypeDao customFormTypeDao;

    public List<CustomFormTypeEntity> getAllFormType(){
        return customFormTypeDao.getAllFormType();
    }

    public List<CustomFormTypeEntity> findByTypeId(String typeId){
        return customFormTypeDao.findByTypeId(typeId);
    }


    public void save(CustomFormTypeEntity customFormTypeEntity){
        customFormTypeDao.save(customFormTypeEntity);
    }

    public CustomFormTypeEntity findOne(String formTypeId){
        return customFormTypeDao.findOne(formTypeId);
    }


    public List<CustomFormTypeEntity> getFormByTypeId(String typeId){
        return customFormTypeDao.getFormByTypeId(typeId);
    }

    public List<CustomFormTypeEntity> findByTypeIdXh(String typeId,int xh){
        return customFormTypeDao.findByTypeIdXh(typeId,xh);
    }

    public List<CustomFormTypeEntity> findByFormId(String formId){
        return customFormTypeDao.findByFormId(formId);
    }

    public void deleteOne(String formTypeId){
        customFormTypeDao.delete(formTypeId);
    }
}
