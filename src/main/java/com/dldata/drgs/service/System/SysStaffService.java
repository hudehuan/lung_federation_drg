package com.dldata.drgs.service.System;

//import com.dldata.drgs.business.SysStaffBE.StaffInfoBE;
import com.dldata.drgs.entity.SysStaffEntity;
import com.dldata.drgs.repository.System.SysStaffDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysStaffService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    SysStaffDao sysStaffDao;



    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<SysStaffEntity> getAllStaff(){
        return sysStaffDao.getAllStaff();
    }


//    public List<StaffInfoBE> getAllStaffInfo(){
//
//        //内连接
//        String hql = "select new com.dldata.drgs.business.SysStaffBE.StaffInfoBE(a.id,a.name,a.code,a.userClass,a.status,a.pym,a.ksId,a.kswId,a.yqId,a.zhiCheng,a.zhiWei,a.weiyiCode,"
//                + "b.name,c.name,d.name) "
//                + "from  SysStaffEntity a,SysKsEntity b,SysKsWorkstationEntity c,SysHospitalBranchEntity d"
//                + " where a.ksId = b.id and  a.kswId = c.id and a.yqId = d.id order by a.name DESC";
//
//
//        TypedQuery<StaffInfoBE> query = em.createQuery(hql, StaffInfoBE.class);
//
//        return query.getResultList();
//    }


    public List getAllStaffInfo2(){
//        String hql = "select a.id,a.name,a.code,a.userclass,a.status,a.pym,a.ksid,a.kswid,a.yqid,a.zhicheng,a.zhiwei,a.weiyicode,"
//                + "b.name as ksname,c.name as kswname,d.name as hosname "
//                + "from  SysStaffEntity a,SysKsEntity b,SysKsWorkstationEntity c,SysHospitalBranchEntity d"
//                + " where a.ksid = b.id and  a.kswid = c.id and a.yqid = d.id order by a.name DESC";

        List rows = jdbcTemplate.queryForList("select id, name, code from Sys_Staff"); //得到装有map的list
        for(int i=0;i<rows.size();i++){                   //遍历
            Map userMap= (Map)rows.get(i);
            System.out.println(userMap.get("id"));
            System.out.println(userMap.get("name"));
            System.out.println(userMap.get("code"));

        }
        return rows;

//        Query query = em.createQuery(hql);
//        List rows = query.getResultList();
//        return query.getResultList();

    }

    public List<SysStaffEntity> findOneByCode(String code) {
        return sysStaffDao.findOneByCode(code);
    }
    public SysStaffEntity findOne(String id){
        return sysStaffDao.findOne(id);
    }

    public void save(SysStaffEntity staff){
        sysStaffDao.save(staff);
    }

    public List<SysStaffEntity> findByCondition(String condition) {
        return sysStaffDao.findByCondition(condition);
    }

    public SysStaffEntity getStaffByID(String staffId){

        return sysStaffDao.findOne(staffId);
    }

    public SysStaffEntity getStaffFromListById(List<SysStaffEntity> entityList,String Id){
        SysStaffEntity entity=null;
        if(entityList.size()>0){
            List<SysStaffEntity> list = entityList.stream().filter(u->u.getId().equals(Id)).collect(Collectors.toList());
            if (list.size()>0){
                entity = list.get(0);
            }
        }

        return entity;

    }

    public List<SysStaffEntity> findByKsid(String id){
        return sysStaffDao.findByKsid(id);
    }

    public List<SysStaffEntity> findByKsIdCondition(String ksid,String condition) {
        return sysStaffDao.findByKsIdCondition(ksid,condition);
    }
    public List<SysStaffEntity> getAllStaffInFromStepUserid(String stepid)
    {
        return sysStaffDao.getAllStaffInFromStepUserid(stepid);
    }
}
