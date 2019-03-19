package com.dldata.drgs.service.System;

import com.dldata.drgs.entity.SysHospitalBranchEntity;
import com.dldata.drgs.repository.System.SysHospitalBranchDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class SysHospitalBranchService {

    @Autowired
    SysHospitalBranchDao hospitalBranchDao;


    public List<SysHospitalBranchEntity> getAllHospitalBranch() {
        return hospitalBranchDao.getAllHospitalBranch();
    }

    public void save(SysHospitalBranchEntity hospitalBranch) {
        hospitalBranchDao.save(hospitalBranch);
    }

    public SysHospitalBranchEntity findOne(String id) {
        return hospitalBranchDao.findOne(id);
    }

    public void update(SysHospitalBranchEntity hospitalBranch) {
        hospitalBranchDao.save(hospitalBranch);
    }

    public List<SysHospitalBranchEntity> findByName(String name) {
        return hospitalBranchDao.findByName(name);
    }

    public List<SysHospitalBranchEntity> findOneByCode(String code) {
        return hospitalBranchDao.findOneByCode(code);
    }
}
