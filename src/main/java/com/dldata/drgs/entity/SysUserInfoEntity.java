package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/11/4.
 */
@Entity
@Table(name = "Sys_User_Info")
@IdClass(SysUserInfoEntityPK.class)
public class SysUserInfoEntity {
    private String id;
    private String loginName;
    private String loginPwd;
    private int status;
    private String homePageId;
    private String sysCode;
    private Boolean isCheck;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "login_name")
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    @Basic
    @Column(name = "login_pwd")
    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    @Basic
    @Column(name = "status")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Basic
    @Column(name = "home_page_id")
    public String getHomePageId() {
        return homePageId;
    }

    public void setHomePageId(String homePageId) {
        this.homePageId = homePageId;
    }

    @Id
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

        SysUserInfoEntity that = (SysUserInfoEntity) o;

        if (status != that.status) return false;
        if (homePageId != null ? !homePageId.equals(that.homePageId) : that.homePageId != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (loginName != null ? !loginName.equals(that.loginName) : that.loginName != null) return false;
        if (loginPwd != null ? !loginPwd.equals(that.loginPwd) : that.loginPwd != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (loginName != null ? loginName.hashCode() : 0);
        result = 31 * result + (loginPwd != null ? loginPwd.hashCode() : 0);
        result = 31 * result + status;
        result = 31 * result + (homePageId != null ? homePageId.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "is_check")
    public Boolean getIsCheck() {
        return isCheck;
    }

    public void setIsCheck(Boolean isCheck) {
        this.isCheck = isCheck;
    }
}
