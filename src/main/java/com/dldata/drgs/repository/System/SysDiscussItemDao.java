package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysDiscussItemEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysDiscussItemDao extends PagingAndSortingRepository<SysDiscussItemEntity,String>,JpaSpecificationExecutor<SysDiscussItemEntity> {
    @Query("select d from SysDiscussItemEntity d")
    List<SysDiscussItemEntity> getAllDiscussItem();
}
