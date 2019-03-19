package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormShLogEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/11/2.
 */
public interface SjsbFormShLogDao extends PagingAndSortingRepository<SjsbFormShLogEntity,String>,JpaSpecificationExecutor<SjsbFormShLogEntity> {



    @Query("select n from SjsbFormShLogEntity n where n.formId=?1 and n.dataId=?2 order by n.sjtime desc ")
    public List<SjsbFormShLogEntity> getFormShLogByFormIDDataID(String formId, String dataId);

    @Query("select n from SjsbFormShLogEntity n where n.dataId=?1 order by n.sjtime desc ")
    public List<SjsbFormShLogEntity> findByDataID(String dataId);

    @Query("select n from SjsbFormShLogEntity n where n.userId=?1 and n.dataId=?2 order by n.sjtime desc ")
    public List<SjsbFormShLogEntity> findByUserIdDataId(String UserId, String dataId);

    @Query("select n from SjsbFormShLogEntity n where n.userId=?1 order by n.sjtime desc ")
    public List<SjsbFormShLogEntity> findByUserID(String Userid);

//    @Query("select n from SjsbFormShLogEntity n where n.formId=?1 and n.dataId=?2 order by n.sjtime desc ")
//    public List<SjsbFormShLogEntity> getFormShLogByFormIDDataID(String formId, String dataId);
//
//    @Query("select n from SjsbFormShLogEntity n where n.dataId=?1 order by n.sjtime desc ")
//    public List<SjsbFormShLogEntity> findByDataID(String dataId);
//
//    @Query("select n from SjsbFormShLogEntity n where n.userId=?1 and n.dataId=?2 order by n.sjtime desc ")
//    public List<SjsbFormShLogEntity> findByUserIdDataId(String UserId, String dataId);
//
//    @Query("select n from SjsbFormShLogEntity n where n.userId=?1 order by n.sjtime desc ")
//    public List<SjsbFormShLogEntity> findByUserID(String Userid);
}
