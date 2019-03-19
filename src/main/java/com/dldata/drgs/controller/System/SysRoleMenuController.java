package com.dldata.drgs.controller.System;

import com.dldata.drgs.businessmodel.TreeNode;
import com.dldata.drgs.entity.SysMenuEntity;
import com.dldata.drgs.entity.SysRoleEntity;
import com.dldata.drgs.entity.SysRoleMenuEntity;
import com.dldata.drgs.service.System.SysMenuService;
import com.dldata.drgs.service.System.SysRoleMenuService;
import com.dldata.drgs.service.System.SysRoleService;
import com.dldata.drgs.service.System.SysUserPowerCheckService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Created by 倪继文 on 2016/7/21.
 */

@Controller
@RequestMapping(value = "/SysRoleMenu")
public class SysRoleMenuController {

    @Autowired
    SysRoleService sysRoleService;

    @Autowired
    SysMenuService sysMenuService;
    @Autowired
    SysRoleMenuService sysRoleMenuService;

    @Autowired
    SysUserPowerCheckService sysUserPowerCheckService;
//    @RequestMapping(value = "/toList")
//    public String toList(@CookieValue(value = "userid",defaultValue = "") String userid,
//                         @RequestParam(value = "menuCode",defaultValue = "") String menuCode,
//                         @CookieValue(value = "syscode",defaultValue = "")String sysCode,
//                         Model model,HttpServletRequest request,HttpServletResponse response){
//        model.addAttribute("titlename", "角色权限管理");
//
//        SysRoleMenuEntity roleMenuEntity = new SysRoleMenuEntity();
//
//        List<SysRoleMenuEntity> sysRoleMenuEntityList = sysUserPowerCheckService.checkUserPower(menuCode,userid,sysCode);
//
//        if (sysRoleMenuEntityList.size()>0){
//            roleMenuEntity = sysRoleMenuEntityList.get(0);
//            model.addAttribute("roleMenu",roleMenuEntity);
//
//        }
//        return "System/SysRoleMenu";
//    }


    @RequestMapping(value = "/getRoleTreeNode")
    @ResponseBody
    public List<TreeNode> getRoleTreeNodes(@CookieValue(value = "syscode",defaultValue = "")String sysCode){

        List<SysRoleEntity> roleEntities = new ArrayList<SysRoleEntity>();
        List<TreeNode> nodes = new ArrayList<TreeNode>();

        roleEntities = sysRoleService.getAllRole(sysCode);

        for(SysRoleEntity entity : roleEntities){

            TreeNode node = new TreeNode();
            node.setId(entity.getId());
            node.setText(entity.getName());
            node.setState("open");
            List<TreeNode> chilenodes = new ArrayList<TreeNode>();
            node.setChildren(chilenodes);

            nodes.add(node);
        }
        return nodes;
    }


    @RequestMapping(value = "/getMenuByRoleID")
    @ResponseBody
    public List<RoleMenu> getMenuByRoleID(String roleId,@CookieValue(value = "syscode",defaultValue = "") String sysCode){

        List<SysMenuEntity> menuEntities = new ArrayList<SysMenuEntity>();
        menuEntities = sysMenuService.getAllMenu(sysCode);

        List<SysRoleMenuEntity> roleMenuEntities = new ArrayList<SysRoleMenuEntity>();
        roleMenuEntities =sysRoleMenuService.getMenuByRoleID(roleId);

        List<RoleMenu> menus = new ArrayList<RoleMenu>();

        for(SysMenuEntity menuEntity : menuEntities){
            if(menuEntity.getCode().length()>3) continue;
            RoleMenu menu = new RoleMenu();
            menu.setMenuId(menuEntity.getId());
            menu.setMenuName("[" + menuEntity.getCode() + "]" + menuEntity.getName());
            menu.setType(menuEntity.getType());
            menu.setMenuCode(menuEntity.getCode());
            menu.setpMenuCode(menuEntity.getpCode());

            roleMenuEntities.stream().filter(r->r.getMenuId().equals(menuEntity.getId())).
                    forEach(e -> {
                        menu.setId(e.getId());
                        menu.setBrowse(e.getIsBrowse());
                        menu.setAdd(e.getIsAdd());
                        menu.setCheck(e.getIsCheck());
                        menu.setUndo(e.getIsUndo());
                        menu.setDel(e.getIsDel());
                        menu.setEdit(e.getIsEdit());
                        menu.setPrint(e.getIsPrint());
                        menu.setExport(e.getIsExport());
                        menu.setMyimport(e.getIsImport());

                    });

            menu.setChildren(_getChildrenRoleMenu(menu.getMenuCode(),menuEntities,roleMenuEntities));

            menus.add(menu);
        }
        return menus;
    }


