package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Menu")
public class SysMenuEntity {
    private String id;
    private String code;
    private String pCode;
    private String name;
    private String url;
    private String img;
    private Integer xh;
    private Integer status;
    private String sysCode;
    private String type;
    private String printUrl;

    @Id
    @Column(name = "ID")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "p_code")
    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Basic
    @Column(name = "print_url")
    public String getPrintUrl() {
        return printUrl;
    }

    public void setPrintUrl(String printUrl) {
        this.printUrl = printUrl;
    }

    @Basic
    @Column(name = "img")
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
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
    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysMenuEntity that = (SysMenuEntity) o;

        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (img != null ? !img.equals(that.img) : that.img != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (pCode != null ? !pCode.equals(that.pCode) : that.pCode != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (url != null ? !url.equals(that.url) : that.url != null) return false;
//        if (printUrl != null ? !printUrl.equals(that.printUrl) : that.printUrl != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (pCode != null ? pCode.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (url != null ? url.hashCode() : 0);
//        result = 31 * result + (printUrl != null ? printUrl.hashCode() : 0);
        result = 31 * result + (img != null ? img.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        return result;
    }
}
