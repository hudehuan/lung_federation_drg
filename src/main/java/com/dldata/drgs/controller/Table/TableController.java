package com.dldata.drgs.controller.Table;

import com.dldata.drgs.entity.TabDefineEntity;
import com.dldata.drgs.entity.TabStructureEntity;
import com.dldata.drgs.service.Table.TabDefineService;
import com.dldata.drgs.service.Table.TabStructureService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import com.dldata.drgs.utils.pubs.DirectoryConfig;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/8/2.
 */


@Controller
@RequestMapping(value = "/table")
public class TableController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    TabDefineService tabDefineService;


    @Autowired
    TabStructureService tabStructureService;


    @Autowired
    JdbcTemplate jdbcTemplate;
    @Autowired
    DirectoryConfig directoryConfig;

    @RequestMapping(value = "/tolist")
    public String tolist() {

        return "table/tablelist";
    }


    @RequestMapping(value = "/toedit")
    public String toEdit(@RequestParam("id") String id, @CookieValue(value = "syscode", defaultValue = "") String sysCode, HttpServletRequest request, HttpServletResponse response, Model model) {
        TabDefineEntity entity = new TabDefineEntity();

        if (!id.equals("")) {
            entity = tabDefineService.getEntityByID(id);
        }
        model.addAttribute("sysCode", sysCode);
        model.addAttribute("table", entity);
        return "table/tableedit";
    }


    @RequestMapping(value = "/toadd")
    public String toAdd(@CookieValue(value = "syscode", defaultValue = "") String sysCode, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("sysCode", sysCode);
        return "table/tableedit";
    }


    @RequestMapping(value = "/list")
    @ResponseBody
    public List<TabDefineEntity> list(@CookieValue(value = "syscode", defaultValue = "") String sysCode) {


        List<TabDefineEntity> tabDefineEntities = new ArrayList<TabDefineEntity>();
        tabDefineEntities = tabDefineService.list(sysCode);

        return tabDefineEntities;

    }

    @RequestMapping(value = "/toSaveFile")
    public String toSaveFile(String id, Model model) {
        model.addAttribute("id", id);
        return "table/tableFileUpload";
    }

    @RequestMapping(value = "/saveFile")
    public void saveFile(String id, @RequestParam("file") MultipartFile file,
                         HttpServletRequest request, HttpServletResponse response) throws Exception {
        String excelFile = "";
        String result;
        try {
            String templateExcelPath = directoryConfig.getTemplateExcel();
            //MultipartFile file = null;
            TabDefineEntity entity = tabDefineService.getEntityByID(id);
            if (Util.checkNotNull(file)) {
                if (Util.checkNotNull(file.getOriginalFilename())) {
                    String filename = file.getOriginalFilename();
                    //获取最后一次.出现位置
                    int position = filename.lastIndexOf(".");
                    //获取后缀名称
                    String after = filename.substring(position, filename.length());
                    //学习资料
                    if (after.equalsIgnoreCase(".xlsx") || after.equalsIgnoreCase(".xls")) {
                        excelFile = Util.saveFile(templateExcelPath, "/", entity.getName(), after, request, file, excelFile);
                    }
                }
            }
            entity.setExcelName(excelFile);
            tabDefineService.save(entity);
            result = "{\"success\":true,\"msg\":\"新增完成！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".saveFile() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
//        return "redirect:tolist";
    }
    /*
    * 保存元数据表时，上传Excel文件
    *
    *
    *
    * */

    @RequestMapping(value = "/save")
    public void save(TabDefineEntity entity, @CookieValue(value = "syscode", defaultValue = "") String sysCode,
                     HttpServletRequest request, HttpServletResponse response) throws Exception {

//        public void save(TabDefineEntity entity,@RequestParam("file") MultipartFile file,
//                         @CookieValue(value = "syscode",defaultValue = "") String sysCode,
//                         HttpServletRequest request,HttpServletResponse response)throws Exception{

        String result = "";
        try {
            if (entity.getId().equals("")) {
                entity.setId(UUID.randomUUID().toString());
                String name = entity.getName();
                if (name != null || !name.equals("")) {
                    entity.setName(sysCode + "_Excel_" + name);
                    name = entity.getName();
                }
                //必须由字母或下划线组成，且开头和结尾不能有下划线
                String regex = "(^[a-zA-Z_]{1,20}$)";
                if (!name.equals("")) {

                    if (!name.matches(regex)) {
                        result = "{\"success\":false,\"msg\":\"表名必须为_或字母！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result, "html", response);
                        return;
                    }
                    // 新增时表名不重复
                    List<TabDefineEntity> tabDefineEntities = new ArrayList<TabDefineEntity>();
                    tabDefineEntities = tabDefineService.findByName(name, sysCode);
                    for (TabDefineEntity t : tabDefineEntities) {
                        if (t.getName().equals(entity.getName())) {
                            result = "{\"success\":false,\"msg\":\"表名已存在！\",\"id\":\"#name\"}";
                            StringUtil.writeToWeb(result, "html", response);
                            return;
                        }
                    }
                }
                entity.setStatus(1);
            }


            if (!entity.getZhName().equals("")) {
                entity.setPym(StringUtil.getPinYinHeadChar(entity.getZhName()).toUpperCase());
            }

            entity.setSysCode(sysCode);
            tabDefineService.save(entity);
            result = "{\"success\":true,\"model\":\"add\",\"msg\":\"新增完成！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/create")
    public void create(String tableIds, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result;

        String[] ids = tableIds.split("/");

        String key = "";

        try {
            for (int i = 0; i < ids.length; i++) {
                TabDefineEntity tableEntity = new TabDefineEntity();
                tableEntity = tabDefineService.getEntityByID(ids[i]);

                List<TabStructureEntity> tabStructureEntities = new ArrayList<TabStructureEntity>();
                tabStructureEntities = tabStructureService.getStrucByTableID(ids[i]);
                List<String> keys = new ArrayList<String>();
                StringBuffer sb = new StringBuffer("");
//                sb.append("if not exists (select 1    " +
//                        "from  sysobjects    " +
//                        "where  id = object_id('"+ tableEntity.getName() +"')    " +
//                        "and   type = 'U' )  Begin  ");
//                        "drop table " + tableEntity.getName() +"    ");
                sb.append("CREATE TABLE " + tableEntity.getName() + " (");
                sb.append(" guid    nvarchar(50) not null ,");
                for (TabStructureEntity entity : tabStructureEntities) {
                    sb.append(entity.getName() + "  ");

                    if (entity.getType().toLowerCase().equals("nvarchar")) {
                        sb.append(" nvarchar(" + entity.getColLength() + ")");

                    } else if (entity.getType().toLowerCase().equals("decimal")) {
                        sb.append(" decimal(18,4)");
                    } else {
                        continue;
                    }

//                    if (entity.getIsKey()) {
//                        sb.append(" not null,");
//                        key = entity.getName();
//                        keys.add(key);
//                    } else {
                        sb.append(" null,");
//                    }
                }
                sb.append(" record_id    nvarchar(50) null, ");
                sb.append(" wdm    nvarchar(50) null ");

//                if (keys.size() > 1) {
//                    sb.append(", constraint PK_" + tableEntity.getName().toUpperCase() + "  primary key (");
//
//                    for (String k : keys) {
//                        sb.append(k + ",");
//                    }
//                    sb.deleteCharAt(sb.length() - 1);
//                    sb.append(")");
//                } else if (keys.size() > 0) {
//                    sb.append(", constraint PK_" + tableEntity.getName().toUpperCase() + "  primary key (" + keys.get(0) + ")");
//                }
                //sb.append(", constraint PK_" + tableEntity.getName().toUpperCase() + "  primary key (guid)");
                sb.append(", primary key (guid)");
                sb.append(")");

                String sql = sb.toString();
                jdbcTemplate.execute(sql);
            }

            result = "{\"success\":true,\"msg\":\"表创建完成！\"}";
            StringUtil.writeToWeb(result, "html", response);
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".create() 方法失败 】异常：" + ex.getMessage());
        }
    }


    @RequestMapping(value = "/download")
    public void downloadExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String tableId = request.getParameter("tableId");
        System.out.print(tableId);

        TabDefineEntity tableEntity = new TabDefineEntity();
        tableEntity = tabDefineService.getEntityByID(tableId);
        if (Util.checkNotNull(tableEntity.getExcelName())) {
            String templageExcelPath = directoryConfig.getTemplateExcel();
            File file = new File(templageExcelPath + tableEntity.getExcelName());

            Servlets.setFileDownloadHeader(request, response, file.getName());
            OutputStream output;
            response.setContentLength((int) file.length());
            output = response.getOutputStream();
            FileUtils.copyFile(file, output);
            output.flush();
        }
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            TabDefineEntity tabDefineEntity = tabDefineService.getEntityByID(id);
            tabDefineEntity.setStatus(0);
            List<TabStructureEntity> tabStructureEntities = tabStructureService.getStrucByTableID(id);
            if (tabStructureEntities != null) {
                tabStructureEntities.forEach((t)-> {
                    t.setStatus(0);
                    tabStructureService.save(t);
                });
            }
            tabDefineService.save(tabDefineEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".delete() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/findByCondition")
    @ResponseBody
    public List<TabDefineEntity> findByCondition(@CookieValue(value = "syscode", defaultValue = "") String sysCode, String condition, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<TabDefineEntity> tabDefineEntities = new ArrayList<TabDefineEntity>();
        String result;
        try {
            tabDefineEntities = tabDefineService.findByCondition("%" + condition + "%", sysCode);
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".findByCondition() 方法失败 】异常：" + ex.getMessage());
        }
        return tabDefineEntities;
    }



    @RequestMapping(value = "/saveTableSql")
    public void saveTableSql(String tdId, String  tableSql, HttpServletRequest request,
                             HttpServletResponse response) throws Exception{

        String result;

        try {
            TabDefineEntity tabDefineEntity = tabDefineService.getEntityByID(tdId);

            tabDefineEntity.setTableSql(tableSql);

            tabDefineService.save(tabDefineEntity);
            result = "{\"success\":true,\"msg\":\"SQL 保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/showTableSql")
    public void showTableSql(String tdId, HttpServletRequest request,
                             HttpServletResponse response) throws Exception{

        String result;

        try {
            TabDefineEntity tabDefineEntity = tabDefineService.getEntityByID(tdId);

            //tabDefineEntity.setTableSql(tableSql);

            String tableSql = tabDefineEntity.getTableSql();
            if(!Util.checkNotNull(tableSql)) tableSql = "";
            //tabDefineService.save(tabDefineEntity);
            result = "{\"success\":true,\"tableSql\":\" " + tableSql + "\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"tableSql\":\"\"}";
        }

        StringUtil.writeToWeb(result, "html", response);

    }


//    @RequestMapping(value = "/getWdm")
//    @ResponseBody
//    public List<Wdm> getWdm(@RequestParam("tableId") String tableId){
//
//        List<Wdm> wdmList = new ArrayList<Wdm>();
//        TabDefineEntity entity = tabDefineService.getEntityByID(tableId);
//        String wdmsql = entity.getTableSql();
//        if(Util.checkNotNull(wdmsql)) {
//
//            try{
//                List rows = jdbcTemplate.queryForList(wdmsql);
//
//                for (int i = 0; i < rows.size(); i++) {                   //遍历
//                    Map userMap = (Map) rows.get(i);
//                    Wdm w = new Wdm();
//                    w.setDm((String) userMap.get("dm"));
//                    w.setName((String) userMap.get("name"));
//                    wdmList.add(w);
//                }
//            }
//            catch (Exception ex){
//
//            }
//        }
//
//
//
//
//        return wdmList;
//    }


    public class Wdm{

        private String dm;
        private String name;

        public String getDm() {
            return dm;
        }

        public void setDm(String dm) {
            this.dm = dm;
        }



        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}
