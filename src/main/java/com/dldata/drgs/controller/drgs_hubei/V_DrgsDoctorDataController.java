package com.dldata.drgs.controller.drgs_hubei;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/09/18.
 */
@Controller
@RequestMapping("/hubei/V_DrgsDoctorData")
public class V_DrgsDoctorDataController {

    @RequestMapping("/toDoctorData")
    public String toJgData(Model model,String hospital,String year,String kemu,String mdctj,String yhqx,String rqkj){
        model.addAttribute("hospital",hospital);
        model.addAttribute("year",year);
        model.addAttribute("kemu",kemu);
        model.addAttribute("mdctj",mdctj);
        model.addAttribute("yhqx",yhqx);
        model.addAttribute("rqkj",rqkj);
        return "/drgs_hubei/drgs/v_drgsDoctorData";
    }
}
