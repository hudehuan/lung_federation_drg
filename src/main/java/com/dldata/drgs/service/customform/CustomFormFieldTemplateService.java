package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.CustomFormFieldTemplateEntity;
import com.dldata.drgs.repository.customform.CustomFormFieldTemplateDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Component
@Transactional
public class CustomFormFieldTemplateService {


    @Autowired
    private CustomFormFieldTemplateDao CustomFormFieldTemplateDao;


    public List<CustomFormFieldTemplateEntity> getAllByTemplateId(String templateId){

        return CustomFormFieldTemplateDao.getAllByTemplateId(templateId);

    }

    public void save(CustomFormFieldTemplateEntity entity){
        CustomFormFieldTemplateDao.save(entity);
    }

    public void saveList(List<CustomFormFieldTemplateEntity> formFieldPropertiesEntityList){

        CustomFormFieldTemplateDao.save(formFieldPropertiesEntityList);

    }

    public CustomFormFieldTemplateEntity getAllByTemplateIdFieldCode(String filedCode, String templateId){

        return CustomFormFieldTemplateDao.getAllByTemplateIdFieldCode(filedCode, templateId);

    }



}
