package com.dldata.drgs.controller.FormDefine;

import com.dldata.drgs.entity.FormItemEntity;
import com.dldata.drgs.entity.FormItemTypeEntity;
import com.dldata.drgs.service.FormDefine.FormItemService;
import com.dldata.drgs.service.FormDefine.FormItemTypeService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
 * Created by admin on 2016/8/12.
 */

@Controller
@RequestMapping(value = "/formItemType")
public class FormItemTypeController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    FormItemTypeService formItemTypeService;

    @Autowired
    FormItemService formItemService;

    @RequestMapping(value = "/toList")
    public String toList() {
        return "FormDefine/FormItem";
    }

    @RequestMapping(value = "/getAllFormItemType")
    @ResponseBody
    public List<MenuNode> getAllFormItem(@CookieValue(value = "syscode",defaultValue = "") String sysCode,Model model,
                                         HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<FormItemTypeEntity> formItemTypes = formItemTypeService.getAllFormItemType(sysCode);
        List<MenuNode> nodes = new ArrayList<MenuNode>();

        List<FormItemTypeEntity> firstLevels = formItemTypes.stream().filter(t -> t.getLevel().length() == 3).collect(Collectors.toList());

//        List<FormItemTypeEntity> firstLevels2 = formItemTypes.stream().
//                filter(t->t.getLevel().length()==3).forEach((p)->{
//
//        });
//
//                collect(Collectors.toList());

        for (FormItemTypeEntity firstLevel : firstLevels) {
            MenuNode node = new MenuNode();
            node.setId(firstLevel.getTypeId());
            node.setText(firstLevel.getTypeName());
            List<MenuNode> children = _getChildNodeByNodeCode(firstLevel.getLevel(), formItemTypes);
            node.setChildren(children);
            if (children.size() == 0) {
                node.setState("open");
            } else {
                node.setState("closed");
            }
            node.setIconCls("icon-function");
            Attribute attribute = new Attribute();
            attribute.setLevel(firstLevel.getLevel());
            node.setAttribute(attribute);
            nodes.add(node);
        }

//        String result;
//        for(FormItemTypeEntity formItemType :formItemTypes){
//            if(formItemType.getLevel().length()==3){


//                MenuNode node = new MenuNode();
//                node.setId(formItemType.getTypeId());
//                node.setText(formItemType.getTypeName());
//                List<MenuNode> children = _getChildNodeByNodeCode(formItemType.getLevel(),formItemTypes);
//                node.setChildren(children);
//                if(children.size() ==0){
//                    node.setState("open");
//                }else{
//                    node.setState("closed");
//                }
//                nodes.add(node);
//            }
//        }
        return nodes;
    }

//    @RequestMapping(value = "/toSave")
//    public String toSave(String id, Model model, @CookieValue(value = "syscode",defaultValue = "") String sysCode) {
//        FormItemTypeEntity formItemType = new FormItemTypeEntity();
//        String pLevel = "";
//        if (!id.equals("")) {
//            formItemType = formItemTypeService.findOne(id);
//            pLevel = formItemType.getLevel();
//        }
//            String level = formItemType.getLevel();
//            model.addAttribute("level", level);
//        }
//        return "FormDefine/FormItemTypeAdd";
//    }
//
//    @RequestMapping(value = "/toSaveNext")
//    public String toSaveNext(String id, Model model) {
//        if (!id.equals("")) {
//            FormItemTypeEntity formItemType = formItemTypeService.findOne(id);

