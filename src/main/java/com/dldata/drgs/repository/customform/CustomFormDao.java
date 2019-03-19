package com.dldata.drgs.repository.customform;


import com.dldata.drgs.entity.CustomFormEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomFormDao extends PagingAndSortingRepository<CustomFormEntity,String>,JpaSpecificationExecutor<CustomFormEntity> {


    @Query("select f from CustomFormEntity f")
    public List<CustomFormEntity> getAllCustomForm();


    @Query("select f from CustomFormEntity f where f.typeId = ?1")
    public List<CustomFormEntity> getFormByTypeId(String typeId);

    @Query("select f from CustomFormEntity f where f.code like ?1 or f.name like ?1 or f.tableName like ?1")
    public List<CustomFormEntity> findBySearch(String searchForm);

    @Query("select f from CustomFormEntity f where f.typeId is not null")
    public List<CustomFormEntity> getAllTypeForm();

}
