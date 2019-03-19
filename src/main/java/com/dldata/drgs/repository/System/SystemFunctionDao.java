package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SystemFunctionEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2016/12/13.
 */
public interface SystemFunctionDao extends PagingAndSortingRepository<SystemFunctionEntity,String>,JpaSpecificationExecutor<SystemFunctionEntity> {

    @Query("select s from SystemFunctionEntity s where s.status = ?1 order by s.xh")
    public List<SystemFunctionEntity> findAllByStatus(boolean status);

    @Query("select s from SystemFunctionEntity s where s.status = ?1 and s.name like ?2 and s.type like ?3 order by s.xh")
    public List<SystemFunctionEntity> findAllBy(boolean status,String search,String type);
}
