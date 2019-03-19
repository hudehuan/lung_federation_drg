package com.dldata.drgs.controller.Table;

import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.FormDefine.FormDefineFieldService;
import com.dldata.drgs.service.FormDefine.FormDefineService;
import com.dldata.drgs.service.FormInput.FormDefineFieldValueService;
import com.dldata.drgs.service.System.SysStaffService;
import com.dldata.drgs.service.Table.ExcelRecordService;
import com.dldata.drgs.service.Table.TabDefineService;
import com.dldata.drgs.service.Table.TabStructureService;
import com.dldata.drgs.utils.DateUtil;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/8/31.
 */
@Controller
@RequestMapping(value = "/ExcelImport")
public class ExcelImportController {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    TabDefineService tabDefineService;

    @Autowired
    TabStructureService tabStructureService;

    @Autowired
    ExcelRecordService excelRecordService;

    @Autowired
    SysStaffService sysStaffService;

    @RequestMapping(value = "/toImport")
    public String toImport(@RequestParam("tableId") String tableId,
                           @RequestParam("recordId") String recordId,
                           @CookieValue(value = "userid",defaultValue = "") String userid,Model model) {

        model.addAttribute("tableId", tableId);
        model.addAttribute("recordId", recordId);
        List<Wdm> wdmList = new ArrayList<Wdm>();
        TabDefineEntity entity = tabDefineService.getEntityByID(tableId);
        String wdmsql = entity.getTableSql();

        int uindex = wdmsql.indexOf("#userid");
        if(uindex!=0){
            wdmsql = wdmsql.replace("#userid",userid);
        }

        if(Util.checkNotNull(wdmsql)) {

            try{
                List rows = jdbcTemplate.queryForList(wdmsql);

                for (int i = 0; i < rows.size(); i++) {                   //遍历
                    Map userMap = (Map) rows.get(i);
                    Wdm w = new Wdm();
                    w.setDm((String) userMap.get("dm"));
                    w.setName((String) userMap.get("name"));
                    wdmList.add(w);
                }
            }
            catch (Exception ex){

            }
        }
        model.addAttribute("wdmList",wdmList);
        return "table/ExcelImport";
    }




    @RequestMapping(value = "/import", method = RequestMethod.POST)
    public void importExcel(@RequestParam("file") MultipartFile file,@RequestParam("recordId") String recordId,
                            @CookieValue(value = "userid",defaultValue = "") String userid,
                            @RequestParam(value = "wdm",required = false,defaultValue="") String wdm,
                            String tableId,
                            HttpServletRequest request,
                            HttpServletResponse response) throws IOException {

        //HttpSession session = request.getSession();
        //String userid = (String) session.getAttribute("userid");
        SysStaffEntity staffEntity = sysStaffService.getStaffByID(userid);


        String result = "";

        TabDefineEntity tableEntity = new TabDefineEntity();
        tableEntity = tabDefineService.getEntityByTableId(tableId);

        String delete = "delete from " + tableEntity.getName() + " where record_id ='" + recordId + "' and wdm='" + wdm + "'";
        jdbcTemplate.execute(delete);


        List<TabStructureEntity> tabStructureEntities = new ArrayList<TabStructureEntity>();
        tabStructureEntities = tabStructureService.getStructure(tableId);

        //String recordId = UUID.randomUUID().toString();
        String filename = "";
        try {
            if (Util.checkNotNull(file)) {
                InputStream input = file.getInputStream();
                XSSFWorkbook workBook = new XSSFWorkbook(input);
                XSSFSheet sheet = workBook.getSheetAt(0);

                if (sheet != null) {
                    for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
                        XSSFRow row = sheet.getRow(i);

                        String sql = " insert into " + tableEntity.getName() + " (guid,";

                        for (int n = 0; n < tabStructureEntities.size(); n++) {
                            sql += (tabStructureEntities.get(n).getName() + ",");
                        }
                        // String s = "ss";
                        sql += " record_id,wdm) ";//导入记录ID

                        sql += " values ( '"+ UUID.randomUUID().toString() + "',";

                        for (int m = 0; m < tabStructureEntities.size(); m++) {
                            String colValue = row.getCell(m).toString();
                            String colType = tabStructureEntities.get(m).getType().toLowerCase();

                            if (colType.equals("nvarchar")) {
                                sql += ("'" + colValue + "',");
                            } else if (colType.equals("datetime")) {
                                Date date = row.getCell(m).getDateCellValue();
                                sql += ("'" + new Timestamp(date.getTime()) + "',");
                            } else if (colType.equals("int")) {
                                // sql += (Integer.parseInt(colValue) + ",");
                                sql += (Double.parseDouble(colValue) + ",");
                            } else if (colType.equals("numeric")) {
                                sql += (Double.parseDouble(colValue) + ",");
                            }

                        }

                        sql += ("'" + recordId + "','"+wdm+"')");
                        jdbcTemplate.update(sql);

                    }//end for
                    if (sheet.getPhysicalNumberOfRows() > 1) {
                        result = "{\"success\":true,\"msg\":\"当月数据导入成功！\"}";
                    } else {
                        result = "{\"success\":false,\"msg\":\"请确认文档数据！\"}";
                    }

                }//if(sheet != null)
                else {
                    result = "{\"success\":false,\"msg\":\"未能读取到数据！\"}";
                }
            }//end if
            else {
                result = "{\"success\":false,\"msg\":\"请上传文件！\"}";
            }


        }//end try
        catch (Exception ex) {
            //logger.error("【执行"+this.getClass().getName()+".create() 方法失败 】异常："+ex.getMessage());
            result = "{\"success\":false,\"msg\":\"文件导入失败！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
    }



