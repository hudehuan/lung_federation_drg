package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */
@Controller
@RequestMapping(value = "/V_SysUserInfoPt")
public class V_SysUserInfoPtController {


    @Autowired
    private SysUserInfoPtService sysUserInfoPtService;

    @Autowired
    SysUserInfoService userInfoService;

    @Autowired
    SysStaffService staffService;

    @Autowired
    SysUserKsService userKsService;

    @Autowired
    SysUserRolesService userRolesService;

    @Autowired
    SysHomePageService sysHomePageService;

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;


    @RequestMapping(value = "/gotoSysUserInfoPt")
    public String gotoSysUserInfoPt(@CookieValue(value = "userid",defaultValue = "") String userid,
                                  @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                                  @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                                  Model model,HttpServletRequest request,HttpServletResponse response) {
        model.addAttribute("titlename", "用户列表");

        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        //权限判断
        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }

        return "System/SysUserInfoPingtai";
    }


    @RequestMapping(value = "/toEdit")
    public String toEdit(String id, Model model, @CookieValue(value = "syscode",defaultValue = "") String sysCode) {
        SysUserInfoEntity user = userInfoService.findByIdAndSysCode(id, sysCode);
        SysUserInfoPtEntity sysUserInfoPtEntities = sysUserInfoPtService.getAllByUserId(id,sysCode);
        SysStaffEntity staff = staffService.findOne(id);
        if (staff != null) {
            String name = staff.getName();
            model.addAttribute("name", name);
        }
        if (user != null) {
            model.addAttribute("user", user);
        }
        if(sysUserInfoPtEntities!= null){
            model.addAttribute("userInfoPt", sysUserInfoPtEntities);
        }
        List<SysHomePageEntity> homePageInterfaceList = new ArrayList<SysHomePageEntity>();
        homePageInterfaceList = sysHomePageService.getAllHomePageInterface(sysCode);
        model.addAttribute("homePageInterfaceList", homePageInterfaceList);
        return "System/SysUserInfoPtEdit";
    }

    @RequestMapping(value = "/toUserStaff")
    public String gotoStaff(Model model, @CookieValue(value = "syscode",defaultValue = "") String sysCode) {
        List<SysHomePageEntity> homePageInterfaceList = new ArrayList<SysHomePageEntity>();
        homePageInterfaceList = sysHomePageService.getAllHomePageInterface(sysCode);
        model.addAttribute("homePageInterfaceList", homePageInterfaceList);
        return "System/SysUserInfoPtAdd";
    }

    @RequestMapping(value = "/toPowerLife")
    public String toPowerLife(String id,Model model, @CookieValue(value = "syscode",defaultValue = "") String sysCode) {

        SysUserInfoPtEntity sysUserInfoPtEntities = sysUserInfoPtService.getAllByUserId(id,sysCode);
        model.addAttribute("ptInfo", sysUserInfoPtEntities);

        return "System/SysUserInfoPtPowerLife";
    }


}
