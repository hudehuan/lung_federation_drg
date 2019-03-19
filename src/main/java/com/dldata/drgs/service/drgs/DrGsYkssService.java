package com.dldata.drgs.service.drgs;

import com.dldata.drgs.entity.DrGsYkssEntity;
import com.dldata.drgs.repository.drgs.DrGsYkssDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Component
@Transactional
public class DrGsYkssService {

    @Autowired
    private DrGsYkssDao drGsYkssDao;

    public List<DrGsYkssEntity> findBySearch(String search){
        return drGsYkssDao.findBySearch("%"+search+"%");
    }

    public void save(DrGsYkssEntity s){
        drGsYkssDao.save(s);
    }

    public List<DrGsYkssEntity> getAll(){
        return drGsYkssDao.getAll();
    }

    public DrGsYkssEntity findOne(String id){
        return drGsYkssDao.findOne(id);
    }

    public void delete(String id){
        drGsYkssDao.delete(id);
    }
}
