package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysMenuTemplateEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2017/1/24.
 */
public interface SysMenuTemplateDao extends PagingAndSortingRepository<SysMenuTemplateEntity,String>,JpaSpecificationExecutor<SysMenuTemplateEntity> {

    @Query("select s from SysMenuTemplateEntity s where s.tid = ?1 order by s.code")
    public List<SysMenuTemplateEntity> findAllByTid(String tid);
}
