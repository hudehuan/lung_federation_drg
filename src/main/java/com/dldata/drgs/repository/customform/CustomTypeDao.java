package com.dldata.drgs.repository.customform;

import com.dldata.drgs.entity.CustomTypeEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */
public interface CustomTypeDao extends PagingAndSortingRepository<CustomTypeEntity,String>,JpaSpecificationExecutor<CustomTypeEntity> {


    @Query("select c from CustomTypeEntity c")
    public List<CustomTypeEntity> getAllCustomType();

    @Query("select c from CustomTypeEntity c where c.name = ?1")
    public List<CustomTypeEntity> findByName(String name);

}
