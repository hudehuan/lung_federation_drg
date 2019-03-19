package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysDictionaryItemEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysDictionaryItemDao extends PagingAndSortingRepository<SysDictionaryItemEntity,String>,JpaSpecificationExecutor<SysDictionaryItemEntity> {
    @Query("select d from SysDictionaryItemEntity d order by d.itemCode ")
    public List<SysDictionaryItemEntity> getAllDictionaryItem();

    @Query("select d from SysDictionaryItemEntity d where d.did =?1 order by d.itemCode ")
    public List<SysDictionaryItemEntity> getAllDictionaryItemById(String did);

    @Query("select d from SysDictionaryItemEntity d where d.itemCode =?1 order by d.itemCode ")
    public SysDictionaryItemEntity findOneByCode(String itemCode);

    @Query("select d from SysDictionaryItemEntity d where d.itemCode like ?1 or d.dicName like ?1 order by d.itemCode ")
    public List<SysDictionaryItemEntity> findByCondition(String condition);
    @Query("select d from SysDictionaryItemEntity d where d.did in (Select p from SysDictionaryEntity p where p.dicCode=?1)")
    public List<SysDictionaryItemEntity> findByIsDicCode(String dicCode);

}
