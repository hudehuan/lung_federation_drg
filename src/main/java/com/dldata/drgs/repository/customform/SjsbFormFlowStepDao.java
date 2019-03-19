package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormFlowStepEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/1.
 */
public interface SjsbFormFlowStepDao extends PagingAndSortingRepository<SjsbFormFlowStepEntity,String>,JpaSpecificationExecutor<SjsbFormFlowStepEntity> {

    @Query("select s from SjsbFormFlowStepEntity s where s.flowId=?1 and s.status= true order by s.xh")
    public List<SjsbFormFlowStepEntity> getStepByFlowID(String flowID);


    @Query("select f from SjsbFormFlowStepEntity f where f.flowId=?1  and f.status = true order by f.xh")
    public List<SjsbFormFlowStepEntity> getFormByFlowId(String flowId);

    @Query("select f from SjsbFormFlowStepEntity f where f.flowId is null  and f.status = true order by f.xh")
    public List<SjsbFormFlowStepEntity> getFormByFlowIdnull();

    @Query("select f from SjsbFormFlowStepEntity f where f.xh=?1 and f.flowId=?2 and f.status=true order by f.xh")
    public List<SjsbFormFlowStepEntity> findByXh(Integer xh, String flowId);

    @Query("select f from SjsbFormFlowStepEntity f where f.name=?1 and f.flowId=?2 and f.status=true order by f.xh")
    public List<SjsbFormFlowStepEntity> findByName(String name, String flowId);

    @Query("select f from SjsbFormFlowStepEntity f")
    public List<SjsbFormFlowStepEntity> getfindAll();

}
