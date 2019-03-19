package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_User_System")
public class SysUserSystemEntity {
    private String id;
    private String sysCode;
    private String userId;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "sys_code")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Basic
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysUserSystemEntity that = (SysUserSystemEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        return result;
    }
}
