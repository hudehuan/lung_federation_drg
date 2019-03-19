package com.dldata.drgs.controller.System;

import com.dldata.drgs.entity.SysKsMKmEntity;
import com.dldata.drgs.service.System.SysKsMKmService;
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
import java.util.stream.Collectors;

/**
 * Created by admin on 2016/9/5.
 */
@Controller
@RequestMapping(value = "/SysMKm")
public class SysKsMKmController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    SysKsMKmService ksMKmService;

    @RequestMapping(value = "/getAllKsMKm")
    @ResponseBody
    public List<MenuNode> getAllKsMKm(HttpServletRequest request, HttpServletResponse response)throws Exception{
        List<MenuNode> nodes = new ArrayList<MenuNode>();
        String result;
        try{
            List<SysKsMKmEntity> ksMKmEntities = ksMKmService.getAllKsMKm();
            if (ksMKmEntities != null) {
                List<SysKsMKmEntity> firstLevels = ksMKmEntities.stream().filter(m -> m.getDm().length() == 2).collect(Collectors.toList());
                for (SysKsMKmEntity firstLevel : firstLevels) {
                    MenuNode node = new MenuNode();
                    node.setId(firstLevel.getDm());
                    node.setText(firstLevel.getMc());
                    List<MenuNode> children = _getChildNodeByNodeCode(firstLevel.getDm(), ksMKmEntities);
                    node.setChildren(children);
                    if (children.size() == 0) {
                        node.setState("open");
                    } else {
                        node.setState("closed");
                    }
                    if (children.size() == 0) {
                        node.setIconCls("icon-function");
                    }
                    nodes.add(node);
                }
            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKsMKm() 方法失败 】异常："+ex.getMessage());
        }
        return nodes;
    }

    private List<MenuNode> _getChildNodeByNodeCode(String level, List<SysKsMKmEntity> ksMKmEntities) {

        List<MenuNode> nodes = new ArrayList<MenuNode>();

        List<SysKsMKmEntity> firstLevels = ksMKmEntities.stream().filter(t -> t.getDm().length() == level.length() + 2)
                .filter(t -> t.getDm().substring(0, level.length()).equals(level)).collect(Collectors.toList());

        for (SysKsMKmEntity nextlevel : firstLevels) {
            MenuNode node = new MenuNode();
            node.setId(nextlevel.getDm());
            node.setText(nextlevel.getMc());

            List<MenuNode> childnodes = new ArrayList<MenuNode>();
            childnodes = _getChildNodeByNodeCode(nextlevel.getDm(), ksMKmEntities);
            node.setChildren(childnodes);
            if (childnodes.size() == 0) {
                node.setState("open");
            } else {
                node.setState("closed");
            }
            node.setIconCls("icon-function");
            nodes.add(node);
        }
        return nodes;
    }

    private class MenuNode {
        private String id;
        private String text;
        private String state;
        private String iconCls;
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

    }
}
