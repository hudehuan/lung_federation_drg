package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysDiscussEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysDiscussDao extends PagingAndSortingRepository<SysDiscussEntity,String>,JpaSpecificationExecutor<SysDiscussEntity> {
    @Query("select d from SysDiscussEntity d")
    List<SysDiscussEntity> getAllDiscuss();
}
