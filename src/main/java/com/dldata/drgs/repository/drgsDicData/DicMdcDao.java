package com.dldata.drgs.repository.drgsDicData;


import com.dldata.drgs.entity.DicMdcEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
public interface DicMdcDao extends PagingAndSortingRepository<DicMdcEntity,String>,JpaSpecificationExecutor<DicMdcEntity> {

    @Query("select e from DicMdcEntity e where e.dm like ?1 or e.mc like ?1 order by e.dm")
    public List<DicMdcEntity> findBySearchLike(String search);

}
