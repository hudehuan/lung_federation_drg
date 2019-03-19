package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysKsWorkstationEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysKeShiWorkStationService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_SysKeShiWorkStation")
public class V_SysKeShiWorkStationController {

    @Autowired
    SysKeShiWorkStationService sysKeShiWorkStationService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;

    @RequestMapping(value="/gotoKsWorkStation")
    public String gotoSysKeShiWorkStation(@CookieValue(value = "userid",defaultValue = "") String userid,
                                          @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                                          @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                                          Model model,HttpServletRequest request,HttpServletResponse response) {
        //ModelAndView mode = new ModelAndView();
        model.addAttribute("titlename", "科室工作站");
        //mode.setViewName("System/SysKeShiWorkStation");
        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "System/SysKeShiWorkStation";
    }


    @RequestMapping(value = "/toEdit")
    public String toEdit(String id,Model model) {
        if(id!=null&&!id.equals("")){
            SysKsWorkstationEntity ksWsEntity = sysKeShiWorkStationService.findOne(id);
            if (ksWsEntity != null) {
                model.addAttribute("ksWsEntity",ksWsEntity);
            }
        }

        return "System/SysKeShiWorkStationEdit";
    }



    @RequestMapping(value = "/toKsWorkStation")
    public String toKsWs() {
        return "System/SysStaffKsWorkStation";
    }
}
