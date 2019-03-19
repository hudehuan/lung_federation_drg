package com.dldata.drgs.controller.drgs_hubei.drgs01;

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
 * Created by 吴岳峰 on 2017/10/18.
 */
@Controller
@RequestMapping("/hubei/V_Drgs0104")
public class V_Drgs0104Controller {
    @Autowired
    SysUserInfoService sysUserInfoService;
    @RequestMapping("/toList")
    public String toList(Model model, @CookieValue(value = "userid",defaultValue = "")String userid,
                         String dateTime,String bivar,String kstj,String yydm)throws Exception {
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userid, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);
        String biIp = prop.getProperty("HBIURL","");
        model.addAttribute("biqtuser",userInfoEntity.getLoginName());
        model.addAttribute("biIp",biIp);
        model.addAttribute("dateTime",dateTime);
        model.addAttribute("bivar",bivar);
        model.addAttribute("kstj",kstj);
        model.addAttribute("yydm",yydm);
        return "/drgs_hubei/drgs01/v_drgs0104";
    }
}
