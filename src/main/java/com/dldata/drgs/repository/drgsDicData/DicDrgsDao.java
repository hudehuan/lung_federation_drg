package com.dldata.drgs.repository.drgsDicData;


import com.dldata.drgs.entity.DicDrgsEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
public interface DicDrgsDao  extends PagingAndSortingRepository<DicDrgsEntity,String>,JpaSpecificationExecutor<DicDrgsEntity> {

    @Query("select e from DicDrgsEntity e where e.dm like ?1 order by e.dm")
    public List<DicDrgsEntity> findByDmLikeBefore(String dm);

}

