package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysStaffEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */

public interface SysStaffDao extends PagingAndSortingRepository<SysStaffEntity,String>,JpaSpecificationExecutor<SysStaffEntity> {

    @Query("select u from SysStaffEntity u where u.status <>0 order by u.code")
    public List<SysStaffEntity> getAllStaff();

    @Query("select u from SysStaffEntity u where u.code =?1 and u.status <>0 order by u.code")
    public List<SysStaffEntity> findOneByCode(String code);


    @Query("select u from SysStaffEntity u where u.status <>0 and (u.name like ?1 or u.code like ?1 or u.pym like ?1) order by u.code")
    List<SysStaffEntity> findByCondition(String condition);

//    @Query("select u.*,k.name as ksname,w.name as kswname from SysStaffEntity u,SysKeShiEntity k,SysKeShiWorkStationEntity w")
//    public List<Staff> getStaff();

//    @Query("select u from SysStaffEntity u where u.age > ?1 and u.name like ?2")
//    public List<SysStaffEntity> getUsersByName(int age, String name);
//
//    @Query("select u from SysStaffEntity u where u.id =?1")
//    public SysStaffEntity getUserById(int id);

    @Query("select s from SysStaffEntity s where s.ksId=?1 and s.status = 1 ")
    public List<SysStaffEntity> findByKsid(String id);
//
    @Query("select s from SysStaffEntity s where s.status <>0 and s.ksId=?1 and (s.code like ?2 or s.name like ?2 or s.pym like ?2)")
    public List<SysStaffEntity> findByKsIdCondition(String ksid, String condition);

    @Query("select u from SysStaffEntity u where  u.id in (select p.userid from SjsbFormFlowStepUserEntity p where p.stepId =?1) And u.status <>0 order by u.code ")
    public List<SysStaffEntity> getAllStaffInFromStepUserid(String stepId);

}
