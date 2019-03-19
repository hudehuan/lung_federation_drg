package com.dldata.drgs.controller.drgs_hubei;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/09/18.
 */
@Controller
@RequestMapping("/hubei/V_DrgsJgData")
public class V_DrgsJgDataController {

    @RequestMapping("/toJgData")
    public String toJgData(Model model,String hospital,String year,String kstj, String mdctj,String yhqx,String rqkj){
        model.addAttribute("kstj",kstj);
        model.addAttribute("mdctj",mdctj);
        model.addAttribute("hospital",hospital);
        model.addAttribute("year",year);
        model.addAttribute("yhqx",yhqx);
        model.addAttribute("rqkj",rqkj);
        return "/drgs_hubei/drgs/v_drgsJgData";
    }
}
