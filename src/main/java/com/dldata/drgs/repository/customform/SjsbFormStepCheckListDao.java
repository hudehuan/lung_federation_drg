package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.SjsbFormStepCheckListEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/11/1.
 */
public interface SjsbFormStepCheckListDao extends PagingAndSortingRepository<SjsbFormStepCheckListEntity,String>,JpaSpecificationExecutor<SjsbFormStepCheckListEntity> {


    //只查询表单状态为审核中的，   formStatus  0 数据保存 1审核中 2审核结束
    @Query("select s from SjsbFormStepCheckListEntity s where s.flowId=?1 and s.stepId=?2 and s.formStatus= ?3")
    public List<SjsbFormStepCheckListEntity> getNonCheckListByFlowIDStepID(String flowID, String stepID, int formStatus);


    //查询表单状态的数据，   formStatus  0 数据保存 1审核中 2审核结束
    @Query("select s from SjsbFormStepCheckListEntity s where  s.formStatus=?1")
    public List<SjsbFormStepCheckListEntity> getDataformStatus(int formStatus);




    @Query("select s from SjsbFormStepCheckListEntity s where s.flowId=?1 and s.stepId=?2 and s.inputKsId=?3 and s.formStatus=?4")
    public List<SjsbFormStepCheckListEntity> getNonCheckListByFlowIDStepIDKsID(String flowID, String stepID, String ksID, int formStatus);


    //只查询表单状态为审核结束的，   formStatus  0 数据保存 1审核中 2审核结束
    @Query("select s from SjsbFormStepCheckListEntity s where s.flowId=?1 and s.stepId=?2 and s.formStatus=2")
    public List<SjsbFormStepCheckListEntity> getCheckedListByFlowIDStepID(String flowID, String stepID);

    @Query("select u from SjsbFormStepCheckListEntity u where u.inputUserId=?1 and u.inputTime between ?2 and ?3 order by u.inputTime desc")
    public List<SjsbFormStepCheckListEntity> getCheckListByUserIDTime(String userID, Timestamp sTime, Timestamp eTime);

    @Query("select u from SjsbFormStepCheckListEntity u where u.inputUserId=?1 order by u.inputTime desc")
    public List<SjsbFormStepCheckListEntity> getCheckListByUserID(String userID);

    @Query("select u from SjsbFormStepCheckListEntity u where u.inputUserId=?1 and u.formStatus =2 order by u.inputTime desc")
    public List<SjsbFormStepCheckListEntity> getCheckListByUserIDEnd(String userID);

    @Query("select d from SjsbFormStepCheckListEntity d where d.dataId=?1")
    public SjsbFormStepCheckListEntity getCheckFormByDataID(String dataID);


    //按用户查询所有的用户自己审核的表单数据
    @Query("select d from SjsbFormStepCheckListEntity d where   d.inputTime between ?2 and ?3 and d.dataId in (Select p.dataId from SjsbFormShLogEntity p where p.formId like ?1)  order by d.inputTime desc")
    public List<SjsbFormStepCheckListEntity> getDataInShLogFormIDTime(String userid, Timestamp sTime, Timestamp eTime);

    //按用户查询所有的用户自己未审核的表单数据
    @Query("select d from SjsbFormStepCheckListEntity d where d.formStatus =1 And  d.stepId in (Select p.stepId from SjsbFormFlowStepUserEntity p where p.userid=?1)  order by d.inputTime desc")
    public List<SjsbFormStepCheckListEntity> getNoCheckListShUserID(String Shuserid);

    @Query("select d from SjsbFormStepCheckListEntity d where d.formStatus =1 and d.inputTime between ?2 and ?3 And  d.stepId in (Select p.stepId from SjsbFormFlowStepUserEntity p where p.userid=?1)  order by d.inputTime desc ")
    public List<SjsbFormStepCheckListEntity> getNoCheckListShUserIDTime(String Shuserid, Timestamp sTime, Timestamp eTime);

    @Query("select d from SjsbFormStepCheckListEntity d where d.formId = ?1")
    public List<SjsbFormStepCheckListEntity> findAllLikeStatus(String formId);

    @Query("select d from SjsbFormStepCheckListEntity d where  d.formStatus=?1 and d.formId = ?2")
    public List<SjsbFormStepCheckListEntity> getDataformStatusFormId(int formStatus, String formId);

    @Query("select f from SjsbFormStepCheckListEntity f where f.inputTime between ?1 and ?2 and f.inputKsId in (" +
            "select k.id from SysKsEntity k where k.id like ?3 or k.code like ?3 or k.name like ?3 or k.pym like ?3) " +
            " and f.formId like ?4")
    public List<SjsbFormStepCheckListEntity> getAllDataByTime(Timestamp s, Timestamp e, String ks, String formid);
}
