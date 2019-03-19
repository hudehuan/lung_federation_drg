package com.dldata.drgs.controller.pages;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * Created by 王干一 on 2017-06-17.
 */
@Controller
@RequestMapping(value = "/V_SysShow")
public class V_SysShowController {
    @RequestMapping(value = "/toShowList")
    public String toShowList(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "DRG_39GSBZ";
    }
    @RequestMapping(value = "/toShowListFY")
    public String toShowListFY(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "FYZZYKZZB";
    }
    @RequestMapping(value = "/toShowListSSCZGCB")
    public String toShowListSSCZGCB(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "SSCZGCB";
    }
    @RequestMapping(value = "/toShowList34JSS")
    public String toShowList34JSS(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "34JSS";
    }
    @RequestMapping(value = "/toShowListYNZZ")
    public String toShowListYNZZ(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "YNZZ";
    }
    @RequestMapping(value = "/toShowListBZHSWL")
    public String toShowListBZHSWL(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "BZHSWL";
    }
    @RequestMapping(value = "/toShowListSJFY")
    public String toShowListSJFY(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "SJFY";
    }
    @RequestMapping(value = "/toShowListJHXL")
    public String toShowListJHXL(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "JHXL";
    }
    @RequestMapping(value = "/toShowListFDQK")
    public String toShowListFDQK(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "FDQK";
    }
    @RequestMapping(value = "/toShowListYYJXPJDFHZB")
    public String toShowListYYJXPJDFHZB(Model model){
        model.addAttribute("titlename","在线用户列表");
        return "YYJXPJDFHZB";
    }
}
