package com.dldata.drgs.service.FormDefine;

import com.dldata.drgs.entity.FormItemEntity;
import com.dldata.drgs.repository.FormDefine.FormItemDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Component
@Transactional
public class FormItemService {


    @Autowired
    FormItemDao formItemDao;

    public List<FormItemEntity> getAllFormItem(String typeId, String sysCode) {
        return formItemDao.getAllFormItem(typeId, sysCode);
    }


    public void save(FormItemEntity formItem) {
        formItemDao.save(formItem);
    }

    public void update(FormItemEntity formItem) {
        formItemDao.save(formItem);
    }

    public FormItemEntity findOne(String id) {
       return formItemDao.findOne(id);
    }
    public int getColumnXH(String typeId){

        List<FormItemEntity> entities = new ArrayList<FormItemEntity>();
        entities = formItemDao.getMaxXH(typeId);
        if(entities.size()>0){
            return entities.get(0).getXh()+1;
        }
        else{
            return 1;
        }
    }
}
