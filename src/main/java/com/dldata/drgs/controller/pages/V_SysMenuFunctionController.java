package com.dldata.drgs.controller.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysMenuFunction")
public class V_SysMenuFunctionController {
    @RequestMapping("/toList")
    public String toSele(){
        return "System/SysFunction";
    }

    @RequestMapping("/toSeleList")
    public String toSeleList(){
        return "System/SysFunctionSele";
    }

//    @RequestMapping("/addFunction")
//    public String addFunction(){
//        return "System/SysFunctionEdit";
//
//    }


    @RequestMapping("/toEdit")
    public String toEdit(String id){
        return "System/SysFunctionEdit";
    }


}