//        model.addAttribute("pLevel", pLevel);
//
//        return "FormDefine/FormItemTypeAdd";
//    }

    @RequestMapping(value = "/toEdit")
    public String toEdit(String id,String pid, Model model) {
        if(id!=null&&!id.equals("")){
            FormItemTypeEntity formItemType = formItemTypeService.findOne(id);
            model.addAttribute("formItemType", formItemType);
        }
        String pLevel = "";
        if(pid!=null&&!pid.equals("")){
            FormItemTypeEntity  formItemType = formItemTypeService.findOne(pid);
            pLevel = formItemType.getLevel();
        }
        model.addAttribute("pLevel", pLevel);
        return "FormDefine/FormItemTypeEdit";
    }

    @RequestMapping(value = "/save")
    public void save(FormItemTypeEntity formItemType, String pLevel,@CookieValue(value = "syscode",defaultValue = "") String sysCode,
                     HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        String level = "";
        int xh = 0;
        try {
//            String name = formItemType.getTypeName();
//            List<FormItemTypeEntity> formItemTypeEntities = formItemTypeService.findByName(name, sysCode);
//            if (formItemTypeEntities.size() > 0) {
//                result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#typeName\"}";
//                StringUtil.writeToWeb(result, "html", response);
//                return;
//            }
            if(formItemType.getTypeId().equals("")){


            if (pLevel == null || pLevel.equals("")) {
                level = formItemTypeService.getNewLevel(sysCode);
                xh = formItemTypeService.getAllPLevel(sysCode).size() + 1;
            } else {
                level = formItemTypeService.getNextLevel(pLevel, sysCode);
                xh = formItemTypeService.getAllNextLevel(pLevel, sysCode).size() + 1;
            }
            formItemType.setLevel(level);
            if (formItemType.getXh() != null) {
                formItemType.setXh(xh);
            }

            formItemType.setTypeId(UUID.randomUUID().toString());
            if (!formItemType.getTypeName().equals("")) {
                formItemType.setPym(StringUtil.getPinYinHeadChar(formItemType.getTypeName()));
            }
            formItemType.setSysCode(sysCode);
            formItemType.setStatus(1);
            formItemTypeService.save(formItemType);
            result = "{\"success\":true,\"msg\":\"添加成功！\"}";
            }else {
                if (!formItemType.getTypeName().equals("")) {
                    formItemType.setPym(StringUtil.getPinYinHeadChar(formItemType.getTypeName()));
                }
                formItemTypeService.update(formItemType);
                result = "{\"success\":true,\"msg\":\"修改成功！\"}";
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".saveUser() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            FormItemTypeEntity formItemType = formItemTypeService.findOne(id);
            formItemType.setStatus(0);
            List<FormItemEntity> formItemEntities = formItemService.getAllFormItem(id, sysCode);
            formItemEntities.forEach((f) -> {
                f.setStatus(0);
                formItemService.save(f);
            });
            formItemTypeService.save(formItemType);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteStaff() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/update")
    public void update(FormItemTypeEntity formItemType, @CookieValue(value = "syscode",defaultValue = "") String sysCode, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            // String id = formItemType.getTypeId();
//            FormItemTypeEntity formItemTypeEntity = formItemTypeService.findOne(id);
//            String oldName = formItemTypeEntity.getTypeName();
//            if (!formItemType.getTypeName().equals(oldName)) {
//                List<FormItemTypeEntity> entities = formItemTypeService.findByName(formItemType.getTypeName(), sysCode);
//                if (entities.size() > 0) {
//                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#typeName\"}";
//                    StringUtil.writeToWeb(result, "html", response);
//                    return;
//                }
//            }
            if (!formItemType.getTypeName().equals("")) {
                formItemType.setPym(StringUtil.getPinYinHeadChar(formItemType.getTypeName()));
            }
            formItemTypeService.update(formItemType);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteStaff() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    // 删除分类时，先判断该分类下是否有元素存在。如果存在不能删除
    @RequestMapping(value = "/search")
    public void search(String id, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                       HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<FormItemEntity> formItems = new ArrayList<FormItemEntity>();
        String result;
        try{
            FormItemTypeEntity formItemType = formItemTypeService.findOne(id);
            if (formItemType != null) {
                String level = formItemType.getLevel();
                if (level.length() == 3) {
                    List<FormItemTypeEntity> formItemTypeEntities = new ArrayList<FormItemTypeEntity>();
                    formItemTypeEntities = formItemTypeService.getAllNextLevel(level, sysCode);
                    if (formItemTypeEntities.size() > 0) {
                        result = "{\"success\":false,\"msg\":\"存在二级分类，无法删除！\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
            }
            formItems = formItemService.getAllFormItem(id,sysCode);
            if (formItems.size() > 0) {
                result = "{\"success\":false,\"msg\":\"存在元素，无法删除！\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            result = "{\"success\":true,\"msg\":\"可以删除！\"}";
            StringUtil.writeToWeb(result, "html", response);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShi() 方法失败 】异常："+ex.getMessage());
        }
    }

    private List<MenuNode> _getChildNodeByNodeCode(String level, List<FormItemTypeEntity> formItemTypeEntities) {

        List<MenuNode> nodes = new ArrayList<MenuNode>();

        List<FormItemTypeEntity> firstLevels = formItemTypeEntities.stream().filter(t -> t.getLevel().length() == level.length() + 3)
                .filter(t -> t.getLevel().substring(0, level.length()).equals(level)).collect(Collectors.toList());

        for (FormItemTypeEntity nextlevel : firstLevels) {
            MenuNode node = new MenuNode();
            node.setId(nextlevel.getTypeId());
            node.setText(nextlevel.getTypeName());
            Attribute attribute = new Attribute();
            attribute.setLevel(nextlevel.getLevel());
            node.setAttribute(attribute);
            List<MenuNode> childnodes = new ArrayList<MenuNode>();
//            childnodes = _getChildNodeByNodeCode(nextlevel.getLevel(), formItemTypeEntities);
            node.setChildren(childnodes);
            if (childnodes.size() == 0) {
                node.setState("open");
            } else {
                node.setState("closed");
            }
            node.setIconCls("icon-function");
            nodes.add(node);
        }

//        for(FormItemTypeEntity formItemType : formItemTypeEntities){
//            if(formItemType.getLevel().length() > 3 && formItemType.getLevel().substring(0,3).equals(level)){
//                MenuNode node = new MenuNode();
//                node.setId(formItemType.getTypeId());
//                node.setText(formItemType.getTypeName());
//
//                List<MenuNode> childnodes = new ArrayList<MenuNode>();
//
//                node.setChildren(childnodes);
//
//                node.setState("open");
//
//                nodes.add(node);
//            }
//        }
        return nodes;
    }

    private class MenuNode {
        private String id;
        private String text;
        private String state;
        private String iconCls;
        private List<MenuNode> children;
        private Attribute attribute;

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

        public String getIconCls() {
            return iconCls;
        }

        public void setIconCls(String iconCls) {
            this.iconCls = iconCls;
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

        public Attribute getAttribute() {
            return attribute;
        }

        public void setAttribute(Attribute attribute) {
            this.attribute = attribute;
        }
    }

    private class Attribute {
        private String level;

        public String getLevel() {
            return level;
        }

        public void setLevel(String level) {
            this.level = level;
        }
    }
}


