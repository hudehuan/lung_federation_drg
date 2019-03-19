package com.dldata.drgs.controller.FormInput;

import com.dldata.drgs.entity.FormDefineEntity;
import com.dldata.drgs.entity.FormDefineFieldValueEntity;
import com.dldata.drgs.entity.FormDefineValueEntity;
import com.dldata.drgs.service.FormDefine.FormDefineService;
import com.dldata.drgs.service.FormInput.FormDefineFieldValueService;
import com.dldata.drgs.service.FormInput.FormDefineValueService;
import com.dldata.drgs.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 新增上报时间
 *
 * Created by 倪继文 on 2016/9/2.
 */

@Controller
@RequestMapping(value = "/FormDefineValue")
public class FormDefineValueController {

    @Autowired
    FormDefineValueService formDefineValueService;

    @Autowired
    FormDefineFieldValueService formDefineFieldValueService;

    @Autowired
    FormDefineService formDefineService;

    @RequestMapping(value = "/toList")
    public String toList(@RequestParam("GUID") String tableId,Model model){
        model.addAttribute("tableId",tableId);

        SimpleDateFormat formatter_day  = new SimpleDateFormat ("yyyy-MM-dd");

        java.util.Calendar calendar = java.util.Calendar.getInstance();
        int yearend = calendar.get(Calendar.YEAR);
        int yearstart = yearend-5;

        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
        String month_frist_day = formatter_day.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        String month_last_day = formatter_day.format(calendar.getTime());


        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tableId);
        if(formDefineEntity.getDatetype().equals("年")){

            model.addAttribute("dateFmt","yyyy");
            model.addAttribute("starttime",String.valueOf(yearstart));
            model.addAttribute("startend",String.valueOf(yearend));
        }
        else if(formDefineEntity.getDatetype().equals("季")){
            model.addAttribute("dateFmt","yyyy-MM季");
            //String d = DateUtil.getCurrentQuarterStartTime();
            model.addAttribute("starttime", String.valueOf(yearend)+"-01"+"季");
            model.addAttribute("startend",String.valueOf(yearend)+"-04"+"季");
        }
        else if(formDefineEntity.getDatetype().equals("月")){
            model.addAttribute("dateFmt","yyyy-MM");
            model.addAttribute("starttime",yearend+"-01");
            model.addAttribute("startend",yearend+"-12");
        }
        else if(formDefineEntity.getDatetype().equals("日")){
            model.addAttribute("dateFmt","yyyy-MM-dd");
            model.addAttribute("starttime",month_frist_day);
            model.addAttribute("startend",month_last_day);
        }
        return "FormInput/FormDefineValue";
    }

    @RequestMapping(value = "/addSbrq")
    public String addSbrq(@RequestParam("tdId") String tdId,Model model){

        FormDefineEntity formDefineEntity = formDefineService.getFormDefine(tdId);
        if(formDefineEntity.getDatetype().equals("年")){
            model.addAttribute("dateFmt","yyyy");
        }
        else if(formDefineEntity.getDatetype().equals("月")){
            model.addAttribute("dateFmt","yyyy-MM");
        }
        else if(formDefineEntity.getDatetype().equals("季")){
            model.addAttribute("dateFmt","yyyy-MM季");
        }
        else if(formDefineEntity.getDatetype().equals("日")){
            model.addAttribute("dateFmt","yyyy-MM-dd");
        }
        model.addAttribute("tdId",tdId);

        return "FormInput/FormDefineValueEdit";
    }

    @RequestMapping("/getDefineValue")
    @ResponseBody
    public List<FormDefineValueEntity> getDefineValue(@RequestParam("tableId") String tableId){

        return formDefineValueService.getDefineValueByTableId(tableId);

    }

    @RequestMapping("/queryDefineValue")
    @ResponseBody
    public List<FormDefineValueEntity> queryDefineValue(@RequestParam("tdId") String tableId,
                                                         @RequestParam("cxrqstart") String cxrqstart,
                                                         @RequestParam("cxrqend") String cxrqend){

        if(cxrqstart.equals("")||cxrqend.equals("")){
            return formDefineValueService.getDefineValueByTableId(tableId);
        }else{
            if(cxrqstart.length()==8 && cxrqend.length() == 8) {
                String js = cxrqstart.substring(5, 7);
                if (js.equals("01")) {
                    js = "-01";
                } else if (js.equals("02")) {
                    js = "-04";
                } else if (js.equals("03")) {
                    js = "-07";
                } else if (js.equals("04")) {
                    js = "-10";
                }
                js += "-01";
                cxrqstart = cxrqstart.substring(0, 4);
                cxrqstart += js;

                String je = cxrqend.substring(5, 7);
                if (je.equals("01")) {
                    je = "-03-31";
                } else if (je.equals("02")) {
                    je = "-06-30";
                } else if (je.equals("03")) {
                    je = "-09-30";
                } else if (je.equals("04")) {
                    je = "-12-31";
                }
                cxrqend = cxrqend.substring(0, 4);
                cxrqend += je;
            }
            if(cxrqstart.length()==4 && cxrqend.length() == 4){
                cxrqstart = cxrqstart +"-01-01";
                cxrqend = cxrqend +"-12-31";
            }
            if(cxrqstart.length()==7 && cxrqend.length() == 7){
                cxrqstart = cxrqstart +"-01";
                cxrqend = cxrqend +"-20";
            }
            return formDefineValueService.queryDefineValue(tableId, cxrqstart, cxrqend);

        }


    }



    @RequestMapping(value = "/updatesh")
    public void checkDefineValue(@RequestParam("tvId") String tvId,HttpServletRequest request,HttpServletResponse response)throws IOException {

        String result = "";
        FormDefineValueEntity formDefineValueEntity = formDefineValueService.getDefineValue(tvId);
        if(formDefineValueEntity.getIsSh()){
            result = "{\"success\":true,\"msg\":\"取消数据审核成功！\"}";
        }
        else{
            result = "{\"success\":true,\"msg\":\"审核数据成功！\"}";
        }
        formDefineValueEntity.setIsSh(!formDefineValueEntity.getIsSh());

        formDefineValueService.save(formDefineValueEntity);
        StringUtil.writeToWeb(result, "html", response);

    }

    @RequestMapping(value = "/checkIsSH")
    public void checkIsSH(@RequestParam("rq") String rq,@RequestParam("tdId") String tdId,HttpServletRequest request,HttpServletResponse response)throws IOException{
        String result = "";
        String tvId = formDefineValueService.getTvIdByRqAndTdId(rq,tdId);
        FormDefineValueEntity formDefineValueEntity = formDefineValueService.getDefineValue(tvId);
        if(formDefineValueEntity.getIsSh()){
            result = "{\"success\":true,\"msg\":\"上报日期("+ rq + ")数据已审核！\"}";
        }
        else{
            result = "{\"success\":false,\"msg\":\"数据未审核！\"}";
        }

        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/checkIsSHByTvId")
    public void checkIsSH(@RequestParam("tvId") String tvId,HttpServletRequest request,HttpServletResponse response)throws IOException{
        String result = "";
//        String tvId = formDefineValueService.getTvIdByRqAndTdId(rq,tdId);
        FormDefineValueEntity formDefineValueEntity = formDefineValueService.getDefineValue(tvId);
        if(formDefineValueEntity.getIsSh()){
            result = "{\"success\":true,\"msg\":\"数据已审核！\"}";
        }
        else{
            result = "{\"success\":false,\"msg\":\"数据未审核！\"}";
        }
        //formDefineValueEntity.setIsSh(!formDefineValueEntity.getIsSh());

        //formDefineValueService.save(formDefineValueEntity);
        StringUtil.writeToWeb(result, "html", response);
    }



    @RequestMapping(value = "/deleteDefineValue")
    public void deleteDefineValue(@RequestParam("tvId") String tvId,HttpServletRequest request,HttpServletResponse response)throws IOException{
        String result = "";
        //FormDefineValueEntity formDefineValueEntity = formDefineValueService.getDefineValue(tvId);

        List<FormDefineFieldValueEntity> formDefineFieldEntityList = formDefineFieldValueService.getDefineFieldValue(tvId);

        try {
            formDefineValueService.deleteDefineValue(tvId);
            formDefineFieldValueService.deleteFormDefineFieldValue(formDefineFieldEntityList);
            result = "{\"success\":true,\"msg\":\"删除数据成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"删除数据失败！\"}";
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/saveDefineValue")
    public void saveDefineValue(String date,
                                String tdId,
                                @CookieValue(value = "userid",defaultValue = "") String userid,
                                HttpServletRequest request,
                                HttpServletResponse response)throws IOException{

        String result = "";
        //HttpSession session = request.getSession();
        //String userid = (String)session.getAttribute("userid");

        List<FormDefineValueEntity> formDefineValueEntityList  = formDefineValueService.getDefineValueByTableIdDate(tdId, date);
        if(formDefineValueEntityList.size()>0){

            result = "{\"success\":false,\"msg\":\"上报日期已存在！\",\"id\":\"#date\"}";
        }else {

            FormDefineValueEntity formDefineValueEntity = new FormDefineValueEntity();
            formDefineValueEntity.setTvId(UUID.randomUUID().toString());
            formDefineValueEntity.setIsSh(false);
            formDefineValueEntity.setInputDate(new Timestamp(new Date().getTime()));
            String cxrq = date;
            if(cxrq.length()==4){
                cxrq += "-01-01";

            }
            if(cxrq.length()==7) {
                cxrq += "-01";
            }
            if(cxrq.length()==8) {

                String j = cxrq.substring(5,7);
                if(j.equals("01")){
                    j = "-01";
                }else if(j.equals("02")){
                    j = "-04";
                }else if(j.equals("03")){
                    j = "-07";
                }else if(j.equals("04")){
                    j = "-10";
                }
                j+="-01";
                cxrq = cxrq.substring(0,4);
                cxrq += j;
            }
            formDefineValueEntity.setCxrq(cxrq);
            formDefineValueEntity.setRq(date);
            formDefineValueEntity.setTdId(tdId);
            formDefineValueEntity.setUserId(userid);

            try {
                formDefineValueService.save(formDefineValueEntity);
                result = "{\"success\":true,\"msg\":\"增加数据成功！\"}";
            } catch (Exception ex) {
                result = "{\"success\":false,\"msg\":\"增加数据失败！\"}";
            }
        }
        StringUtil.writeToWeb(result, "html", response);
    }


    @RequestMapping(value = "/print")
    public void print(){
        try {
            //String command = "D:\\working\\systemconfig2\\systemconfig2\\src\\main\\webapp\\static\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe snap.js http://www.sina.com.cn sina.pdf";
            String command = "cmd.exe /c start /b D:\\working\\systemconfig2\\systemconfig2\\src\\main\\webapp\\static\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe D:\\working\\systemconfig2\\systemconfig2\\src\\main\\webapp\\static\\phantomjs-2.1.1-windows\\bin\\snap.js http://127.0.0.1:8081/print.html D:\\print.pdf";
            // String[] command={"D:\\working\\systemconfig2\\systemconfig2\\src\\main\\webapp\\static\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe","snap.js","http://127.0.0.1:8081/print.html","print.pdf"};
            //String command = "C:\\Windows\\System32\\notepad.exe";

            Process child = Runtime.getRuntime().exec(command);

            try{
                child.waitFor();
                int i = child.exitValue();
                if (i == 0) {
                            System.out.println("执行完成.") ;
                } else {
                            System.out.println("执行失败.") ;
                }

                System.out.println("111111111111.") ;
            }
           catch (Exception eee){

           }

        } catch (IOException e) {

            String s = e.getMessage();
        }
    }
}
