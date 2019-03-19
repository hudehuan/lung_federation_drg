package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysDiscussEntity;
import com.dldata.drgs.repository.System.SysDiscussDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysDiscussService {

    @Autowired
    SysDiscussDao discussDao;

    public List<SysDiscussEntity> getAllDiscuss() {
        return discussDao.getAllDiscuss();
    }

    public void save(SysDiscussEntity discuss) {
        discussDao.save(discuss);
    }

    public void delete(String id) {
        discussDao.delete(id);
    }
}
