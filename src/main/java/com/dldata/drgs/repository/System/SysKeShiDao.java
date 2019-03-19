package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysKsEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysKeShiDao extends PagingAndSortingRepository<SysKsEntity,String>,JpaSpecificationExecutor<SysKsEntity> {


    @Query("select k from SysKsEntity k where k.satus <>0 order by k.xh ")
    public List<SysKsEntity> getAllKeShi();

    @Query("select k from SysKsEntity k where k.satus <>0 and (k.code like ?1 or k.name like ?1 or k.pym like ?1) order by k.xh")
    public List<SysKsEntity> findByCondition(String input);

    @Query("select k from SysKsEntity k where k.code =?1 and k.satus <> 0 order by k.xh")
    public List<SysKsEntity> findOneByCode(String code);

    @Query("select k from SysKsEntity k where k.name =?1 and k.satus <> 0 order by k.xh")
    public List<SysKsEntity> findByName(String name);

    @Query("select k from SysKsEntity k where k.zy = true order by k.xh")
    public List<SysKsEntity> getZyKs();
}
