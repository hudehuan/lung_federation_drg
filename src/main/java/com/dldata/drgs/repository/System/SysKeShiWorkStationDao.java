package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysKsWorkstationEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysKeShiWorkStationDao extends PagingAndSortingRepository<SysKsWorkstationEntity,String>,JpaSpecificationExecutor<SysKsWorkstationEntity> {
    @Query("select s from SysKsWorkstationEntity s where s.status <> 0 order by s.code")
    public List<SysKsWorkstationEntity> getAllKsWorkStation();

    @Query("select s from SysKsWorkstationEntity s where s.code =?1 and s.status <> 0 order by s.code")
    public List<SysKsWorkstationEntity> findOneByCode(String code);

    @Query("select s from SysKsWorkstationEntity s where s.status <>0 and (s.code like ?1 or s.name like ?1 or s.pym like ?1) order by s.code")
    public List<SysKsWorkstationEntity> findOneByCondition(String condition);

    @Query("select s from SysKsWorkstationEntity s where s.name =?1 and s.status <> 0 order by s.code")
    public List<SysKsWorkstationEntity> findByName(String name);
}
