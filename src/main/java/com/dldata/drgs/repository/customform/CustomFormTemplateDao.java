package com.dldata.drgs.repository.customform;


import com.dldata.drgs.entity.CustomFormTemplateEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomFormTemplateDao extends PagingAndSortingRepository<CustomFormTemplateEntity,String>,JpaSpecificationExecutor<CustomFormTemplateEntity> {

    @Query("select f from CustomFormTemplateEntity f where f.formId=?1 order by f.xh")
    public List<CustomFormTemplateEntity> getFormTemplateByFormId(String formId);


    @Query("select a from CustomFormTemplateEntity a where a.formId=?1 and a.active= true")
    public CustomFormTemplateEntity getFormActivtyTemplateByFormId(String formId);

    @Query("select max(a.xh) from CustomFormTemplateEntity a where a.formId=?1")
    public int getMaxXh(String formId);

}
