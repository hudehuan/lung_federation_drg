package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.CustomFormFieldEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomFormFieldDao extends PagingAndSortingRepository<CustomFormFieldEntity,String>,JpaSpecificationExecutor<CustomFormFieldEntity> {

    @Query("select f from CustomFormFieldEntity f where f.formId=?1 order by f.xh")
    public List<CustomFormFieldEntity> getAllFieldByFormId(String formId);


}
