package com.dldata.drgs.repository.drgsDicData;


import com.dldata.drgs.entity.DicIcd10Entity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
public interface DicIcd10Dao  extends PagingAndSortingRepository<DicIcd10Entity,String>,JpaSpecificationExecutor<DicIcd10Entity> {

    @Query("select e from DicIcd10Entity e where e.dm like ?1 or e.mc like ?1 or e.lx like ?1 order by e.dm")
    public List<DicIcd10Entity> findBySearchLike(String search);
}
