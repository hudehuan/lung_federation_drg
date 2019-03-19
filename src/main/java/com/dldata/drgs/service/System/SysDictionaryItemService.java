package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.repository.System.SysDictionaryItemDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysDictionaryItemService {

    @Autowired
    SysDictionaryItemDao dictionaryItemDao;

    public void save(SysDictionaryItemEntity dictionary) {
        dictionaryItemDao.save(dictionary);
    }

    public void delete(String id){
        dictionaryItemDao.delete(id);
    }

    public List<SysDictionaryItemEntity> getAllDictionaryItemById(String did) {
        return dictionaryItemDao.getAllDictionaryItemById(did);
    }

    public List<SysDictionaryItemEntity> getAllDictionaryItem() {
        return dictionaryItemDao.getAllDictionaryItem();
    }

    public SysDictionaryItemEntity findOne(String itemId) {
        return dictionaryItemDao.findOne(itemId);
    }

    public SysDictionaryItemEntity findOneByCode(String itemCode) {
        return dictionaryItemDao.findOneByCode(itemCode);
    }

    public List<SysDictionaryItemEntity> findByCondition(String condition) {
        return dictionaryItemDao.findByCondition(condition);
    }
    public List<SysDictionaryItemEntity> findByIsDicCode(String diccode) {
        return dictionaryItemDao.findByIsDicCode(diccode);
    }
}
