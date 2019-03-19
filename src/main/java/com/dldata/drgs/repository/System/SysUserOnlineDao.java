package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysUserOnlineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysUserOnlineDao extends PagingAndSortingRepository<SysUserOnlineEntity,String>,JpaSpecificationExecutor<SysUserOnlineEntity> {
    @Query("select u from SysUserOnlineEntity u order by u.loginTime desc ")
    List<SysUserOnlineEntity> getAllUserOnline();


    @Query("select o from SysUserOnlineEntity o,SysStaffEntity u where o.userId= u.id and (u.name like ?1 or u.pym like ?1) order by o.loginTime desc")
    public List<SysUserOnlineEntity> findByCondition(String condition);

    @Query("select o from SysUserOnlineEntity o,SysUserInfoEntity u where o.userId= u.id and u.loginName = ?1 and o.sysCode = ?2 and u.sysCode=?2 order by o.loginTime desc")
    public List<SysUserOnlineEntity> getUserOnlineByLoginName(String loginname, String syscode);

    @Modifying
    @Query("delete from SysUserOnlineEntity c where c.userId = ?1")
    public void deleteByUserID(String userid);


    @Modifying
    @Query(value = "update SysUserOnlineEntity u set u.loginTime=?2,u.sessionId=?3 where u.userId=?1")
    public void updateUserOnline(String userid, Timestamp logintime, String sessionid);

    @Query("select e from SysUserOnlineEntity e where e.userId=?1 and e.sysCode=?2 order by e.loginTime desc ")
    public List<SysUserOnlineEntity> getUserOnlineD(String userid,String sysCode);

}
