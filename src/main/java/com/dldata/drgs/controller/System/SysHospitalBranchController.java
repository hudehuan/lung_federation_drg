package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysHospitalBranchEntity;
import com.dldata.drgs.service.System.SysHospitalBranchService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysHospitalBranch")
public class SysHospitalBranchController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysHospitalBranchService hospitalBranchService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;


//    @RequestMapping(value = "/gotoHospitalBranch")
//    public String gotoHospitalBranch(@CookieValue(value = "userid",defaultValue = "") String userid,
//                                     @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                                     @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                                     Model model,HttpServletRequest request,HttpServletResponse response) {
//        model.addAttribute("titlename", "院区管理");
//
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//
//        return "/System/SysHospitalBranch";
//    }

    @RequestMapping(value = "/getAllHospitalBranch")
    @ResponseBody
    public List<SysHospitalBranchEntity> getAllHospitalBranch(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysHospitalBranchEntity> hospitalBranch = new ArrayList<SysHospitalBranchEntity>();
        String result;
        try {
            hospitalBranch = hospitalBranchService.getAllHospitalBranch();
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllHospitalBranch() 方法失败 】异常：" + ex.getMessage());
        }
        return hospitalBranch;
    }

//    @RequestMapping(value = "/gotosave")
//    public String gotoSave() {
//        return "/System/SysHospitalBranchEdit";
//    }

//    @RequestMapping(value = "/toUpdate")
//    public String toUpdate(String id, Model model) {
//        SysHospitalBranchEntity hospitalBranch = hospitalBranchService.findOne(id);
//        if (hospitalBranch != null) {
//            model.addAttribute("hospitalBranch", hospitalBranch);
//        }
//        return "System/SysHospitalBranchEdit";
//    }

    @RequestMapping(value = "/save")
    public void saveHsbranch(SysHospitalBranchEntity hospitalBranch, HttpServletRequest request
            , HttpServletResponse response) throws Exception {
        String result;
        try {
            if (hospitalBranch.getId().equals("")) {
                hospitalBranch.setId(UUID.randomUUID().toString());
                List<SysHospitalBranchEntity> hsBranch = hospitalBranchService.findOneByCode(hospitalBranch.getCode());
                if (hsBranch.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                hsBranch = hospitalBranchService.findByName(hospitalBranch.getName());
                if (hsBranch.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = hospitalBranch.getId();
                List<SysHospitalBranchEntity> hsBranch = new ArrayList<SysHospitalBranchEntity>();
                SysHospitalBranchEntity ksWorkstationEntity = hospitalBranchService.findOne(id);
                String oldCode = ksWorkstationEntity.getCode();
                if (!hospitalBranch.getCode().equals(oldCode)) {
                    hsBranch = hospitalBranchService.findOneByCode(hospitalBranch.getCode());
                    if (hsBranch.size() >0) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                String oldName = ksWorkstationEntity.getName();
                if (!hospitalBranch.getName().equals(oldName)) {
                    hsBranch = hospitalBranchService.findByName(hospitalBranch.getName());
                    if (hsBranch.size() >0) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            hospitalBranch.setStatus(1);
            if (hospitalBranch.getXh() == null) {
                hospitalBranch.setXh(0);
            }
            hospitalBranchService.save(hospitalBranch);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveHospitalBranch() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            SysHospitalBranchEntity hospitalBranchEntity = hospitalBranchService.findOne(id);
            hospitalBranchEntity.setStatus(0);
            hospitalBranchService.save(hospitalBranchEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteHospitalBranch() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


}
