package com.dldata.drgs.controller.drgsDicData;

import com.dldata.drgs.entity.DicJgdmEntity;
import com.dldata.drgs.entity.DicJgdmTzEntity;
import com.dldata.drgs.entity.DicXzqhEntity;
import com.dldata.drgs.entity.DicYylbEntity;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import com.dldata.drgs.service.drgsDicData.DicJgdmTzService;
import com.dldata.drgs.service.drgsDicData.DicXzqhService;
import com.dldata.drgs.service.drgsDicData.DicYylbService;
import com.dldata.drgs.utils.GridJson;
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
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Controller
@RequestMapping("/DicJgdm")
public class DicJgdmController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DicJgdmService dicJgdmService;

    @Autowired
    private DicYylbService dicYylbService;

    @Autowired
    private DicXzqhService dicXzqhService;

    @Autowired
    private DicJgdmTzService dicJgdmTzService;


    @RequestMapping("/save")
    public void save(DicJgdmEntity dicJgdmEntity, HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            if (dicJgdmEntity.getDm().equals("")) {
                dicJgdmEntity.setDm(UUID.randomUUID().toString());
            }
            dicJgdmService.save(dicJgdmEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveKeShi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/getAllJjdm")
    @ResponseBody
    public String getAllJjdm(String xzqh ,String jglb){
        String json = "[]";
        StringBuilder _str = new StringBuilder();

        List<DicJgdmTzEntity> dicJgdmTzEntity = dicJgdmTzService.getAll();

        List<DicJgdmEntity> dicJgdmEntityLisy = new ArrayList<DicJgdmEntity>();
        if(!xzqh.equals("")&&!jglb.equals("")){
            dicJgdmEntityLisy = dicJgdmService.getAllDataByXzqgJglbLikeLeft(xzqh,jglb);

        }else if(!xzqh.equals("")){
            dicJgdmEntityLisy = dicJgdmService.findByXzqg(xzqh);
        }else {
            dicJgdmEntityLisy = dicJgdmService.getAllData();
        }
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();

        dicJgdmEntityLisy.forEach(d -> {
            Map<String, String> map = new HashMap<String, String>();
            map.put("xh", d.getXh() == null ? "" : d.getXh().toString());
            map.put("pass","");
            map.put("menu","无");
            dicJgdmTzEntity.stream().filter(t -> t.getDm().equals(d.getDm())).limit(1).forEach(t -> {
                map.put("menu",t.getMenuRole()==null?"无":t.getMenuRole()?"有":"无");
                map.put("pass",t.getRandPass()==null?"":t.getRandPass());
            });
            map.put("gid", d.getGid());
            map.put("mc", d.getMc());
            map.put("xzqh", d.getXzqh());
            map.put("xzqhmc", d.getXzqhmc());
            map.put("sheng", d.getSheng());
            map.put("shi", d.getShi());
            map.put("xian", d.getXian());
            map.put("jgdm", d.getJgdm());
            map.put("yyfr", d.getYyfr());
            map.put("yyzrr", d.getYyzrr());
            map.put("tel", d.getTel());
            map.put("yyjb", d.getYyjb());
            map.put("yydj", d.getYydj());
            map.put("yylb", d.getYylb());
            map.put("issz", d.getIssz());
            map.put("isbjorqg", d.getIsbjorqg() == null?"":d.getIsbjorqg().toString());
            map.put("iscwtj", d.getIscwtj() == null?"":d.getIscwtj().toString());
            map.put("jc", d.getJc());
            map.put("sysb", d.getSysb() == null ? "" :d.getSysb().toString());
            map.put("bzcw", d.getBzcw() == null ? "" : d.getBzcw().toString());
            map.put("sjkfvw",d.getSjkfcw() == null ? "" : d.getSjkfcw().toString());
            map.put("zbys", d.getZbys() == null ? "" : d.getZbys().toString());
            map.put("zbzyhs", d.getZbzyhs() == null ? "" : d.getZbzyhs().toString());
            map.put("htyss", d.getHtyss() == null ? "" : d.getHtyss().toString());
            map.put("hthss", d.getHthss() == null ? "" : d.getHthss().toString());
            map.put("zymj",  d.getZymj() == null ? "" : d.getZymj().toString());
            map.put("mzmj",  d.getMzmj() == null ? "" : d.getMzmj().toString());
            map.put("id",  d.getDm());
            map.put("jglbdm",  d.getJglbdm());

            _str.append(GridJson.ToDhmlxGridJson("id", "xh,menu,pass,id,mc,xzqh,xzqhmc,sheng,shi,xian,jgdm," +
                    "yyfr,yyzrr,tel,yyjb,yydj,yylb,issz,isbjorqg,iscwtj,jc,sysb,bzcw,sjkfvw,zbys,zbzyhs,htyss," +
                    "hthss,zymj,mzmj,gid,jglbdm", map, true));

        });

        json = "{\"rows\": [" + GridJson.trimEnd(_str.toString(), ',') + "]}";

        return json;
    }


    @RequestMapping(value = "/getTree")
    @ResponseBody
    public List<MenuNode> getTree(@CookieValue(value = "syscode",defaultValue = "") String sysCode) {

        List<DicJgdmEntity> dicJgdmEntityLisy = dicJgdmService.getAllData();
        List<DicXzqhEntity> dicXzqhEntities =  dicXzqhService.getAllData();
        List<DicYylbEntity> dicYylbEntities = dicYylbService.getAllData();

        List<MenuNode> nodes = new ArrayList<MenuNode>();

        if (dicJgdmEntityLisy != null) {
            List<DicXzqhEntity> menus = dicXzqhEntities.stream().filter(m -> m.getDm().length() == 2).collect(Collectors.toList());
            menus.forEach((p) -> {
                dicJgdmEntityLisy.stream().filter(x -> p.getDm().equals(x.getXzqh()==null?"":
                        x.getXzqh().length()<2?x.getXzqh():x.getXzqh().substring(0,2))).limit(1).forEach(x ->{
                    MenuNode node = new MenuNode();
                    node.setId(p.getDm());
                    node.setText(p.getMc());

                    Attributes attributes = new Attributes();
                    attributes.setUrl("&xzqh="+p.getDm()+"&jglb=");
                    node.setAttributes(attributes);
                    List<MenuNode> childnodes = new ArrayList<MenuNode>();
                    childnodes = _getChildNodeByNodeCode(p.getDm(),dicJgdmEntityLisy, dicXzqhEntities,dicYylbEntities,4);
                    if (childnodes.size() != 0) {
                        node.setChildren(childnodes);
                        node.setState("closed");
                    } else {
                        node.setIconCls("icon-function");
                        node.setState("open");
                    }
                    nodes.add(node);
                });
            });
        }
        return nodes;
    }

    private List<MenuNode> _getChildNodeByNodeCode(String nodePCode,List<DicJgdmEntity> dicJgdmEntityLisy, List<DicXzqhEntity> dicXzqhEntities,List<DicYylbEntity> dicYylbEntities,int dmLength) {

        List<MenuNode> nodes = new ArrayList<MenuNode>();
        List<DicXzqhEntity> menus = dicXzqhEntities.stream().filter(m -> m.getDm().length() == dmLength).collect(Collectors.toList());
        menus.forEach((menuEntity) -> {
            dicJgdmEntityLisy.stream().filter(x -> menuEntity.getDm().equals(x.getXzqh()==null?"":
                    x.getXzqh().length()<dmLength?x.getXzqh():x.getXzqh().substring(0,dmLength))).limit(1).forEach(x ->{
                String dm = menuEntity.getDm() == null ? "" : menuEntity.getDm().substring(0, dmLength - 2);
                if (dm.equals(nodePCode)) {
                    MenuNode node = new MenuNode();
                    node.setId(menuEntity.getDm());
                    node.setText(menuEntity.getMc());

                    Attributes attributes = new Attributes();
                    attributes.setUrl("&xzqh="+menuEntity.getDm()+"&jglb=");
                    node.setAttributes(attributes);
                    List<MenuNode> childnodes = new ArrayList<MenuNode>();
                    if (dmLength == x.getXzqh().length()) {

                        childnodes =  _getYylb("",menuEntity.getWdm(), dicJgdmEntityLisy,dicYylbEntities,1);
                    }else{
                        childnodes = _getChildNodeByNodeCode(menuEntity.getDm(),dicJgdmEntityLisy, dicXzqhEntities,dicYylbEntities, dmLength + 2);
                    }
                    if (childnodes.size() != 0) {
                        node.setChildren(childnodes);
                        node.setState("closed");
                    } else {
                        node.setIconCls("icon-function");
                        node.setState("open");
                    }

                    nodes.add(node);
                }
            });
        });
        return nodes;
    }

    private List<MenuNode> _getYylb(String nodePCode,String xzqhdm ,List<DicJgdmEntity> dicJgdmEntityLisy, List<DicYylbEntity> dicYylbEntities,int dmLength) {
        List<MenuNode> nodes = new ArrayList<MenuNode>();


        List<DicYylbEntity> menus = dicYylbEntities.stream().filter(m -> m.getDm().length() == dmLength).collect(Collectors.toList());
        menus.forEach(menuEntity -> {
            dicJgdmEntityLisy.stream().filter(x -> menuEntity.getDm().equals(x.getJglbdm()==null?"":
                    x.getJglbdm().length()<dmLength?x.getJglbdm():x.getJglbdm().substring(0,dmLength))&&xzqhdm.equals(x.getXzqh())).limit(1).forEach(x -> {
                String dm ="";
                if(dmLength>3){
                     dm = menuEntity.getDm() == null ? "" : menuEntity.getDm().substring(0, dmLength-2);
                }
                else {
                     dm = menuEntity.getDm() == null ? "" : menuEntity.getDm().substring(0, dmLength-1);
                }

                if (dm.equals(nodePCode)||nodePCode.equals("")) {
                    MenuNode node = new MenuNode();
                    node.setId(menuEntity.getDm());
                    node.setText(menuEntity.getMc());

                    Attributes attributes = new Attributes();
                    attributes.setUrl("&xzqh="+xzqhdm+"&jglb="+menuEntity.getDm());
                    node.setAttributes(attributes);
                    List<MenuNode> childnodes = new ArrayList<MenuNode>();
                   if(dmLength==2){
                       childnodes =  _getYylb(x.getJglbdm().substring(0,dmLength), xzqhdm,dicJgdmEntityLisy,dicYylbEntities,dmLength+2);
                   }else{
                       childnodes =  _getYylb(x.getJglbdm().substring(0,dmLength), xzqhdm,dicJgdmEntityLisy,dicYylbEntities,dmLength+1);
                   }

                    if (childnodes.size() != 0) {
                        node.setChildren(childnodes);
                        node.setState("closed");
                    } else {
                        node.setIconCls("icon-function");
                        node.setState("open");
                    }

                    nodes.add(node);
                }
            });
        });


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

    @RequestMapping("/del")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            dicJgdmService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}




