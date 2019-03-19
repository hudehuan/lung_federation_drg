package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.entity.SysKsEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_SysKeShi")
public class V_SysKeShiController {

    @Autowired
    SysKeShiService sysKeShiService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;
    @Autowired
    SysDictionaryService dictionaryService;
    @Autowired
    SysDictionaryItemService dictionaryItemService;
    @Resource(name = "dictionaryConfig")
    DictionaryConfig dictionaryConfig;

    @RequestMapping(value = "/gotoKeShi")
    public String gotoKeShi(@CookieValue(value = "userid",defaultValue = "") String userid,
                            @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                            @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                            Model model,HttpServletRequest request,HttpServletResponse response){

        model.addAttribute("titlename","科室列表");

        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "System/SysKeShi";
    }


    @RequestMapping(value = "toEdit")
    public String toEdit(String id,Model model,@CookieValue(value = "syscode", defaultValue = "") String sysCode){
        SysDictionaryEntity dic = new SysDictionaryEntity();
        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
        dic = dictionaryService.findByCode(dictionaryConfig.getKeshiType(), sysCode);
        if (dic != null) {
            dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        if (dictionaryItemEntities.size() > 0) {
            model.addAttribute("typeEnums", dictionaryItemEntities);
        }
        if(id != null&&!id.equals("")){
            SysKsEntity ksEntity = sysKeShiService.findOne(id);
            if (ksEntity != null) {
                model.addAttribute("ksEntity",ksEntity);
            }
        }
        return "System/SysKeShiEdit";
    }




    @RequestMapping(value = "toSelKs")
    public String getAllKs() {
        return "System/SysStaffKs";
    }
}
