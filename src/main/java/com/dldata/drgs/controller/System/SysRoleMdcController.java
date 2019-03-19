package com.dldata.drgs.controller.System;

import com.dldata.drgs.businessmodel.TreeNode;
import com.dldata.drgs.entity.*;
import com.dldata.drgs.repository.drgsDicData.DicMdcDao;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysRoleMdcService;
import com.dldata.drgs.service.System.SysRoleMenuService;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.service.drgsDicData.DicMdcService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
@Controller
@RequestMapping(value = "/SysRoleMdc")
public class SysRoleMdcController {
    @Autowired
    private SysMenuService sysMenuService;
    @Autowired
    private DicMdcService dicMdcService;
    @Autowired
    private SysRoleMdcService sysRoleMdcService;

    @RequestMapping(value = "/getMdcByRoleID")
    @ResponseBody
    public String getMdcByRoleID(String roleId, @CookieValue(value = "syscode",defaultValue = "") String sysCode){

        List<DicMdcEntity> dicMdcEntities = dicMdcService.findBySearchLike("");

        List<SysRoleMdcEntity> sysRoleMdcEntities =sysRoleMdcService.findMdcByRoleid(roleId);

        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();

        dicMdcEntities.forEach(mdc -> {
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("id","");
            map.put("mdcdm",mdc.getDm());
            map.put("mdcmc",mdc.getMc());
            map.put("browse","");
            sysRoleMdcEntities.stream().filter(r -> r.getJbdm().equals(mdc.getDm())).limit(1).forEach(r -> {
                map.put("id",r.getId());
                map.put("browse",r.getBrowse());
            });
            mapList.add(map);
        });
        return  mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";

    }

    @RequestMapping(value = "/saveRoleMdc" ,method = {RequestMethod.POST})
    @ResponseBody
    public String saveRoleMdc(@RequestBody String roleMdc,
                               @CookieValue(value = "syscode",defaultValue = "") String sysCode){


        JSONArray array = JSONArray.fromObject(roleMdc);


        //先保存所有选中的内容
        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            SysRoleMdcEntity selectResult = new SysRoleMdcEntity();

            selectResult.setId(object.get("id").toString());
            selectResult.setJbdm(object.get("mdcdm").toString());
            selectResult.setRoleId(object.get("roleid").toString());
            selectResult.setBrowse(Boolean.valueOf(object.get("browse").toString()));


            if(selectResult.getId().equals("")){
                selectResult.setId(UUID.randomUUID().toString());
            }
            sysRoleMdcService.save(selectResult);


        }


        return roleMdc;
    }

}
