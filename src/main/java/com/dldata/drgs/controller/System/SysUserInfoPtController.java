package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.*;
import com.dldata.drgs.utils.MD5Util;
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
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */

@Controller
@RequestMapping(value = "/SysUserInfoPt")
public class SysUserInfoPtController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

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
    @Autowired
    private SysDictionaryItemService sysDictionaryItemService;
    @Autowired
    DictionaryConfig dictionaryConfig;
    @Autowired
    SysKeShiService sysKeShiService;


    @RequestMapping(value = "/getAllUserInfo")
    @ResponseBody
    public String getAllUserInfo(@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                 HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        try {
            List<SysUserInfoEntity> sysUserInfo = userInfoService.getAllUserInfo(sysCode);
            List<SysStaffEntity> sysStaffEntityList = staffService.getAllStaff();
            List<SysUserInfoPtEntity> sysUserInfoPtEntities = sysUserInfoPtService.getAllInfo();
            List<SysHomePageEntity> sysHomePageEntity = sysHomePageService.getAllHomePageInterface(sysCode);
            sysUserInfo.forEach((u) -> {
                Map<String,Object> map = new HashMap<String, Object>();

                map.put("id",u.getId());
                map.put("loginName", u.getLoginName());
                map.put("loginPwd", u.getLoginPwd());
                map.put("status", u.getStatus());
                map.put("isCheck",false);
                if (Util.checkNotNull(u.getIsCheck())) {
                    map.put("isCheck", u.getIsCheck());
                }
//                map.put("homePage","");
//                sysHomePageEntity.stream().filter(hp -> hp.getId().equals(u.getHomePageId())).forEach(hp -> {
//                    if (hp != null) {
//                        map.put("homePage", hp.getName());
//                    }
//                });
                map.put("name", "");
                sysStaffEntityList.stream().filter(staff -> staff.getId().equals( u.getId())).limit(1).forEach(staff -> {
                    map.put("name", staff.getName());
                });
                map.put("type","");
                map.put("xlh","");
                map.put("power","");
                map.put("menuRole","");
                map.put("report","");
                map.put("pass","");
                map.put("wtLoginName","");
                sysUserInfoPtEntities.stream().filter(pt -> pt.getUserid().equals( u.getId())&&pt.getSysCode().equals(u.getSysCode()))
                        .limit(1).forEach(pt -> {
                    map.put("type",pt.getUserType());
                    map.put("xlh",pt.getXlh());
                    if (Util.checkNotNull(pt.getPowerFile())) {
                        map.put("power","1");
                    }
                    if (Util.checkNotNull(pt.getReport())) {
                        map.put("report",pt.getReport()?"1":"");
                    }
                    if (Util.checkNotNull(pt.getMenuRole())) {
                        map.put("menuRole",pt.getMenuRole()?"1":"");
                    }
                    map.put("wtLoginName",pt.getWtLoginName());
                    map.put("pass",pt.getRandPass());
                    mapList.add(map);
                });


            });
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllUserInfo() 方法失败 】异常：" + ex.getMessage());
        }

        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }


    @RequestMapping(value = "/save")
    public void save(SysUserInfoEntity userInfo,String userType,String report,String menuRole,
                     @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     String flag, String on,String check, HttpServletRequest request,String wtLoginName,
                     HttpServletResponse response) throws Exception {
        String result;
        try {
            String id = userInfo.getId();
            SysUserInfoEntity oldUserInfo = userInfoService.findByIdAndSysCode(id, sysCode);

            SysUserInfoPtEntity UserInfoPt = new SysUserInfoPtEntity();
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
                String pwd = MD5Util.MD5Encoder(userInfo.getLoginName()+ "123456");
                SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.findByWtLoginName(wtLoginName,sysCode);
                if (sysUserInfoPtEntity != null) {
                    result = "{\"success\":false,\"msg\":\"卫统登录代码已存在！\",\"id\":\"#wtLoginName\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                userInfo.setLoginPwd(pwd);
                UserInfoPt.setUserid(id);
                UserInfoPt.setSysCode(sysCode);
            } else {
                // 未修改人员
                UserInfoPt =  sysUserInfoPtService.getAllByUserId(id,sysCode);
                if (id.equals(flag)) {
                    if (!userInfo.getLoginName().equals(oldUserInfo.getLoginName())) {
                        SysUserInfoEntity user = userInfoService.checkUserInfo(userInfo.getLoginName(),sysCode);
                        if (user != null) {
                            result = "{\"success\":false,\"msg\":\"用户登录代码已存在！\",\"id\":\"#loginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                    if(!wtLoginName.equals(UserInfoPt.getWtLoginName())){
                        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.findByWtLoginName(wtLoginName,sysCode);
                        if (sysUserInfoPtEntity != null) {
                            result = "{\"success\":false,\"msg\":\"卫统登录代码已存在！\",\"id\":\"#wtLoginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                    // 修改人员
                } else {
                    if (oldUserInfo != null) {
                        result = "{\"success\":false,\"msg\":\"人员已存在！\",\"id\":\"#choose\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                    if (!userInfo.getLoginName().equals(oldUserInfo.getLoginName())) {
                        SysUserInfoEntity user = userInfoService.checkUserInfo(userInfo.getLoginName(),sysCode);
                        if (user != null) {
                            result = "{\"success\":false,\"msg\":\"登录代码已存在！\",\"id\":\"#loginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                    if(!UserInfoPt.getWtLoginName().equals(wtLoginName)){
                        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.findByWtLoginName(wtLoginName,sysCode);
                        if (sysUserInfoPtEntity != null) {
                            result = "{\"success\":false,\"msg\":\"卫统登录代码已存在！\",\"id\":\"#wtLoginName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }

            }
            if (Util.checkNotNull(on)) {
//                if(on.equals("1")) {
                    userInfo.setStatus(1);
//                }
//                else{
//                    userInfo.setStatus(0);
//                }

            }else{
                userInfo.setStatus(0);
            }


            if (!Util.checkNotNull(userInfo.getIsCheck())) {
                userInfo.setIsCheck(false);

            }
            UserInfoPt.setUserType(userType);
            if(menuRole!=null){
                UserInfoPt.setMenuRole(true);
            }else {
                UserInfoPt.setMenuRole(false);
            }
            if(report!=null){
                UserInfoPt.setReport(true);
            }else {
                UserInfoPt.setReport(false);
            }
            UserInfoPt.setWtLoginName(wtLoginName);
            sysUserInfoPtService.save(UserInfoPt);
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
            SysUserInfoPtEntity sysUserInfoPtEntities = sysUserInfoPtService.getAllByUserId(id,sysCode);

            if(sysUserInfoPtEntities != null){
                sysUserInfoPtService.delete(sysUserInfoPtEntities);
            }

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
    public String findByCondition(String condition, String userType,@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                  HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        try {
            List<SysUserInfoEntity> sysUserInfo = userInfoService.findByCondition("%" + condition + "%",sysCode);
            List<SysStaffEntity> sysStaffEntityList = staffService.getAllStaff();
            List<SysUserInfoPtEntity> sysUserInfoPtEntities = sysUserInfoPtService.findByTypeLike(userType,sysCode);

            List<SysHomePageEntity> sysHomePageEntity = sysHomePageService.getAllHomePageInterface(sysCode);
            List<SysDictionaryItemEntity> zhiCheng = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiChengCode());
            List<SysDictionaryItemEntity> zhiWei = sysDictionaryItemService.findByIsDicCode(dictionaryConfig.getZhiWeiCode());
            if (sysUserInfo.size() >0) {
                sysUserInfo.forEach((u) -> {
                    Map<String,Object> map = new HashMap<String, Object>();
                    map.put("id",u.getId());
                    map.put("loginName", u.getLoginName());
                    map.put("loginPwd", u.getLoginPwd());
                    map.put("status", u.getStatus());
                    map.put("isCheck",false);
                    if (Util.checkNotNull(u.getIsCheck())) {
                        map.put("isCheck", u.getIsCheck());
                    }
//                    map.put("homePage","");
//                    sysHomePageEntity.stream().filter(hp -> hp.getId().equals(u.getHomePageId())).forEach(hp -> {
//                        if (hp != null) {
//                            map.put("homePage", hp.getName());
//                        }
//                    });
                    map.put("name", "");
                    sysStaffEntityList.stream().filter(staff -> staff.getId().equals( u.getId())).limit(1).forEach(staff -> {
                        map.put("name", staff.getName());
                    });
                    map.put("type","");
                    map.put("xlh","");
                    map.put("power","");
                    map.put("wtLoginName","");
                    sysUserInfoPtEntities.stream().filter(pt -> pt.getUserid().equals( u.getId())&&pt.getSysCode().equals(u.getSysCode()))
                            .limit(1).forEach(pt -> {
                        map.put("type",pt.getUserType());
                        map.put("wtLoginName",pt.getWtLoginName());
                        map.put("xlh",pt.getXlh());
                        if (Util.checkNotNull(pt.getPowerFile())) {
                            map.put("power","1");
                        }

                    if(sysUserInfoPtEntities != null){
                        boolean c = true;
                        if(!userType.equals("")){
                            c=false;
                            List<SysUserInfoPtEntity> s = sysUserInfoPtEntities.stream().filter(spt -> spt.getUserid().equals( u.getId())&&spt.getSysCode().equals(u.getSysCode())).collect(Collectors.toList());
                            if(s.size()>0){
                                c=true;
                            }
                        }
                        if (c){
                            mapList.add(map);
                        }

                    }
                    });
                });
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findUserInfoByCondition() 方法失败 】异常：" + ex.getMessage());
        }
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";
    }

    @RequestMapping(value = "/getPowerFile")
    public void getPowerFile( SysUserInfoPtEntity sysUserInfoPtEntity, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {
        String result;

        try {
            sysUserInfoPtService.save(sysUserInfoPtEntity);
            result = "{\"success\":true,\"msg\":\"上传成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
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
    @RequestMapping(value = "/getRandPass")
    public void getRandPass( String  userid, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                              HttpServletRequest request,
                              HttpServletResponse response) throws Exception {
        String result;

        try {
            SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userid,sysCode);

            String base = "0123456789abcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < 6; i++) {
                int number = random.nextInt(base.length());
                sb.append(base.charAt(number));
            }

            sysUserInfoPtEntity.setRandPass( sb.toString());
            sysUserInfoPtService.save(sysUserInfoPtEntity);
            result = "{\"success\":true,\"msg\":\""+sb.toString()+"\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}

