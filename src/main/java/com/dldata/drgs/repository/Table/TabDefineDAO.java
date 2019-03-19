package com.dldata.drgs.repository.Table;


import com.dldata.drgs.entity.TabDefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/2.
 */
public interface TabDefineDAO extends PagingAndSortingRepository<TabDefineEntity,String>,JpaSpecificationExecutor<TabDefineEntity> {



    @Query("select t from TabDefineEntity t where t.status <> 0 and t.sysCode =?1 order by t.zhName")
    public List<TabDefineEntity> getAll(String sysCode);

    @Query("select t from TabDefineEntity t where t.status <> 0 and t.sysCode =?2 and (t.name like ?1 or t.pym like ?1 or t.zhName like ?1) order by t.zhName")
    public List<TabDefineEntity> findByCondition(String condition, String sysCode);

    @Query("select t from TabDefineEntity t where t.status <> 0 and t.sysCode =?2 and t.name = ?1 order by t.zhName")
    public List<TabDefineEntity> findByName(String name, String sysCode);
}
