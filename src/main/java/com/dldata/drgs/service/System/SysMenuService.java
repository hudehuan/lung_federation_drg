package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysMenuEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.repository.System.SysMenuDao;
import com.dldata.drgs.repository.System.SysRoleMenuDao;
import com.dldata.drgs.utils.SysConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysMenuService {

    @Autowired
    SysMenuDao sysMenuDao;


    public List<SysMenuEntity> getAllMenu(String sysCode){
        return  sysMenuDao.getAllMenu(sysCode);
    }

    public SysMenuEntity findOne(String id){
        return sysMenuDao.findOne(id);
    }

    public void save(SysMenuEntity entity) {
        sysMenuDao.save(entity);
    }

    public List<SysMenuEntity> findOneByCode(String code, String sysCode) {
        return sysMenuDao.findOneByCode(code, sysCode);
    }

    public List<SysMenuEntity> findByCondition(String condition, String sysCode) {
        return sysMenuDao.findByCondition(condition, sysCode);
    }

    public List<SysMenuEntity>  findAllBySysCode(String sysCode){
        return sysMenuDao.findAllBySysCode(sysCode);
    }

    public void saveList(List<SysMenuEntity> sysMenuEntities){
        sysMenuDao.save(sysMenuEntities);
    }

    @Autowired
    SysRoleMenuDao sysRoleMenuDao;
    @PersistenceContext
    private EntityManager em;

    @Autowired
    SysConfig sysConfig;


    public List<SysRoleMenuEntity> getUserMenuPower(String userId, String menuCode){
        String hql = "select new com.dldata.drgs.entity.SysRoleMenuEntity(rm.id,rm.roleId, rm.menuId, rm.isBrowse, rm.isAdd, rm.isEdit, rm.isDel, rm.isPrint, rm.isImport, rm.isExport, rm.isCheck,rm.isUndo) from SysUserRolesEntity ur,SysRoleMenuEntity rm,SysMenuEntity m" +
                " where ur.roleId = rm.roleId and rm.menuId = m.id" +
                " and m.code = '"+ menuCode + "' and m.sysCode='" + sysConfig.SysCode + "' and m.status<>0" +
                " and ur.uerId = '" + userId + "' order by m.code";

        TypedQuery<SysRoleMenuEntity> query = em.createQuery(hql, SysRoleMenuEntity.class);

        List<SysRoleMenuEntity>  list= query.getResultList();
//        List<SysRoleMenuEntity>  list=  sysRoleMenuDao.getUserMenuPower(menuCode,sysConfig.SysCode, userId);
        return list;


    }


    public List<SysMenuEntity> fineBySysCode(String sysCode,String userId){

        return sysMenuDao.fineBySysCode(sysCode, userId);
    }


    public SysMenuEntity fineMenuEntityByCode(String menuCode){

        return sysMenuDao.fineMenuEntityByCode(menuCode);
    }
}
