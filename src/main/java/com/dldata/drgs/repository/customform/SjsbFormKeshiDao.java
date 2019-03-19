package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormKeshiEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/3/17.
 */
public interface SjsbFormKeshiDao extends PagingAndSortingRepository<SjsbFormKeshiEntity,String>,JpaSpecificationExecutor<SjsbFormKeshiEntity> {

    @Query("select k from SjsbFormKeshiEntity k where k.formId = ?1")
    public List<SjsbFormKeshiEntity> getByFormId(String formId);

    @Query("select k from SjsbFormKeshiEntity k where k.kid = ?1")
    public List<SjsbFormKeshiEntity> findByKid(String kId);

    @Query("select k from SjsbFormKeshiEntity k where k.formId = ?1 and k.kid = ?2 ")
    public List<SjsbFormKeshiEntity> findByFidKid(String formId, String kid);
}
