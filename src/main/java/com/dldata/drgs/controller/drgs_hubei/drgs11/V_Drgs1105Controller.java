package com.dldata.drgs.controller.drgs_hubei.drgs11;

import com.dldata.drgs.entity.DrGsYkssEntity;
import com.dldata.drgs.entity.DrGsYkssZedEntity;
import com.dldata.drgs.service.drgs.DrGsYkssService;
import com.dldata.drgs.service.drgs.DrGsYkssZedService;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Controller
@RequestMapping("/hubei/V_Drgs1105")
public class V_Drgs1105Controller {

    @Autowired
    private DrGsYkssService drGsYkssService;
    @Autowired
    private DrGsYkssZedService drGsYkssZedService;

    @RequestMapping("/toList")
    public String toList(Model model){
        return "/drgs_hubei/drgs11/v_drgs1105";
    }

    @RequestMapping("/toEdit")
    public String toEdit(Model model,String id ){
        if(!StringUtil.isNullOrSpace(id)){
            DrGsYkssEntity drGsYkssEntity = drGsYkssService.findOne(id);
            model.addAttribute("entity",drGsYkssEntity);
        }
        return "/drgs_hubei/drgs11/v_drgs1105_1";
    }

    @RequestMapping("/to_2List")
    public String to_2List(Model model,String id ){
            model.addAttribute("ykid",id);
        return "/drgs_hubei/drgs11/v_drgs1105_2";
    }

    @RequestMapping("/to_3Edit")
    public String to_3Edit(Model model,String id ,String ykid){
        model.addAttribute("ykid",ykid);
        if(!StringUtil.isNullOrSpace(id)){
            DrGsYkssZedEntity drGsYkssZedEntity = drGsYkssZedService.findOne(id);
            model.addAttribute("entity",drGsYkssZedEntity);
        }
        return "/drgs_hubei/drgs11/v_drgs1105_3";
    }
}
