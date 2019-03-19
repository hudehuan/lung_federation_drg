package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysRoleEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysRoleDao extends PagingAndSortingRepository<SysRoleEntity,String>,JpaSpecificationExecutor<SysRoleEntity> {
    @Query("select r from SysRoleEntity r where r.status <> 0 and r.sysCode =?1 order by r.xh")
    public List<SysRoleEntity> getAllRole(String sysCode);

    @Query("select r from SysRoleEntity r where r.status <> 0 and r.sysCode =?2 and (r.name like ?1 or r.pym like ?1) order by r.xh")
    public List<SysRoleEntity> findByCondition(String condition,String sysCode);

    @Query("select r from SysRoleEntity r where r.status <> 0 and r.name = ?1 and r.sysCode =?2 order by r.xh")
    public List<SysRoleEntity> findByName(String name, String sysCode);

}
