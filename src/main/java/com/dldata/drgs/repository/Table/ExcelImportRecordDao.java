package com.dldata.drgs.repository.Table;

import com.dldata.drgs.entity.TabImportRecordEntity;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/9/9.
 */
public interface ExcelImportRecordDao extends PagingAndSortingRepository<TabImportRecordEntity,String>,JpaSpecificationExecutor<TabImportRecordEntity> {

    @Query("select i from TabImportRecordEntity i where i.tableId=?1 order by i.inputDate")
    public List<TabImportRecordEntity> getRecodeByTableId(String tableId);

    @Query("select i from TabImportRecordEntity i where i.tableId=?1 and i.inputDate>=?2 and i.inputDate<=?3 order by i.inputDate")
    public List<TabImportRecordEntity> getRecordByTableIdBytime(String tableId, Timestamp startTime,Timestamp endTime);


    @Query("select i from TabImportRecordEntity i where i.inputDate=?1 and i.tableId=?2")
    public List<TabImportRecordEntity> checkByInputDateTableId(Timestamp inputDate,String tableId);





}
