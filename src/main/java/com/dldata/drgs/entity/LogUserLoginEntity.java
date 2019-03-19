package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

/**
 * Created by admin on 2016/10/22.
 */
@Entity
@Table(name = "Log_User_Login")
public class LogUserLoginEntity {
    private String id;
    private String userId;
    private Date loginDate;
    private Time loginTime;
    private String loginIp;
    private String sysCode;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "login_date")
    public Date getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(Date loginDate) {
        this.loginDate = loginDate;
    }

    @Basic
    @Column(name = "login_time")
    public Time getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Time loginTime) {
        this.loginTime = loginTime;
    }

    @Basic
    @Column(name = "login_ip")
    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
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

        LogUserLoginEntity that = (LogUserLoginEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (loginDate != null ? !loginDate.equals(that.loginDate) : that.loginDate != null) return false;
        if (loginIp != null ? !loginIp.equals(that.loginIp) : that.loginIp != null) return false;
        if (loginTime != null ? !loginTime.equals(that.loginTime) : that.loginTime != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (loginDate != null ? loginDate.hashCode() : 0);
        result = 31 * result + (loginTime != null ? loginTime.hashCode() : 0);
        result = 31 * result + (loginIp != null ? loginIp.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        return result;
    }
}
