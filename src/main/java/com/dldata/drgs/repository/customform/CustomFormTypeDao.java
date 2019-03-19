package com.dldata.drgs.repository.customform;


import com.dldata.drgs.entity.CustomFormTypeEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomFormTypeDao extends PagingAndSortingRepository<CustomFormTypeEntity,String>,JpaSpecificationExecutor<CustomFormTypeEntity> {

    @Query("select t from CustomFormTypeEntity t order by t.xh")
    public List<CustomFormTypeEntity> getAllFormType();

    @Query("select t from CustomFormTypeEntity t where t.typeId = ?1 order by t.xh")
    public List<CustomFormTypeEntity> findByTypeId(String typeId);

    @Query("select t from CustomFormTypeEntity t where t.formId = ?1 order by t.xh")
    public List<CustomFormTypeEntity> findByFormId(String formId);

    @Query("select f from CustomFormTypeEntity f where f.typeId = ?1 order by  f.xh")
    public List<CustomFormTypeEntity> getFormByTypeId(String typeId);


    @Query("select f from CustomFormTypeEntity f where f.typeId = ?1 and f.xh = ?2")
    public List<CustomFormTypeEntity> findByTypeIdXh(String typeId,int xh);
}
