package com.dldata.drgs.service.FormInput;

import com.dldata.drgs.entity.FormDefineFieldValueEntity;
import com.dldata.drgs.repository.FormInput.FormDefineFieldValueDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/9/2.
 */

@Component
@Transactional
public class FormDefineFieldValueService {

    @Autowired
    FormDefineFieldValueDao formDefineFieldValueDao;

    public List<FormDefineFieldValueEntity> getDefineFieldValue(String tvId){
        return formDefineFieldValueDao.getDefineFieldValue(tvId);
    }

    public List<FormDefineFieldValueEntity> getDefineFieldValueByTdId(String tdId){
        return formDefineFieldValueDao.getDefineFieldValueByTdId(tdId);
    }

    public void save(FormDefineFieldValueEntity entity){
        formDefineFieldValueDao.save(entity);
    }

    public void deleteFormDefineFieldValue(List<FormDefineFieldValueEntity> entities){
        formDefineFieldValueDao.delete(entities);
    }

    public String getByTvIdFdIdWdm(String tvId,String fdId,String wdm){
        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = formDefineFieldValueDao.getByTvIdFdIdWdm(tvId, fdId, wdm);
        if(formDefineFieldValueEntityList.size()>0){
            return formDefineFieldValueEntityList.get(0).getFvId();
        }else{
            return "";
        }
    }

    public List<FormDefineFieldValueEntity> getByTvIdWdm(String tvId,String wdm){
        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = formDefineFieldValueDao.getByTvIdWdm(tvId, wdm);

        return formDefineFieldValueEntityList;
    }

    public List<FormDefineFieldValueEntity> queryDefineFieldValue(String tableId, String cxrqstart,String cxrqend){
        List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = formDefineFieldValueDao.queryDefineFieldValue(tableId, cxrqstart,cxrqend);

        return formDefineFieldValueEntityList;
    }
}
