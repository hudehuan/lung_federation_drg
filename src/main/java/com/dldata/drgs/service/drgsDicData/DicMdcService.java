package com.dldata.drgs.service.drgsDicData;


import com.dldata.drgs.entity.DicMdcEntity;
import com.dldata.drgs.repository.drgsDicData.DicCm3DefineDao;
import com.dldata.drgs.repository.drgsDicData.DicMdcDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Component
@Transactional
public class DicMdcService {


    @Autowired
    private DicMdcDao dicMdcDao;

    public List<DicMdcEntity> findBySearchLike(String search){
        return dicMdcDao.findBySearchLike("%"+search+"%");
    }
}
