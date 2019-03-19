package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/12.
 */
@Entity
@Table(name = "Form_Item")
public class FormItemEntity {
    private String itemId;
    private String typeId;
    private String itemName;
    private Integer xh;
    private String pym;
    private String sfDesc;
    private String sysCode;
    private Boolean isText;
    private Integer status;

    @Id
    @Column(name = "item_id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    @Basic
    @Column(name = "type_id", nullable = true, insertable = true, updatable = true, length = 36)
    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    @Basic
    @Column(name = "item_name", nullable = true, insertable = true, updatable = true)
    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    @Basic
    @Column(name = "xh", nullable = true, insertable = true, updatable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Basic
    @Column(name = "pym", nullable = true, insertable = true, updatable = true)
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "sf_desc", nullable = true, insertable = true, updatable = true)
    public String getSfDesc() {
        return sfDesc;
    }

    public void setSfDesc(String sfDesc) {
        this.sfDesc = sfDesc;
    }

    @Basic
    @Column(name = "sys_code", nullable = true, insertable = true, updatable = true)
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Basic
    @Column(name = "is_text", nullable = true, insertable = true, updatable = true)
    public Boolean getIsText() {
        return isText;
    }

    public void setIsText(Boolean isText) {
        this.isText = isText;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormItemEntity that = (FormItemEntity) o;

        if (isText != null ? !isText.equals(that.isText) : that.isText != null) return false;
        if (itemId != null ? !itemId.equals(that.itemId) : that.itemId != null) return false;
        if (itemName != null ? !itemName.equals(that.itemName) : that.itemName != null) return false;
        if (pym != null ? !pym.equals(that.pym) : that.pym != null) return false;
        if (sfDesc != null ? !sfDesc.equals(that.sfDesc) : that.sfDesc != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (typeId != null ? !typeId.equals(that.typeId) : that.typeId != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = itemId != null ? itemId.hashCode() : 0;
        result = 31 * result + (typeId != null ? typeId.hashCode() : 0);
        result = 31 * result + (itemName != null ? itemName.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (sfDesc != null ? sfDesc.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (isText != null ? isText.hashCode() : 0);
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
}
