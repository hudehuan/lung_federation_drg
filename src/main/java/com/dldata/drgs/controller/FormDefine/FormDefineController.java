package com.dldata.drgs.controller.FormDefine;

import com.dldata.drgs.entity.FormDefineEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.FormDefine.FormDefineService;
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
@RequestMapping(value = "/formDefine")
public class FormDefineController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    FormDefineService formDefineService;

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;

    @RequestMapping(value = "/toList")
    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
                         Model model,HttpServletRequest request,HttpServletResponse response){

        model.addAttribute("titlename","自定义表单配置");
        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();

        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);

        if (sysRoleMenuEntityList.size()>0){
            roleMenuEntity = sysRoleMenuEntityList.get(0);
            model.addAttribute("roleMenu",roleMenuEntity);

        }
        return "FormDefine/FormDefine";
    }

    @RequestMapping(value = "/getAllFormDefine")
    @ResponseBody
    public List<FormDefineEntity> getAllFormDefine(@CookieValue(value = "syscode",defaultValue = "") String sysCode,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<FormDefineEntity> formDefines = new ArrayList<FormDefineEntity>();
        String result;
        try{
            formDefines = formDefineService.getAllFormDefine(sysCode);
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".getAllFormDefine() 方法失败 】异常："+ex.getMessage(),ex);
        }
        return formDefines;
    }

//    @RequestMapping(value = "/toSave")
//    public String toSave () {
//        return "FormDefine/FormDefineAdd";
//    }

    @RequestMapping(value = "/save")
    public void save(FormDefineEntity formDefine,  @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                      HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            List<FormDefineEntity> formDefineEntities = new ArrayList<FormDefineEntity>();
            formDefineEntities = formDefineService.findByName(formDefine.getName(), sysCode);
            if (formDefineEntities.size() > 0) {
                result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                StringUtil.writeToWeb(result, "html", response);
                return;
            }
            formDefine.setTdId(UUID.randomUUID().toString());
            formDefine.setStatus(1);
            if(formDefine.getIsSh() == null) {
                formDefine.setIsSh(false);
            }
            if(formDefine.getIsEdit() == null) {
                formDefine.setIsEdit(false);
            }
            if(formDefine.getIsDel() == null) {
                formDefine.setIsDel(false);
            }
            if(formDefine.getIsNew() == null) {
                formDefine.setIsNew(false);
            }
            formDefine.setSysCode(sysCode);
            formDefineService.save(formDefine);
            result = "{\"success\":true,\"msg\":\"添加成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".save() 方法失败 】异常："+ex.getMessage(),ex);
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/saveTextarea")
    public void saveTextarea (String tdId, String tableJs, String tableSql, HttpServletRequest request,
                              HttpServletResponse response) throws Exception{
        String result;
        try {
            FormDefineEntity formDefineEntity = formDefineService.findOne(tdId);
            if (formDefineEntity != null) {
                formDefineEntity.setTableJs(tableJs);
                formDefineEntity.setTableSql(tableSql);
                formDefineService.save(formDefineEntity);
                result = "{\"success\":true,\"msg\":\"添加成功！\"}";
            } else {
                result = "{\"success\":false,\"msg\":\"添加失败！\"}";
            }
        } catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行"+this.getClass().getName()+".saveTextarea() 方法失败 】异常："+ex.getMessage(),ex);
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/toEdit")
    public String toEdit(Model model,String id) {
        if(id!=null&&!id.equals("")){
            FormDefineEntity formDefine = formDefineService.findOne(id);
            model.addAttribute("formDefine",formDefine);
        }
        return "FormDefine/FormDefineEdit";
    }

    @RequestMapping(value = "/update")
    public void update(FormDefineEntity formDefine, @CookieValue(value = "syscode",defaultValue = "") String sysCode,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            String id = formDefine.getTdId();
            FormDefineEntity oldFormDefine = formDefineService.findOne(id);

            List<FormDefineEntity> formDefineEntities = new ArrayList<FormDefineEntity>();
            if (!oldFormDefine.getName().equals(formDefine.getName())) {
                formDefineEntities = formDefineService.findByName(formDefine.getName(), sysCode);
                if (formDefineEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"名称已存在！\",\"id\":\"#name\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }
            if(formDefine.getIsSh() == null) {
                formDefine.setIsSh(false);
            } else {
                formDefine.setIsSh(true);
            }
            if(formDefine.getIsEdit() == null) {
                formDefine.setIsEdit(false);
            } else {
                formDefine.setIsEdit(true);
            }
            if(formDefine.getIsDel() == null) {
                formDefine.setIsDel(false);
            }else {
                formDefine.setIsDel(true);
            }
            if(formDefine.getIsNew() == null) {
                formDefine.setIsNew(false);
            }else {
                formDefine.setIsNew(true);
            }
            if (oldFormDefine.getTableJs() != null) {
                formDefine.setTableJs(oldFormDefine.getTableJs());
            }else{
                formDefine.setTableJs("");
            }
            if (oldFormDefine.getTableSql() != null) {
                formDefine.setTableSql(oldFormDefine.getTableSql());
            }else{
                formDefine.setTableSql("");
            }
            //formDefine.setDatetype();
            formDefine.setSysCode(sysCode);
            formDefine.setStatus(1);
            formDefineService.update(formDefine);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".update() 方法失败 】异常："+ex.getMessage(),ex);
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            FormDefineEntity formDefine = formDefineService.findOne(id);
            formDefine.setStatus(0);
            formDefineService.save(formDefine);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage(),ex);
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
