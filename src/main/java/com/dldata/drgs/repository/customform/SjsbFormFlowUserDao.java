package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormFlowStepUserEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by admin on 2016/11/11.
 */
public interface SjsbFormFlowUserDao extends PagingAndSortingRepository<SjsbFormFlowStepUserEntity,String>,JpaSpecificationExecutor<SjsbFormFlowStepUserEntity> {
}
