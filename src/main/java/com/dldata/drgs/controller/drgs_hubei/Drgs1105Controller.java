package com.dldata.drgs.controller.drgs_hubei;

import com.dldata.drgs.entity.DrGsYkssEntity;
import com.dldata.drgs.entity.DrGsYkssZedEntity;
import com.dldata.drgs.service.drgs.DrGsYkssService;
import com.dldata.drgs.service.drgs.DrGsYkssZedService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Controller
@RequestMapping("/hubei/Drgs1105")
public class Drgs1105Controller {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DrGsYkssService drGsYkssService;
    @Autowired
    private DrGsYkssZedService drGsYkssZedService;

    @ResponseBody
    @RequestMapping("/getYkssList")
    public String getYkssList(){
        List<DrGsYkssEntity> drGsYkssEntities = drGsYkssService.getAll();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        drGsYkssEntities.forEach(d -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("id",d.getId());
            map.put("name",d.getName());
            map.put("status",d.getStatus()!=null&&d.getStatus()?"启用":"停用");
            map.put("year",d.getYear());
            map.put("address",d.getAddress());
            map.put("ckqz",d.getCkqz());
            map.put("yjqz",d.getYjqz());
            map.put("fffl",d.getFffl());
            mapList.add(map);
        });
        return mapList.size()>0 ? net.sf.json.JSONArray.fromObject(mapList).toString():"[]";
    }

    @ResponseBody
    @RequestMapping("/findYkssListBySearch")
    public String findYkssListBySearch(String search){
        List<DrGsYkssEntity> drGsYkssEntities = drGsYkssService.findBySearch(search);
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        drGsYkssEntities.forEach(d -> {
            Map<String,String> map = new HashMap<String,String>();
            map.put("id",d.getId());
            map.put("name",d.getName());
            map.put("status",d.getStatus()!=null&&d.getStatus()?"启用":"停用");
            map.put("year",d.getYear());
            map.put("address",d.getAddress());
            map.put("ckqz",d.getCkqz());
            map.put("yjqz",d.getYjqz());
            map.put("fffl",d.getFffl());
            mapList.add(map);
        });
        return mapList.size()>0 ? net.sf.json.JSONArray.fromObject(mapList).toString():"[]";
    }

    @RequestMapping("/ykssSave")
    private void ykssSave(DrGsYkssEntity drGsYkssEntity, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try{
            if(drGsYkssEntity.getId().equals("")){
                drGsYkssEntity.setId(UUID.randomUUID().toString());
            }
            drGsYkssService.save(drGsYkssEntity);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"操作错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".ykssSave() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/ykssDel")
    public void ykssDel(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            List<DrGsYkssZedEntity> drGsYkssZedEntities = drGsYkssZedService.findByYkId(id);
            drGsYkssZedEntities.forEach(e -> {
                drGsYkssZedService.delete(e.getId());
            });
            drGsYkssService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".ykssDel() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @ResponseBody
    @RequestMapping("/getZedGs")
    public String getZedGs(String ykid){
        List<DrGsYkssZedEntity> drGsYkssZedEntities = drGsYkssZedService.findByYkId(ykid);
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        drGsYkssZedEntities.forEach(d -> {
            Map<String ,String > map = new HashMap<String,String>();
            map.put("id",d.getId());
            map.put("ykid",d.getYkid());
            map.put("gs",d.getGs());
            map.put("status",d.getStatus()!=null&&d.getStatus()?"启用":"停用");
            mapList.add(map);
        });
        return mapList.size()>0 ? net.sf.json.JSONArray.fromObject(mapList).toString():"[]";
    }

    @RequestMapping("/gsSave")
    private void gsSave(DrGsYkssZedEntity drGsYkssZedEntity, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try{
            if(drGsYkssZedEntity.getId().equals("")){
                drGsYkssZedEntity.setId(UUID.randomUUID().toString());
            }
            drGsYkssZedService.save(drGsYkssZedEntity);
            result = "{\"success\":true,\"msg\":\"修改成功！\"}";

        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"操作错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".gsSave() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/gsDel")
    public void gsDel(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result;
        try {
            drGsYkssZedService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".gsDel() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
