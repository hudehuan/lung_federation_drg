package com.dldata.drgs.service.drgs;

import com.dldata.drgs.entity.DrGsYkssZedEntity;
import com.dldata.drgs.repository.drgs.DrGsYkssZedDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Component
@Transactional
public class DrGsYkssZedService {

    @Autowired
    private DrGsYkssZedDao drGsYkssZedDao;

    public List<DrGsYkssZedEntity> getAll(){
        return drGsYkssZedDao.getAll();
    }

    public List<DrGsYkssZedEntity> findByYkId(String ykId){
        return drGsYkssZedDao.findByYkId(ykId);
    }

    public DrGsYkssZedEntity findOne(String id) {
        return drGsYkssZedDao.findOne(id);
    }

    public void delete(String id){
        drGsYkssZedDao.delete(id);
    }

    public void save(DrGsYkssZedEntity s){
        drGsYkssZedDao.save(s);
    }
}
