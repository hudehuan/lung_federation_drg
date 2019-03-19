package com.dldata.drgs.controller.drgs_hubei;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.utils.SysConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

/**
 * Created by 吴岳峰 on 2017/11/15.
 */
@Controller
@RequestMapping(value = "/hubei/V_hospitalCon")
public class V_hospitalConController {
    @Autowired
    SysUserInfoService sysUserInfoService;

    @RequestMapping(value = "/toHospitalCon/{conUrl}")
    public String toHospitalCon(Model model,String treeData,
                                  @PathVariable("conUrl") String conUrl,
                                  @CookieValue(value = "userid",defaultValue = "")String userid)throws Exception {
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
        model.addAttribute("treeData",treeData);
        return "/drgs_hubei/hospitalCon/"+conUrl;
    }
}
