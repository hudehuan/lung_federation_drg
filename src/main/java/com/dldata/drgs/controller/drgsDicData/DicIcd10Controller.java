package com.dldata.drgs.controller.drgsDicData;


import com.dldata.drgs.entity.DicIcd10Entity;
import com.dldata.drgs.service.drgsDicData.DicIcd10Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Controller
@RequestMapping("/DicIcd10")
public class DicIcd10Controller {

    @Autowired
    private DicIcd10Service dicIcd10Service;

    @RequestMapping("/getList")
    @ResponseBody
    public List<DicIcd10Entity> getList(@RequestParam(value = "q",defaultValue = "") String q){
        List<DicIcd10Entity> dicIcd10Entities = dicIcd10Service.findBySearchLike(q);
        return dicIcd10Entities.stream().limit(500).collect(Collectors.toList());
    }

}
