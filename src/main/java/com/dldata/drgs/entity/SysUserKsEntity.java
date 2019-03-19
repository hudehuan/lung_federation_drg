package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/23.
 */
@Entity
@Table(name = "Sys_User_KS")
public class SysUserKsEntity {
    private String id;
    private String userid;
    private String ksid;
    private String sysCode;

    @Id
    @Column(name = "id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "userid", nullable = true, insertable = true, updatable = true, length = 36)
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Basic
    @Column(name = "ksid", nullable = true, insertable = true, updatable = true, length = 36)
    public String getKsid() {
        return ksid;
    }

    public void setKsid(String ksid) {
        this.ksid = ksid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysUserKsEntity that = (SysUserKsEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (ksid != null ? !ksid.equals(that.ksid) : that.ksid != null) return false;
        if (userid != null ? !userid.equals(that.userid) : that.userid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (userid != null ? userid.hashCode() : 0);
        result = 31 * result + (ksid != null ? ksid.hashCode() : 0);
        return result;
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
