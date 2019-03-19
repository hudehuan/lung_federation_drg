package com.dldata.drgs.repository.drgsDicData;

import com.dldata.drgs.entity.DicXzqhEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
public interface DicXzqhDao extends PagingAndSortingRepository<DicXzqhEntity,String>,JpaSpecificationExecutor<DicXzqhEntity> {

    @Query("select e from DicXzqhEntity e ")
    public List<DicXzqhEntity> getAllData();

}
