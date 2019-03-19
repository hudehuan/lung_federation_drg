package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysDiscussItemEntity;
import com.dldata.drgs.repository.System.SysDiscussItemDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysDiscussItemService {

    @Autowired
    SysDiscussItemDao discussItemDao;

    public List<SysDiscussItemEntity> getAllDiscussItem() {
        return discussItemDao.getAllDiscussItem();
    }

    public void save(SysDiscussItemEntity discussItem) {
        discussItemDao.save(discussItem);
    }

    public void delete(String id){
        discussItemDao.delete(id);
    }
}
