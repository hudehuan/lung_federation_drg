package com.dldata.drgs.repository.FormDefine;


import com.dldata.drgs.entity.FormDefineFieldEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/12.
 */
public interface FormDefineFieldDao extends PagingAndSortingRepository<FormDefineFieldEntity,String>,JpaSpecificationExecutor<FormDefineFieldEntity> {

    @Query("select f from  FormDefineFieldEntity f where f.tdId=?1 and f.status <>0 order by f.xh")
    public List<FormDefineFieldEntity> getAllFormDefineField(String tdId);

    @Query(value = "select f from FormDefineFieldEntity f where f.tdId=?1 order by f.xh desc ")
    public List<FormDefineFieldEntity> getMaxXH(String tdId);

    @Query("select f from  FormDefineFieldEntity f where f.fdName=?1 and f.status <>0 order by f.xh")
    public List<FormDefineFieldEntity> findByfdName(String name);

    @Query("select d from FormDefineFieldEntity d where d.tdId=?1 and d.status <> 0 order by d.xh")
    public List<FormDefineFieldEntity> getFormDefineFieldList(String tdId);


}


