package com.dldata.drgs.controller.customform;

import com.dldata.drgs.entity.SjsbFormKeshiEntity;
import com.dldata.drgs.entity.SysKsEntity;
import com.dldata.drgs.service.System.SysKeShiService;
import com.dldata.drgs.service.customform.SjsbFormKeshiService;
import com.dldata.drgs.utils.StringUtil;
import net.sf.json.JSONArray;
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
 * Created by 吴岳峰 on 2017/6/7.
 */
@Controller
@RequestMapping(value = "/CustomFormKeshi")
public class CustomFormKeshiController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SjsbFormKeshiService customFormKeshiService;

    @Autowired
    private SysKeShiService sysKeShiService;

    @RequestMapping("/findByFormId")
    @ResponseBody
    public String findByFormId(String formId, HttpServletRequest request, HttpServletResponse response){
        List<SjsbFormKeshiEntity> sjsbFormKeshiEntities = customFormKeshiService.getByFormId(formId);
        List<SysKsEntity> sysKsEntities = sysKeShiService.getAllKeShi();
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();

        sjsbFormKeshiEntities.forEach(f -> {
            Map<String,String> map = new HashMap<String, String>();
            map.put("id",f.getId());
            map.put("code","");
            map.put("name" ,"");
            sysKsEntities.stream().filter(k -> k.getId().equals(f.getKid()==null?"":f.getKid())).limit(1).forEach(k -> {
                map.put("code",k.getCode()==null?k.getId():k.getCode());
                map.put("name" ,k.getName()==null?k.getId():k.getName());
            });
            mapList.add(map);
        });
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";

    }

    @RequestMapping("/addFormKeshi")
    public void addFormKeshi(String id ,String formId,HttpServletRequest request,HttpServletResponse response)throws Exception{
        String result;
        try {
            String[] kid = id.split(",");
            List<SjsbFormKeshiEntity> sjsbFormKeshiEntities = customFormKeshiService.getByFormId(formId);
            for(int i = 0; i<kid.length;i++){
                boolean is = false;
                for (SjsbFormKeshiEntity s : sjsbFormKeshiEntities) {
                    if(s.getKid().equals(kid[i])){
                        is = true;
                    }
                }
                if(!is){
                    SjsbFormKeshiEntity sjsbFormKeshiEntity = new SjsbFormKeshiEntity();
                    sjsbFormKeshiEntity.setId(UUID.randomUUID().toString());
                    sjsbFormKeshiEntity.setKid(kid[i]);
                    sjsbFormKeshiEntity.setFormId(formId);
                    customFormKeshiService.save(sjsbFormKeshiEntity);
                }
            }

            result = "{\"success\":true,\"msg\":\"权限科室保存成功！\"}";

        }catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".addFormKeshi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);

    }


    @RequestMapping("/deleFormKeshi")
    public void deleFormKeshi(String id,HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        try {
            customFormKeshiService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".deleFormKeshi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
