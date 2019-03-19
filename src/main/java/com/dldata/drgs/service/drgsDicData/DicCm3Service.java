package com.dldata.drgs.service.drgsDicData;


import com.dldata.drgs.entity.DicCm3Entity;
import com.dldata.drgs.repository.drgsDicData.DicCm3Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Component
@Transactional
public class DicCm3Service {

    @Autowired
    private DicCm3Dao dicCm3Dao;

    public List<DicCm3Entity> findBySearchLike(String search){
        return dicCm3Dao.findBySearchLike("%"+search+"%");

    }

}
