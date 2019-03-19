package com.dldata.drgs.entity;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */
public class SysUserInfoPtEntityPK implements Serializable {
    private String userid;
    private String sysCode;

    @Column(name = "userid", nullable = false)
    @Id
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Column(name = "sys_code", nullable = false, length = 50)
    @Id
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

        SysUserInfoPtEntityPK that = (SysUserInfoPtEntityPK) o;

        if (userid != null ? !userid.equals(that.userid) : that.userid != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userid != null ? userid.hashCode() : 0;
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        return result;
    }
}
