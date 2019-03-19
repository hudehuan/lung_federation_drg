package com.dldata.drgs.repository.drgs;

import com.dldata.drgs.entity.DrGsYkssZedEntity;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import javax.persistence.*;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
public interface DrGsYkssZedDao extends PagingAndSortingRepository<DrGsYkssZedEntity,String>,JpaSpecificationExecutor<DrGsYkssZedEntity> {

    @Query("select e from DrGsYkssZedEntity e")
    public List<DrGsYkssZedEntity> getAll();

    @Query("select e from DrGsYkssZedEntity e where e.ykid =?1")
    public List<DrGsYkssZedEntity> findByYkId(String ykId);
}
