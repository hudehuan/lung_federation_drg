package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysUserOnlineEntity;
import com.dldata.drgs.repository.System.SysUserOnlineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysUserOnlineService {
    @Autowired
    SysUserOnlineDao userOnlineDao;
    public List<SysUserOnlineEntity> getAllUserOnline() {
        return userOnlineDao.getAllUserOnline();
    }

    public SysUserOnlineEntity save(SysUserOnlineEntity userOnline) {
        return userOnlineDao.save(userOnline);
    }

    public void delete(String id) {
        userOnlineDao.delete(id);
    }

    public void deleteOnlineInfos(List<SysUserOnlineEntity> entities){
        userOnlineDao.delete(entities);
    }

    public List<SysUserOnlineEntity> findByCondition(String condition){
        List<SysUserOnlineEntity> entities = new ArrayList<SysUserOnlineEntity>();
        entities = userOnlineDao.findByCondition(condition);
        return entities;
    }

    public List<SysUserOnlineEntity> getUserOnlineByLoginName(String loginname, String syscode) {
        List<SysUserOnlineEntity> entities = new ArrayList<SysUserOnlineEntity>();
        entities = userOnlineDao.getUserOnlineByLoginName(loginname, syscode);
        return entities;
    }

    public void deleteByUserID(String userid,String sysCode){

        List<SysUserOnlineEntity> sysUserOnlineEntities = getUserOnlineD(userid, sysCode);
        //sysUserOnlineDao.deleteByUserID(userid);
        userOnlineDao.delete(sysUserOnlineEntities);
    }

    public void updateUserOnline(SysUserOnlineEntity entity){

        //sysUserOnlineDao.updateUserOnline(entity.getUserid(),entity.getLogintime(),entity.getSessionid());
        userOnlineDao.save(entity);
    }

    public List<SysUserOnlineEntity> getUserOnlineD(String userid,String sysCode){
        return userOnlineDao.getUserOnlineD(userid, sysCode);
    }

}
