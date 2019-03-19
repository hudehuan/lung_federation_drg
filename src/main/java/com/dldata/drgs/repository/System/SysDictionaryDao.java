package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysDictionaryEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysDictionaryDao extends PagingAndSortingRepository<SysDictionaryEntity,String>,JpaSpecificationExecutor<SysDictionaryEntity> {
    @Query("select d from SysDictionaryEntity d where d.sysCode =?1 or d.sysCode=?2 order by d.dicCode")
    public List<SysDictionaryEntity> getAllDictionary(String sysCode, String sys);

    @Query("select d from SysDictionaryEntity d where (d.dicName like ?1 or d.dicCode like ?1) and (d.sysCode =?2 or d.sysCode=?3) order by d.dicCode")
    public List<SysDictionaryEntity> findByCondition(String condition, String sysCode, String sys);

    @Query("select d from SysDictionaryEntity d where d.dicName =?1 and (d.sysCode =?2 or d.sysCode=?3) order by d.dicCode")
    public List<SysDictionaryEntity> findByName(String name, String sysCode, String sys);

    @Query("select d from SysDictionaryEntity d where d.dicCode =?1 and (d.sysCode =?2 or d.sysCode=?3) order by d.dicCode")
    public SysDictionaryEntity findByCode(String dicCode, String sysCode, String sys);
}
