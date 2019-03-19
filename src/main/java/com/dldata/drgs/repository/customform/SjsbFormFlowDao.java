package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormFlowEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/1.
 */
public interface SjsbFormFlowDao extends PagingAndSortingRepository<SjsbFormFlowEntity,String>,JpaSpecificationExecutor<SjsbFormFlowEntity> {

    @Query("select f from SjsbFormFlowEntity f where f.formid=?1 and f.status = true order by f.xh")
    public List<SjsbFormFlowEntity> getByFormID(String fromID);

    @Query("select f from SjsbFormFlowEntity f where f.formid is null and f.status = true order by f.xh")
    public List<SjsbFormFlowEntity> getFlowByFormIDnull();

    @Query("select f from SjsbFormFlowEntity f where f.xh=?1 and f.status = true and f.formid = ?2 order by f.xh")
    public List<SjsbFormFlowEntity> findByXh(int xh, String formId);

    @Query("select f from SjsbFormFlowEntity f where f.name=?1 and f.status = true and f.formid = ?2 order by f.xh")
    public  List<SjsbFormFlowEntity> findByName(String name, String formId);

    @Query("select f from SjsbFormFlowEntity f ")
    public  List<SjsbFormFlowEntity> findAll();



}

