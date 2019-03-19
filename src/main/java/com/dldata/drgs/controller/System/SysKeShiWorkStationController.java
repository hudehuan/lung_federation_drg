package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysKsWorkstationEntity;
import com.dldata.drgs.service.System.SysKeShiWorkStationService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysKsWorkStation")
public class SysKeShiWorkStationController {


    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    SysKeShiWorkStationService sysKeShiWorkStationService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;

//    @RequestMapping(value="/gotoKsWorkStation")
//    public String gotoSysKeShiWorkStation(@CookieValue(value = "userid",defaultValue = "") String userid,
//                                                @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                                                @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                                                Model model,HttpServletRequest request,HttpServletResponse response) {
//        //ModelAndView mode = new ModelAndView();
//        model.addAttribute("titlename", "科室工作站");
//        //mode.setViewName("System/SysKeShiWorkStation");
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//        return "System/SysKeShiWorkStation";
//    }

//    @RequestMapping(value = "/toUpdate")
//    public String toUpdate(String id,Model model) {
//        SysKsWorkstationEntity ksWsEntity = sysKeShiWorkStationService.findOne(id);
//        if (ksWsEntity != null) {
//            model.addAttribute("ksWsEntity",ksWsEntity);
//        }
//        return "System/SysKeShiWorkStationEdit";
//    }

    @RequestMapping(value = "/getAllKsWorkStation")
    @ResponseBody
    public List<SysKsWorkstationEntity> getAllKsWorkStation(HttpServletRequest request, HttpServletResponse response)throws Exception{

        List<SysKsWorkstationEntity> sysKsWorkstation = new ArrayList<SysKsWorkstationEntity>();
        String result;
        try{
            sysKsWorkstation = sysKeShiWorkStationService.getAllKsWorkStation();
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShiWorkStation() 方法失败 】异常："+ex.getMessage());
        }
        return sysKsWorkstation;
    }
//    @RequestMapping(value = "/gotosave")
//    public String gotoSave() {
//        return "System/SysKeShiWorkStationEdit";
//    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public void save(SysKsWorkstationEntity ksWs,HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        String result;

        try {
            if (ksWs.getId().equals("")) {
                ksWs.setId(UUID.randomUUID().toString());

                List<SysKsWorkstationEntity> sysKsWorkstationEntities = new ArrayList<SysKsWorkstationEntity>();
                sysKsWorkstationEntities = sysKeShiWorkStationService.findOneByCode(ksWs.getCode());
                if (sysKsWorkstationEntities.size() >0) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                sysKsWorkstationEntities = sysKeShiWorkStationService.findByName(ksWs.getName());
                if (sysKsWorkstationEntities.size() >0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            } else {
                String id = ksWs.getId();
                List<SysKsWorkstationEntity> sysKsWorkstationEntities = new ArrayList<SysKsWorkstationEntity>();
                SysKsWorkstationEntity ksWorkstationEntity = sysKeShiWorkStationService.findOne(id);
                String oldCode = ksWorkstationEntity.getCode();
                if (!ksWs.getCode().equals(oldCode)) {
                    sysKsWorkstationEntities = sysKeShiWorkStationService.findOneByCode(ksWs.getCode());
                    if (sysKsWorkstationEntities.size() >0) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                String oldName = ksWorkstationEntity.getName();
                if (!ksWs.getName().equals(oldName)) {
                    sysKsWorkstationEntities = sysKeShiWorkStationService.findByName(ksWs.getName());
                    if (sysKsWorkstationEntities.size() >0) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            ksWs.setStatus(1);
            if (!ksWs.getName().equals("")) {
                ksWs.setPym(StringUtil.getPinYinHeadChar(ksWs.getName()));
            }
            sysKeShiWorkStationService.save(ksWs);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveKeShiWorkStation() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            SysKsWorkstationEntity ksWorkstationEntity = sysKeShiWorkStationService.findOne(id);
            ksWorkstationEntity.setStatus(0);
            sysKeShiWorkStationService.save(ksWorkstationEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteKeShiWorkStation() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<SysKsWorkstationEntity> findByCondition(String condition,HttpServletRequest request,HttpServletResponse response) throws Exception{
        List<SysKsWorkstationEntity> ksWs = new ArrayList<SysKsWorkstationEntity>();
        String result;
        try{
            ksWs = sysKeShiWorkStationService.findByCondition("%"+condition+"%");
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getKeShiWorkStationByCondition() 方法失败 】异常："+ex.getMessage());
        }
        return ksWs;
    }

}
