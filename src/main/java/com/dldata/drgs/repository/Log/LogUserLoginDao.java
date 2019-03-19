package com.dldata.drgs.repository.Log;

import com.dldata.drgs.entity.LogUserLoginEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface LogUserLoginDao extends PagingAndSortingRepository<LogUserLoginEntity,String>,JpaSpecificationExecutor<LogUserLoginEntity> {

    @Query("select u from LogUserLoginEntity u order by u.loginDate")
    public List<LogUserLoginEntity> getAllLogUserLogin();

    @Query("select u from LogUserLoginEntity u, SysStaffEntity s where u.userId = s.id and (s.name like ?1 or s.pym like ?1)" +
            "and u.loginDate between ?2 and ?3 order by u.loginDate desc ,u.loginTime desc")
    public List<LogUserLoginEntity> findByCondition(String condition,Timestamp sTime, Timestamp eTime) ;
}
