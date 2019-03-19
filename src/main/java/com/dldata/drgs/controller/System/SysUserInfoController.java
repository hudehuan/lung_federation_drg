package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysUserInfo")
public class SysUserInfoController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

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
    @Autowired
    private SysDictionaryItemService sysDictionaryItemService;
    @Autowired
    DictionaryConfig dictionaryConfig;
    @Autowired
    SysKeShiService sysKeShiService;

//    @RequestMapping(value = "/gotoSysUserInfo")
//    public String gotoSysUserInfo(@CookieValue(value = "userid",defaultValue = "") String userid,
//                                  @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                                  @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                                  Model model,HttpServletRequest request,HttpServletResponse response) {
//        model.addAttribute("titlename", "用户列表");
//
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        //权限判断
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//
//        return "System/SysUserInfo";
//    }

    @RequestMapping(value = "/getAllUserInfo")
    @ResponseBody
    public String getAllUserInfo(@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                 HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<SysUserInfoEntity> sysUserInfo = new ArrayList<SysUserInfoEntity>();
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        List<SysStaffEntity> sysStaffEntityList = staffService.getAllStaff();
        List<SysKsEntity> sysKsEntityList = sysKeShiService.getAllKeShi();
        String result;
        try {
            sysUserInfo = userInfoService.getAllUserInfo(sysCode);
            List<SysHomePageEntity> sysHomePageEntity = sysHomePageService.getAllHomePageInterface(sysCode);
            List<SysDictionaryItemEntity> zhiCheng = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiChengCode());
            List<SysDictionaryItemEntity> zhiWei = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiWeiCode());
            if (sysUserInfo.size() >0) {
                sysUserInfo.forEach((u) -> {
                    //SysStaffEntity staff = staffService.findOne(u.getId());
                    SysStaffEntity staff = staffService.getStaffFromListById(sysStaffEntityList, u.getId());

                    Map<String,Object> map = new HashMap<String, Object>();
                    map.put("name", "");
                    map.put("ksName", "");
                    map.put("zhiCheng", "");
                    map.put("zhiWei", "");
                    map.put("id",u.getId());
                    map.put("loginName", u.getLoginName());
                    map.put("loginPwd", u.getLoginPwd());
                    map.put("status", u.getStatus());
                    map.put("isCheck",false);
                    if (Util.checkNotNull(u.getIsCheck())) {
                        map.put("isCheck", u.getIsCheck());
                    }
                    map.put("homePage","");
                    sysHomePageEntity.stream().filter(hp -> hp.getId().equals(u.getHomePageId())).forEach(hp -> {
                        if (hp != null) {
                            map.put("homePage", hp.getName());
                        }
                    });
                    if (staff != null) {
                        map.put("name", staff.getName());
                        SysKsEntity ks = sysKeShiService.getKsFromListById(sysKsEntityList,staff.getKsId());
                        if (ks!=null){
                            map.put("ksName", ks.getName());
                        }
                        zhiCheng.stream().filter(p -> p.getItemCode().equals(staff.getZhiCheng())).forEach(
                                p -> {
                                    map.put("zhiCheng", p.getDicName());
                                }
                        );

                        zhiWei.stream().filter(p -> p.getItemCode().equals(staff.getZhiWei())).forEach(
                                p -> {
                                    map.put("zhiWei", p.getDicName());
                                }
                        );
                    }
                        mapList.add(map);

                });
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllUserInfo() 方法失败 】异常：" + ex.getMessage());
        }

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }



    @RequestMapping(value = "/editPwd")
    public void editPwd(SysUserInfoEntity user, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            SysUserInfoEntity userInfo = userInfoService.findByIdAndSysCode(user.getId(), sysCode);
            if (userInfo.equals("")) {
                //userInfo.setId(UUID.randomUUID().toString());
                result = "{\"success\":false,\"msg\":\"该人员不存在！\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            String pwd = toMD5(userInfo.getLoginName()+ user.getLoginPwd());
            userInfo.setLoginPwd(pwd);
            userInfoService.save(userInfo);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".editPwd() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/save")
    public void save(SysUserInfoEntity userInfo,
                     @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     String flag, String on,String check, HttpServletRequest request,
                     HttpServletResponse response) throws Exception {
        String result;
        try {
            String id = userInfo.getId();
            SysUserInfoEntity oldUserInfo = userInfoService.findByIdAndSysCode(id, sysCode);
            if (flag.equals("")) {
                if (oldUserInfo != null) {
                    result = "{\"success\":false,\"msg\":\"人员已存在！\",\"id\":\"#choose\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                SysUserInfoEntity user = userInfoService.checkUserInfo(userInfo.getLoginName(),sysCode);
                if (user != null) {
                    result = "{\"success\":false,\"msg\":\"用户登录代码已存在！\",\"id\":\"#loginName\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                String pwd = toMD5(userInfo.getLoginName()+ "123456");
                userInfo.setLoginPwd(pwd);
            } else {
                // 未修改人员
                if (id.equals(flag)) {
                    if (!userInfo.getLoginName().equals(oldUserInfo.getLoginName())) {
                        SysUserInfoEntity user = userInfoService.checkUserInfo(userInfo.getLoginName(),sysCode);
                        if (user != null) {
                            result = "{\"success\":false,\"msg\":\"用户登录代码已存在！\",\"id\":\"#loginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                    // 修改人员
                } else {
                    oldUserInfo = userInfoService.findByIdAndSysCode(id, sysCode);
                    if (oldUserInfo != null) {
                        result = "{\"success\":false,\"msg\":\"人员已存在！\",\"id\":\"#choose\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                    SysUserInfoEntity user = userInfoService.checkUserInfo(userInfo.getLoginName(),sysCode);
                    if (!userInfo.getLoginName().equals(oldUserInfo.getLoginName())) {
                        if (user != null) {
                            result = "{\"success\":false,\"msg\":\"登录代码已存在！\",\"id\":\"#loginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }
            }
            if (Util.checkNotNull(on)) {
                if(on.equals("1")) {
                    userInfo.setStatus(1);
                }
                else{
                    userInfo.setStatus(0);
                }

            }else{
                userInfo.setStatus(0);
            }


            if (!Util.checkNotNull(userInfo.getIsCheck())) {
                userInfo.setIsCheck(false);

            }


            userInfo.setSysCode(sysCode);
            userInfoService.save(userInfo);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                       HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            SysUserInfoEntity userInfoEntity = userInfoService.findByIdAndSysCode(id,sysCode);
            List<SysUserKsEntity> userKsEntities = userKsService.getAllUserKs(id,sysCode);
            List<SysUserRolesEntity> userRolesEntities = userRolesService.getAllRole(id,sysCode);

            if (userKsEntities != null) {
                userKsEntities.forEach((u) -> {
                    userKsService.delete(u);
                });
            }
            if (userRolesEntities != null) {
                userRolesEntities.forEach((u) -> {
                    userRolesService.delete(u);
                });
            }
//            userInfoEntity.setStatus(0);
            userInfoService.delete(userInfoEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public String findByCondition(String condition, String kscondition,@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                  HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SysUserInfoEntity> sysUserInfo = userInfoService.findByCondition("%" + condition + "%",sysCode);
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        List<SysStaffEntity> sysStaffEntityList = staffService.getAllStaff();
        List<SysKsEntity> sysKsEntityList = sysKeShiService.findByCondition("%" + kscondition + "%");
        String result;
        try {
            List<SysHomePageEntity> sysHomePageEntity = sysHomePageService.getAllHomePageInterface(sysCode);
            List<SysDictionaryItemEntity> zhiCheng = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiChengCode());
            List<SysDictionaryItemEntity> zhiWei = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiWeiCode());
            if (sysUserInfo.size() >0) {
                sysUserInfo.forEach((u) -> {
                    SysStaffEntity staff = staffService.getStaffFromListById(sysStaffEntityList, u.getId());

                    Map<String,Object> map = new HashMap<String, Object>();
                    map.put("name", "");
                    map.put("ksName", "");
                    map.put("zhiCheng", "");
                    map.put("zhiWei", "");
                    map.put("id",u.getId());
                    map.put("loginName", u.getLoginName());
                    map.put("loginPwd", u.getLoginPwd());
                    map.put("status", u.getStatus());
                    map.put("isCheck",false);
                    if (Util.checkNotNull(u.getIsCheck())) {
                        map.put("isCheck", u.getIsCheck());
                    }
                    map.put("homePage","");
                    sysHomePageEntity.stream().filter(hp -> hp.getId().equals(u.getHomePageId())).forEach(hp -> {
                        if (hp != null) {
                            map.put("homePage", hp.getName());
                        }
                    });
                    if (staff != null) {
                        map.put("name", staff.getName());
                        SysKsEntity ks = sysKeShiService.getKsFromListById(sysKsEntityList,staff.getKsId());
                        if (ks!=null){
                            map.put("ksName", ks.getName());
                        }
                        zhiCheng.stream().filter(p -> p.getItemCode().equals(staff.getZhiCheng())).forEach(
                                p -> {
                                    map.put("zhiCheng", p.getDicName());
                                }
                        );

                        zhiWei.stream().filter(p -> p.getItemCode().equals(staff.getZhiWei())).forEach(
                                p -> {
                                    map.put("zhiWei", p.getDicName());
                                }
                        );
                    }
                        if(sysKsEntityList != null){
                            boolean c = true;
                            if(!kscondition.equals("")){
                                c = sysKeShiService.checkExistKsFromListById(sysKsEntityList,
                                        staff == null ? "" : staff.getKsId()==null ? "":staff.getKsId());
                            }
                            if (c){
                                mapList.add(map);
                            }

                        }

                });
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findUserInfoByCondition() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    public String toMD5(String plainText) {
        StringBuffer buf = new StringBuffer("");
        try {
            //生成实现指定摘要算法的 MessageDigest 对象。
            MessageDigest md = MessageDigest.getInstance("MD5");
            //使用指定的字节数组更新摘要。
            md.update(plainText.getBytes());
            //通过执行诸如填充之类的最终操作完成哈希计算。
            byte b[] = md.digest();
            //生成具体的md5密码到buf数组
            int i;

            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
//            System.out.println("32位: " + buf.toString());// 32位的加密
//            System.out.println("16位: " + buf.toString().substring(8, 24));// 16位的加密，其实就是32位加密后的截取
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return buf.toString();
    }

    private class ShowUserInfo {
        private String id;
        private String name;
        private String loginName;
        private String loginPwd;
        private Integer status;
        private String homePage;
        private boolean isCheck;
        private String ksName;
        private String zhiCheng;
        private String zhiWei;

        public String getZhiWei() {
            return zhiWei;
        }

        public void setZhiWei(String zhiWei) {
            this.zhiWei = zhiWei;
        }

        public String getZhiCheng() {
            return zhiCheng;
        }

        public void setZhiCheng(String zhiCheng) {
            this.zhiCheng = zhiCheng;
        }

        public String getKsName() {
            return ksName;
        }

        public void setKsName(String ksName) {
            this.ksName = ksName;
        }

//        public boolean isCheck() {
//            return isCheck;
//        }
//
//        public void setCheck(boolean isCheck) {
//            this.isCheck = isCheck;
//        }

        public boolean getIsCheck() {
            return isCheck;
        }

        public void setIsCheck(boolean isCheck) {
            this.isCheck = isCheck;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getLoginName() {
            return loginName;
        }

        public void setLoginName(String loginName) {
            this.loginName = loginName;
        }

        public String getLoginPwd() {
            return loginPwd;
        }

        public void setLoginPwd(String loginPwd) {
            this.loginPwd = loginPwd;
        }

        public Integer getStatus() {
            return status;
        }

        public void setStatus(Integer status) {
            this.status = status;
        }

        public String getHomePage() {
            return homePage;
        }

        public void setHomePage(String homePage) {
            this.homePage = homePage;
        }
    }
}

