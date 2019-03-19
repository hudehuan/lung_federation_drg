package com.dldata.drgs.service.Log;

import com.dldata.drgs.entity.LogUserLoginEntity;
import com.dldata.drgs.repository.Log.LogUserLoginDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class LogUserLoginService {


    @Autowired
    private LogUserLoginDao logUserLoginDao;

    public void save(LogUserLoginEntity entity){

        logUserLoginDao.save(entity);

    }

    public List<LogUserLoginEntity> getAllLogUserLogin() {
        return logUserLoginDao.getAllLogUserLogin();
    }

    public List<LogUserLoginEntity> findByCondition(String condition,Timestamp sTime, Timestamp eTime) {
        return logUserLoginDao.findByCondition(condition,sTime,eTime);
    }
}
