package com.dldata.drgs.service.drgsDicData;


import com.dldata.drgs.entity.DicDrgsEntity;
import com.dldata.drgs.repository.drgsDicData.DicDrgsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Component
@Transactional
public class DicDrgsService {

    @Autowired
    private DicDrgsDao dicDrgsDao;

    public List<DicDrgsEntity> findByDmLikeBefore(String dm){
        return dicDrgsDao.findByDmLikeBefore(dm+"%");
    }
}
