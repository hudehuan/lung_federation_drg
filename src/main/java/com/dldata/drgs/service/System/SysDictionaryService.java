package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.repository.System.SysDictionaryDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysDictionaryService {
    @Autowired
    SysDictionaryDao dictionaryDao;

    public List<SysDictionaryEntity> getAllDictionary(String sysCode) {
        return dictionaryDao.getAllDictionary(sysCode, "SYS");
    }

    public void save(SysDictionaryEntity dictionary) {
        dictionaryDao.save(dictionary);
    }

    public void delete(String id){
        dictionaryDao.delete(id);
    }

    public SysDictionaryEntity findOne(String did) {
        return dictionaryDao.findOne(did);
    }

    public List<SysDictionaryEntity> findByCondition(String condition, String sysCode) {
        return dictionaryDao.findByCondition(condition, sysCode, "SYS");
    }

    public List<SysDictionaryEntity> findByName(String name, String sysCode) {
        return dictionaryDao.findByName(name, sysCode, "SYS");
    }

    public SysDictionaryEntity findByCode(String dicCode, String sysCode) {
        return dictionaryDao.findByCode(dicCode, sysCode, "SYS");
    }
}
