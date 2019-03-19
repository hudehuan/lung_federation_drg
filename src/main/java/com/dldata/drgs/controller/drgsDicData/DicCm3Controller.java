package com.dldata.drgs.controller.drgsDicData;


import com.dldata.drgs.entity.DicCm3Entity;
import com.dldata.drgs.service.drgsDicData.DicCm3Service;
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
@RequestMapping("/DicCm3")
public class DicCm3Controller {

    @Autowired
    private DicCm3Service dicCm3Service;

    @RequestMapping("/getList")
    @ResponseBody
    public List<DicCm3Entity> getList(@RequestParam(value = "q",defaultValue = "") String q){
        List<DicCm3Entity> dicCm3Entities = dicCm3Service.findBySearchLike(q);
        return dicCm3Entities.stream().limit(500).collect(Collectors.toList());
    }
}
