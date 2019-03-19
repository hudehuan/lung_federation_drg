package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysUserInfoEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysUserInfoDao extends PagingAndSortingRepository<SysUserInfoEntity,String>,JpaSpecificationExecutor<SysUserInfoEntity> {
    @Query("select u from SysUserInfoEntity u where u.sysCode=?1")
    List<SysUserInfoEntity> getAllUserInfo(String syscode);

    @Query("select u from SysUserInfoEntity u where u.loginName=?1 and u.sysCode=?2")
    public SysUserInfoEntity checkUserInfo(String loginname,String sysCode);

    @Query("select u from SysUserInfoEntity u where (u.loginName like ?1 or u.id in (" +
            "select p.id from SysStaffEntity p where( p.name like ?1 or p.pym like ?1 or p.code like ?1) and p.status = 1 )) and u.sysCode=?2")
    public List<SysUserInfoEntity> findByCondition(String condition,String sysCode);

    @Query("select u from SysUserInfoEntity u where u.id=?1 and u.sysCode=?2")
    public SysUserInfoEntity findById(String id,String sysCode);



    @Query("select u from SysUserInfoEntity u where u.loginName=?1 and u.sysCode=?2")
    public SysUserInfoEntity getUserInfo(String loginname,String sysCode);

    @Query("select u from SysUserInfoEntity u where u.id=?1 and u.sysCode=?2")
    public SysUserInfoEntity getUserInfoByUserID(String userid,String sysCode);

}
