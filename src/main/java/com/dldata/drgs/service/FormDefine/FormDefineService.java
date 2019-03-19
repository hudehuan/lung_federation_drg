package com.dldata.drgs.service.FormDefine;

import com.dldata.drgs.entity.FormDefineEntity;
import com.dldata.drgs.repository.FormDefine.FormDefineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/12.
 */
@Component
@Transactional
public class FormDefineService {

    @Autowired
    FormDefineDao formDefineDao;

    public List<FormDefineEntity> getAllFormDefine(String sysCode) {
        return formDefineDao.getAllFormDefine(sysCode);
    }

    public void save(FormDefineEntity formDefine) {
        formDefineDao.save(formDefine);
    }

    public void update(FormDefineEntity formDefine) {
        formDefineDao.save(formDefine);
    }

    public FormDefineEntity findOne(String id) {
        return formDefineDao.findOne(id);
    }

    public List<FormDefineEntity> findByName(String name, String sysCode) {
        return formDefineDao.findByName(name, sysCode);
    }

    public FormDefineEntity getFormDefine(String tdId){
        return formDefineDao.findOne(tdId);
    }


}
