package com.dldata.drgs.service.drgsDicData;

import com.dldata.drgs.entity.DicIcd10DefineEntity;
import com.dldata.drgs.repository.drgsDicData.DicIcd10DefineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */

@Component
@Transactional
public class DicIcd10DefineService {

    @Autowired
    private DicIcd10DefineDao dicIcd10DefineDao;

    public List<DicIcd10DefineEntity> findBeSearchLike(String search){
        return dicIcd10DefineDao.findBeSearchLike("%"+search+"%");
    }

    public List<DicIcd10DefineEntity> findOneByCode(String code){
        return dicIcd10DefineDao.findOneByCode(code);
    }

    public void save(DicIcd10DefineEntity e){
        dicIcd10DefineDao.save(e);
    }

    public void delete(String id){
        dicIcd10DefineDao.delete(id);
    }

}