    public List<RoleMenu> _getChildrenRoleMenu(String menuCode,
                                               List<SysMenuEntity> menuEntities,
                                               List<SysRoleMenuEntity> roleMenuEntities){
        List<RoleMenu> children = new ArrayList<RoleMenu>();

        menuEntities.stream().filter(m->m.getpCode().equals(menuCode)).
                forEach(m -> {

                    RoleMenu menu = new RoleMenu();

                    menu.setMenuId(m.getId());
                    menu.setMenuName("[" + m.getCode() + "]" + m.getName());
                    menu.setMenuCode(m.getCode());
                    menu.setpMenuCode(m.getpCode());
                    menu.setType(m.getType());
                    roleMenuEntities.stream().filter(r->r.getMenuId().equals(m.getId())).
                            forEach(e -> {
                                menu.setId(e.getId());
                                menu.setBrowse(e.getIsBrowse());
                                menu.setAdd(e.getIsAdd());
                                menu.setCheck(e.getIsCheck());
                                menu.setUndo(e.getIsUndo());
                                menu.setDel(e.getIsDel());
                                menu.setEdit(e.getIsEdit());
                                menu.setPrint(e.getIsPrint());
                                menu.setExport(e.getIsExport());
                                menu.setMyimport(e.getIsImport());

                            });

                    menu.setChildren(_getChildrenRoleMenu(menu.getMenuCode(),menuEntities,roleMenuEntities));
                    children.add(menu);
                });
        return children;
    }



