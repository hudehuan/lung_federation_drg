package com.dldata.drgs.repository.Log;

import com.dldata.drgs.entity.LogUserOperEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface LogUserOperDao extends PagingAndSortingRepository<LogUserOperEntity,String>,JpaSpecificationExecutor<LogUserOperEntity> {

    @Query("select u from LogUserOperEntity u order by u.optDate")
    public List<LogUserOperEntity> getAllLogeUserOper();

    @Query("select u from LogUserOperEntity u order by u.optDate")
    public List<LogUserOperEntity> findByCondition();

}
