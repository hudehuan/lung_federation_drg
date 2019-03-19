package com.dldata.drgs.repository.System;

import com.dldata.drgs.entity.SysHospitalBranchEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
public interface SysHospitalBranchDao extends PagingAndSortingRepository<SysHospitalBranchEntity,String>,JpaSpecificationExecutor<SysHospitalBranchEntity> {
    @Query("select h from SysHospitalBranchEntity h where h.status <> 0 order by h.xh")
    public List<SysHospitalBranchEntity> getAllHospitalBranch();

    @Query("select h from SysHospitalBranchEntity h where h.name =?1 and h.status <> 0 order by h.xh")
    public List<SysHospitalBranchEntity> findByName(String name);

    @Query("select h from SysHospitalBranchEntity h where h.code =?1 and h.status <> 0 order by h.xh")
    public List<SysHospitalBranchEntity> findOneByCode(String code);
}
