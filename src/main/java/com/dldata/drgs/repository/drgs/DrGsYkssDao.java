package com.dldata.drgs.repository.drgs;

import com.dldata.drgs.entity.DrGsYkssEntity;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
public interface DrGsYkssDao extends PagingAndSortingRepository<DrGsYkssEntity,String>,JpaSpecificationExecutor<DrGsYkssEntity> {

    @Query("select e from DrGsYkssEntity e order by e.year desc ,e.address")
    public List<DrGsYkssEntity> getAll();

    @Query("select e from DrGsYkssEntity e where e.name like ?1 or e.address like ?1 or e.year like ?1")
    public List<DrGsYkssEntity> findBySearch(String search);

}
