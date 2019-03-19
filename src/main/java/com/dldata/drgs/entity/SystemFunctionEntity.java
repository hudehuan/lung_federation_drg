package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by admin on 2016/12/14.
 */
@Entity
@Table(name = "System_Function")
public class SystemFunctionEntity {
    private String id;
    private String name;
    private String url;
    private Integer xh;
    private Boolean status;
    private String sysCode;
    private String type;
    private String printUrl;
    private String hospitelName;
    private Timestamp cjrq;
    private String bz;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
    @Column(name = "xh")
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Basic
    @Column(name = "status")
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
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

    @Basic
    @Column(name = "print_url")
    public String getPrintUrl() {
        return printUrl;
    }

    public void setPrintUrl(String printUrl) {
        this.printUrl = printUrl;
    }

    @Basic
    @Column(name = "hospitel_name")
    public String getHospitelName() {
        return hospitelName;
    }

    public void setHospitelName(String hospitelName) {
        this.hospitelName = hospitelName;
    }

    @Basic
    @Column(name = "cjrq")
    public Timestamp getCjrq() {
        return cjrq;
    }

    public void setCjrq(Timestamp cjrq) {
        this.cjrq = cjrq;
    }

    @Basic
    @Column(name = "bz")
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SystemFunctionEntity that = (SystemFunctionEntity) o;

        if (bz != null ? !bz.equals(that.bz) : that.bz != null) return false;
        if (cjrq != null ? !cjrq.equals(that.cjrq) : that.cjrq != null) return false;
        if (hospitelName != null ? !hospitelName.equals(that.hospitelName) : that.hospitelName != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (printUrl != null ? !printUrl.equals(that.printUrl) : that.printUrl != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (url != null ? !url.equals(that.url) : that.url != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (url != null ? url.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (printUrl != null ? printUrl.hashCode() : 0);
        result = 31 * result + (hospitelName != null ? hospitelName.hashCode() : 0);
        result = 31 * result + (cjrq != null ? cjrq.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        return result;
    }
}
