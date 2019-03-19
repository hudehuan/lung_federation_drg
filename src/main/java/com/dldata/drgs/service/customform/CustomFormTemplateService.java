package com.dldata.drgs.service.customform;

import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.repository.customform.CustomFormTemplateDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Component
@Transactional
public class CustomFormTemplateService {


    @Autowired
    private CustomFormTemplateDao customFormTemplateDao;

    public List<CustomFormTemplateEntity> getFormTemplateByFormId(String formId){
        return customFormTemplateDao.getFormTemplateByFormId(formId);
    }

    public CustomFormTemplateEntity getFormActivtyTemplateByFormId(String formId){

        return customFormTemplateDao.getFormActivtyTemplateByFormId(formId);
    }


    public CustomFormTemplateEntity  getTemplateById(String templateId){
        return customFormTemplateDao.findOne(templateId);

    }


    public void save(CustomFormTemplateEntity customFormTemplateEntity){
        customFormTemplateDao.save(customFormTemplateEntity);
    }

    public int getMaxXh(String formId){
        return customFormTemplateDao.getMaxXh(formId);
    }

    public void saveEntityList(List<CustomFormTemplateEntity> customFormTemplateEntities){
        customFormTemplateDao.save(customFormTemplateEntities);
    }

}
