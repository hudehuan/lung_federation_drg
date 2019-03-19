package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysSystemDefineEntity;
import com.dldata.drgs.service.System.SysSystemDefineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysSystemDefine")
public class V_SysSystemDefineController {

    @Autowired
    SysSystemDefineService systemDefineService;


    @RequestMapping(value = "/gotoSystemDefine")
    public String gotoSystemDefine(Model model,HttpServletRequest request,HttpServletResponse response) {
        List<SysSystemDefineEntity> systemDefine = new ArrayList<SysSystemDefineEntity>();
        systemDefine = systemDefineService.getAllSystem();
        if (systemDefine.size() >0 ) {
            model.addAttribute("systemDefine",systemDefine);
        }
        return "System/SysSystemDefine";
    }
}
