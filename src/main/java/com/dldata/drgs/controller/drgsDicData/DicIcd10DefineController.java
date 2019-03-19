package com.dldata.drgs.controller.drgsDicData;

import com.dldata.drgs.entity.DicIcd10DefineEntity;
import com.dldata.drgs.service.drgsDicData.DicIcd10DefineService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */

@Controller
@RequestMapping("/DicIcd10Define")
public class DicIcd10DefineController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DicIcd10DefineService dicIcd10DefineService;

    @RequestMapping("/getList")
    @ResponseBody
    public List<DicIcd10DefineEntity> getList(String search){
        List<DicIcd10DefineEntity> dicIcd10DefineEntities = dicIcd10DefineService.findBeSearchLike(search);

        List<DicIcd10DefineEntity> reList = dicIcd10DefineEntities.stream().limit(500).collect(Collectors.toList());
        return dicIcd10DefineEntities;
    }

    @RequestMapping("/save")
    public void save(DicIcd10DefineEntity dicIcd10DefineEntity, HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            if (dicIcd10DefineEntity.getId().equals("")) {
                dicIcd10DefineEntity.setId(UUID.randomUUID().toString());
                List<DicIcd10DefineEntity> dicIcd10DefineEntities = new ArrayList<DicIcd10DefineEntity>();
                dicIcd10DefineEntities = dicIcd10DefineService.findOneByCode(dicIcd10DefineEntity.getCode());
                if (dicIcd10DefineEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"对照代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }
            dicIcd10DefineService.save(dicIcd10DefineEntity);
            result = "{\"success\":true,\"msg\":\"保存成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".saveKeShi() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping("/del")
    public void delete(String id,HttpServletRequest request,
                       HttpServletResponse response)throws Exception{
        String result;

        try {
            dicIcd10DefineService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
