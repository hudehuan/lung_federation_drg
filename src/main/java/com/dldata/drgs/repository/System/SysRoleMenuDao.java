package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysRoleMenuEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysRoleMenuDao extends PagingAndSortingRepository<SysRoleMenuEntity,String>,JpaSpecificationExecutor<SysRoleMenuEntity> {

    @Query("select r from SysRoleMenuEntity r where r.roleId=?1")
    public List<SysRoleMenuEntity> getMenuByRoleId(String roleId);

    @Query(value = " select  rm.*   from sys_role_menu  rm" +
            " cross join  sys_user_roles  ur  " +
            " cross join sys_menu   m" +
            "  where  ur.role_id=rm.role_id  and rm.menu_id=m.id  and m.code=?1 and m.sys_code=?2  and m.status<>0 " +
            "  and ur.uer_id= ?3" ,nativeQuery = true)
    public List<SysRoleMenuEntity> getUserMenuPower(String menuCode,String sysCode,String userId);
}
