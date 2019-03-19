package com.dldata.drgs.controller.Table;

import com.dldata.drgs.entity.TabStructureEntity;
import com.dldata.drgs.service.Table.TabStructureService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by 倪继文 on 2016/8/3.
 */


@Controller
@RequestMapping(value = "/tabstruc")
public class TableStrucController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    TabStructureService tabStructureService;


    @RequestMapping(value = "/tolist")
    public String toTabStruc(HttpServletRequest request, HttpServletResponse response, Model model) {
        String tableid = request.getParameter("tableid");

        model.addAttribute("tableid", tableid);

        return "table/tablelist";
    }


//    @RequestMapping(value = "/toadd")
//    public String toAdd(String id, String tableid, Model model) {
//
//        model.addAttribute("tableid", tableid);
//        return "table/tableStrucAdd";
//    }

    @RequestMapping(value = "/toedit")
    public String toEdit(String tableid, String id, Model model) {

        TabStructureEntity entity = new TabStructureEntity();
        if(id!=null&&!id.equals("")){
            entity = tabStructureService.findOne(id);
            model.addAttribute("tablestruc", entity);
        }
        model.addAttribute("tableid", tableid);
        return "table/tableStrucEdit";

    }


    @RequestMapping(value = "/list")
    @ResponseBody
    public List<TabStructureEntity> getTabStrucOfTableByTableID(String tableid, HttpServletRequest request, HttpServletResponse response) {

        List<TabStructureEntity> tabStructureEntities = new ArrayList<TabStructureEntity>();
        tabStructureEntities = tabStructureService.getStrucByTableID(tableid);


        return tabStructureEntities;

    }


    @RequestMapping(value = "/save")
    public void save(TabStructureEntity entity, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String result;

        if (entity.getId().equals("")) {
            entity.setId(UUID.randomUUID().toString());

            if (entity.getIsKey() == null) {
                entity.setIsKey(false);
            }
            String tableid = entity.getTableId();
            String name = entity.getName();
            List<TabStructureEntity> tabStructureEntities = new ArrayList<TabStructureEntity>();
            tabStructureEntities = tabStructureService.getStrucByTableID(tableid);

            if (tabStructureEntities.size() > 0) {
                for (TabStructureEntity t : tabStructureEntities) {
                    if (t.getName().equals(name)) {
                        String result1 = "{\"success\":false,\"msg\":\"字段已存在！\",\"id\":\"#name\"}";
                        StringUtil.writeToWeb(result1, "html", response);
                        return;
                    }
                }
                ;
            }
            result = "{\"success\":true,\"model\":\"add\",\"msg\":\"新增完成！\"}";
        } else {
            result = "{\"success\":true,\"model\":\"update\",\"msg\":\"修改完成！\"}";
        }

        try {
            if (!entity.getZhName().equals("")) {
                entity.setPym(StringUtil.getPinYinHeadChar(entity.getZhName()));
            }
            Integer xh = entity.getXh();
            if (xh == null) {
                xh = tabStructureService.getColumnXH(entity.getTableId());
                entity.setXh(xh);
            }
            entity.setStatus(1);
            tabStructureService.save(entity);
            StringUtil.writeToWeb(result, "html", response);
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            StringUtil.writeToWeb(result, "html", response);
            logger.error("【执行" + this.getClass().getName() + ".save() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/delete")
    public void delete(String id, HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        String result;

        try {
            TabStructureEntity tabStructureEntity = tabStructureService.findOne(id);
            tabStructureEntity.setStatus(0);
            tabStructureService.save(tabStructureEntity);
            result = "{\"success\":true,\"msg\":\"删除成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteTabStruc() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }
}
