package com.dldata.drgs.service.Table;

import com.dldata.drgs.entity.TabDefineEntity;
import com.dldata.drgs.repository.Table.TabDefineDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/2.
 */

@Component
//@Transactional
public class TabDefineService {


    @Autowired
    TabDefineDAO tabDefineDAO;


    public List<TabDefineEntity> list(String sysCode){
        return tabDefineDAO.getAll(sysCode);
    }


    public void save(TabDefineEntity entity){
        tabDefineDAO.save(entity);
    }

    public TabDefineEntity getEntityByID(String id){
        TabDefineEntity entity = tabDefineDAO.findOne(id);

        return entity;
    }

    public List<TabDefineEntity> findByCondition(String condition, String sysCode) {
        return tabDefineDAO.findByCondition(condition, sysCode);
    }

    public List<TabDefineEntity> findByName(String name, String sysCode) {
        return tabDefineDAO.findByName(name, sysCode);
    }



    public TabDefineEntity getEntityByTableId(String tableId){
        return tabDefineDAO.findOne(tableId);
    }
}
