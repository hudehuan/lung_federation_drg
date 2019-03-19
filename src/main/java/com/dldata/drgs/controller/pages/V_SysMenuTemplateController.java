package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysMenuTemplate")
public class V_SysMenuTemplateController {

    @RequestMapping("/selectMenu")
    public String selectMenu(){
        return "System/SysFunctionMenuTemplateSele";
    }


    @RequestMapping("/toSysFunctionMenuView")
    public String toSysFunctionMenuView(String id){
        return "System/SysFunctionMenuView";
    }

    @RequestMapping("/toMenuList")
    public String toMenuList(){
        return "System/SysFunctionMenuTemplate";
    }

    @RequestMapping("/toSaveMune")
    public String toSaveMune(String id){
        return "System/SysFunctionSaveMune";
    }




}
