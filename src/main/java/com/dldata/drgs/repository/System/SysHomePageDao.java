package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysHomePageEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysHomePageDao extends PagingAndSortingRepository<SysHomePageEntity,String>,JpaSpecificationExecutor<SysHomePageEntity> {
    @Query("select h from SysHomePageEntity h where h.sysCode =?1")
    public List<SysHomePageEntity> getAllHomePageInterface(String sysCode);

    @Query("select h from SysHomePageEntity h where h.name like ?1 and h.sysCode =?2")
    public List<SysHomePageEntity> findByCondition(String condition, String sysCode);

    @Query("select h from SysHomePageEntity h where h.name =?1 and h.sysCode =?2 ")
    public List<SysHomePageEntity> findByName(String name, String sysCode);

}