    @RequestMapping(value = "/saveRoleMenu" ,method = {RequestMethod.POST})
    @ResponseBody
    public String saveRoleMenu(@RequestBody String roleMenus,
                               @CookieValue(value = "syscode",defaultValue = "") String sysCode){


        String roleId="";
        //先获取到系统下全部的菜单
        List<SysMenuEntity> menuEntities = new ArrayList<SysMenuEntity>();
        menuEntities = sysMenuService.getAllMenu(sysCode);

        List<String> pMenuCodeList = new ArrayList<>();

        JSONArray array = JSONArray.fromObject(roleMenus);


        //先保存所有选中的内容
        for(int i=0;i<array.size();i++){
            JSONObject object = (JSONObject)array.get(i);
            SysRoleMenuEntity selectResult = new SysRoleMenuEntity();

            selectResult.setId(object.get("id").toString());
            selectResult.setMenuId(object.get("menuid").toString());

            String pMenucode = object.get("pmenucode").toString();
            String menucode = object.get("menucode").toString();
            if(menucode.length()==3) {
                //array.stream().filter(a->a.get("menucode").toString())
                pMenuCodeList.add(menucode);
            };
            if(menucode.length()==6){
                System.out.println(menucode);
            }
            //selectResult.se.setPmenucode(object.get("pmenucode").toString());
            //selectResult.set.setMenuname(object.get("menuname").toString());
            //selectResult.set.setMenucode(object.get("menucode").toString());
            selectResult.setRoleId(object.get("roleid").toString());
            roleId = object.get("roleid").toString();
            //pSelectResult.setRoleId(object.get("roleid").toString());
            selectResult.setIsExport(Boolean.valueOf(object.get("export").toString()));
            selectResult.setIsAdd(Boolean.valueOf(object.get("add").toString()));
            selectResult.setIsBrowse(Boolean.valueOf(object.get("browse").toString()));
            selectResult.setIsCheck(Boolean.valueOf(object.get("check").toString()));
            selectResult.setIsUndo(Boolean.valueOf(object.get("undo").toString()));
            selectResult.setIsDel(Boolean.valueOf(object.get("del").toString()));
            selectResult.setIsEdit(Boolean.valueOf(object.get("edit").toString()));
            selectResult.setIsImport(Boolean.valueOf(object.get("myimport").toString()));
            selectResult.setIsPrint(Boolean.valueOf(object.get("print").toString()));


            if(selectResult.getId().equals("")){
                selectResult.setId(UUID.randomUUID().toString());
            }
            sysRoleMenuService.save(selectResult);


        }

        //在更新父节点选中状态
        List<SysRoleMenuEntity> roleMenuEntities = new ArrayList<SysRoleMenuEntity>();
        roleMenuEntities =sysRoleMenuService.getMenuByRoleID(roleId);

        for(int n=0;n<pMenuCodeList.size();n++){
            String menucode = pMenuCodeList.get(n).toString();
            if(menucode.length() == 3){
                List<SysMenuEntity> pmenuEntities = menuEntities.stream().filter(s -> s.getCode().equals(menucode)).collect(Collectors.toList());
                String pMenuId = pmenuEntities.get(0).getId();
                List<SysRoleMenuEntity> pRoleMenuEntity = roleMenuEntities.stream().filter(r->r.getMenuId().equals(pMenuId)).collect(Collectors.toList());
                SysRoleMenuEntity sysRoleMenuEntity = pRoleMenuEntity.get(0);

                for(int i=0;i<array.size();i++){
                    JSONObject object = (JSONObject)array.get(i);
                    String code = object.get("menucode").toString();
                    if(code.startsWith(menucode)){
                        if(Boolean.valueOf(object.get("browse").toString())){
                            sysRoleMenuEntity.setIsBrowse(true);
                        }
                        if(Boolean.valueOf(object.get("export").toString())){
                            sysRoleMenuEntity.setIsExport(true);
                        }
                        if(Boolean.valueOf(object.get("add").toString())){
                            sysRoleMenuEntity.setIsAdd(true);
                        }
                        if(Boolean.valueOf(object.get("check").toString())){
                            sysRoleMenuEntity.setIsCheck(true);
                        }
                        if(Boolean.valueOf(object.get("undo").toString())){
                            sysRoleMenuEntity.setIsUndo(true);
                        }
                        if(Boolean.valueOf(object.get("del").toString())){
                            sysRoleMenuEntity.setIsDel(true);
                        }
                        if(Boolean.valueOf(object.get("edit").toString())){
                            sysRoleMenuEntity.setIsEdit(true);
                        }
                        if(Boolean.valueOf(object.get("myimport").toString())){
                            sysRoleMenuEntity.setIsImport(true);
                        }
                        if(Boolean.valueOf(object.get("print").toString())){
                            sysRoleMenuEntity.setIsPrint(true);
                        }
                    }
                }
                sysRoleMenuService.save(sysRoleMenuEntity);
            }
        }



        return roleMenus;
    }


    private class RoleMenu{
        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        private String id="";
        private String menuId="";
        private String menuCode="";
        private String menuName="";
        private String pMenuCode="";
        private String type="";
        private boolean browse = false;
        private boolean add = false;
        private boolean edit = false;
        private boolean del = false;
        private boolean print = false;
        private boolean myimport = false;
        private boolean export = false;
        private boolean check = false;
        private boolean undo = false;
        private String state ="open";
        private List<RoleMenu> children;
        private String _parentId;



        public boolean isBrowse() {
            return browse;
        }

        public void setBrowse(boolean browse) {
            this.browse = browse;
        }

        public boolean isAdd() {
            return add;
        }

        public void setAdd(boolean add) {
            this.add = add;
        }

        public boolean isEdit() {
            return edit;
        }

        public void setEdit(boolean edit) {
            this.edit = edit;
        }

        public boolean isDel() {
            return del;
        }

        public void setDel(boolean del) {
            this.del = del;
        }

        public boolean isPrint() {
            return print;
        }

