package com.dldata.drgs.controller.drgs_hubei;

import com.alibaba.fastjson.JSONObject;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.Util;
import net.sf.json.JSONArray;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.Region;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import sun.misc.BASE64Decoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by 吴岳峰 on 2018/01/20.
 */
@Controller
@RequestMapping("/hubei/ExcelDown")
public class ExcelDownController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @RequestMapping("/createExcelFile")
    public void createExcelFile(HttpServletRequest request, HttpServletResponse response) throws Exception{

        String fileName = "Excel.xls";
        String filepath = request.getSession().getServletContext().getRealPath("");

        String result="";
        FileOutputStream stream = null;
        BufferedImage bufferImg = null;

        String excelData = request.getParameter("excel");
        JSONArray excelJson = JSONArray.fromObject(excelData);
        HSSFWorkbook wb = new HSSFWorkbook();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/x-download");
        fileName = URLEncoder.encode(fileName, "UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);

        for(int index =0;index<excelJson.size();index++){

            List<String> imgUrls = new ArrayList<String>();
            JSONObject excelJsonObj = JSONObject.parseObject(excelJson.get(index).toString());
            Object imgs = excelJsonObj.get("img");
            Object tbales = excelJsonObj.get("table");
            Object name = excelJsonObj.get("name");
            if(Util.checkNotNull(imgs)){
                JSONArray jsonImg = JSONArray.fromObject(imgs);
                for(int i=0;i<jsonImg.size();i++){
                    String baseImg = jsonImg.get(i).toString();
                    String imgName = toMD5(baseImg);
                    String imgPath =  request.getSession().getServletContext().getRealPath("/") + "img";
                    String imgUrl = imgPath +"/"+ imgName +".png";

                    File file = new File(imgPath);
                    if(!file.exists()){
                        file.mkdir();
                    }
                    createImg(baseImg,imgUrl);
                    imgUrls.add(imgUrl);
                }
            }

            try {
                HSSFSheet sheet = wb.createSheet(Util.checkNotNull(name)?name.toString():"sheet"+(index==0?"":index));
                HSSFFont font = wb.createFont();
                font.setFontName("宋体");
                font.setFontHeightInPoints((short) 16);
                // 4.创建单元格，设置值表头，设置表头居中
                HSSFCellStyle style = wb.createCellStyle();
                style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
                style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                Map<Integer,Integer> ExcelTitle = new HashMap<Integer,Integer>();//表头合并
                Map<Integer,String> fileArray = new HashMap<Integer,String>();//表头字段
                int rowIndex = 0;
                int cellIndex = 0;
                if(Util.checkNotNull(tbales)){
                    JSONArray jsonTable = JSONArray.fromObject(tbales);
                    // 3.在sheet中添加表头第0行，老版本poi对excel行数列数有限制short
                    HSSFRow row = sheet.createRow((int) 0);

                    for(int tIndex=0;tIndex<jsonTable.size();tIndex++){
                        JSONObject tableJsonObj = JSONObject.parseObject(jsonTable.get(tIndex).toString());
                        Object title = tableJsonObj.get("title");
                        Object data = tableJsonObj.get("data");


                        // 表头数据
                        if(Util.checkNotNull(title)){
                            JSONArray jsonTitle = JSONArray.fromObject(title);
//                            //冻结第表头
//                            sheet.createFreezePane( 0, jsonTitle.size(), 0, jsonTitle.size() );
                            for(int i=0;i<jsonTitle.size();i++){
                                row = sheet.createRow((int) rowIndex);
                                rowIndex++;
                                JSONArray jsonTitleArray = JSONArray.fromObject(jsonTitle.get(i));
                                cellIndex = 0;
                                for(int j=0;j<jsonTitleArray.size();j++){
                                    JSONObject titleStr = JSONObject.parseObject(jsonTitleArray.get(j).toString());
                                    Object rowspanObj = titleStr.get("rowspan");
                                    Object colspanObj = titleStr.get("colspan");
                                    int rowspan = 1;
                                    int colspan = 1;
                                    for(;cellIndex<ExcelTitle.size()+1;cellIndex++){
                                        if(!(i>0&&i<ExcelTitle.get(cellIndex))){
                                            if(Util.checkNotNull(rowspanObj)){
                                                rowspan = (Integer)rowspanObj;
                                                ExcelTitle.put(cellIndex,rowspan);
                                            }else{
                                                ExcelTitle.put(cellIndex,1);
                                            }
                                            break;
                                        }
                                    }
                                    // 设置表头
                                    HSSFCell cell = row.createCell(cellIndex);

                                    if(Util.checkNotNull(titleStr.get("field"))){
                                        fileArray.put(cellIndex,titleStr.get("field").toString());
                                    }

                                    if(Util.checkNotNull(colspanObj)){
                                        colspan = (Integer)colspanObj;
                                        for(int cIndex=0;cIndex<colspan;cIndex++){
                                            ExcelTitle.put(cellIndex,1);
                                            cellIndex+=1;
                                        }
                                    }else{
                                        cellIndex+=1;
                                    }
                                    //合并单元格
                                    Region region = new Region(i, (short)(cellIndex-colspan), i+rowspan-1, (short)(cellIndex-1));
                                    sheet.addMergedRegion(region);
                                    cell.setCellValue(titleStr.get("title").toString().replace("&lt;","<").replace("&gt;",">"));
                                    cell.setCellStyle(style);
                                }
                            }
                        }
                        if(Util.checkNotNull(data)){
                            JSONArray jsonData = JSONArray.fromObject(data);
                            for(int i=0;i<jsonData.size();i++){
                                row = sheet.createRow(rowIndex);
                                rowIndex++;
                                if(fileArray.size()>0){
                                    JSONObject dataStr = JSONObject.parseObject(jsonData.get(i).toString());
                                    for(int j=0;j<fileArray.size();j++){
                                        if(Util.checkNotNull(fileArray.get(j))){
                                            String rowData = Util.checkNotNull(dataStr)?(Util.checkNotNull(dataStr.get(fileArray.get(j)))?dataStr.get(fileArray.get(j)):"").toString():"";
                                            Pattern p_html=Pattern.compile("<[^>]+>",Pattern.CASE_INSENSITIVE);
                                            Matcher m_html=p_html.matcher(rowData);
                                            rowData=m_html.replaceAll("");

                                            Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");
                                            if(Util.checkNotNull(rowData)&&!rowData.equals("-")&&pattern.matcher(rowData).matches()){
                                                row.createCell(j).setCellValue(Float.parseFloat(rowData));
                                            } else{
                                                row.createCell(j).setCellValue(rowData);
                                            }

                                        }
                                    }
                                }else{
                                    cellIndex = 0;
                                    JSONArray dataStr = JSONArray.fromObject(jsonData.get(i).toString());
                                    for(int j=0;j<dataStr.size();j++){
                                        cellIndex++;
                                        String rowData = dataStr.get(j).toString();
                                        Pattern p_html=Pattern.compile("<[^>]+>",Pattern.CASE_INSENSITIVE);
                                        Matcher m_html=p_html.matcher(rowData);
                                        rowData=m_html.replaceAll("");

                                        Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");
                                        if(Util.checkNotNull(rowData)&&pattern.matcher(rowData).matches()){
                                            row.createCell(j).setCellValue(Float.parseFloat(rowData));
                                        } else{
                                            row.createCell(j).setCellValue(rowData);
                                        }
                                    }
                                }
                            }
                        }
                        rowIndex++;
                    }
                }










                // 画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）
                HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
                for (int i = 0; i < imgUrls.size(); i++) {
                    ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
                    bufferImg = ImageIO.read(new File(imgUrls.get(i)));
                    ImageIO.write(bufferImg, "png", byteArrayOut);
                    // anchor主要用于设置图片的属性
                    Region region = new Region(1+i*10, (short)(1+cellIndex), 8+i*10, (short)(5+cellIndex));
                    sheet.addMergedRegion(region);
                    HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023, 250, (short) (1+cellIndex), 1+i*10, (short) (5+cellIndex), 8+i*10);
                    // 插入图片
                    patriarch.createPicture(anchor, wb.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_PNG));
                }

                stream = new FileOutputStream(filepath+"/"+fileName);
                wb.write(stream);
                // 写入excel文件
                wb.write(stream);
                result = "{\"success\":true,\"msg\":\"文件导出成功！\",\"fileName\":\""+fileName+"\"}";
            } catch (Exception e) {
                result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
                logger.error("【执行"+this.getClass().getName()+".createExcelFile() 方法失败 】异常："+e.getMessage());
                e.printStackTrace();
            } finally {
                if (stream != null) {
                    try {
                        stream.close();
                    } catch (IOException e) {
                        result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
                        e.printStackTrace();
                    }
                }
            }



        }





