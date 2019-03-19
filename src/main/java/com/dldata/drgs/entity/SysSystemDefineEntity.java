package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_System_Define")
public class SysSystemDefineEntity {
    private String id;
    private String sysCode;
    private String sysName;
    private String loginUrl;
    private Integer xh;
    private String redirectUrl;
    private String redirectIp;
    private Integer redirectPort;

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
    @Column(name = "sys_name")
    public String getSysName() {
        return sysName;
    }

    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    @Basic
    @Column(name = "login_url")
    public String getLoginUrl() {
        return loginUrl;
    }

    public void setLoginUrl(String loginUrl) {
        this.loginUrl = loginUrl;
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
    @Column(name = "redirect_url")
    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    @Basic
    @Column(name = "redirect_ip")
    public String getRedirectIp() {
        return redirectIp;
    }

    public void setRedirectIp(String redirectIp) {
        this.redirectIp = redirectIp;
    }

    @Basic
    @Column(name = "redirect_port")
    public Integer getRedirectPort() {
        return redirectPort;
    }

    public void setRedirectPort(Integer redirectPort) {
        this.redirectPort = redirectPort;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysSystemDefineEntity that = (SysSystemDefineEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (loginUrl != null ? !loginUrl.equals(that.loginUrl) : that.loginUrl != null) return false;
        if (redirectIp != null ? !redirectIp.equals(that.redirectIp) : that.redirectIp != null) return false;
        if (redirectPort != null ? !redirectPort.equals(that.redirectPort) : that.redirectPort != null) return false;
        if (redirectUrl != null ? !redirectUrl.equals(that.redirectUrl) : that.redirectUrl != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (sysName != null ? !sysName.equals(that.sysName) : that.sysName != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (sysName != null ? sysName.hashCode() : 0);
        result = 31 * result + (loginUrl != null ? loginUrl.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (redirectUrl != null ? redirectUrl.hashCode() : 0);
        result = 31 * result + (redirectIp != null ? redirectIp.hashCode() : 0);
        result = 31 * result + (redirectPort != null ? redirectPort.hashCode() : 0);
        return result;
    }
}
