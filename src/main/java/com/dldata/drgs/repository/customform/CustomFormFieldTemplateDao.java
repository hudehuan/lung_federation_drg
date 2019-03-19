package com.dldata.drgs.repository.customform;


import com.dldata.drgs.entity.CustomFormFieldTemplateEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomFormFieldTemplateDao extends PagingAndSortingRepository<CustomFormFieldTemplateEntity,String>,JpaSpecificationExecutor<CustomFormFieldTemplateEntity> {


    @Query("select p from CustomFormFieldTemplateEntity p where p.templateId=?1")
    public List<CustomFormFieldTemplateEntity> getAllByTemplateId(String templateId);


    @Query("select p from CustomFormFieldTemplateEntity p where p.fieldCode=?1 and p.templateId=?2 ")
    public CustomFormFieldTemplateEntity getAllByTemplateIdFieldCode(String filedCode, String templateId);



}
