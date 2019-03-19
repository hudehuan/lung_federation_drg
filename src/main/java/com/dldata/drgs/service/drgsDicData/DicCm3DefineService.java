package com.dldata.drgs.service.drgsDicData;


import com.dldata.drgs.entity.DicCm3DefineEntity;
import com.dldata.drgs.repository.drgsDicData.DicCm3DefineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Component
@Transactional
public class DicCm3DefineService {

    @Autowired
    private DicCm3DefineDao dicCm3DefineDao;

    public List<DicCm3DefineEntity> findBeSearchLike(String search){
        return dicCm3DefineDao.findBeSearchLike("%"+search+"%");
    }

    public List<DicCm3DefineEntity> findOneByCode(String code){
        return dicCm3DefineDao.findOneByCode(code);
    }

    public void save(DicCm3DefineEntity e){
        dicCm3DefineDao.save(e);
    }

    public void delete(String id){
        dicCm3DefineDao.delete(id);
    }

}
