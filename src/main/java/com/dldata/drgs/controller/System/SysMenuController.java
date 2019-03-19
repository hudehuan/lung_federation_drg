package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.DicJgdmTzEntity;
import com.dldata.drgs.entity.SysMenuEntity;
import com.dldata.drgs.entity.SysUserInfoPtEntity;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysUserInfoPtService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.service.drgsDicData.DicJgdmTzService;
import com.dldata.drgs.utils.DateUtil;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.pubs.DictionaryConfig;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/sysMenu")
public class SysMenuController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysMenuService sysMenuService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;


    @Autowired
    SysConfig sysConfig;

    @Autowired
    DictionaryConfig dictionaryConfig;

    @Autowired
    private SysUserInfoPtService sysUserInfoPtService;

    @Autowired
    private DicJgdmTzService dicJgdmTzService;

//    @RequestMapping(value = "/toList")
//    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
//                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                         Model model,HttpServletRequest request,HttpServletResponse response) {
//        model.addAttribute("titlename", "菜单管理");
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//        return "System/SysMenu";
//    }


    @RequestMapping(value = "/getSysMenu")
    @ResponseBody
    public String getSysMenu(
                                  @CookieValue(value = "dlSSOServerUrl",defaultValue = "") String serverURL,
                                  HttpServletRequest request,HttpServletResponse response){

        //return sysMenuService.getMenuByUserId(userId);

//        String hql = "select new com.dldata.drgs.entity.SysMenuEntity(mu.id,mu.code,mu.pCode,mu.name,mu.url,mu.img, mu.xh, mu.status, mu.sysCode, mu.type)" +
//                " from SysMenuEntity mu where mu.status <> 0 and mu.id in(select distinct( m.menuId) from " +
//                " SysUserRolesEntity r,SysRoleMenuEntity m  " +
//                " where  r.roleId = m.roleId and r.uerId = '" + userId + "'" +
//                " and m.isBrowse =true ) and mu.sysCode='" + sysConfig.SysCode + "' order by mu.xh";
        String sysCode =  sysConfig.SysCode;
        List<SysMenuEntity>  list=  sysMenuService.findByCondition(dictionaryConfig.getSystemCode()+"%",sysCode);

        String hmiUrl = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort();

        List<Map<String,String>> maplist = new ArrayList<Map<String,String>>();
        list.forEach(mu -> {
            Map<String,String> map = new HashMap<String, String>();
            map.put("id",mu.getCode());
            map.put("pid",mu.getpCode());
            map.put("dm",mu.getCode());
            map.put("mc", mu.getName());
            map.put("href","");
            String type = mu.getType().trim().toUpperCase();
            String t_url="";
            if(mu.getUrl().contains("?")){
                t_url = mu.getUrl()+"&menuCode=";
            }
            else{
                t_url = mu.getUrl()+"?menuCode=";
            }
            if(type.equals("SYSTEM")){
                map.put("href", serverURL + t_url + mu.getCode() );//链接通用后台
            }else {
                map.put("href",hmiUrl + t_url + mu.getCode());//链接HMI自己的功能链接
            }
            maplist.add(map);
        });
        return  maplist.size()>0 ? JSONArray.fromObject(maplist).toString() : "[]";
    }

    @RequestMapping(value = "/getMenuByUserId")
    @ResponseBody
    public String getMenuByUserId(@RequestParam("userId") String userId,
                                  @CookieValue(value = "dlSSOServerUrl",defaultValue = "") String serverURL,
                                  HttpServletRequest request,HttpServletResponse response){

        //return sysMenuService.getMenuByUserId(userId);

//        String hql = "select new com.dldata.drgs.entity.SysMenuEntity(mu.id,mu.code,mu.pCode,mu.name,mu.url,mu.img, mu.xh, mu.status, mu.sysCode, mu.type)" +
//                " from SysMenuEntity mu where mu.status <> 0 and mu.id in(select distinct( m.menuId) from " +
//                " SysUserRolesEntity r,SysRoleMenuEntity m  " +
//                " where  r.roleId = m.roleId and r.uerId = '" + userId + "'" +
//                " and m.isBrowse =true ) and mu.sysCode='" + sysConfig.SysCode + "' order by mu.xh";
        String sysCode =  sysConfig.SysCode;
        List<SysMenuEntity>  list=  sysMenuService.fineBySysCode(sysCode,userId);

        List<SysMenuEntity>  dataList=  sysMenuService.findByCondition(dictionaryConfig.getDataDownUpCode()+"%",sysCode);
        list.removeAll(dataList);
        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userId,sysCode);
        List<DicJgdmTzEntity> dicJgdmTzEntities = dicJgdmTzService.findJgdmByUseridRole(userId);
        boolean isc = false;
        if(dicJgdmTzEntities.size()>0){
            for (DicJgdmTzEntity dicJgdmTzEntity : dicJgdmTzEntities) {
                if(dicJgdmTzEntity.getMenuRole()!=null&&dicJgdmTzEntity.getMenuRole()){
                    isc = true;
                    break;
                }
            }
        }
        if((sysUserInfoPtEntity==null||(sysUserInfoPtEntity.getUserType()!=null&&sysUserInfoPtEntity.getUserType().equals("机构")))
                &&isc){
            list.addAll(dataList);
        }
