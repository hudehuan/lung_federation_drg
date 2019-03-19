package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysRoleJgdmEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
public interface SysRoleJgdmDao extends PagingAndSortingRepository<SysRoleJgdmEntity,String>,JpaSpecificationExecutor<SysRoleJgdmEntity> {

    @Query("select e from SysRoleJgdmEntity e where e.roleId = ?1")
    public List<SysRoleJgdmEntity> findJgdmByRoleid(String roleId);

    @Query("select e from SysRoleJgdmEntity e where e.roleId in (" +
            "select r.roleId from SysUserRolesEntity r where r.uerId = ?1) and e.browse =true")
    public List<SysRoleJgdmEntity> findJgdmByUseridRole(String userid);

}
