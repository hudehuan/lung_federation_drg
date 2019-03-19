package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.CustomFormEntity;
import com.dldata.drgs.entity.SjsbFormStepCheckListEntity;
import com.dldata.drgs.service.customform.CustomFormService;
import com.dldata.drgs.service.customform.SjsbFormStepCheckListService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 吴岳峰 on 2017/6/2.
 */
@Controller
@RequestMapping(value = "/CustomFormIndex")
public class CustomFormIndexController {

    @Autowired
    private SjsbFormStepCheckListService sjsbFormStepCheckListService;

    @Autowired
    private CustomFormService customFormService;

    @RequestMapping("/getPie")
    @ResponseBody
    public String getPie(String startTime,String endTime,
                         @CookieValue(value = "userid", defaultValue = "") String userId){
        Timestamp sTime = Timestamp.valueOf(startTime+" 00:00:00");
        Timestamp eTime = Timestamp.valueOf(endTime+" 23:59:59");
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = sjsbFormStepCheckListService.getCheckListByUserIDTime(userId, sTime, eTime);

        List<CustomFormEntity> customFormEntities =customFormService.getAllTypeForm();
//                customFormService.getAllForm(SysConfig.SysCode);
        List<Map<String,Object>> mapList = new ArrayList<>();
        customFormEntities.forEach(f -> {
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("num",0);
            sjsbFormStepCheckListEntities.stream().filter(l -> l.getFormId().equals(f.getId())).forEach(l -> {
                map.put("name",l.getFormName());
                map.put("num",(int)map.get("num")+1);
            });
            sjsbFormStepCheckListEntities.stream().filter(l -> l.getFormId().equals(f.getId())).limit(1).forEach(l -> {
                mapList.add(map);
            });

        });
        return mapList.size() > 0 ? JSONArray.fromObject(mapList).toString() : "[]";

    }

    @RequestMapping("/getBar")
    @ResponseBody
    public String getBar(String year,
                         @CookieValue(value = "userid", defaultValue = "") String userId){

        Timestamp sTime = Timestamp.valueOf(year+"-01-01 00:00:00");
        Timestamp eTime = Timestamp.valueOf(year+"-12-31 23:59:59");
        List<SjsbFormStepCheckListEntity> sjsbFormStepCheckListEntities = sjsbFormStepCheckListService.getCheckListByUserIDTime(userId, sTime, eTime);
        List<Map<String,Object>> mapList = new ArrayList<>();
        int i = 0;
        for(int a = 1;a<13;a++) {
            Map<String, Object> map = new HashMap<String, Object>();
            String month = a+"";
            if (a < 10) {
                month = "0" + a;
            }
            map.put("time",month);
            map.put("num", 0);
            sjsbFormStepCheckListEntities.stream().filter(l -> l.getInputTime().toString().substring(5,7).equals(map.get("time"))).forEach(l -> {
                map.put("num", (int) map.get("num") + 1);
            });
            mapList.add(map);
        }
        return mapList.size() > 0 ? JSONArray.fromObject(mapList).toString() : "[]";

    }


}
