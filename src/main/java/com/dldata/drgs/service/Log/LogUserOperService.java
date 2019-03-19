package com.dldata.drgs.service.Log;

import com.dldata.drgs.entity.LogUserOperEntity;
import com.dldata.drgs.repository.Log.LogUserOperDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 倪继文 on 2016/7/21.
 */
@Component
@Transactional
public class LogUserOperService {

    @Autowired
    LogUserOperDao logUserOperDao;

    public List<LogUserOperEntity> getAllLogUserOper() {
        List<LogUserOperEntity> logUserOperEntities = new ArrayList<LogUserOperEntity>();
        logUserOperEntities = logUserOperDao.getAllLogeUserOper();
        return logUserOperEntities;
    }

    public List<LogUserOperEntity> findByCondition(String condition) {
        List<LogUserOperEntity> logUserOperEntities = new ArrayList<LogUserOperEntity>();
        logUserOperEntities = logUserOperDao.findByCondition();
        return logUserOperEntities;
    }

    public void save(LogUserOperEntity logUserOperEntity) {
        logUserOperDao.save(logUserOperEntity);
    }
}