//        if(sysUserInfoPtEntity!=null&&sysUserInfoPtEntity.getMenuRole()!=null&&sysUserInfoPtEntity.getMenuRole()){
//            list.addAll(dataList);
//        }

        String hmiUrl = request.getScheme() +"://" + request.getServerName() + ":" +request.getServerPort();

        List<Map<String,String>> maplist = new ArrayList<Map<String,String>>();
        list.forEach(mu -> {
            Map<String,String> map = new HashMap<String, String>();
            map.put("id",mu.getCode());
            map.put("pid",mu.getpCode());
            map.put("dm",mu.getCode());
            map.put("mc", mu.getName());
            map.put("href","");
            String type = mu.getType().trim().toUpperCase();
            String t_url="";
            if(mu.getUrl().contains("?")){
                t_url = mu.getUrl()+"&menuCode=";
            }
            else{
                t_url = mu.getUrl()+"?menuCode=";
            }
            if(type.equals("SYSTEM")){
                map.put("href", serverURL + t_url + mu.getCode() );//链接通用后台
            }else {
                map.put("href",hmiUrl + t_url + mu.getCode());//链接HMI自己的功能链接
            }
            maplist.add(map);
        });
        return  maplist.size()>0 ? JSONArray.fromObject(maplist).toString() : "[]";
    }

    @RequestMapping(value = "/getAllMenu")
    @ResponseBody
    public List<MenuNode> getAllMenu(@CookieValue(value = "syscode",defaultValue = "") String sysCode) {

        List<SysMenuEntity> menuEntities =  sysMenuService.getAllMenu(sysCode);
        for(SysMenuEntity s : menuEntities){
            if(s.getStatus()==0){
                s.setName(s.getName()+"[已删除]");
            }
        }
        List<MenuNode> nodes = new ArrayList<MenuNode>();

        if (menuEntities != null) {
            List<SysMenuEntity> menus = menuEntities.stream().filter(m -> m.getCode().length() == 3).collect(Collectors.toList());
            menus.forEach((p) -> {
                MenuNode node = new MenuNode();
                node.setId(p.getId());
                node.setText("[" + p.getCode() + "]"+p.getName());

                Attributes attributes = new Attributes();
                if (p.getUrl() != null) {
                    attributes.setUrl(p.getUrl());
                }
                if (p.getPrintUrl() != null) {
                    attributes.setPrintUrl(p.getPrintUrl());
                }
                node.setAttributes(attributes);
                List<MenuNode> childnodes = new ArrayList<MenuNode>();
                childnodes = _getChildNodeByNodeCode(p.getCode(), menuEntities);
                if (childnodes.size() != 0) {
                    node.setChildren(childnodes);
                } else {
                    if (p.getType().equals("function")) {
                        node.setIconCls("icon-function");
                    } else if (p.getType().equals("BI")) {
                        node.setIconCls("icon-picture");
                    } else if (p.getType().equals("BIolap")) {
                        node.setIconCls("icon-olap");
                    } else if (p.getType().equals("comment")) {
                        node.setIconCls("icon-comment");
                    } else if (p.getType().equals("report")) {
                        node.setIconCls("icon-report");
                    } else if (p.getType().equals("form")) {
                        node.setIconCls("icon-form");
                    } else if (p.getType().equals("excel")) {
                        node.setIconCls("icon-execl");
                    } else if (p.getType().equals("sort")) {
                        node.setIconCls("icon-function");
                    } else {
                        node.setIconCls("icon-function");
                    }
                }
                if (p.getStatus() == 0&&childnodes.size() != 0) {
                    node.setState("closed");
                } else {
                    node.setState("open");
                }
                nodes.add(node);
            });
        }
        return nodes;
    }


    @RequestMapping(value = "/getMenu")
    @ResponseBody
    public SysMenuEntity getMenu(@RequestParam("id") String id) {
        SysMenuEntity entity = new SysMenuEntity();
        entity = sysMenuService.findOne(id);
        return entity;
    }

    @RequestMapping(value = "/save")
    public void save(SysMenuEntity menuEntity, String refCode, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            if (menuEntity.getId().equals("")) {
                menuEntity.setId(UUID.randomUUID().toString());
                List<SysMenuEntity> menuEntities = new ArrayList<SysMenuEntity>();
                if (menuEntity.getCode() != null && refCode != null) {
                    int length = menuEntity.getCode().length();
                    String pCode = menuEntity.getCode().substring(0,length-3);
                    if (length != refCode.length() + 3 || !pCode.equals(refCode)) {
                        result = "{\"success\":false,\"msg\":\"必须由父菜单代码加上三位数组成！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                menuEntities = sysMenuService.findOneByCode(menuEntity.getCode(), sysCode);
                if (menuEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                if (!menuEntity.getpCode().equals("")) {
                    menuEntities = sysMenuService.findOneByCode(menuEntity.getpCode(), sysCode);
                    if (menuEntities.size() == 0) {
                        result = "{\"success\":false,\"msg\":\"父代码不存在！\",\"id\":\"#pCode\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            } else {
                String id = menuEntity.getId();
                if (menuEntity.getCode() != null && refCode != null) {
                    int length = menuEntity.getCode().length();
                    String pCode = menuEntity.getCode().substring(0,length-3);
                    if (length != refCode.length() + 3 || !pCode.equals(refCode)) {
                        result = "{\"success\":false,\"msg\":\"必须由父菜单代码加上三位数组成！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                SysMenuEntity menu = sysMenuService.findOne(id);
                String oldCode = menu.getCode();
                String oldpCode = menu.getpCode();
                List<SysMenuEntity> menuEntities = new ArrayList<SysMenuEntity>();
                if (!menuEntity.getCode().equals(oldCode)) {
                    menuEntities = sysMenuService.findOneByCode(menuEntity.getCode(), sysCode);
                    if (menuEntities.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"代码已存在！\",\"id\":\"#code\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                if (!menuEntity.getpCode().equals("")) {
                    if (!menuEntity.getpCode().equals(oldpCode)) {
                        menuEntities = sysMenuService.findOneByCode(menuEntity.getpCode(), sysCode);
                        if (menuEntities.size() == 0) {
                            result = "{\"success\":false,\"msg\":\"父代码不存在！\",\"id\":\"#pCode\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }

            }
            if (menuEntity.getXh() == null) {
                menuEntity.setXh(0);
            }
            if (menuEntity.getType() == null) {
                menuEntity.setType("function");
            }
            menuEntity.setStatus(1);
            menuEntity.setSysCode(sysCode);
            sysMenuService.save(menuEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveMenu() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            SysMenuEntity menuEntity = sysMenuService.findOne(id);
            menuEntity.setStatus(0);
            sysMenuService.save(menuEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".delete() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    private List<MenuNode> _getChildNodeByNodeCode(String nodePCode, List<SysMenuEntity> menuEntities) {

        List<MenuNode> nodes = new ArrayList<MenuNode>();
        for (SysMenuEntity menuEntity : menuEntities) {
            if (menuEntity.getpCode().equals(nodePCode)) {
                MenuNode node = new MenuNode();
                node.setId(menuEntity.getId());
                node.setText("[" + menuEntity.getCode() + "]" + menuEntity.getName());

                Attributes attributes = new Attributes();
                attributes.setUrl(menuEntity.getUrl());
//                if (!menuEntity.getPrintUrl().equals("") || menuEntity.getPrintUrl() != null) {
//                    attributes.setPrintUrl(menuEntity.getPrintUrl());
//                }
                node.setAttributes(attributes);
                List<MenuNode> childnodes = new ArrayList<MenuNode>();
                childnodes = _getChildNodeByNodeCode(menuEntity.getCode(), menuEntities);
                if (childnodes.size() != 0) {
                    node.setChildren(childnodes);
                } else {
                    if (menuEntity.getType().equals("function")) {
                        node.setIconCls("icon-function");
                    } else if (menuEntity.getType().equals("BI")) {
                        node.setIconCls("icon-picture");
                    } else if (menuEntity.getType().equals("BIolap")) {
                        node.setIconCls("icon-olap");
                    } else if (menuEntity.getType().equals("comment")) {
                        node.setIconCls("icon-comment");
                    } else if (menuEntity.getType().equals("report")) {
                        node.setIconCls("icon-report");
                    } else if (menuEntity.getType().equals("form")) {
                        node.setIconCls("icon-form");
                    } else if (menuEntity.getType().equals("excel")) {
                        node.setIconCls("icon-execl");
                    } else {
                        node.setIconCls("icon-function");
                    }
                }
                if (menuEntity.getStatus() == 0&&childnodes.size() != 0) {
                    node.setState("closed");
                } else {
                    node.setState("open");
                }
                nodes.add(node);
            }
        }
        return nodes;
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<MenuNode> findByCondition(@CookieValue(value = "syscode",defaultValue = "") String sysCode,String condition) {

        String result;
        List<MenuNode> nodes = new ArrayList<MenuNode>();
        if (condition == "") {
            return getAllMenu(sysCode);
        }
        List<SysMenuEntity> menuEntities = sysMenuService.findByCondition("%" + condition + "%", sysCode);
        if (menuEntities != null) {

            List<SysMenuEntity> firstLevels = menuEntities.stream().filter(m -> m.getCode().length() >= 3).collect(Collectors.toList());
            firstLevels.forEach((p) -> {
                MenuNode node = new MenuNode();
                node.setId(p.getId());
                node.setText("[" + p.getCode() + "]"+p.getName());
                if (p.getType().equals("function")) {
                    node.setIconCls("icon-function");
                } else if (p.getType().equals("BI")) {
                    node.setIconCls("icon-picture");
                } else if (p.getType().equals("BIolap")) {
                    node.setIconCls("icon-olap");
                } else if (p.getType().equals("comment")) {
                    node.setIconCls("icon-comment");
                } else if (p.getType().equals("report")) {
                    node.setIconCls("icon-report");
                } else if (p.getType().equals("form")) {
                    node.setIconCls("icon-form");
                } else if (p.getType().equals("excel")) {
                    node.setIconCls("icon-execl");
                } else {
                    node.setIconCls("icon-function");
                }
                Attributes attributes = new Attributes();
                attributes.setUrl(p.getUrl());
//                if (!p.getPrintUrl().equals("") || p.getPrintUrl() != null) {
//                    attributes.setPrintUrl(p.getPrintUrl());
//                }
                node.setAttributes(attributes);
                List<MenuNode> childnodes = new ArrayList<MenuNode>();
                childnodes = _getChildNodeByNodeCode(p.getCode(), menuEntities);
                node.setChildren(childnodes);

                if (p.getStatus() == 0&&childnodes.size() != 0) {
                    node.setState("closed");
                } else {
                    node.setState("open");
                }
                nodes.add(node);
            });
        }
        return nodes;
    }



    private class MenuNode {
        private String id;
        private String text;
        private String state;
        private String iconCls;
        private Attributes attributes;
        private List<MenuNode> children;


        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public List<MenuNode> getChildren() {
            return children;
        }

        public void setChildren(List<MenuNode> children) {
            this.children = children;
        }

        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }

        public String getIconCls() {
            return iconCls;
        }

        public void setIconCls(String iconCls) {
            this.iconCls = iconCls;
        }

        public Attributes getAttributes() {
            return attributes;
        }

        public void setAttributes(Attributes attributes) {
            this.attributes = attributes;
        }
    }

    private class Attributes {
        private String url;
        private String printUrl;
        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getPrintUrl() {
            return printUrl;
        }

        public void setPrintUrl(String printUrl) {
            this.printUrl = printUrl;
        }
    }

    @RequestMapping("/downMenu")
    public void downMenu(HttpServletRequest request,HttpServletResponse response,
                         @CookieValue(value = "syscode",defaultValue = "") String sysCode) throws Exception{
        String result;

        try {
            List<SysMenuEntity> menuEntities =  sysMenuService.getAllMenu(sysCode);
            JSONArray jsonArr = JSONArray.fromObject(menuEntities);
            /* 写入Txt文件 */
            // 相对路径，如果没有则要建立一个新的output。txt文件
            String filepath=request.getSession().getServletContext().getRealPath("");
            File fileUrl = new File(filepath+"\\"+DateUtil.formatFromDate("yyyyMMddHHmmssSSS", Calendar.getInstance().getTime())+".txt");
            fileUrl.createNewFile(); // 创建新文件
            BufferedWriter out = new BufferedWriter(new FileWriter(fileUrl));
            out.write(jsonArr.toString()); // \r\n即为换行
            out.flush(); // 把缓存区内容压入文件
            out.close(); // 关闭文件

            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            try {
                String fileName =fileUrl.getName();
                response.setContentType("application/octet-stream");
                response.setCharacterEncoding("UTF-8");
                response.setHeader("Content-disposition","attachment; filename="+ fileName);

                response.setContentLength((int)fileUrl.length());

                bis = new BufferedInputStream(new FileInputStream(fileUrl));
                bos = new BufferedOutputStream(response.getOutputStream());

                byte[] buff = new byte[2048];
                int bytesRead = 0;
                while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                    bos.write(buff, 0, bytesRead);
                }
                bos.flush();

            }catch(Exception e){
                e.printStackTrace();
            } finally {
                if(bis != null){
                    try{
                        bis.close();
                    }
                    catch(IOException e){
                        e.printStackTrace();
                    }
                    bis=null;
                }
                if(bos != null){
                    try{
                        bos.close();
                    }catch(IOException e){
                        e.printStackTrace();
                    }
                    bos=null;
                }
            }
            try{
                fileUrl.delete();//成功导出后删除文件
            }catch(Exception e){
            }

            result = "{\"success\":true,\"msg\":\"导出成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".downMenu() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/loadMenu")
    public String loadMenu(){
        return "System/SysMenuLoad";
    }
    @RequestMapping("/doLoadMenu")
    public void doLoadMenu(String json,HttpServletRequest request,HttpServletResponse response) throws Exception{
        String result;
        try {
        JSONArray jsonArray = JSONArray.fromObject(json);
        List<SysMenuEntity> list = (List<SysMenuEntity>) jsonArray.toCollection(jsonArray, SysMenuEntity.class);
        sysMenuService.saveList(list);

        result = "{\"success\":true,\"msg\":\"导入成功！\"}";
    }
    catch (Exception ex){
        result = "{\"success\":false,\"msg\":\"导入失败，请核对数据！\"}";
        logger.error("【执行"+this.getClass().getName()+".doLoadMenu() 方法失败 】异常："+ex.getMessage());
    }
    StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/findMenu")
    @ResponseBody
    public String findMenu(@CookieValue(value = "syscode",defaultValue = "") String sysCode,String search) {
        List<SysMenuEntity> menuEntities =  sysMenuService.getAllMenu(sysCode);
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        menuEntities.stream().filter(m->m.getName().indexOf(search)>-1||m.getCode().indexOf(search)>-1).forEach(m-> {
            List<SysMenuEntity> child = menuEntities.stream().filter(cm->m.getCode().equals(cm.getpCode())).collect(Collectors.toList());
            if(child.size()<1){
            Map<String,String> map = new HashMap<String,String>();
            map.put("id",m.getId());
            map.put("pname","");
            String type ="";
            switch (m.getType()){
                case "function" :
                    type = "功能";
                    break;
                case "System" :
                    type = "系统";
                    break;
                case "sort" :
                    type = "分类";
                    break;
                case "BI" :
                    type = "BI图表";
                    break;
                case "BIolap" :
                    type = "BIolap";
                    break;
                case "comment" :
                    type = "BI评价方案";
                    break;
                case "report" :
                    type = "BI分析报告";
                    break;
                case "form" :
                    type = "自定义表单";
                    break;
                case "excel" :
                    type = "Excel导入";
                    break;
            }
            map.put("type",type);
            menuEntities.stream().filter(pm -> pm.getCode().equals(m.getpCode())).limit(1).forEach(pm-> {
                map.put("pname",pm.getName());
            });
            map.put("code",m.getCode());
            map.put("name",m.getName());
            map.put("pym",StringUtil.getPinYinHeadChar(m.getName()).toLowerCase());
            map.put("ppym",StringUtil.getPinYinHeadChar(map.get("pname")).toLowerCase());
            mapList.add(map);
            }
        });
        return mapList.size()>0?JSONArray.fromObject(mapList).toString():"[]";
    }
}
