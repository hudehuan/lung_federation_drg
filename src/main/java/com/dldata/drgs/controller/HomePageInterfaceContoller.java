package com.dldata.drgs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 倪继文 on 2016/12/7.
 */
@Controller
@RequestMapping("/HomePageInterface")
public class HomePageInterfaceContoller {

    @RequestMapping(value = "/home/{userHome}")
    public String goHome(@PathVariable("userHome") String userHome){
        return "/home/"+userHome;
    }

}
