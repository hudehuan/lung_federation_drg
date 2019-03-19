package com.dldata.drgs.repository.drgsDicData;

import com.dldata.drgs.entity.DicJgdmEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
public interface DicJgdmDao  extends PagingAndSortingRepository<DicJgdmEntity,String>,JpaSpecificationExecutor<DicJgdmEntity> {

    @Query("select e from DicJgdmEntity e ")
    public List<DicJgdmEntity> getAllData();

    @Query("select e from DicJgdmEntity e where e.xzqh like ?1 and e.jglbdm like ?2")
    public List<DicJgdmEntity> getAllDataByXzqgJglbLikeLeft(String xzqg,String jglb);

    @Query("select e from DicJgdmEntity e where e.xzqh like ?1 ")
    public List<DicJgdmEntity> findByXzqg(String xzqg);

    @Query("select e from DicJgdmEntity e where e.dm in (" +
            "select rj.jgdm from SysRoleJgdmEntity rj where rj.browse = true and rj.roleId in (" +
            "select ur.roleId from SysUserRolesEntity ur where ur.uerId = ?1))")
    public List<DicJgdmEntity> findInfoByUserId(String userid);
}
