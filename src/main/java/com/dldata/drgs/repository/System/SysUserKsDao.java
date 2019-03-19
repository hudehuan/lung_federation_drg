package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysUserKsEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2016/8/23.
 */
public interface SysUserKsDao extends PagingAndSortingRepository<SysUserKsEntity,String>,JpaSpecificationExecutor<SysUserKsEntity> {

    @Query("select u from SysUserKsEntity u where u.userid =?1 and u.sysCode=?2")
    public List<SysUserKsEntity> getAllUserKs(String userid, String sysCode);

    @Query("select k from SysUserKsEntity k where k.userid = ?1 and k.sysCode = ?2")
    public List<SysUserKsEntity> findByUserId(String userid, String SysCode);
}
