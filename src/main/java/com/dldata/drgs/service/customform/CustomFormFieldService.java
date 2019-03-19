package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.CustomFormFieldEntity;
import com.dldata.drgs.repository.customform.CustomFormFieldDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Component
@Transactional
public class CustomFormFieldService {

    @Autowired
    private CustomFormFieldDao customFormFieldDao;


    public List<CustomFormFieldEntity> getAllFieldByFormId(String formId){
        return customFormFieldDao.getAllFieldByFormId(formId);

    }


    public CustomFormFieldEntity getFieldByFieldId(String fieldId){
        return customFormFieldDao.findOne(fieldId);
    }


    public void save(CustomFormFieldEntity customFormFieldEntity){
        customFormFieldDao.save(customFormFieldEntity);


    }
}
