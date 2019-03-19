package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysMenuTemplateDefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2017/1/24.
 */
public interface SysMenuTemplateDefineDao extends PagingAndSortingRepository<SysMenuTemplateDefineEntity,String>,JpaSpecificationExecutor<SysMenuTemplateDefineEntity> {

    @Query("select s from SysMenuTemplateDefineEntity s where s.name = ?1")
    public List<SysMenuTemplateDefineEntity> findByName(String name);

    @Query("select s from SysMenuTemplateDefineEntity s where s.name like ?1 and s.status = true ")
    public List<SysMenuTemplateDefineEntity> findBySearch(String search);
}
