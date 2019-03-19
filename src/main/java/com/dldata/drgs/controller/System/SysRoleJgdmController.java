package com.dldata.drgs.controller.System;

import com.dldata.drgs.businessmodel.TreeNode;
import com.dldata.drgs.entity.*;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysRoleJgdmService;
import com.dldata.drgs.service.System.SysRoleMenuService;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import com.dldata.drgs.service.drgsDicData.DicXzqhService;
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
@RequestMapping(value = "/SysRoleJgdm")
public class SysRoleJgdmController {

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysRoleJgdmService sysRoleJgdmService;

    @Autowired
    private DicJgdmService dicJgdmService;

    @Autowired
    private DicXzqhService dicXzqhService;

    @RequestMapping(value = "/getJgdmByRoleID")
    @ResponseBody
    public List<RoleJgdm> getJgdmByRoleID(String roleId, @CookieValue(value = "syscode",defaultValue = "") String sysCode){

        List<DicXzqhEntity> dicXzqhEntities = dicXzqhService.getAllData().stream().filter(x ->x.getDm().length()==4).collect(Collectors.toList());

        List<DicJgdmEntity> dicJgdmEntities = dicJgdmService.getAllData();

        List<SysRoleJgdmEntity> sysRoleJgdmEntities =sysRoleJgdmService.findJgdmByRoleid(roleId);
        DicXzqhEntity dicXzqhEntity = new DicXzqhEntity();
        dicXzqhEntity.setDm("4299");
        dicXzqhEntity.setMc("湖北省省属单位");
        dicXzqhEntity.setShi("省属");
        dicXzqhEntities.add(dicXzqhEntity);

        List<RoleJgdm> jgdms = new ArrayList<RoleJgdm>();
        dicXzqhEntities.forEach(x->{
            RoleJgdm roleJgdm = new RoleJgdm();
            roleJgdm.setState("closed");
            roleJgdm.setJgdm(x.getDm());
            roleJgdm.setJgmc(x.getMc());
            roleJgdm.setBrowse(false);
            List<RoleJgdm> roleJgdmchilds =  new ArrayList<RoleJgdm>();
            dicJgdmEntities.stream().filter(jgdm -> (jgdm.getXzqh()==null?"":jgdm.getXzqh()).indexOf(x.getDm())==0
            || jgdm.getIssz().equals(x.getShi())).forEach(jgdm -> {
                RoleJgdm roleJgdmchild = new RoleJgdm();
                roleJgdmchild.setChildren(new ArrayList<RoleJgdm>());
                roleJgdmchild.setpJgdm(x.getDm());
                roleJgdmchild.setJgdm(jgdm.getDm());
                roleJgdmchild.setJgmc(jgdm.getMc());
                roleJgdmchild.setBrowse(false);
                sysRoleJgdmEntities.stream().filter(r -> r.getJgdm().equals(jgdm.getDm())).limit(1).forEach(r -> {
                    roleJgdmchild.setId(r.getId());
                    roleJgdmchild.setBrowse(r.getBrowse());
                    if(r.getBrowse()){
                        roleJgdm.setBrowse(true);
                    }
                });
                roleJgdmchilds.add(roleJgdmchild);
            });
            roleJgdm.setChildren(roleJgdmchilds);
            if(roleJgdmchilds.size()>0){
                jgdms.add(roleJgdm);
            }

        });

        return jgdms;
//                mapList.size()>0 ? JSONArray.fromObject(mapList).toString() : "[]";

    }

    @RequestMapping(value = "/saveRoleJgdm" ,method = {RequestMethod.POST})
    @ResponseBody
    public String saveRoleJgdm(@RequestBody String roleJgdm,
                              @CookieValue(value = "syscode",defaultValue = "") String sysCode){


        JSONArray array = JSONArray.fromObject(roleJgdm);


        //先保存所有选中的内容
        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            SysRoleJgdmEntity selectResult = new SysRoleJgdmEntity();

            selectResult.setId(object.get("id").toString());
            selectResult.setJgdm(object.get("jgdm").toString());
            selectResult.setRoleId(object.get("roleid").toString());
            selectResult.setBrowse(Boolean.valueOf(object.get("browse").toString()));


            if(selectResult.getId().equals("")){
                selectResult.setId(UUID.randomUUID().toString());
            }
            sysRoleJgdmService.save(selectResult);


        }


        return roleJgdm;
    }


    private class RoleJgdm{


        private String id="";
        private String jgdm="";
        private String jgmc="";
        private boolean browse = false;
        private String state ="open";
        private List<RoleJgdm> children;
        private String pJgdm = "";

        public String getpJgdm() {
            return pJgdm;
        }

        public void setpJgdm(String pJgdm) {
            this.pJgdm = pJgdm;
        }

        public String getJgdm() {
            return jgdm;
        }

        public void setJgdm(String jgdm) {
            this.jgdm = jgdm;
        }

        public String getJgmc() {
            return jgmc;
        }

        public void setJgmc(String jgmc) {
            this.jgmc = jgmc;
        }
        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public boolean isBrowse() {
            return browse;
        }

        public void setBrowse(boolean browse) {
            this.browse = browse;
        }





        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }


        public List<RoleJgdm> getChildren() {
            return children;
        }

        public void setChildren(List<RoleJgdm> children) {
            this.children = children;
        }

    }

}
