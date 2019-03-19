package com.dldata.drgs.service.drgsDicData;

import com.dldata.drgs.entity.DicYylbEntity;
import com.dldata.drgs.repository.drgsDicData.DicYylbDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Component
@Transactional
public class DicYylbService {

    @Autowired
    private DicYylbDao dicYylbDao;

    public List<DicYylbEntity> getAllData(){
        return dicYylbDao.getAllData();
    }

}
