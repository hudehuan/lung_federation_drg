package com.dldata.drgs.controller.drgs_hubei.drgs05;

import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.utils.SysConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

/**
 * Created by 吴岳峰 on 2017/08/10.
 */
@Controller
@RequestMapping("/hubei/V_Drgs0501")
public class V_Drgs0501Controller {
    @Autowired
    SysUserInfoService sysUserInfoService;
    @RequestMapping("/toList")
    public String toList(Model model, @CookieValue(value = "userid",defaultValue = "")String userid,HttpSession session)throws Exception {
        SysUserInfoEntity userInfoEntity = sysUserInfoService.getUserInfoByUserID(userid, SysConfig.SysCode);
        InputStreamReader in = null;
        Properties prop=new Properties();
        in = new InputStreamReader(this.getClass().getResourceAsStream("/sysconfig.properties"));
        BufferedReader bf = new BufferedReader(in);
        prop.load(bf);
        String biIp = prop.getProperty("HBIURL","");
        String staffname = session.getAttribute("staffname").toString();
        model.addAttribute("biqtuser",userInfoEntity.getLoginName());
        model.addAttribute("biIp",biIp);
        model.addAttribute("staffname",staffname);
        return "/drgs_hubei/drgs05/v_drgs0501";
    }
}
