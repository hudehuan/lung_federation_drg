package com.dldata.drgs.controller.drgsDicData;


import com.dldata.drgs.entity.DicCm3DefineEntity;
import com.dldata.drgs.service.drgsDicData.DicCm3DefineService;
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
@RequestMapping("/DicCm3Define")
public class DicCm3DefineController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DicCm3DefineService dicCm3DefineService;

    @RequestMapping("/getList")
    @ResponseBody
    public List<DicCm3DefineEntity> getList(String search){
        List<DicCm3DefineEntity> dicCm3DefineEntities = dicCm3DefineService.findBeSearchLike(search);

        List<DicCm3DefineEntity> reList = dicCm3DefineEntities.stream().limit(500).collect(Collectors.toList());
        return dicCm3DefineEntities;
    }

    @RequestMapping("/save")
    public void save(DicCm3DefineEntity dicCm3DefineEntity, HttpServletRequest request, HttpServletResponse response) throws Exception{
        String result;
        try {
            if (dicCm3DefineEntity.getId().equals("")) {
                dicCm3DefineEntity.setId(UUID.randomUUID().toString());
                List<DicCm3DefineEntity> dicCm3DefineEntities = new ArrayList<DicCm3DefineEntity>();
                dicCm3DefineEntities = dicCm3DefineService.findOneByCode(dicCm3DefineEntity.getCode());
                if (dicCm3DefineEntities.size() > 0) {
                    result = "{\"success\":false,\"msg\":\"对照代码已存在！\",\"id\":\"#code\"}";
                    StringUtil.writeToWeb(result, "html", response);
                    return;
                }
            }
            dicCm3DefineService.save(dicCm3DefineEntity);
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
            dicCm3DefineService.delete(id);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        }
        catch (Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行"+this.getClass().getName()+".delete() 方法失败 】异常："+ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
