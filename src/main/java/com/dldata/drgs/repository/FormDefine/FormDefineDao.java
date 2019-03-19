package com.dldata.drgs.repository.FormDefine;

import com.dldata.drgs.entity.FormDefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/12.
 */
public interface FormDefineDao extends PagingAndSortingRepository<FormDefineEntity,String>,JpaSpecificationExecutor<FormDefineEntity> {

    @Query("select d from FormDefineEntity d where d.status <>0 and d.sysCode =?1")
    public List<FormDefineEntity> getAllFormDefine(String sysCode);

    @Query("select d from FormDefineEntity d where d.status <>0 and d.name =?1 and d.sysCode =?2")
    public List<FormDefineEntity> findByName(String name, String sysCode);
}
