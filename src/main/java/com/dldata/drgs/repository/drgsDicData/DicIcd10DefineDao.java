package com.dldata.drgs.repository.drgsDicData;

import com.dldata.drgs.entity.DicIcd10DefineEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
public interface DicIcd10DefineDao  extends PagingAndSortingRepository<DicIcd10DefineEntity,String>,JpaSpecificationExecutor<DicIcd10DefineEntity> {

    @Query("select e from DicIcd10DefineEntity e where e.code like ?1 or e.type like ?1 or e.icd10Dm like ?1 or e.icd10Mc like ?1 order by e.icd10Dm")
    public List<DicIcd10DefineEntity> findBeSearchLike(String search);

    @Query("select e from DicIcd10DefineEntity e where e.code = ?1 order by e.icd10Dm")
    public List<DicIcd10DefineEntity> findOneByCode(String code);

}
