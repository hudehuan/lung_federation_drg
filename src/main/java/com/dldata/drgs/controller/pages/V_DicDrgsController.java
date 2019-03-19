package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Controller
@RequestMapping("/V_DicDrgs")
public class V_DicDrgsController {

    @RequestMapping("/toList")
    public String toList(){
        return "/drgsDicData/V_DicDrgs";
    }

}
