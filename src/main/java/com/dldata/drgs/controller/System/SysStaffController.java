package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysStaff")
public class SysStaffController {

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


//    @RequestMapping(value = "/gotoSysStaff")
//    public String gotoSysStaff(@CookieValue(value = "userid", defaultValue = "") String userid,
//                               @RequestParam(value = "menuCode", defaultValue = "") String menuCode,
//                               @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                               Model model, HttpServletRequest request, HttpServletResponse response) {
//
//        //ModelAndView mode = new ModelAndView();
//        model.addAttribute("titlename", "人员列表");
//        //mode.setViewName("System/SysStaff");
//
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode, userid,sysCode);
//
//        if (sysRoleMenuEntityList.size() > 0) {
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu", roleMenuEntity);
//
//        }
//
//
//        return "System/SysStaff";
//    }
//
//    @RequestMapping(value = "/toUpdate")
//    public String toUpdate(String id, Model model, @CookieValue(value = "syscode", defaultValue = "") String sysCode) {
//
//        // 得到003字典组（类型）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getStaffType(), "dic", sysCode, model);
//
//        // 得到001字典组（职称）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getZhiChengCode(), "zhiCheng", sysCode, model);
//
//        // 得到002字典组（职位）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getZhiWeiCode(), "zhiWei", sysCode, model);
//
//        SysStaffEntity staff = sysStaffService.findOne(id);
//        String ksName = "";
//        String ksWsName = "";
//        if (staff != null) {
//            if (staff.getKsId() != null) {
//                ksName = keShiService.findOne(staff.getKsId()).getName();
//            }
//            if (staff.getKswId() != null) {
//                ksWsName = ksWorkStationService.findOne(staff.getKswId()).getName();
//            }
//            model.addAttribute("staff", staff);
//
//            if (ksName != null) {
//                model.addAttribute("ksName", ksName);
//            }
//            if (ksWsName != null) {
//                model.addAttribute("ksWsName", ksWsName);
//            }
//        }
//        List<SysHospitalBranchEntity> hospitalBranchEntities = new ArrayList<SysHospitalBranchEntity>();
//        hospitalBranchEntities = hspBranchService.getAllHospitalBranch();
//        if (hospitalBranchEntities.size() > 0) {
//            model.addAttribute("hspBranch", hospitalBranchEntities);
//        }
//        return "System/SysStaffEdit";
//    }
//
//    @RequestMapping(value = "/gotosave")
//    public String gotoSave(Model model, @CookieValue(value = "syscode", defaultValue = "") String sysCode) {
//        // 得到003字典组（类型）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getStaffType(), "dic", sysCode, model);
//        // 得到001字典组（职称）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getZhiChengCode(), "zhiCheng", sysCode, model);
//
//        // 得到002字典组（职位）中的字典项 为页面下拉框初始化传值
//        getDicItem(dictionaryConfig.getZhiWeiCode(), "zhiWei", sysCode, model);
//
//        List<SysHospitalBranchEntity> hospitalBranchEntities = new ArrayList<SysHospitalBranchEntity>();
//        hospitalBranchEntities = hspBranchService.getAllHospitalBranch();
//        if (hospitalBranchEntities.size() > 0) {
//            model.addAttribute("hspBranch", hospitalBranchEntities);
//        }
//        return "System/SysStaffEdit";
//    }

    @RequestMapping(value = "/getAllStaff")
    @ResponseBody
    public String getAllStaff(@CookieValue(value = "syscode", defaultValue = "") String sysCode,
                              HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<SysStaffEntity> sysStaffs = sysStaffService.getAllStaff();
        List<SysKsEntity> sysKsEntities = keShiService.getAllKeShi();
        List<SysKsWorkstationEntity> sysKsWorkstationEntities = ksWorkStationService.getAllKsWorkStation();
        List<SysHospitalBranchEntity> sysHospitalBranchEntities = hspBranchService.getAllHospitalBranch();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        String result;
        try {
            sysStaffs.forEach((s) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("id",s.getId());
                map.put("name", s.getName());
                map.put("code", s.getCode());
                map.put("zhiCheng", "");

                if (s.getZhiCheng() != null) {
                    String zhiCheng = setDicItemName(dictionaryConfig.getZhiChengCode(), s.getZhiCheng(), sysCode);
                    map.put("zhiCheng", zhiCheng);
                }
                map.put("zhiWei","");
                if (s.getZhiWei() != null) {
                    String zhiWei = setDicItemName(dictionaryConfig.getZhiWeiCode(), s.getZhiWei(), sysCode);
                    map.put("zhiWei",zhiWei);
                }
                map.put("userClass","");
                if (s.getUserClass() != null) {
                    String userClass = setDicItemName(dictionaryConfig.getStaffType(), String.valueOf(s.getUserClass()), sysCode);
                    map.put("userClass", userClass);
                }
                map.put("weiyiCode","");
                if (s.getWeiyiCode() != null) {
                    map.put("weiyiCode", s.getWeiyiCode());
                }
                map.put("ksName","");
                sysKsEntities.stream().filter(ks -> ks.getId().equals(s.getKsId()==null?"":s.getKsId())).limit(1).forEach(ks -> {
                    map.put("ksName",ks.getName());
                });
                map.put("kswName","");
                sysKsWorkstationEntities.stream().filter(ksw -> ksw.getId().equals(s.getKswId()==null?"":s.getKswId())).limit(1).forEach(ksw ->{
                    map.put("kswName", ksw.getName());
                });
                map.put("yqName","");
                sysHospitalBranchEntities.stream().filter(hos -> hos.getId().equals(s.getYqId()==null?"":s.getYqId())).limit(1).forEach(hos -> {
                    map.put("yqName",hos.getName());
                });
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllStaff() 方法失败 】异常：" + ex.getMessage());
        }

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/getAllStaffInfo2")
    @ResponseBody
    public List getAllStaffInfo2(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List staffInfos = new ArrayList();

        staffInfos = sysStaffService.getAllStaffInfo2();

        return staffInfos;
    }

//    @RequestMapping(value = "/toKs")
//    public String getAllKs() {
//        return "System/SysStaffKs";
//    }

//    @RequestMapping(value = "/toKsWorkStation")
//    public String toKsWs() {
//        return "System/SysStaffKsWorkStation";
//    }

    @RequestMapping(value = "/delete")
    public void deleteStaff(String id, HttpServletRequest request,
                            HttpServletResponse response) throws Exception {
        String result;

        try {
            SysStaffEntity staff = sysStaffService.findOne(id);
            staff.setStatus(0);
            sysStaffService.save(staff);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteStaff() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);


    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public String findByCondition(String condition, @CookieValue(value = "syscode", defaultValue = "") String sysCode,
                                           HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysStaffEntity> sysStaffs = sysStaffService.findByCondition("%" + condition + "%");
        List<SysKsEntity> sysKsEntities = keShiService.getAllKeShi();
        List<SysKsWorkstationEntity> sysKsWorkstationEntities = ksWorkStationService.getAllKsWorkStation();
        List<SysHospitalBranchEntity> sysHospitalBranchEntities = hspBranchService.getAllHospitalBranch();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        String result;
        try {
            sysStaffs.forEach((s) -> {
                Map<String,String> map = new HashMap<String, String>();
                map.put("id",s.getId());
                map.put("name", s.getName());
                map.put("code", s.getCode());
                map.put("zhiCheng", "");

                if (s.getZhiCheng() != null) {
                    String zhiCheng = setDicItemName(dictionaryConfig.getZhiChengCode(), s.getZhiCheng(), sysCode);
                    map.put("zhiCheng", zhiCheng);
                }
                map.put("zhiWei","");
                if (s.getZhiWei() != null) {
                    String zhiWei = setDicItemName(dictionaryConfig.getZhiWeiCode(), s.getZhiWei(), sysCode);
                    map.put("zhiWei",zhiWei);
                }
                map.put("userClass","");
                if (s.getUserClass() != null) {
                    String userClass = setDicItemName(dictionaryConfig.getStaffType(), String.valueOf(s.getUserClass()), sysCode);
                    map.put("userClass", userClass);
                }
                map.put("weiyiCode","");
                if (s.getWeiyiCode() != null) {
                    map.put("weiyiCode", s.getWeiyiCode());
                }
                map.put("ksName","");
                sysKsEntities.stream().filter(ks -> ks.getId().equals(s.getKsId()==null?"":s.getKsId())).limit(1).forEach(ks -> {
                    map.put("ksName",ks.getName());
                });
                map.put("kswName","");
                sysKsWorkstationEntities.stream().filter(ksw -> ksw.getId().equals(s.getKswId()==null?"":s.getKswId())).limit(1).forEach(ksw ->{
                    map.put("kswName", ksw.getName());
                });
                map.put("yqName","");
                sysHospitalBranchEntities.stream().filter(hos -> hos.getId().equals(s.getYqId()==null?"":s.getYqId())).limit(1).forEach(hos -> {
                    map.put("yqName",hos.getName());
                });
                mapList.add(map);
            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findByConditionStaff() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public void saveStaff(SysStaffEntity staff, HttpServletRequest request,
                          HttpServletResponse response) throws Exception {
        String result;
        try {
            if (staff.getId().equals("")) {
                staff.setId(UUID.randomUUID().toString());
                List<SysStaffEntity> staffEntities = new ArrayList<SysStaffEntity>();
                staffEntities = sysStaffService.findOneByCode(staff.getCode());
                if (staffEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = staff.getId();
                SysStaffEntity oldStaff = sysStaffService.findOne(id);
                String oldCode = oldStaff.getCode();
                if (!staff.getCode().equals(oldCode)) {
                    List<SysStaffEntity> staffEntities = new ArrayList<SysStaffEntity>();
                    staffEntities = sysStaffService.findOneByCode(staff.getCode());
                    if (staffEntities.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            if (!staff.getName().equals("")) {
                staff.setPym(StringUtil.getPinYinHeadChar(staff.getName()));
            }
            if (staff.getKswId().equals("")) {
                staff.setKswId(null);
            }
            if (staff.getKsId().equals("")) {
                staff.setKsId(null);
            }
            staff.setStatus(1);
            sysStaffService.save(staff);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveStaff() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

//    private void getDicItem(String code, String name, String sysCode, Model model) {
//        SysDictionaryEntity dic = new SysDictionaryEntity();
//        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
//        dic = dictionaryService.findByCode(code, sysCode);
//        if (dic != null) {
//            dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
//        }
//        if (dictionaryItemEntities.size() > 0) {
//            model.addAttribute(name, dictionaryItemEntities);
//        }
//    }

    private String setDicItemName(String code, String dicItemCode, String sysCode) {
        SysDictionaryEntity dic = new SysDictionaryEntity();
        List<SysDictionaryItemEntity> dictionaryItemEntities = new ArrayList<SysDictionaryItemEntity>();
        dic = dictionaryService.findByCode(code, sysCode);
        if (dic != null) {
            dictionaryItemEntities = dictionaryItemService.getAllDictionaryItemById(dic.getDid());
        }
        if (dictionaryItemEntities.size() > 0) {
            for (SysDictionaryItemEntity dicItem : dictionaryItemEntities) {
                if (dicItem.getItemCode().equals(dicItemCode)) {
                    return dicItem.getDicName();
                }
            }
        }
        return "";
    }

}
