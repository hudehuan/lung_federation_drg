package com.dldata.drgs.service.FormInput;

import com.dldata.drgs.entity.FormDefineValueEntity;
import com.dldata.drgs.repository.FormInput.FormDefineValueDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/9/2.
 */
@Component
@Transactional
public class FormDefineValueService {

    @Autowired
    FormDefineValueDao formDefineValueDao;


    public List<FormDefineValueEntity> getDefineValueByTableId(String tableId){
        return formDefineValueDao.getDefineValueByTableId(tableId);
    }

    public void save(FormDefineValueEntity entity){
        formDefineValueDao.save(entity);
    }

    public FormDefineValueEntity getDefineValue(String tvId){
        return formDefineValueDao.findOne(tvId);
    }

    public void deleteDefineValue(String tvId){
        formDefineValueDao.delete(tvId);
    }

    public List<FormDefineValueEntity> getDefineValueByTableIdDate(String tableId,String rq){
        return formDefineValueDao.getDefineValueByTableIdDate(tableId,rq);
    }


    public String getTvIdByRqAndTdId(String rq,String tdId){
        List<FormDefineValueEntity> formDefineValueEntityList  = formDefineValueDao.getDefineValueByTableIdDate(tdId,rq );
        if(formDefineValueEntityList.size()>0){
            return formDefineValueEntityList.get(0).getTvId();
        }
        else{
            return "";

        }
    }


    public List<FormDefineValueEntity> queryDefineValue(String tableId, String cxrqstart,String cxrqend){
        return formDefineValueDao.queryDefineValue(tableId, cxrqstart,cxrqend);
    }
}
