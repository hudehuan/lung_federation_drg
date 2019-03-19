package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.DicJgdmEntity;
import com.dldata.drgs.repository.drgsDicData.DicJgdmDao;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Controller
@RequestMapping("/V_DicJgdm")
public class V_DicJgdmController {

    @Autowired
    private DicJgdmService dicJgdmService;

    @RequestMapping("/toList")
    public String toList(){
        return "/drgsDicData/v_dicJgdm";
    }


    @RequestMapping("/toEdit")
    public String toEdit(String dm, Model model){
        if(dm!=null&&!dm.equals("")){
            DicJgdmEntity dicJgdmEntity = dicJgdmService.findOne(dm);
            model.addAttribute("entity",dicJgdmEntity);
        }
        return "/drgsDicData/v_dicJgdmEdit";
    }
}
