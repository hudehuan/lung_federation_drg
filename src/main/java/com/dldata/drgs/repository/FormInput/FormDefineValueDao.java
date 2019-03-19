package com.dldata.drgs.repository.FormInput;

import com.dldata.drgs.entity.FormDefineValueEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/9/9.
 */
public interface FormDefineValueDao extends PagingAndSortingRepository<FormDefineValueEntity,String>,JpaSpecificationExecutor<FormDefineValueEntity> {

    @Query("select v from FormDefineValueEntity v where v.tdId=?1 order by v.inputDate")
    public List<FormDefineValueEntity> getDefineValueByTableId(String tableId);


    @Query("select v from FormDefineValueEntity v where v.tdId=?1 and v.rq=?2")
    public List<FormDefineValueEntity> getDefineValueByTableIdDate(String tdId,String rq);

    @Query("select v from FormDefineValueEntity v where v.tdId=?1 and v.cxrq>=?2 and v.cxrq<=?3 order by v.rq asc ")
    public List<FormDefineValueEntity> queryDefineValue(String tableId, String cxrqstart,String cxrqend);
}
