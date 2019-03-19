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
 * Created by 吴岳峰 on 2017/08/18.
 */
@Controller
@RequestMapping("/hubei/V_basyIndex")
public class V_basyIndexController {

    @Autowired
    SysUserInfoService sysUserInfoService;

    @RequestMapping("/toBasyIndex")
    public String toBasyIndex(Model model,String bah,
                              @CookieValue(value = "userid",defaultValue = "")String userid)throws Exception {
//        layeropen(0.85*width,height-50,'模板文件导入','/test/test');
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userid, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);
        String biIp = prop.getProperty("HBIURL","");
        model.addAttribute("biqtuser",userInfoEntity.getLoginName());
        model.addAttribute("biIp",biIp);
        model.addAttribute("bah",bah);
        return "/drgs_hubei/v_BasyIndex";
    }

}
