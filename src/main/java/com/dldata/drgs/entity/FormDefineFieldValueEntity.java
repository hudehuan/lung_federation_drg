package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/9/2.
 */
@Entity
@Table(name = "Form_Define_Field_Value")
public class FormDefineFieldValueEntity {
    private String fvId;
    private String tdId;
    private String tvId;
    private String fdId;
    private String fdValue;
    private String wdm;
    private String itemId;
    private String fdName;
    private String cxrq;

    @Id
    @Column(name = "fv_id")
    public String getFvId() {
        return fvId;
    }

    public void setFvId(String fvId) {
        this.fvId = fvId;
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
    @Column(name = "tv_id")
    public String getTvId() {
        return tvId;
    }

    public void setTvId(String tvId) {
        this.tvId = tvId;
    }

    @Basic
    @Column(name = "fd_id")
    public String getFdId() {
        return fdId;
    }

    public void setFdId(String fdId) {
        this.fdId = fdId;
    }

    @Basic
    @Column(name = "fd_value")
    public String getFdValue() {
        return fdValue;
    }

    public void setFdValue(String fdValue) {
        this.fdValue = fdValue;
    }

    @Basic
    @Column(name = "wdm")
    public String getWdm() {
        return wdm;
    }

    public void setWdm(String wdm) {
        this.wdm = wdm;
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
    @Column(name = "fd_name")
    public String getFdName() {
        return fdName;
    }

    public void setFdName(String fdName) {
        this.fdName = fdName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormDefineFieldValueEntity that = (FormDefineFieldValueEntity) o;

        if (fdId != null ? !fdId.equals(that.fdId) : that.fdId != null) return false;
        if (fdName != null ? !fdName.equals(that.fdName) : that.fdName != null) return false;
        if (fdValue != null ? !fdValue.equals(that.fdValue) : that.fdValue != null) return false;
        if (fvId != null ? !fvId.equals(that.fvId) : that.fvId != null) return false;
        if (itemId != null ? !itemId.equals(that.itemId) : that.itemId != null) return false;
        if (tdId != null ? !tdId.equals(that.tdId) : that.tdId != null) return false;
        if (tvId != null ? !tvId.equals(that.tvId) : that.tvId != null) return false;
        if (wdm != null ? !wdm.equals(that.wdm) : that.wdm != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = fvId != null ? fvId.hashCode() : 0;
        result = 31 * result + (tdId != null ? tdId.hashCode() : 0);
        result = 31 * result + (tvId != null ? tvId.hashCode() : 0);
        result = 31 * result + (fdId != null ? fdId.hashCode() : 0);
        result = 31 * result + (fdValue != null ? fdValue.hashCode() : 0);
        result = 31 * result + (wdm != null ? wdm.hashCode() : 0);
        result = 31 * result + (itemId != null ? itemId.hashCode() : 0);
        result = 31 * result + (fdName != null ? fdName.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "cxrq")
    public String getCxrq() {
        return cxrq;
    }

    public void setCxrq(String cxrq) {
        this.cxrq = cxrq;
    }
}
