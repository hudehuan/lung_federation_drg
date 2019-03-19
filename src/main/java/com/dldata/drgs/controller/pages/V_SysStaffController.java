package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
 * Created by 吴岳峰 on 2017/5/20.
 */
@Controller
@RequestMapping(value = "/V_SysStaff")
public class V_SysStaffController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    SysKeShiService keShiService;
    @Autowired
    SysDictionaryItemService dictionaryItemService;

    @Autowired
    SysDictionaryService dictionaryService;

    @Autowired
    SysStaffService sysStaffService;

    @Autowired
    SysKeShiWorkStationService ksWorkStationService;

    @Autowired
    SysHospitalBranchService hspBranchService;

    @Resource(name = "dictionaryConfig")
    DictionaryConfig dictionaryConfig;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;

    @RequestMapping(value = "/gotoSysStaff")
    public String gotoSysStaff(@CookieValue(value = "userid", defaultValue = "") String userid,
                               @RequestParam(value = "menuCode", defaultValue = "") String menuCode,
                               @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                               Model model, HttpServletRequest request, HttpServletResponse response) {

        //ModelAndView mode = new ModelAndView();
        model.addAttribute("titlename", "人员列表");
        //mode.setViewName("System/SysStaff");

        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode, userid,sysCode);

        if (sysRoleMenuEntityList.size() > 0) {
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu", roleMenuEntity);

        }


        return "System/SysStaff";
    }



    @RequestMapping(value = "/toEdit")
    public String toEdit(String id, Model model, @CookieValue(value = "syscode", defaultValue = "") String sysCode) {

        // 得到003字典组（类型）中的字典项 为页面下拉框初始化传值
        getDicItem(dictionaryConfig.getStaffType(), "dic", sysCode, model);

        // 得到001字典组（职称）中的字典项 为页面下拉框初始化传值
        getDicItem(dictionaryConfig.getZhiChengCode(), "zhiCheng", sysCode, model);

        // 得到002字典组（职位）中的字典项 为页面下拉框初始化传值
        getDicItem(dictionaryConfig.getZhiWeiCode(), "zhiWei", sysCode, model);


        if(id !=null&& !id.equals("")){
            SysStaffEntity staff = sysStaffService.findOne(id);
            String ksName = "";
            String ksWsName = "";
            if (staff != null) {
                if (staff.getKsId() != null) {
                    ksName = keShiService.findOne(staff.getKsId())==null?"":keShiService.findOne(staff.getKsId()).getName();
                }
                if (staff.getKswId() != null) {
                    ksWsName = ksWorkStationService.findOne(staff.getKswId())==null?"":ksWorkStationService.findOne(staff.getKswId()).getName();
                }
                model.addAttribute("staff", staff);

                if (ksName != null) {
                    model.addAttribute("ksName", ksName);
                }
                if (ksWsName != null) {
                    model.addAttribute("ksWsName", ksWsName);
                }
            }
        }
        List<SysHospitalBranchEntity> hospitalBranchEntities = new ArrayList<SysHospitalBranchEntity>();
        hospitalBranchEntities = hspBranchService.getAllHospitalBranch();
        if (hospitalBranchEntities.size() > 0) {
            model.addAttribute("hspBranch", hospitalBranchEntities);
        }
        return "System/SysStaffEdit";
    }



    private void getDicItem(String code, String name, String sysCode, Model model) {
        SysDictionaryEntity dic = new SysDictionaryEntity();
        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
        dic = dictionaryService.findByCode(code, sysCode);
        if (dic != null) {
            dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        if (dictionaryItemEntities.size() > 0) {
            model.addAttribute(name, dictionaryItemEntities);
        }
    }
}
