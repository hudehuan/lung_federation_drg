package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/09/07.
 */
@Entity
@Table(name = "Sys_User_Info_Pt")
@IdClass(SysUserInfoPtEntityPK.class)
public class SysUserInfoPtEntity {
    private String userid;
    private String sysCode;
    private String xlh;
    private String userType;
    private String powerFile;
    private Boolean menuRole;
    private String randPass;
    private Boolean report;
    private String wtLoginName;

    @Id
    @Column(name = "userid", nullable = false)
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Id
    @Column(name = "sys_code", nullable = false, length = 50)
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Basic
    @Column(name = "xlh", nullable = true, length = 200)
    public String getXlh() {
        return xlh;
    }

    public void setXlh(String xlh) {
        this.xlh = xlh;
    }

    @Basic
    @Column(name = "user_type", nullable = true, length = 200)
    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    @Basic
    @Column(name = "power_file", nullable = true, length = 1000)
    public String getPowerFile() {
        return powerFile;
    }

    public void setPowerFile(String powerFile) {
        this.powerFile = powerFile;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysUserInfoPtEntity that = (SysUserInfoPtEntity) o;

        if (userid != null ? !userid.equals(that.userid) : that.userid != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (xlh != null ? !xlh.equals(that.xlh) : that.xlh != null) return false;
        if (userType != null ? !userType.equals(that.userType) : that.userType != null) return false;
        if (powerFile != null ? !powerFile.equals(that.powerFile) : that.powerFile != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userid != null ? userid.hashCode() : 0;
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (xlh != null ? xlh.hashCode() : 0);
        result = 31 * result + (userType != null ? userType.hashCode() : 0);
        result = 31 * result + (powerFile != null ? powerFile.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "menu_role", nullable = true)
    public Boolean getMenuRole() {
        return menuRole;
    }

    public void setMenuRole(Boolean menuRole) {
        this.menuRole = menuRole;
    }

    @Basic
    @Column(name = "rand_pass", nullable = true, length = 500)
    public String getRandPass() {
        return randPass;
    }

    public void setRandPass(String randPass) {
        this.randPass = randPass;
    }

    @Basic
    @Column(name = "report", nullable = true)
    public Boolean getReport() {
        return report;
    }

    public void setReport(Boolean report) {
        this.report = report;
    }

    @Basic
    @Column(name = "wt_login_name", nullable = true, length = 50)
    public String getWtLoginName() {
        return wtLoginName;
    }

    public void setWtLoginName(String wtLoginName) {
        this.wtLoginName = wtLoginName;
    }
}
