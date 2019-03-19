package com.dldata.drgs.service.drgsDicData;


import com.dldata.drgs.entity.DicIcd10Entity;
import com.dldata.drgs.repository.drgsDicData.DicIcd10Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Component
@Transactional
public class DicIcd10Service {

    @Autowired
    private DicIcd10Dao dicIcd10Dao;

    public List<DicIcd10Entity> findBySearchLike(String search){
        return dicIcd10Dao.findBySearchLike("%"+search+"%");

    }
}
