package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysKsMKmEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2016/9/5.
 */
public interface SysKsMkmDao extends PagingAndSortingRepository<SysKsMKmEntity,String>,JpaSpecificationExecutor<SysKsMKmEntity> {

    @Query("select k from SysKsMKmEntity k order by k.dm ")
    public List<SysKsMKmEntity> getAllKsMKm();
}