    @RequestMapping(value = "/toaddImportDate")
    public String toaddImportDate(@RequestParam("tableId") String tableId, Model model){
        model.addAttribute("tableId", tableId);

        return "table/ExcelAddImportDate";
    }

    /*
    * 新增excel导入日期，并检查当月是否已导入
    *
    *
    * */
    @RequestMapping(value = "/addImportDate")
    public void addImportDate(@CookieValue(value = "userid",defaultValue = "") String userid,
                              String inputDate,String tableId,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException{

        String result = "";
        Date date = DateUtil.strToDate(inputDate);
        int year = date.getYear();
        int month = date.getMonth();
        SysStaffEntity staffEntity = sysStaffService.getStaffByID(userid);
        List<TabImportRecordEntity> tabImportRecordEntityList = excelRecordService.getRecordByTableId(tableId);
        List<TabImportRecordEntity> t_list  = tabImportRecordEntityList.stream().filter(t -> t.getInputDate().getYear() == year)
                .filter(t -> t.getInputDate().getMonth() == month).collect(Collectors.toList());

        if(t_list.size()>0){
            result = "{\"success\":false,\"msg\":\"当月已存在上报！，请选择当月上报日期\",\"id\":\"#inputDate\"}";
        }
        else{
            TabImportRecordEntity entity = new TabImportRecordEntity();
            entity.setId(UUID.randomUUID().toString());
            entity.setIsSh(false);
            entity.setImportDate(new Timestamp(new Date().getTime()));
            inputDate += " 00:00:00";
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            ts = Timestamp.valueOf(inputDate);
            entity.setInputDate(ts);
            entity.setTableId(tableId);
            entity.setUserName(staffEntity.getName());

            excelRecordService.save(entity);
            result = "{\"success\":true,\"msg\":\"新增导入日期成功！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);

    }



    //文件下载
    @RequestMapping(value = "/download")
    public void down(String fileName,HttpServletRequest request,HttpServletResponse response) throws IOException {
        String nowPath = request.getSession().getServletContext().getRealPath("download");
        nowPath =nowPath + File.separator + fileName;
        File file = new File(nowPath);

        // 清空response
        response.reset();

        // 设置response的Header
        response.addHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("gbk"),"iso-8859-1"));  //转码之后下载的文件不会出现中文乱码
        response.addHeader("Content-Length", "" + file.length());

        try{
            //以流的形式下载文件
            InputStream fis = new BufferedInputStream(new FileInputStream(nowPath));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();

            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    @Autowired
    FormDefineService formDefineService;
    @Autowired
    FormDefineFieldValueService formDefineFieldValueService;
    @Autowired
    FormDefineFieldService formDefineFieldService;
    @RequestMapping("/doExcel")
    public  void doExcel(HttpServletRequest request,HttpServletResponse response,String tvId,String tdId) throws Exception {
        String result = "";
        try {
            List<FormDefineFieldEntity> formDefineFieldEntityList = new ArrayList<FormDefineFieldEntity>();
            formDefineFieldEntityList = formDefineFieldService.getFormDefineFieldList(tdId);
            // 1.创建一个workbook，对应一个Excel文件

            HSSFWorkbook wb = new HSSFWorkbook();
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/x-download");

            String fileName = "数据表.xls";
            fileName = URLEncoder.encode(fileName, "UTF-8");
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
            // 2.在workbook中添加一个sheet，对应Excel中的一个sheet
            HSSFSheet sheet = wb.createSheet("数据表");
//            sheet.setDefaultRowHeight((short) (2 * 256));
//            sheet.setColumnWidth(0, 50 * 160);
            HSSFFont font = wb.createFont();
            font.setFontName("宋体");
            font.setFontHeightInPoints((short) 16);
            // 3.在sheet中添加表头第0行，老版本poi对excel行数列数有限制short
            HSSFRow row = sheet.createRow((int) 0);
            // 4.创建单元格，设置值表头，设置表头居中
            HSSFCellStyle style = wb.createCellStyle();
            // 居中格式
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            // 设置表头
            HSSFCell cell = row.createCell(0);
            cell.setCellValue("科室");
            cell.setCellStyle(style);
            for( int a = 0;a<formDefineFieldEntityList.size();a++ ){
                cell = row.createCell(a+1);
                cell.setCellValue(formDefineFieldEntityList.get(a).getFdName());
                cell.setCellStyle(style);
            }
            FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tdId);
            String wdmSql = formDefineEntity.getTableSql();
            if(Util.checkNotNull(wdmSql)) {

                List rows = jdbcTemplate.queryForList(wdmSql);
                List<FormDefineFieldValueEntity> formDefineFieldValueEntityList = new ArrayList<FormDefineFieldValueEntity>();
                formDefineFieldValueEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);
                for (int i = 0; i < rows.size(); i++) {
                    row = sheet.createRow((int) i + 1);
                    Map userMap = (Map) rows.get(i);
                    row.createCell(0).setCellValue((String) userMap.get("name"));
                    //创建一行
                    for(int j=0; j< formDefineFieldEntityList.size();j++){
                        String t_fdId = formDefineFieldEntityList.get(j).getFdId();
                        List<FormDefineFieldValueEntity> t_fieldValueEntityList =  formDefineFieldValueEntityList.stream().filter(t->t.getFdId().equals(t_fdId)).
                                filter(tt->tt.getWdm().equals((String) userMap.get("dm"))).collect(Collectors.toList());
                        if(t_fieldValueEntityList.size()>0){
                            row.createCell(j+1).setCellValue(t_fieldValueEntityList.get(0).getFdValue());
                        }else{
                            row.createCell(j+1).setCellValue("");
                        }

                    }

                }
            }
            try
            {
                OutputStream out = response.getOutputStream();
                wb.write(out);
                out.close();
            }
            catch (ServiceException e)
            {
//                logger.info("=====导出excel异常====");
                result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
            }
            catch (Exception e1)
            {
//                logger.info("=====导出excel异常====");
                result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
            }
            result = "{\"success\":true,\"msg\":\"文件导出成功！\"}";
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
    }



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
