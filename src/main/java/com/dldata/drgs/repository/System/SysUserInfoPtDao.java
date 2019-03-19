package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysUserInfoPtEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */
public interface SysUserInfoPtDao extends PagingAndSortingRepository<SysUserInfoPtEntity,String>,JpaSpecificationExecutor<SysUserInfoPtEntity> {

    @Query("select s from SysUserInfoPtEntity s ")
    public List<SysUserInfoPtEntity> getAllInfo();

    @Query("select s from SysUserInfoPtEntity s where s.userid =?1 and s.sysCode =?2")
    public SysUserInfoPtEntity getAllByUserId(String userId,String sysCode);


    @Query("select s from SysUserInfoPtEntity s where s.userType like ?1 and s.sysCode =?2")
    public List<SysUserInfoPtEntity> findByTypeLike(String type,String sysCode);

    @Query("select s from SysUserInfoPtEntity s where s.wtLoginName = ?1 and s.sysCode = ?2")
    public SysUserInfoPtEntity findByWtLoginName(String wtLoginName,String sysCode);
}
