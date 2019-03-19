package com.dldata.drgs.repository.drgsDicData;

import com.dldata.drgs.entity.DicYylbEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
public interface DicYylbDao extends PagingAndSortingRepository<DicYylbEntity,String>,JpaSpecificationExecutor<DicYylbEntity> {

    @Query("select e from DicYylbEntity e ")
    public List<DicYylbEntity> getAllData();
}
