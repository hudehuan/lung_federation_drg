package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/12.
 */
@Entity
@Table(name = "Form_Define")
public class FormDefineEntity {
    private String tdId;
    private String name;
    private Boolean isSh;
    private Boolean isEdit;
    private Boolean isDel;
    private Boolean isNew;
    private Integer fg;
    private String bz;
    private String datetype;
    private Integer status;
    private String tableJs;
    private String tableSql;
    private String sysCode;

    @Id
    @Column(name = "td_id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getTdId() {
        return tdId;
    }

    public void setTdId(String tdId) {
        this.tdId = tdId;
    }

    @Basic
    @Column(name = "name", nullable = true, insertable = true, updatable = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "is_sh", nullable = true, insertable = true, updatable = true)
    public Boolean getIsSh() {
        return isSh;
    }

    public void setIsSh(Boolean isSh) {
        this.isSh = isSh;
    }

    @Basic
    @Column(name = "is_edit", nullable = true, insertable = true, updatable = true)
    public Boolean getIsEdit() {
        return isEdit;
    }

    public void setIsEdit(Boolean isEdt) {
        this.isEdit = isEdt;
    }

    @Basic
    @Column(name = "is_del", nullable = true, insertable = true, updatable = true)
    public Boolean getIsDel() {
        return isDel;
    }

    public void setIsDel(Boolean isDel) {
        this.isDel = isDel;
    }

    @Basic
    @Column(name = "is_new", nullable = true, insertable = true, updatable = true)
    public Boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(Boolean isNew) {
        this.isNew = isNew;
    }

    @Basic
    @Column(name = "fg", nullable = true, insertable = true, updatable = true)
    public Integer getFg() {
        return fg;
    }

    public void setFg(Integer fg) {
        this.fg = fg;
    }

    @Basic
    @Column(name = "bz", nullable = true, insertable = true, updatable = true)
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Basic
    @Column(name = "datetype", nullable = true, insertable = true, updatable = true)
    public String getDatetype() {
        return datetype;
    }

    public void setDatetype(String datetype) {
        this.datetype = datetype;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormDefineEntity that = (FormDefineEntity) o;

        if (bz != null ? !bz.equals(that.bz) : that.bz != null) return false;
        if (datetype != null ? !datetype.equals(that.datetype) : that.datetype != null) return false;
        if (fg != null ? !fg.equals(that.fg) : that.fg != null) return false;
        if (isDel != null ? !isDel.equals(that.isDel) : that.isDel != null) return false;
        if (isEdit != null ? !isEdit.equals(that.isEdit) : that.isEdit != null) return false;
        if (isNew != null ? !isNew.equals(that.isNew) : that.isNew != null) return false;
        if (isSh != null ? !isSh.equals(that.isSh) : that.isSh != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (tdId != null ? !tdId.equals(that.tdId) : that.tdId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tdId != null ? tdId.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (isSh != null ? isSh.hashCode() : 0);
        result = 31 * result + (isEdit != null ? isEdit.hashCode() : 0);
        result = 31 * result + (isDel != null ? isDel.hashCode() : 0);
        result = 31 * result + (isNew != null ? isNew.hashCode() : 0);
        result = 31 * result + (fg != null ? fg.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        result = 31 * result + (datetype != null ? datetype.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "status", nullable = true, insertable = true, updatable = true)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Basic
    @Column(name = "table_js", nullable = true, insertable = true, updatable = true)
    public String getTableJs() {
        return tableJs;
    }

    public void setTableJs(String tableJs) {
        this.tableJs = tableJs;
    }

    @Basic
    @Column(name = "table_sql", nullable = true, insertable = true, updatable = true)
    public String getTableSql() {
        return tableSql;
    }

    public void setTableSql(String tableSql) {
        this.tableSql = tableSql;
    }

    @Basic
    @Column(name = "sys_code")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }
}
