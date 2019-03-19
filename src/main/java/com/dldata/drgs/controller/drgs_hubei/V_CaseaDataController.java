package com.dldata.drgs.controller.drgs_hubei;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.utils.SysConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

/**
 * Created by 吴岳峰 on 2017/09/13.
 */
@Controller
@RequestMapping("/hubei/V_CaseaData")
public class V_CaseaDataController {
    @Autowired
    SysUserInfoService sysUserInfoService;
    @RequestMapping(value = "/toHomePageCaseaData")
    public String toHomePageCaseaData(Model model, @CookieValue(value = "userid",defaultValue = "")String userid)throws Exception {
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userid, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);
        String biIp = prop.getProperty("HBIURL","");
        model.addAttribute("biqtuser",userInfoEntity.getLoginName());
        model.addAttribute("biIp",biIp);
        model.addAttribute("titlename","首页界面表");
        return "/drgs_hubei/home/casea_data";
    }

    @RequestMapping(value = "/toHomePageCaseaDataUp")
    public String toHomePageCaseaDataUp(Model model, @CookieValue(value = "userid",defaultValue = "")String userid)throws Exception {
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userid, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);
        String biIp = prop.getProperty("HBIURL","");
        model.addAttribute("biqtuser",userInfoEntity.getLoginName());
        model.addAttribute("biIp",biIp);
        model.addAttribute("titlename","首页界面表");
        return "/drgs_hubei/home/casea_data_up";
    }

    @RequestMapping(value = "/toHomePageCaseaDataUpDat")
    public String toHomePageCaseaDataUpDat(Model model,String fDate)throws Exception {
        model.addAttribute("fDate",fDate);

        return "/drgs_hubei/home/casea_data_upDat";
    }

}
