package com.dldata.drgs.repository.FormDefine;

import com.dldata.drgs.entity.FormItemEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2016/8/12.
 */
public interface FormItemDao extends PagingAndSortingRepository<FormItemEntity,String>,JpaSpecificationExecutor<FormItemEntity> {

    @Query("select f from FormItemEntity f where f.typeId=?1 and f.status <>0 and f.sysCode =?2 order by f.xh")
    public List<FormItemEntity> getAllFormItem(String typeId, String sysCode);

    @Query(value = "select f from FormItemEntity f where f.typeId=?1 order by f.xh desc ")
    public List<FormItemEntity> getMaxXH(String typeId);
}
