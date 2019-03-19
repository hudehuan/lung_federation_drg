package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysMenuEntity;
import com.dldata.drgs.entity.SysMenuTemplateDefineEntity;
import com.dldata.drgs.entity.SysMenuTemplateEntity;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysMenuTemplateDefineService;
import com.dldata.drgs.service.System.SysMenuTemplateService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Created by admin on 2017/2/4.
 */
@Controller
@RequestMapping(value = "/sysMenuTemplate")
public class SysMenuTemplateController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SysMenuTemplateService sysMenuTemplateService;

    @Autowired
    public SysMenuTemplateDefineService sysMenuTemplateDefineService;
    @Autowired
    private SysMenuService sysMenuService;

//    @RequestMapping("/toSysFunctionMenuView")
//    public String toSysFunctionMenuView(String id){
//        return "System/SysFunctionMenuView";
//    }

    @RequestMapping("/saveTemplate")
    public void saveTemplate(SysMenuTemplateDefineEntity sysMenuTemplateDefineEntity,
                         @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                         HttpServletRequest request,HttpServletResponse response) throws Exception{
        String result;
        String tid = "";
        try {
            if(sysMenuTemplateDefineEntity.getTid().equals("")){
                //新增数据
                tid = UUID.randomUUID().toString();
                sysMenuTemplateDefineEntity.setTid(tid);
                List<SysMenuTemplateDefineEntity> sEntity = sysMenuTemplateDefineService.findByName(sysMenuTemplateDefineEntity.getName());
                if(sEntity.size()>0){
                    result = "{\"success\":false,\"msg\":\"模板名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
                List<SysMenuEntity> sysMenuEntity = sysMenuService.findAllBySysCode(sysCode);
                if(sysMenuEntity!=null){
                    for(SysMenuEntity s : sysMenuEntity){
                        SysMenuTemplateEntity sysMenuTemplateEntity = new SysMenuTemplateEntity();
                        sysMenuTemplateEntity.setId(UUID.randomUUID().toString());
                        sysMenuTemplateEntity.setCode(s.getCode());
                        sysMenuTemplateEntity.setpCode(s.getpCode());
                        sysMenuTemplateEntity.setName(s.getName());
                        sysMenuTemplateEntity.setUrl(s.getUrl());
                        sysMenuTemplateEntity.setPrintUrl(s.getPrintUrl());
                        sysMenuTemplateEntity.setImg(s.getImg());
                        sysMenuTemplateEntity.setXh(s.getXh());
                        sysMenuTemplateEntity.setStatus(s.getStatus());
                        sysMenuTemplateEntity.setSysCode(s.getSysCode());
                        sysMenuTemplateEntity.setType(s.getType());
                        sysMenuTemplateEntity.setTid(tid);
                        sysMenuTemplateService.save(sysMenuTemplateEntity);
                    }
                }
            }else{
                SysMenuTemplateDefineEntity sysMenuTemplateDefine = sysMenuTemplateDefineService.findOne(sysMenuTemplateDefineEntity.getTid());
                if(!sysMenuTemplateDefine.getName().equals(sysMenuTemplateDefineEntity.getName())){
                    List<SysMenuTemplateDefineEntity> sEntity = sysMenuTemplateDefineService.findByName(sysMenuTemplateDefineEntity.getName());
                    if(sEntity.size()>0){
                        result = "{\"success\":false,\"msg\":\"模板名称已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }

            }
            sysMenuTemplateDefineEntity.setStatus(true);

            sysMenuTemplateDefineService.save(sysMenuTemplateDefineEntity);

            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping("/SysMenuTemplateEntity")
    @ResponseBody
    public SysMenuTemplateEntity SysMenuTemplateEntity(String id){
        SysMenuTemplateEntity sysMenuTemplateEntity = sysMenuTemplateService.findById(id);
        return sysMenuTemplateEntity;
    }


    @RequestMapping("/getAllMenuTemplate")
    @ResponseBody
    public List<SysMenuTemplateDefineEntity> getAllMenuTemplate(String search){
        List<SysMenuTemplateDefineEntity> sysMenuTemplateDefineEntity = sysMenuTemplateDefineService.findBySearch("%"+search+"%");
        return sysMenuTemplateDefineEntity;
    }

    @RequestMapping("/getUpdateMenu")
    @ResponseBody
    public SysMenuTemplateDefineEntity getUpdateMenu(String id){
        return sysMenuTemplateDefineService.findOne(id);
    }

    @RequestMapping("/delete")
    public void delete(String tid,HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try{
            SysMenuTemplateDefineEntity sysMenuTemplateDefineEntity= sysMenuTemplateDefineService .findOne(tid);
            sysMenuTemplateDefineEntity.setStatus(false);
            sysMenuTemplateDefineService.save(sysMenuTemplateDefineEntity);

            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/saveMenu")
    public void saveMenu(String tid,
                             HttpServletRequest request,HttpServletResponse response) throws Exception{
        String result;
        try {
            List<SysMenuTemplateEntity> sysMenuTemplateEntities = sysMenuTemplateService.findAllByTid(tid);

            for(SysMenuTemplateEntity s : sysMenuTemplateEntities){
                SysMenuEntity sysMenuEntity = new SysMenuEntity();
                sysMenuEntity.setId(UUID.randomUUID().toString());
                sysMenuEntity.setCode(s.getCode());
                sysMenuEntity.setpCode(s.getpCode());
                sysMenuEntity.setName(s.getName());
                sysMenuEntity.setUrl(s.getUrl());
                sysMenuEntity.setImg(s.getImg());
                sysMenuEntity.setXh(s.getXh());
                sysMenuEntity.setStatus(s.getStatus());
                sysMenuEntity.setSysCode(s.getSysCode());
                sysMenuEntity.setType(s.getType());
                sysMenuEntity.setPrintUrl(s.getPrintUrl());
                sysMenuService.save(sysMenuEntity);
            }

            result = "{\"success\":true,\"msg\":\"保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/getAllMenu")
    @ResponseBody
    public List<MenuNode> getAllMenu(@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                     String tid) {
        List<SysMenuTemplateEntity> menuEntities = sysMenuTemplateService.findAllByTid(tid);
//        List<SysMenuEntity> menuEntities =  sysMenuService.getAllMenu(sysCode);
        for(SysMenuTemplateEntity s : menuEntities){
            if(s.getStatus()==0){
                s.setName(s.getName()+"[已删除]");
            }
        }
        List<MenuNode> nodes = new ArrayList<MenuNode>();

        if (menuEntities != null) {
            List<SysMenuTemplateEntity> menus = menuEntities.stream().filter(m -> m.getCode().length() == 3).collect(Collectors.toList());
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


    private List<MenuNode> _getChildNodeByNodeCode(String nodePCode, List<SysMenuTemplateEntity> menuEntities) {

        List<MenuNode> nodes = new ArrayList<MenuNode>();
        for (SysMenuTemplateEntity menuEntity : menuEntities) {
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
}
