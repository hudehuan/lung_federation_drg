package com.dldata.drgs.repository.common;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by zhangyy on 2017-05-18.
 */
@Transactional
@Repository("zyJdbcTemplate")
public class ZyJdbcTemplate extends JdbcTemplate {

    @Resource(name="jdbcTemplate")
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        setDataSource(jdbcTemplate.getDataSource());
    }
}
