package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Dictionary_Item")
public class SysDictionaryItemEntity {
    private String itemId;
    private String itemCode;
    private String did;
    private String dicName;
    private Integer xh;
    private String bz;

    @Id
    @Column(name = "item_id")
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    @Basic
    @Column(name = "item_code")
    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    @Basic
    @Column(name = "did")
    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    @Basic
    @Column(name = "dic_name")
    public String getDicName() {
        return dicName;
    }

    public void setDicName(String dicName) {
        this.dicName = dicName;
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
    @Column(name = "bz")
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysDictionaryItemEntity that = (SysDictionaryItemEntity) o;

        if (bz != null ? !bz.equals(that.bz) : that.bz != null) return false;
        if (dicName != null ? !dicName.equals(that.dicName) : that.dicName != null) return false;
        if (did != null ? !did.equals(that.did) : that.did != null) return false;
        if (itemCode != null ? !itemCode.equals(that.itemCode) : that.itemCode != null) return false;
        if (itemId != null ? !itemId.equals(that.itemId) : that.itemId != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = itemId != null ? itemId.hashCode() : 0;
        result = 31 * result + (itemCode != null ? itemCode.hashCode() : 0);
        result = 31 * result + (did != null ? did.hashCode() : 0);
        result = 31 * result + (dicName != null ? dicName.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        return result;
    }
}
