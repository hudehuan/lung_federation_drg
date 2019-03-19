package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysRoleMdcEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
public interface SysRoleMdcDao extends PagingAndSortingRepository<SysRoleMdcEntity,String>,JpaSpecificationExecutor<SysRoleMdcEntity> {



@Query("select e from SysRoleMdcEntity e where e.roleId = ?1")
    public List<SysRoleMdcEntity> findMdcByRoleid(String roleid);
}