        public void setPrint(boolean print) {
            this.print = print;
        }

        public boolean isMyimport() {
            return myimport;
        }

        public void setMyimport(boolean myimport) {
            this.myimport = myimport;
        }

        public boolean isExport() {
            return export;
        }

        public void setExport(boolean export) {
            this.export = export;
        }

        public boolean isCheck() {
            return check;
        }

        public void setCheck(boolean check) {
            this.check = check;
        }

        public boolean isUndo() {
            return undo;
        }

        public void setUndo(boolean undo) {
            this.undo = undo;
        }



        public String get_parentId() {
            return _parentId;
        }

        public void set_parentId(String _parentId) {
            this._parentId = _parentId;
        }




        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }


        public List<RoleMenu> getChildren() {
            return children;
        }

        public void setChildren(List<RoleMenu> children) {
            this.children = children;
        }

        public String getMenuId() {
            return menuId;
        }

        public void setMenuId(String menuId) {
            this.menuId = menuId;
        }

        public String getMenuCode() {
            return menuCode;
        }

        public void setMenuCode(String menuCode) {
            this.menuCode = menuCode;
        }

        public String getMenuName() {
            return menuName;
        }

        public void setMenuName(String menuName) {
            this.menuName = menuName;
        }

        public String getpMenuCode() {
            return pMenuCode;
        }

        public void setpMenuCode(String pMenuCode) {
            this.pMenuCode = pMenuCode;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }
    }


    public class SelectResult{

        private String menuid;
        private String menucode;
        private String menuname;
        private String pmenucode;
        private boolean browse = false;
        private boolean add = false;
        private boolean edit = false;
        private boolean del = false;
        private boolean print = false;
        private boolean myimport = false;
        private boolean export = false;
        private boolean check = false;
        private boolean undo = false;
        private String roleid;

        public String getMenuid() {
            return menuid;
        }

        public void setMenuid(String menuid) {
            this.menuid = menuid;
        }


        public String getMenucode() {
            return menucode;
        }

        public void setMenucode(String menucode) {
            this.menucode = menucode;
        }

        public String getMenuname() {
            return menuname;
        }

        public void setMenuname(String menuname) {
            this.menuname = menuname;
        }

        public String getPmenucode() {
            return pmenucode;
        }

        public void setPmenucode(String pmenucode) {
            this.pmenucode = pmenucode;
        }

        public boolean isBrowse() {
            return browse;
        }

        public void setBrowse(boolean browse) {
            this.browse = browse;
        }

        public boolean isAdd() {
            return add;
        }

        public void setAdd(boolean add) {
            this.add = add;
        }

        public boolean isEdit() {
            return edit;
        }

        public void setEdit(boolean edit) {
            this.edit = edit;
        }

        public boolean isDel() {
            return del;
        }

        public void setDel(boolean del) {
            this.del = del;
        }

        public boolean isPrint() {
            return print;
        }

        public void setPrint(boolean print) {
            this.print = print;
        }

        public boolean isMyimport() {
            return myimport;
        }

        public void setMyimport(boolean myimport) {
            this.myimport = myimport;
        }

        public boolean isExport() {
            return export;
        }

        public void setExport(boolean export) {
            this.export = export;
        }

        public boolean isCheck() {
            return check;
        }

        public void setCheck(boolean check) {
            this.check = check;
        }

        public String getRoleid() {
            return roleid;
        }

        public void setRoleid(String roleid) {
            this.roleid = roleid;
        }

        public boolean isUndo() {
            return undo;
        }

        public void setUndo(boolean undo) {
            this.undo = undo;
        }










    }


    public class User {

        private int id;
        private String name;
        private String gender;

        public User() {

        }

        public User(int id, String name, String gender) {
            this.id = id;
            this.name = name;
            this.gender = gender;
        }

        public int getId() {
            return id;
        }
        public void setId(int id) {
            this.id = id;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
        public String getGender() {
            return gender;
        }
        public void setGender(String gender) {
            this.gender = gender;
        }

        @Override
        public String toString() {
            return "id=" + id + "，name=" + name + "，gender=" + gender;
        }
    }


}
