package com.dldata.drgs.controller.Table;

import com.dldata.drgs.entity.TabDefineEntity;
import com.dldata.drgs.entity.TabImportRecordEntity;
import com.dldata.drgs.entity.TabStructureEntity;
import com.dldata.drgs.service.Table.ExcelRecordService;
import com.dldata.drgs.service.Table.TabDefineService;
import com.dldata.drgs.service.Table.TabStructureService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by 倪继文 on 2016/8/31.
 */
@Controller
@RequestMapping(value = "/ExcelImportRecord")
public class ExcelImportRecordController {

    @Autowired
    ExcelRecordService excelRecordService;

    @Autowired
    TabStructureService tabStructureService;

    @Autowired
    TabDefineService tabDefineService;
    @Autowired
    JdbcTemplate jdbcTemplate;

    @RequestMapping(value = "/toRecord")
    public String toRecord(@RequestParam("GUID") String tableId,Model model){

        model.addAttribute("tableId",tableId);
        return "table/ExcelImportRecord";

    }



    @RequestMapping(value = "/getRecordByTableId")
    @ResponseBody
    public List<TabImportRecordEntity> getRecordByTableId(@RequestParam("tableId") String tableId,Model model){
        List<TabImportRecordEntity> recordEntityList = new ArrayList<TabImportRecordEntity>();

        recordEntityList = excelRecordService.getRecordByTableId(tableId);
        return recordEntityList;
    }

    @RequestMapping(value = "/getRecordByTableIdBytime")
    @ResponseBody
    public List<TabImportRecordEntity> getRecordByTableIdBytime(@RequestParam("tableId") String tableId,Model model
            , String startTime,String endTime){
        List<TabImportRecordEntity> recordEntityList = new ArrayList<TabImportRecordEntity>();
        Timestamp s =  Timestamp.valueOf(startTime + "-01 00:00:00");
        Timestamp e =  Timestamp.valueOf(endTime + "-31 23:59:59");

        recordEntityList = excelRecordService.getRecordByTableIdBytime(tableId,s,e);
        return recordEntityList;
    }

    @RequestMapping(value = "/loadData")
    @ResponseBody
    public String loadData(@RequestParam("recordId") String recordId,
                           @RequestParam("tableId") String tableId,
                           @CookieValue(value = "userid",defaultValue = "") String userid){

        //先得到表名

        TabDefineEntity tabDefineEntity=null;

        tabDefineEntity = tabDefineService.getEntityByTableId(tableId);
        String wdms = "";
        String wdmsql = tabDefineEntity.getTableSql();
        if(Util.checkNotNull(wdmsql)) {
            int uindex = wdmsql.indexOf("#userid");
            if (uindex != 0) {
                wdmsql = wdmsql.replace("#userid", userid);
            }

            try {
                List rows = jdbcTemplate.queryForList(wdmsql);
                for (int i = 0; i < rows.size(); i++) {                   //遍历
                    Map userMap = (Map) rows.get(i);
                    if(i== rows.size()-1){
                        wdms += "'" + (String) userMap.get("dm")+ "'";
                    }else{
                        wdms += "'" + (String) userMap.get("dm") + "'" + ",";
                    }

                }
            }
            catch (Exception ex){

            }
        }
        //再得到表数据
        //List<TabStructureEntity> tabStructureEntityList = new ArrayList<TabStructureEntity>();

        //tabStructureEntityList = tabStructureService.getStructure(tableId);

        //构建Json数据返回给界面


        String sql = "select * from " + tabDefineEntity.getName() + " where record_id='" + recordId + "'";

        if(!wdms.equals("")){
            sql += " and wdm in (" + wdms + ")";
        }
        List rows = jdbcTemplate.queryForList(sql); //得到装有map的list

        String json = JSONSerializer.toJSON(rows).toString();
//        String json ="[";
//        for(int i=0;i<rows.size();i++){                   //遍历
//            JSONObject jo = new JSONObject();
//            Map map= (Map)rows.get(i);
//
//            String j = JSONSerializer.toJSON(map).toString();
//
//            if(i<rows.size()-1){j+=",";}
//            json += j;
//
//        }
//        json +="]";
        System.out.println(json);
        return json;
    }


    @RequestMapping(value = "/getStructure")
    @ResponseBody
    public List<TabStructureEntity> getStructure(@RequestParam("tableId") String tableId){
        return tabStructureService.getStructure(tableId);
    }


    @RequestMapping(value = "/checkDataIsExist")
    public void checkDataIsExist(String inputDate,String tableId,HttpServletResponse response) throws IOException {

        String result = "";

        inputDate += " 00:00:00";
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        ts = Timestamp.valueOf(inputDate);


        List<TabImportRecordEntity> tabImportRecordEntityList = excelRecordService.checkByInputDateTableId(ts, tableId);

        if(tabImportRecordEntityList.size()>0){
            //result = "{\\\"success\\\":false,\\\"msg\\\":\\\"系统错误，请稍候再试！\\\"\"+ ex.getMessage().replace(\"\\r\",\"\").replace(\"\\n\",\"\")+\"}\";
            TabImportRecordEntity entity = tabImportRecordEntityList.get(0);
            if(entity.getIsSh()){
                result = "{\"isExist\":true,\"isSH\":true,\"msg\":\"当月数据已导入,并已审核通过！\"}";
            }else {
                result = "{\"isExist\":true,\"isSH\":false,\"msg\":\"当月数据已导入！\"}";
            }
        }
        else{
            result = "{\"isExist\":false,\"msg\":\"！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
        //return result;
    }


    @RequestMapping(value = "/deleteByInputDateTableId")
    public void deleteByInputDateTableId(String inputDate,String tableId,HttpServletResponse response)throws IOException{


        inputDate += " 00:00:00";
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        ts = Timestamp.valueOf(inputDate);
        excelRecordService.deleteByInputDateTableId(ts, tableId);

        String result = "{\"success\":true,\"msg\":\"当月数据删除成功！\"}";
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/deleteImportData")
    public void deleteImportDate(String recordId,HttpServletResponse response)throws IOException{
        String result="";
        TabImportRecordEntity tabImportRecordEntity = excelRecordService.findOne(recordId);

        if(tabImportRecordEntity.getIsSh()){
            result = "{\"success\":false,\"msg\":\"导入数据已审核，请先取消审核！\"}";
        }else {
            String tableId = tabImportRecordEntity.getTableId();
            excelRecordService.deleteOne(tabImportRecordEntity);

            TabDefineEntity tabDefineEntity = tabDefineService.getEntityByTableId(tableId);

            String sql = "delete from " + tabDefineEntity.getName() + " where record_id='" + recordId + "'";

            jdbcTemplate.execute(sql);

            result = "{\"success\":true,\"msg\":\"导入数据删除成功！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping(value = "/checkImportData")
    public void checkImportData(String recordId,HttpServletResponse response) throws IOException{
        String result="";
        TabImportRecordEntity tabImportRecordEntity = excelRecordService.findOne(recordId);

        if(tabImportRecordEntity.getIsSh()){
            result = "{\"success\":true,\"msg\":\"取消数据审核成功！\"}";
        }
        else{
            result = "{\"success\":true,\"msg\":\"审核数据成功！\"}";
        }
        tabImportRecordEntity.setIsSh(!tabImportRecordEntity.getIsSh());

        excelRecordService.save(tabImportRecordEntity);

        StringUtil.writeToWeb(result, "html", response);
    }
}