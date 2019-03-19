package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.repository.customform.CustomFormDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Component
@Transactional
public class CustomFormService {


    @Autowired
    private CustomFormDao customFormDao;


    public List<CustomFormEntity> getAllCustomForm(){
        return customFormDao.getAllCustomForm();
    }
    public List<CustomFormEntity> getFormByTypeId(String typeId){
        return customFormDao.getFormByTypeId(typeId);
    }

    public CustomFormEntity getCustomFormByFormId(String formId){
        return customFormDao.findOne(formId);
    }


    public void save(CustomFormEntity entity){
        customFormDao.save(entity);
    }

    public List<CustomFormEntity> findBySearchLike(String searchForm){
        return customFormDao.findBySearch("%"+searchForm+"%");
    }

    public List<CustomFormEntity> getAllTypeForm(){
        return customFormDao.getAllTypeForm();
    }

}
