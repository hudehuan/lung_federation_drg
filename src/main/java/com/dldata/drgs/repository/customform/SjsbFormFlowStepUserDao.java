package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormFlowStepUserEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/2.
 */
public interface SjsbFormFlowStepUserDao extends PagingAndSortingRepository<SjsbFormFlowStepUserEntity,String>,JpaSpecificationExecutor<SjsbFormFlowStepUserEntity> {

    @Query("select u from SjsbFormFlowStepUserEntity u where u.userid = ?1")
    public List<SjsbFormFlowStepUserEntity> getFlowStepOfUserID(String userID);

    @Query("select u from SjsbFormFlowStepUserEntity u where u.stepId = ?1")
    public List<SjsbFormFlowStepUserEntity> findByStepId(String StepId);

    @Query("select u from SjsbFormFlowStepUserEntity u where u.flowId = ?1")
    public List<SjsbFormFlowStepUserEntity> findByFlowId(String flowId);
}
