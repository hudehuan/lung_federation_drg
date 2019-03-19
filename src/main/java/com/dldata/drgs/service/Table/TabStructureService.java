package com.dldata.drgs.service.Table;

import com.dldata.drgs.entity.TabStructureEntity;
import com.dldata.drgs.repository.Table.TabStructureDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2016/8/3.
 */

@Component
public class TabStructureService {

    @Autowired
    TabStructureDAO tabStructureDAO;


    public List<TabStructureEntity> getStrucByTableID(String tableid){

        List<TabStructureEntity> entities = new ArrayList<TabStructureEntity>();

        entities = tabStructureDAO.getTabStrucOfTabID(tableid);

        return entities;
    }


    public void save(TabStructureEntity entity){
        tabStructureDAO.save(entity);
    }

    public TabStructureEntity findOne(String id){
        TabStructureEntity entity = tabStructureDAO.findOne(id);

        return  entity;
    }

    public Integer getColumnXH(String tableid){

        List<Integer> xhs = new ArrayList<Integer>();
        xhs = tabStructureDAO.getMaxXH(tableid);
        if(xhs.size()>0){
            return xhs.get(0)+1;
        }
        else{
            return 0;
        }

    }

    public List<TabStructureEntity> findByName(String name) {
        return tabStructureDAO.findByName(name);
    }





    public List<TabStructureEntity> getStructure(String tableId){

        return tabStructureDAO.getStructure(tableId);
    }

}
