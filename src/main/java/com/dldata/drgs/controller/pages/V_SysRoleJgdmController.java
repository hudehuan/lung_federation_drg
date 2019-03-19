package com.dldata.drgs.controller.pages;

import com.dldata.drgs.businessmodel.TreeNode;
import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysRoleJgdmService;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
@Controller
@RequestMapping(value = "/V_SysRoleJgdm")
public class V_SysRoleJgdmController {

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;

   @RequestMapping("/toList")
    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                         Model model, HttpServletRequest request, HttpServletResponse response){
       model.addAttribute("titlename", "角色权限管理");

       SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

       List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

       if (sysRoleMenuEntityList.size()>0){
           roleMenuEntity = sysRoleMenuEntityList.get(0);
           model.addAttribute("roleMenu",roleMenuEntity);

       }
       return "/System/v_SysRoleJgdm";
   }

}
