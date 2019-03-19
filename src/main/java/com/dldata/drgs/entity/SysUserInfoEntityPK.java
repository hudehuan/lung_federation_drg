package com.dldata.drgs.entity;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by 倪继文 on 2016/11/4.
 */
public class SysUserInfoEntityPK implements Serializable {
    private String id;
    private String sysCode;

    @Column(name = "id")
    @Id
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "sys_code")
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

        SysUserInfoEntityPK that = (SysUserInfoEntityPK) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        return result;
    }
}
