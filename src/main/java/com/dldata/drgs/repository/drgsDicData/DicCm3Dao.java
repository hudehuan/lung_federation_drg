package com.dldata.drgs.repository.drgsDicData;


import com.dldata.drgs.entity.DicCm3Entity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
public interface DicCm3Dao  extends PagingAndSortingRepository<DicCm3Entity,String>,JpaSpecificationExecutor<DicCm3Entity> {

    @Query("select e from DicCm3Entity e where e.dm like ?1 or e.mc like ?1 or e.lx like ?1 order by e.dm")
    public List<DicCm3Entity> findBySearchLike(String search);

}
