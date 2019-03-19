package com.dldata.drgs.repository.Table;


import com.dldata.drgs.entity.TabStructureEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/3.
 */
public interface TabStructureDAO extends PagingAndSortingRepository<TabStructureEntity,String>,JpaSpecificationExecutor<TabStructureEntity> {



    @Query(value = "select s from TabStructureEntity s where s.tableId=?1 and s.status <> 0 order by s.xh")
    public List<TabStructureEntity> getTabStrucOfTabID(String tableid);

    @Query(value = "select s.xh from TabStructureEntity s where s.tableId=?1 and s.status <> 0 order by s.xh desc ")
    public List<Integer> getMaxXH(String tableid);

    @Query(value = "select s from TabStructureEntity s where s.name=?1 and s.status <> 0 order by s.xh")
    public List<TabStructureEntity> findByName(String name);


    @Query("select s from TabStructureEntity s where s.tableId =?1 and s.status <> 0 order by s.xh")
    public List<TabStructureEntity> getStructure(String tableId);

}
