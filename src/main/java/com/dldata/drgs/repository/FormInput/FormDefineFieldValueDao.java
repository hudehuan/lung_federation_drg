package com.dldata.drgs.repository.FormInput;

import com.dldata.drgs.entity.FormDefineFieldValueEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/9/9.
 */
public interface FormDefineFieldValueDao extends PagingAndSortingRepository<FormDefineFieldValueEntity,String>,JpaSpecificationExecutor<FormDefineFieldValueEntity> {

    @Query("select f from FormDefineFieldValueEntity f where f.tvId=?1")
    public List<FormDefineFieldValueEntity> getDefineFieldValue(String tvId);


    @Query("select f from FormDefineFieldValueEntity f where f.tvId=?1 and f.fdId=?2 and f.wdm=?3")
    public List<FormDefineFieldValueEntity> getByTvIdFdIdWdm(String tvId,String fdId,String wdm);

    @Query("select f from FormDefineFieldValueEntity f where f.tvId=?1 and f.wdm=?2")
    public List<FormDefineFieldValueEntity> getByTvIdWdm(String tvId,String wdm);

    @Query("select f from FormDefineFieldValueEntity f where f.tdId=?1")
    public List<FormDefineFieldValueEntity> getDefineFieldValueByTdId(String tdId);

    @Query("select f from FormDefineFieldValueEntity f where f.tdId=?1 and f.cxrq>?2 and f.cxrq<?3")
    public List<FormDefineFieldValueEntity> queryDefineFieldValue(String tdId,String cxrqstart,String cxrqend);
}
