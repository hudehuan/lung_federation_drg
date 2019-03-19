package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysMenuEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysMenuDao extends PagingAndSortingRepository<SysMenuEntity,String>,JpaSpecificationExecutor<SysMenuEntity> {

    @Query("select m from SysMenuEntity m where m.sysCode =?1 and m.status<>0 order by m.code")
    public List<SysMenuEntity> getAllMenu(String sysCode);

    @Query("select m from SysMenuEntity m where m.code =?1 and m.status<>0 and  m.sysCode =?2 order by m.code")
    public List<SysMenuEntity> findOneByCode(String code, String sysCode);

    @Query("select m from SysMenuEntity m where m.sysCode =?2 and m.status<>0 and (m.code like ?1 or m.name like ?1) order by m.xh, m.code")
    public List<SysMenuEntity> findByCondition(String condition,String sysCode);

    @Query("select m from SysMenuEntity m where m.sysCode =?1 and m.status<>0 order by m.code")
    public List<SysMenuEntity> findAllBySysCode(String sysCode);

    @Query("select mu from SysMenuEntity mu where mu.status <> 0 and mu.sysCode = ?1 and mu.id in (" +
            "select m.menuId from SysRoleMenuEntity m where m.isBrowse =true  and  m.roleId in (" +
            "select r.roleId from SysUserRolesEntity r where r.uerId = ?2 and r.sysCode = ?1" +
            ")) order by  mu.xh,mu.code")
    public List<SysMenuEntity> fineBySysCode(String sysCode,String userId);

    @Query("select m from SysMenuEntity m where m.code =?1 order by m.code")
    public SysMenuEntity fineMenuEntityByCode(String menuCode);

}
