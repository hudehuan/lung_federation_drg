package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysSystemDefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/22.
 */
public interface SysSystemDefineDao extends PagingAndSortingRepository<SysSystemDefineEntity,String>,JpaSpecificationExecutor<SysSystemDefineEntity> {


    @Query("select s from SysSystemDefineEntity s order by s.xh")
    public List<SysSystemDefineEntity> getAllSystem();


}
