package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysDictionaryService;
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
@RequestMapping(value = "/V_SysDictionary")
public class V_SysDictionaryController {

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;
    @Autowired
    SysDictionaryService dictionaryService;

    @RequestMapping(value = "/gotoDictionary")
    public String gotoDictionary(@CookieValue(value = "userid",defaultValue = "") String userid,
                                 @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                                 @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                                 Model model,HttpServletRequest request,HttpServletResponse response) {
        model.addAttribute("titlename","字典表");
        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "System/SysDictionary";
    }


    @RequestMapping(value = "/toEdit")
    public String toEdit(String did,@CookieValue(value = "syscode",defaultValue = "") String sysCode,Model model) {
        model.addAttribute("sysCode", sysCode);
        if(did!=null&&!did.equals("")){
            SysDictionaryEntity dic = dictionaryService.findOne(did);
            model.addAttribute("dic",dic);
//            String code = dic.getDicCode();
            if (!dic.getSysCode().equals(sysCode)) {
                model.addAttribute("isSys",true);
            }
        }
        return "System/SysDictionaryEdit";
    }
}
