package com.dldata.drgs.controller.drgsDicData;

import com.dldata.drgs.entity.DicMdcEntity;
import com.dldata.drgs.service.drgsDicData.DicMdcService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Controller
@RequestMapping("/DicMdc")
public class DicMdcController {

    @Autowired
    private DicMdcService dicMdcService;

    @RequestMapping("/getList")
    @ResponseBody
    public List<DicMdcEntity> getList(String search){
        List<DicMdcEntity> dicMdcEntities = dicMdcService.findBySearchLike(search);
        return dicMdcEntities ;
    }

}