//        String imgs = request.getParameter("img");
//        String table = request.getParameter("table");
//
//        String fileName = "Excel.xls";
//        String filepath = request.getSession().getServletContext().getRealPath("");
//
//        String result;
//        FileOutputStream stream = null;
//
//        List<String> imgUrls = new ArrayList<String>();
//
//        if(Util.checkNotNull(imgs)){
//            JSONArray jsonImg = JSONArray.fromObject(imgs);
//            for(int index=0;index<jsonImg.size();index++){
//                String baseImg = jsonImg.get(index).toString();
//                String imgName = toMD5(baseImg);
//                String imgPath =  request.getSession().getServletContext().getRealPath("/") + "img";
//                String imgUrl = imgPath +"/"+ imgName +".png";
//
//                File file = new File(imgPath);
//                if(!file.exists()){
//                    file.mkdir();
//                }
//                createImg(baseImg,imgUrl);
//                imgUrls.add(imgUrl);
//            }
//        }
//
//        BufferedImage bufferImg = null;
//        // 先把读进来的图片放到一个ByteArrayOutputStream中，以便产生ByteArray
//        try {
//
//
//            HSSFWorkbook wb = new HSSFWorkbook();
//            HSSFSheet sheet = wb.createSheet("test picture");
//            // 画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）
//            HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
//            for (int i = 0; i < imgUrls.size(); i++) {
//                ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
//                bufferImg = ImageIO.read(new File(imgUrls.get(i)));
//                ImageIO.write(bufferImg, "png", byteArrayOut);
//                // anchor主要用于设置图片的属性
//                Region region = new Region(1+i*10, (short)(1), 8+i*10, (short)5);
//                sheet.addMergedRegion(region);
//                HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023, 250, (short) 1, 1+i*10, (short) 5, 8+i*10);
//                // 插入图片
//                patriarch.createPicture(anchor, wb.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_PNG));
//            }
//
//            stream = new FileOutputStream(filepath+"/"+fileName);
//            wb.write(stream);
//            // 写入excel文件
//            wb.write(stream);
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (stream != null) {
//                try {
//                    stream.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }






//        String title = request.getParameter("title");
//        String data = request.getParameter("data");

//        //文件名
//        String fileName = "Excel.xls";
//        String filepath = request.getSession().getServletContext().getRealPath("");
//        File fileUrl = new File(filepath + "\\" + fileName );
//        try {
//            fileUrl.delete();//成功导出后删除文件
//        } catch (Exception e) {
//
//        }
//        try{
//            // 1.创建一个workbook，对应一个Excel文件
//            HSSFWorkbook wb = new HSSFWorkbook();
//            request.setCharacterEncoding("UTF-8");
//            response.setCharacterEncoding("UTF-8");
//            response.setContentType("application/x-download");
//            fileName = URLEncoder.encode(fileName, "UTF-8");
//            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
//            // 2.在workbook中添加一个sheet，对应Excel中的一个sheet
//            HSSFSheet sheet = wb.createSheet("Excel数据");
//            HSSFFont font = wb.createFont();
//            font.setFontName("宋体");
//            font.setFontHeightInPoints((short) 16);
//            // 4.创建单元格，设置值表头，设置表头居中
//            HSSFCellStyle style = wb.createCellStyle();
//            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平居中
//            style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
//            // 3.在sheet中添加表头第0行，老版本poi对excel行数列数有限制short
//            HSSFRow row = sheet.createRow((int) 0);
//            // 表头数据
//            JSONArray jsonTitle = JSONArray.fromObject(title);
//            //冻结第表头
//            sheet.createFreezePane( 0, jsonTitle.size(), 0, jsonTitle.size() );
//            Map<Integer,Integer> ExcelTitle = new HashMap<Integer,Integer>();
//            Map<Integer,String> fileArray = new HashMap<Integer,String>();
//            for(int i=0;i<jsonTitle.size();i++){
//                row = sheet.createRow((int) i);
//                JSONArray jsonTitleArray = JSONArray.fromObject(jsonTitle.get(i));
//                int cellIndex = 0;
//                for(int j=0;j<jsonTitleArray.size();j++){
//                    JSONObject titleStr = JSONObject.parseObject(jsonTitleArray.get(j).toString());
//                    Object rowspanObj = titleStr.get("rowspan");
//                    Object colspanObj = titleStr.get("colspan");
//                    int rowspan = 1;
//                    int colspan = 1;
//                    for(;cellIndex<ExcelTitle.size()+1;cellIndex++){
//                        if(!(i>0&&i<ExcelTitle.get(cellIndex))){
//                            if(Util.checkNotNull(rowspanObj)){
//                                rowspan = (Integer)rowspanObj;
//                                ExcelTitle.put(cellIndex,rowspan);
//                            }else{
//                                ExcelTitle.put(cellIndex,1);
//                            }
//                            break;
//                        }
//                    }
//                    // 设置表头
//                    HSSFCell cell = row.createCell(cellIndex);
//
//                    if(Util.checkNotNull(titleStr.get("field"))){
//                        fileArray.put(cellIndex,titleStr.get("field").toString());
//                    }
//
//                    if(Util.checkNotNull(colspanObj)){
//                        colspan = (Integer)colspanObj;
//                        for(int index=0;index<colspan;index++){
//                            ExcelTitle.put(cellIndex,1);
//                            cellIndex+=1;
//                        }
//                    }else{
//                        cellIndex+=1;
//                    }
//                    //合并单元格
//                    Region region = new Region(i, (short)(cellIndex-colspan), i+rowspan-1, (short)(cellIndex-1));
//                    sheet.addMergedRegion(region);
//                    cell.setCellValue(titleStr.get("title").toString().replace("&lt;","<").replace("&gt;",">"));
//                    cell.setCellStyle(style);
//                }
//            }
//            JSONArray jsonData = JSONArray.fromObject(data);
//            for(int i=0;i<jsonData.size();i++){
//                JSONObject dataStr = JSONObject.parseObject(jsonData.get(i).toString());
//                row = sheet.createRow((int) i+jsonTitle.size());
//                for(int j=0;j<fileArray.size();j++){
//                    if(Util.checkNotNull(fileArray.get(j))){
//                        String rowData = dataStr.get(fileArray.get(j)).toString();
//                        Pattern p_html=Pattern.compile("<[^>]+>",Pattern.CASE_INSENSITIVE);
//                        Matcher m_html=p_html.matcher(rowData);
//                        rowData=m_html.replaceAll("");
//
//                        Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");
//                        if(Util.checkNotNull(rowData)&&pattern.matcher(rowData).matches()){
//                            row.createCell(j).setCellValue(Float.parseFloat(rowData));
//                        } else{
//                            row.createCell(j).setCellValue(rowData);
//                        }
//
//                    }
//                }
//            }
//
//
//            stream = new FileOutputStream(filepath+"/"+fileName);
//            wb.write(stream);


//            result = "{\"success\":true,\"msg\":\"文件导出成功！\",\"fileName\":\""+fileName+"\"}";
//
//        }catch (Exception ex){
//            result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
//            logger.error("【执行"+this.getClass().getName()+".createExcelFile() 方法失败 】异常："+ex.getMessage());
//            ex.printStackTrace();
//
//        }finally {
//            try{
//                stream.close();
//            }catch (Exception ex){
//                result = "{\"success\":false,\"msg\":\"文件导出失败！\"}";
//                ex.printStackTrace();
//            }
//        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/fileDown" )
    public void fileDown( String fName,
                          HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result;
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String filepath = request.getSession().getServletContext().getRealPath("");
        File fileUrl = new File(filepath + "\\" + fName );
        try {
            String fileName = fileUrl.getName();
            response.setContentType("application/octet-stream");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);

            response.setContentLength((int) fileUrl.length());

            bis = new BufferedInputStream(new FileInputStream(fileUrl));
            bos = new BufferedOutputStream(response.getOutputStream());

            byte[] buff = new byte[2048];
            int bytesRead = 0;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
            bos.flush();

            result = "{\"success\":true,\"msg\":\"导出成功！\"}";
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".fileDown() 方法失败 】异常："+ex.getMessage());
        }finally {
            try {
                bis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            bis = null;

            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                bos = null;
            }
        }
        try {
            fileUrl.delete();//成功导出后删除文件
        } catch (Exception e) {

        }
    }


    public void createImg(String baseImg,String fileName)throws Exception{
        OutputStream out = null;
        String result;
        try{
            String imgBase = baseImg.substring(22,baseImg.length());
            byte[] b = new BASE64Decoder().decodeBuffer(imgBase);

            // 生成图片

            File fileUrl = new File(fileName );
            if(fileUrl.exists()){
                fileUrl.delete();//成功导出后删除文件
            }
            out = new FileOutputStream(new File(fileName));
            out.write(b);
            out.flush();
        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"导出失败，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".fileDown() 方法失败 】异常："+ex.getMessage());
        }finally {
            out.close();
        }
    }

    public String toMD5(String plainText) {
        StringBuffer buf = new StringBuffer("");
        try {
            //生成实现指定摘要算法的 MessageDigest 对象。
            MessageDigest md = MessageDigest.getInstance("MD5");
            //使用指定的字节数组更新摘要。
            md.update(plainText.getBytes());
            //通过执行诸如填充之类的最终操作完成哈希计算。
            byte b[] = md.digest();
            //生成具体的md5密码到buf数组
            int i;

            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return buf.toString();
    }
}
