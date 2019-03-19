package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/9/2.
 */
@Entity
@Table(name = "Form_Define_Field")
public class FormDefineFieldEntity {
    private String fdId;
    private String tdId;
    private String fdName;
    private Integer xh;
    private Boolean isEdit;
    private String defaultValue;
    private String itemId;
    private Integer status;
    private String level;
    private String unit;

    @Id
    @Column(name = "fd_id")
    public String getFdId() {
        return fdId;
    }

    public void setFdId(String fdId) {
        this.fdId = fdId;
    }

    @Basic
    @Column(name = "td_id")
    public String getTdId() {
        return tdId;
    }

    public void setTdId(String tdId) {
        this.tdId = tdId;
    }

    @Basic
    @Column(name = "fd_name")
    public String getFdName() {
        return fdName;
    }

    public void setFdName(String fdName) {
        this.fdName = fdName;
    }

    @Basic
    @Column(name = "xh")
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
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
    @Column(name = "default_value")
    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    @Basic
    @Column(name = "item_id")
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    @Basic
    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Basic
    @Column(name = "level")
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Basic
    @Column(name = "unit")
    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormDefineFieldEntity that = (FormDefineFieldEntity) o;

        if (defaultValue != null ? !defaultValue.equals(that.defaultValue) : that.defaultValue != null) return false;
        if (fdId != null ? !fdId.equals(that.fdId) : that.fdId != null) return false;
        if (fdName != null ? !fdName.equals(that.fdName) : that.fdName != null) return false;
        if (isEdit != null ? !isEdit.equals(that.isEdit) : that.isEdit != null) return false;
        if (itemId != null ? !itemId.equals(that.itemId) : that.itemId != null) return false;
        if (level != null ? !level.equals(that.level) : that.level != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (tdId != null ? !tdId.equals(that.tdId) : that.tdId != null) return false;
        if (unit != null ? !unit.equals(that.unit) : that.unit != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = fdId != null ? fdId.hashCode() : 0;
        result = 31 * result + (tdId != null ? tdId.hashCode() : 0);
        result = 31 * result + (fdName != null ? fdName.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (isEdit != null ? isEdit.hashCode() : 0);
        result = 31 * result + (defaultValue != null ? defaultValue.hashCode() : 0);
        result = 31 * result + (itemId != null ? itemId.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (level != null ? level.hashCode() : 0);
        result = 31 * result + (unit != null ? unit.hashCode() : 0);
        return result;
    }
}
