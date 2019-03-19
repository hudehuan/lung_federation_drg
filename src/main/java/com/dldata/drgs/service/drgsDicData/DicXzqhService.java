package com.dldata.drgs.service.drgsDicData;

import com.dldata.drgs.entity.DicXzqhEntity;
import com.dldata.drgs.repository.drgsDicData.DicXzqhDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Component
@Transactional
public class DicXzqhService {

    @Autowired
    private DicXzqhDao dicXzqhDao;

    public List<DicXzqhEntity> getAllData(){
        return dicXzqhDao.getAllData();
    }

}
