package com.dldata.drgs.controller.drgsDicData;

import com.dldata.drgs.entity.DicDrgsEntity;
import com.dldata.drgs.service.drgsDicData.DicDrgsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Controller
@RequestMapping("/DicDrgs")
public class DicDrgsController {

    @Autowired
    private DicDrgsService dicDrgsService;

    @RequestMapping("/findByMdc")
    @ResponseBody
    public List<DicDrgsEntity> findByMdc(String dm){
        List<DicDrgsEntity> dicDrgsEntities = new ArrayList<DicDrgsEntity>();
        if(dm!=null&&!dm.equals("")){
            dicDrgsEntities = dicDrgsService.findByDmLikeBefore(dm.substring(dm.length()-1,dm.length()));
        }
        return dicDrgsEntities;
    }

    @RequestMapping("/findByDmLike3")
    @ResponseBody
    public List<DicDrgsEntity> findByDmLike3(String dm){
        List<DicDrgsEntity> dicDrgsEntities = new ArrayList<DicDrgsEntity>();
        if(dm!=null&&!dm.equals("")){
            dicDrgsEntities = dicDrgsService.findByDmLikeBefore(dm.substring(0,3));
        }
        return dicDrgsEntities;
    }
}
