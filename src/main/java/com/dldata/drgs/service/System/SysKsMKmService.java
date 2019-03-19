package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysKsMKmEntity;
import com.dldata.drgs.repository.System.SysKsMkmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2016/9/5.
 */
@Component
@Transactional
public class SysKsMKmService {
    @Autowired
    SysKsMkmDao sysKsMkmDao;

    public List<SysKsMKmEntity> getAllKsMKm(){return sysKsMkmDao.getAllKsMKm();}
}
