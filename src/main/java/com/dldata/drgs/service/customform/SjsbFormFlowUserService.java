package com.dldata.drgs.service.customform;

import com.dldata.drgs.repository.customform.SjsbFormFlowUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by admin on 2016/11/11.
 */
@Component
@Transactional
public class SjsbFormFlowUserService {

    @Autowired
    private SjsbFormFlowUserDao sjsbFormFlowUserDao;
}
