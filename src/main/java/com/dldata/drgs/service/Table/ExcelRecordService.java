package com.dldata.drgs.service.Table;


import com.dldata.drgs.entity.TabDefineEntity;
import com.dldata.drgs.entity.TabImportRecordEntity;
import com.dldata.drgs.repository.Table.ExcelImportRecordDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/8/31.
 */
@Component
@Transactional
public class ExcelRecordService {



    @Autowired
    ExcelImportRecordDao excelImportRecordDao;

    @Autowired
    TabDefineService tabDefineService;
    @Autowired
    JdbcTemplate jdbcTemplate;


    public List<TabImportRecordEntity> getRecordByTableId(String tableId){
        return excelImportRecordDao.getRecodeByTableId(tableId);
    }

    public List<TabImportRecordEntity> getRecordByTableIdBytime(String tableId , Timestamp startTime,Timestamp endTime){
        return excelImportRecordDao.getRecordByTableIdBytime(tableId, startTime, endTime);
    }


    public void save(TabImportRecordEntity entity){
        excelImportRecordDao.save(entity);

    }

    public TabImportRecordEntity findOne(String recordId){
        return excelImportRecordDao.findOne(recordId);
    }

    public void deleteOne(TabImportRecordEntity entity){
        excelImportRecordDao.delete(entity);
    }


    public List<TabImportRecordEntity> checkByInputDateTableId(Timestamp inputDate,String tableId){
        return excelImportRecordDao.checkByInputDateTableId(inputDate, tableId);
    }


    public void deleteByInputDateTableId(Timestamp inputDate,String tableId){
        List<TabImportRecordEntity> tabImportRecordEntityList = excelImportRecordDao.checkByInputDateTableId(inputDate, tableId);
        excelImportRecordDao.delete(tabImportRecordEntityList);


        TabDefineEntity tabDefineEntity = tabDefineService.getEntityByTableId(tableId);
        //if(tabImportRecordEntityList.size()>0){
        for(TabImportRecordEntity entity :tabImportRecordEntityList) {
            //TabImportRecordEntity entity = tabImportRecordEntityList.get(0);
            String recordId = entity.getId();


            String sql = "delete from " + tabDefineEntity.getName() + " where record_id='" + recordId + "'";
            jdbcTemplate.execute(sql);
        }
        //}

    }



}
