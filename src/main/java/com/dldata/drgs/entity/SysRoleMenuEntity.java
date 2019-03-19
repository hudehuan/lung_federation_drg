package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Role_Menu")
public class SysRoleMenuEntity {
    private String id;
    private String roleId;

    private String menuId;
    private Boolean isBrowse;
    private Boolean isAdd;
    private Boolean isEdit;
    private Boolean isDel;
    private Boolean isPrint;
    private Boolean isImport;
    private Boolean isExport;
    private Boolean isCheck;
    private Boolean isUndo;

    public SysRoleMenuEntity(){}

    public SysRoleMenuEntity(String id, String roleId, String menuId, Boolean isBrowse, Boolean isAdd, Boolean isEdit, Boolean isDel, Boolean isPrint, Boolean isImport, Boolean isExport, Boolean isCheck,Boolean isUndo) {
        this.id = id;
        this.roleId = roleId;
        this.menuId = menuId;
        this.isBrowse = isBrowse;
        this.isAdd = isAdd;
        this.isEdit = isEdit;
        this.isDel = isDel;
        this.isPrint = isPrint;
        this.isImport = isImport;
        this.isExport = isExport;
        this.isCheck = isCheck;
        this.isUndo = isUndo;
    }

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "role_id")
    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    @Basic
    @Column(name = "menu_id")
    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    @Basic
    @Column(name = "is_browse")
    public Boolean getIsBrowse() {
        return isBrowse;
    }

    public void setIsBrowse(Boolean isBrowse) {
        this.isBrowse = isBrowse;
    }

    @Basic
    @Column(name = "is_add")
    public Boolean getIsAdd() {
        return isAdd;
    }

    public void setIsAdd(Boolean isAdd) {
        this.isAdd = isAdd;
    }

    @Basic
    @Column(name = "is_edit")
    public Boolean getIsEdit() {
        return isEdit;
    }

    public void setIsEdit(Boolean isEdit) {
        this.isEdit = isEdit;
    }

    @Basic
    @Column(name = "is_del")
    public Boolean getIsDel() {
        return isDel;
    }

    public void setIsDel(Boolean isDel) {
        this.isDel = isDel;
    }

    @Basic
    @Column(name = "is_print")
    public Boolean getIsPrint() {
        return isPrint;
    }

    public void setIsPrint(Boolean isPrint) {
        this.isPrint = isPrint;
    }

    @Basic
    @Column(name = "is_import")
    public Boolean getIsImport() {
        return isImport;
    }

    public void setIsImport(Boolean isImport) {
        this.isImport = isImport;
    }

    @Basic
    @Column(name = "is_export")
    public Boolean getIsExport() {
        return isExport;
    }

    public void setIsExport(Boolean isExport) {
        this.isExport = isExport;
    }

    @Basic
    @Column(name = "is_check")
    public Boolean getIsCheck() {
        return isCheck;
    }

    public void setIsCheck(Boolean isCheck) {
        this.isCheck = isCheck;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysRoleMenuEntity that = (SysRoleMenuEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (isAdd != null ? !isAdd.equals(that.isAdd) : that.isAdd != null) return false;
        if (isBrowse != null ? !isBrowse.equals(that.isBrowse) : that.isBrowse != null) return false;
        if (isCheck != null ? !isCheck.equals(that.isCheck) : that.isCheck != null) return false;
        if (isDel != null ? !isDel.equals(that.isDel) : that.isDel != null) return false;
        if (isEdit != null ? !isEdit.equals(that.isEdit) : that.isEdit != null) return false;
        if (isExport != null ? !isExport.equals(that.isExport) : that.isExport != null) return false;
        if (isImport != null ? !isImport.equals(that.isImport) : that.isImport != null) return false;
        if (isPrint != null ? !isPrint.equals(that.isPrint) : that.isPrint != null) return false;
        if (menuId != null ? !menuId.equals(that.menuId) : that.menuId != null) return false;
        if (roleId != null ? !roleId.equals(that.roleId) : that.roleId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (roleId != null ? roleId.hashCode() : 0);
        result = 31 * result + (menuId != null ? menuId.hashCode() : 0);
        result = 31 * result + (isBrowse != null ? isBrowse.hashCode() : 0);
        result = 31 * result + (isAdd != null ? isAdd.hashCode() : 0);
        result = 31 * result + (isEdit != null ? isEdit.hashCode() : 0);
        result = 31 * result + (isDel != null ? isDel.hashCode() : 0);
        result = 31 * result + (isPrint != null ? isPrint.hashCode() : 0);
        result = 31 * result + (isImport != null ? isImport.hashCode() : 0);
        result = 31 * result + (isExport != null ? isExport.hashCode() : 0);
        result = 31 * result + (isCheck != null ? isCheck.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "is_undo")
    public Boolean getIsUndo() {
        return isUndo;
    }

    public void setIsUndo(Boolean isUndo) {
        this.isUndo = isUndo;
    }
}
