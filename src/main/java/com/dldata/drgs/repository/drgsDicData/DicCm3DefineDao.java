package com.dldata.drgs.repository.drgsDicData;


import com.dldata.drgs.entity.DicCm3DefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
public interface DicCm3DefineDao  extends PagingAndSortingRepository<DicCm3DefineEntity,String>,JpaSpecificationExecutor<DicCm3DefineEntity> {

    @Query("select e from DicCm3DefineEntity e where e.code like ?1 or e.type like ?1 or e.cm3Mc like ?1 or e.cm3Mc like ?1 order by e.cm3Dm")
    public List<DicCm3DefineEntity> findBeSearchLike(String search);

    @Query("select e from DicCm3DefineEntity e where e.code = ?1 order by e.cm3Dm")
    public List<DicCm3DefineEntity> findOneByCode(String code);

}
