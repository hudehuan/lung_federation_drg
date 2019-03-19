package com.dldata.drgs.controller.FormDefine;

import com.dldata.drgs.entity.FormItemEntity;
import com.dldata.drgs.entity.FormItemTypeEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.FormDefine.FormItemService;
import com.dldata.drgs.service.FormDefine.FormItemTypeService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
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
@RequestMapping(value = "/formItem")
public class FormItemController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    FormItemService formItemService;

    @Autowired
    FormItemTypeService formItemTypeService;
    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;


    @RequestMapping(value = "/toList")
    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                         Model model,HttpServletRequest request,HttpServletResponse response){
        model.addAttribute("titlename","键值元素分类");
        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "FormDefine/FormItem";
    }

    @RequestMapping(value = "/toSave")
    public String toSave(String id, Model model) {
        model.addAttribute("typeId",id);
        return "FormDefine/FormItemAdd";
    }

    @RequestMapping(value = "/getAllFormItem")
    @ResponseBody
    public List<FormItemEntity> getAllFormItem(String id, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                                               HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<FormItemEntity> allFormItems = new ArrayList<FormItemEntity>();
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
                        for (FormItemTypeEntity formItemTypeEntity : formItemTypeEntities) {
                            formItems = formItemService.getAllFormItem(formItemTypeEntity.getTypeId(),sysCode);
                            allFormItems.addAll(formItems);
                        }
                    }
                } else {
                    allFormItems = formItemService.getAllFormItem(id,sysCode);
                    }
                }
            }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllKeShi() 方法失败 】异常："+ex.getMessage());
        }

        return allFormItems;
    }

    @RequestMapping(value = "/save")
    public void save(FormItemEntity formItem, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                       HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            if (formItem.getItemId().equals("")) {
            formItem.setItemId(UUID.randomUUID().toString());
            if (!formItem.getItemName().equals("")) {
                formItem.setPym(StringUtil.getPinYinHeadChar(formItem.getItemName()));
            }
            String typeId = formItem.getTypeId();
            List<FormItemEntity> formItemEntities = new ArrayList<FormItemEntity>();
            formItemEntities = formItemService.getAllFormItem(typeId, sysCode);
            if (formItemEntities.size() > 0) {
                String name = formItem.getItemName();
                for (FormItemEntity f : formItemEntities) {
                    if (f.getItemName().equals(name)) {
                        result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#itemName\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                }
                ;
            }
            if (formItem.getXh() == null) {
                int xh = formItemService.getColumnXH(formItem.getTypeId());
                formItem.setXh(xh);
            }
            formItem.setStatus(1);
            formItem.setSysCode(sysCode);
            formItemService.save(formItem);
            result = "{\"success\":true,\"msg\":\"添加成功！\"}";
        }else {
                FormItemEntity oldFormItem = formItemService.findOne(formItem.getItemId());
                String oldName = oldFormItem.getItemName();
                if (!formItem.getItemName().equals(oldName)) {
                    String typeId = formItem.getTypeId();
                    List<FormItemEntity> formItemEntities = new ArrayList<FormItemEntity>();
                    formItemEntities = formItemService.getAllFormItem(typeId, sysCode);
                    if (formItemEntities.size() > 0) {
                        String name = formItem.getItemName();
                        for (FormItemEntity f : formItemEntities) {
                            if (f.getItemName().equals(name)) {
                                result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#itemName\"}";
                                StringUtil.writeToWeb(result, "html", response);
                                return;
                            }
                        }
                        ;
                    }
                }
                if (formItem.getIsText() == null) {
                    formItem.setIsText(false);
                } else {
                    formItem.setIsText(true);
                }
                formItem.setStatus(1);
                formItem.setSysCode(sysCode);
                if (!formItem.getItemName().equals("")) {
                    formItem.setPym(StringUtil.getPinYinHeadChar(formItem.getItemName()));
                }
                formItemService.update(formItem);
                result = "{\"success\":true,\"msg\":\"修改成功！\"}";
            }
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/toEdit")
    public String toEdit(String id,String typeId, Model model) {
        if(typeId!=null&&!typeId.equals("")){
            model.addAttribute("typeId",typeId);
        }
        if (id!=null&&!id.equals("")) {
            FormItemEntity formItemEntity = formItemService.findOne(id);
            model.addAttribute("formItem",formItemEntity);
            model.addAttribute("typeId",formItemEntity.getTypeId());
        }
        return "FormDefine/FormItemEdit";
    }

    @RequestMapping(value = "/update")
    public void update(FormItemEntity formItem, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                       HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            FormItemEntity oldFormItem = formItemService.findOne(formItem.getItemId());
            String oldName = oldFormItem.getItemName();
            if (!formItem.getItemName().equals(oldName)) {
                String typeId = formItem.getTypeId();
                List<FormItemEntity> formItemEntities = new ArrayList<FormItemEntity>();
                formItemEntities = formItemService.getAllFormItem(typeId, sysCode);
                if (formItemEntities.size() > 0) {
                    String name = formItem.getItemName();
                    for (FormItemEntity f: formItemEntities) {
                        if (f.getItemName().equals(name)) {
                            result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#itemName\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    };
                }
            }
            if (formItem.getIsText() == null) {
                formItem.setIsText(false);
            } else {
                formItem.setIsText(true);
            }
            formItem.setStatus(1);
            formItem.setSysCode(sysCode);
            if (!formItem.getItemName().equals("")) {
                formItem.setPym(StringUtil.getPinYinHeadChar(formItem.getItemName()));
            }
            formItemService.update(formItem);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".update() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            FormItemEntity formItem = formItemService.findOne(id);
            formItem.setStatus(0);
            formItemService.save(formItem);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleteStaff() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
