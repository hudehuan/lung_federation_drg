package com.dldata.drgs.service.FormDefine;

import com.dldata.drgs.entity.FormDefineFieldEntity;
import com.dldata.drgs.repository.FormDefine.FormDefineFieldDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2016/8/12.
 */
@Component
@Transactional
public class FormDefineFieldService {
    @Autowired
    FormDefineFieldDao formDefineFieldDao;
    public List<FormDefineFieldEntity> getAllFormDefineField(String tdId) {

        return formDefineFieldDao.getAllFormDefineField(tdId);
    }

    public void save(FormDefineFieldEntity formDefineField) {
        formDefineFieldDao.save(formDefineField);
    }

    public FormDefineFieldEntity findOne(String id) {
        return formDefineFieldDao.findOne(id);
    }

    public void update(FormDefineFieldEntity formDefineField) {
        formDefineFieldDao.save(formDefineField);
    }

    public int getColumnXH(String tdId){

        List<FormDefineFieldEntity> entities = new ArrayList<FormDefineFieldEntity>();
        entities = formDefineFieldDao.getMaxXH(tdId);
        if(entities.size()>0){
            return entities.get(0).getXh()+1;
        }
        else{
            return 1;
        }

    }

    public List<FormDefineFieldEntity> findByfdName(String name) {
        return formDefineFieldDao.findByfdName(name);
    }

    public List<FormDefineFieldEntity> getFormDefineFieldList(String tdId){
        return formDefineFieldDao.getFormDefineFieldList(tdId);
    }


}
