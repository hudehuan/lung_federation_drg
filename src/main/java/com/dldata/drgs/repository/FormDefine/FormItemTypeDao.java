package com.dldata.drgs.repository.FormDefine;

import com.dldata.drgs.entity.FormItemTypeEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by admin on 2016/8/12.
 */
public interface FormItemTypeDao extends PagingAndSortingRepository<FormItemTypeEntity,String>,JpaSpecificationExecutor<FormItemTypeEntity> {

    @Query("select f from FormItemTypeEntity f where f.status <>0 and f.sysCode = ?1")
    public List<FormItemTypeEntity> getAllFormItemType(String sysCode);

    @Query(value = "select f.xh from FormItemTypeEntity f where f.level=?1 and f.sysCode = ?2 order by f.xh ")
    public List<FormItemTypeEntity> getMaxXH(String level, String sysCode);

    @Query(value = "select t from FormItemTypeEntity t where LENGTH(t.level) = 3 and t.sysCode = ?1")
    public List<FormItemTypeEntity> getNewLevel(String sysCode);

//    @Query(value = "select t.level from FormItemTypeEntity t where LENGTH(t.level) = ?1 and t.sysCode = ?1")
//    public List<String> getCurrentLevel(Integer length, String sysCode);

    @Query(value = "select t from FormItemTypeEntity t where LENGTH(t.level) = 6 and SUBSTRING(t.level,1,LENGTH(?1))= ?1 and t.sysCode =?2 and t.status <> 0")
    public List<FormItemTypeEntity> getNextLevel(String cLevel, String sysCode);

    @Query(value = "select f.xh from FormItemTypeEntity f where f.typeName=?1 and f.sysCode = ?2")
    public List<FormItemTypeEntity> findByName(String name, String sysCode);

}
