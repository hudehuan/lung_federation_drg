package com.dldata.drgs.controller.FormDefine;

import com.dldata.drgs.entity.FormDefineEntity;
import com.dldata.drgs.entity.FormDefineFieldEntity;
import com.dldata.drgs.entity.FormItemEntity;
import com.dldata.drgs.service.FormDefine.FormDefineFieldService;
import com.dldata.drgs.service.FormDefine.FormDefineService;
import com.dldata.drgs.service.FormDefine.FormItemService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/8/12.
 */

@Controller
@RequestMapping(value = "/formDefineField")
public class FormDefineFieldController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    FormDefineFieldService formDefineFieldService;

    @Autowired
    FormDefineService formDefineService;

    @Autowired
    FormItemService formItemService;

    @RequestMapping(value = "/showTextarea")
    public void showTextarea(String tdId, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        FormDefineEntity formDefineEntity = formDefineService.findOne(tdId);
        String sql = "";
        String js = "";
        if (formDefineEntity != null) {
            sql = formDefineEntity.getTableSql();
            if (sql != null) {
                model.addAttribute("sql", sql);
            }
            js = formDefineEntity.getTableJs();
            if (js != null) {
                model.addAttribute("js", js);
            }
        }
        String result = "{\"success\":true,\"js\":\"" + js;
        result += "\",\"sql\":\"" + sql;
        result += "\"}";
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/getAllFormDefineField")
    @ResponseBody
    public List<ShowFormdfField> getAllFormDefine(String tdId, Model model, HttpServletRequest request,
                                                        HttpServletResponse response) throws Exception {
        List<FormDefineFieldEntity> formDefineFields = new ArrayList<FormDefineFieldEntity>();
        List<ShowFormdfField> showFormdfFields = new ArrayList<ShowFormdfField>();
        String result;
        try {
            formDefineFields = formDefineFieldService.getAllFormDefineField(tdId);
            if (formDefineFields.size() > 0) {
                for (FormDefineFieldEntity formDefineField :formDefineFields) {
                    String itemId = formDefineField.getItemId();
                    ShowFormdfField formdfField = new ShowFormdfField();
                    formdfField.setDefaultValue(formDefineField.getDefaultValue());
                    formdfField.setFdId(formDefineField.getFdId());
                    formdfField.setTdId(formDefineField.getTdId());
                    formdfField.setFdName(formDefineField.getFdName());
                    formdfField.setXh(formDefineField.getXh());
                    formdfField.setLevel(formDefineField.getLevel());
                    formdfField.setIsEdit(formDefineField.getIsEdit());
                    formdfField.setUnit(formDefineField.getUnit());
                    if (itemId != null) {
                        FormItemEntity formItemEntity = formItemService.findOne(itemId);
                        formdfField.setItemId(itemId);
                        if (formItemEntity != null) {
                            formdfField.setName(formItemEntity.getItemName());
                        }
                    }
                    showFormdfFields.add(formdfField);
                }
            }

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".getAllFormDefine() 方法失败 】异常：" + ex.getMessage());
        }
        return showFormdfFields;
    }

    @RequestMapping(value = "/toSave")
    public String toSave(String tdId, Model model) {
        model.addAttribute("tdId", tdId);
        return "FormDefine/FormDefineFieldAdd";
    }

    @RequestMapping(value = "/save")
    public void save(String tdId, FormDefineFieldEntity formDefineField, HttpServletRequest request,
                     HttpServletResponse response) throws Exception {
        String result;
        try {
            String name = formDefineField.getFdName();
            List<FormDefineFieldEntity> fieldEntities = new ArrayList<FormDefineFieldEntity>();
            fieldEntities = formDefineFieldService.findByfdName(name);
            if (fieldEntities.size() > 0) {
                result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#fdName\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            formDefineField.setFdId(UUID.randomUUID().toString());
            formDefineField.setStatus(1);
            if (formDefineField.getIsEdit() == null) {
                formDefineField.setIsEdit(false);
            }
            if (formDefineField.getXh() == null) {
                int xh = formDefineFieldService.getColumnXH(tdId);
                formDefineField.setXh(xh);
            }
            if (formDefineField.getItemId().equals("")){
                formDefineField.setItemId(null);
            }
            formDefineFieldService.save(formDefineField);
            result = "{\"success\":true,\"msg\":\"添加成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/toUpdate")
    public String toUpdate(Model model, String id) {
        FormDefineFieldEntity formDefineField = formDefineFieldService.findOne(id);
        model.addAttribute("formDefineField", formDefineField);
        return "FormDefine/FormDefineFieldEdit";
    }

    @RequestMapping(value = "/update")
    public void update(FormDefineFieldEntity formDefineField, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;
        try {
            String fdId = formDefineField.getFdId();
            FormDefineFieldEntity oldFieldEntity = formDefineFieldService.findOne(fdId);
            List<FormDefineFieldEntity> fieldEntities = new ArrayList<FormDefineFieldEntity>();

            if (!oldFieldEntity.getFdName().equals(formDefineField.getFdName())) {
                fieldEntities = formDefineFieldService.findByfdName(formDefineField.getFdName());
                if (fieldEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#fdName\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }

            if (formDefineField.getIsEdit() == null) {
                formDefineField.setIsEdit(false);
            } else {
                formDefineField.setIsEdit(true);
            }
            formDefineField.setStatus(1);
            String tdId = formDefineField.getTdId();
            if (formDefineField.getXh() == null) {
                int xh = formDefineFieldService.getColumnXH(tdId);
                formDefineField.setXh(xh);
            }
            if (formDefineField.getItemId().equals("")){
                formDefineField.setItemId(null);
            }
            formDefineFieldService.update(formDefineField);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".update() 方法失败 】异常：" + ex.getMessage());
        }
        //return "FormDefine/FormDefineField?tdId="+formDefineField.getTdId();
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            FormDefineFieldEntity formDefineField = formDefineFieldService.findOne(id);
            formDefineField.setStatus(0);
            formDefineFieldService.save(formDefineField);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".delete() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }



    @RequestMapping(value = "/getFormColumns")
    @ResponseBody
    public List<FormDefineStructure> getFormColumns(@RequestParam("tdId") String tdId){
        List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
        formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);

        List<FormDefineStructure> formDefineStructureList = new ArrayList<FormDefineStructure>();
        for(int i=0;i<formDefineFieldEntityList.size();i++){
            FormDefineStructure structure = new FormDefineStructure();
            structure.setFieldName("s"+i);
            structure.setFieldZhName(formDefineFieldEntityList.get(i).getFdName());

            formDefineStructureList.add(structure);
        }

        return formDefineStructureList;

    }

    private class ShowFormdfField {
        private String fdId;
        private String tdId;
        private String fdName;
        private Integer xh;
        private Boolean isEdit;
        private String defaultValue;
        private String itemId;
        private String name;
        private String level;
        private String unit;

        public String getFdId() {
            return fdId;
        }

        public void setFdId(String fdId) {
            this.fdId = fdId;
        }

        public String getTdId() {
            return tdId;
        }

        public void setTdId(String tdId) {
            this.tdId = tdId;
        }

        public String getFdName() {
            return fdName;
        }

        public void setFdName(String fdName) {
            this.fdName = fdName;
        }

        public Integer getXh() {
            return xh;
        }

        public void setXh(Integer xh) {
            this.xh = xh;
        }

        public Boolean getIsEdit() {
            return isEdit;
        }

        public void setIsEdit(Boolean isEdit) {
            this.isEdit = isEdit;
        }

        public String getDefaultValue() {
            return defaultValue;
        }

        public void setDefaultValue(String defaultValue) {
            this.defaultValue = defaultValue;
        }

        public String getItemId() {
            return itemId;
        }

        public void setItemId(String itemId) {
            this.itemId = itemId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getLevel() {
            return level;
        }

        public void setLevel(String level) {
            this.level = level;
        }

        public String getUnit() {
            return unit;
        }

        public void setUnit(String unit) {
            this.unit = unit;
        }
    }


    public class FormDefineStructure{

        private String fieldName;
        private String fieldZhName;

        public String getFieldName() {
            return fieldName;
        }

        public void setFieldName(String fieldName) {
            this.fieldName = fieldName;
        }




        public String getFieldZhName() {
            return fieldZhName;
        }

        public void setFieldZhName(String fieldZhName) {
            this.fieldZhName = fieldZhName;
        }
    }

}
