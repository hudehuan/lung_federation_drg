package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysUserRolesEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysUserRolesDao extends PagingAndSortingRepository<SysUserRolesEntity,String>,JpaSpecificationExecutor<SysUserRolesEntity> {

    @Query("select r from SysUserRolesEntity r where r.uerId =?1 and r.sysCode=?2")
    public List<SysUserRolesEntity> getAllRole(String userId,String sysCode);

}
