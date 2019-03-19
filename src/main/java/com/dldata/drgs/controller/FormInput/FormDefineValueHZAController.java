package com.dldata.drgs.controller.FormInput;

import com.dldata.drgs.entity.FormDefineEntity;
import com.dldata.drgs.entity.FormDefineValueEntity;
import com.dldata.drgs.service.FormDefine.FormDefineFieldService;
import com.dldata.drgs.service.FormDefine.FormDefineService;
import com.dldata.drgs.service.FormInput.FormDefineFieldValueService;
import com.dldata.drgs.service.FormInput.FormDefineValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

/**
 * Created by 倪继文 on 2016/9/7.
 */
@Controller
@RequestMapping(value = "/FormDefineValuehza")
public class FormDefineValueHZAController {

    @Autowired
    FormDefineValueService formDefineValueService;

    @Autowired
    FormDefineFieldService formDefineFieldService;

    @Autowired
    FormDefineFieldValueService formDefineFieldValueService;
    @Autowired
    FormDefineService formDefineService;

    @RequestMapping(value = "/toList")
    public String toList(@RequestParam("GUID") String tableId,Model model){
        model.addAttribute("tableId",tableId);
        SimpleDateFormat formatter_day  = new SimpleDateFormat ("yyyy-MM-dd");

        java.util.Calendar calendar = java.util.Calendar.getInstance();
        int yearend = calendar.get(Calendar.YEAR);
        int yearstart = yearend-5;

        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
        String month_frist_day = formatter_day.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        String month_last_day = formatter_day.format(calendar.getTime());


        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tableId);
        if(formDefineEntity.getDatetype().equals("年")){

            model.addAttribute("dateFmt","yyyy");
            model.addAttribute("starttime",String.valueOf(yearstart));
            model.addAttribute("startend",String.valueOf(yearend));
        }
        else if(formDefineEntity.getDatetype().equals("季")){
            model.addAttribute("dateFmt","yyyy-MM季");
            model.addAttribute("starttime", String.valueOf(yearend)+"-01"+"季");
            model.addAttribute("startend",String.valueOf(yearend)+"-04"+"季");
        }
        else if(formDefineEntity.getDatetype().equals("月")){
            model.addAttribute("dateFmt","yyyy-MM");
            model.addAttribute("starttime",yearend+"-01");
            model.addAttribute("startend",yearend+"-12");
        }
        else if(formDefineEntity.getDatetype().equals("日")){
            model.addAttribute("dateFmt","yyyy-MM-dd");
            model.addAttribute("starttime",month_frist_day);
            model.addAttribute("startend",month_last_day);
        }
        return "FormInput/FormDefineValueHZA";
    }

    @RequestMapping(value = "/getDefineValue")
    @ResponseBody
    public List<FormDefineValueEntity> getDefineValue(@RequestParam("tableId") String tableId){

        return formDefineValueService.getDefineValueByTableId(tableId);

    }

}