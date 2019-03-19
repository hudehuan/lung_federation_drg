package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.repository.System.SysRoleMenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Created by 倪继文 on 2016/9/18.
 */
@Component
@Transactional
public class SysUserPowerCheckService {

    @PersistenceContext
    private EntityManager em;

    @Autowired
    SysRoleMenuDao sysRoleMenuDao;
    public List<SysRoleMenuEntity> checkUserPower(String menuCode,String userId,String sysCode){
     String hql = " select new com.dldata.drgs.entity.SysRoleMenuEntity(rm.id,rm.roleId, rm.menuId, rm.isBrowse, rm.isAdd, rm.isEdit, rm.isDel, rm.isPrint, rm.isImport, rm.isExport, rm.isCheck,rm.isUndo) from SysRoleMenuEntity rm, SysMenuEntity m ,SysUserRolesEntity ur " +
                  " where rm.menuId = m.id and m.code='"+ menuCode + "' and ur.roleId = rm.roleId " +
                  " and ur.uerId='" + userId + "' and  m.sysCode='"+ sysCode + "'";

        TypedQuery<SysRoleMenuEntity> query = em.createQuery(hql, SysRoleMenuEntity.class);

        List<SysRoleMenuEntity>  list= query.getResultList();
//        List<SysRoleMenuEntity>  list=  sysRoleMenuDao.getUserMenuPower(menuCode,sysCode, userId);
        return list;

    }

}
