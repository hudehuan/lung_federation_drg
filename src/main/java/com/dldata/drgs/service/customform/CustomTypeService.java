package com.dldata.drgs.service.customform;

//import com.dldata.drgs.repository.customform.CustomFormTypeDao;
import com.dldata.drgs.entity.CustomTypeEntity;
import com.dldata.drgs.repository.customform.CustomTypeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2017/4/21.
 */

@Component
@Transactional
public class CustomTypeService {


    @Autowired
    private CustomTypeDao customTypeDao;


    public List<CustomTypeEntity> getAllCustomType(){
        return customTypeDao.getAllCustomType();
    }


    public CustomTypeEntity findOne(String typeId){
        return customTypeDao.findOne(typeId);
    }


    public  List<CustomTypeEntity> findByName(String name){
        return customTypeDao.findByName(name);
    }

    public void save(CustomTypeEntity customTypeEntity){
        customTypeDao.save(customTypeEntity);
    }
}
