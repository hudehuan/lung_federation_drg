package com.dldata.drgs.repository.drgsDicData;

import com.dldata.drgs.entity.DicJgdmTzEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/09/15.
 */
public interface DicJgdmTzDao  extends PagingAndSortingRepository<DicJgdmTzEntity,String>,JpaSpecificationExecutor<DicJgdmTzEntity> {

    @Query("select e from DicJgdmTzEntity e ")
    public List<DicJgdmTzEntity> getAll();

    @Query("select e from DicJgdmTzEntity e where e.dm = ?1")
    public DicJgdmTzEntity findByJgdm(String jgdm);

    @Query("select e from DicJgdmTzEntity e where e.dm in (" +
            "select j.jgdm from SysRoleJgdmEntity j where j.browse = true and j.roleId in (" +
            "select r.roleId from SysUserRolesEntity r where r.uerId = ?1))")
    public List<DicJgdmTzEntity> findJgdmByUseridRole(String userid);

}
