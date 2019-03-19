package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/26.
 */
@Entity
@Table(name = "Sys_Dictionary")
public class SysDictionaryEntity {
    private String did;
    private String dicCode;
    private String dicName;
    private String groupId;
    private String bz;
    private String sysCode;

    @Id
    @Column(name = "did")
    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    @Basic
    @Column(name = "dic_code")
    public String getDicCode() {
        return dicCode;
    }

    public void setDicCode(String dicCode) {
        this.dicCode = dicCode;
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
    @Column(name = "group_id")
    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    @Basic
    @Column(name = "bz")
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Basic
    @Column(name = "sys_code")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysDictionaryEntity that = (SysDictionaryEntity) o;

        if (bz != null ? !bz.equals(that.bz) : that.bz != null) return false;
        if (dicCode != null ? !dicCode.equals(that.dicCode) : that.dicCode != null) return false;
        if (dicName != null ? !dicName.equals(that.dicName) : that.dicName != null) return false;
        if (did != null ? !did.equals(that.did) : that.did != null) return false;
        if (groupId != null ? !groupId.equals(that.groupId) : that.groupId != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = did != null ? did.hashCode() : 0;
        result = 31 * result + (dicCode != null ? dicCode.hashCode() : 0);
        result = 31 * result + (dicName != null ? dicName.hashCode() : 0);
        result = 31 * result + (groupId != null ? groupId.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        return result;
    }
}
