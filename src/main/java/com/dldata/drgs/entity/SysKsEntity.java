package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/16.
 */
@Entity
@Table(name = "Sys_KS")
public class SysKsEntity {
    private String id;
    private String code;
    private Integer xh;
    private String name;
    private String shortName;
    private String wbCode;
    private String fl;
    private Integer satus;
    private Integer ksType;
    private Boolean mz;
    private Boolean zy;
    private Boolean jz;
    private String pym;
    private Integer bedNums;
    private Integer fixedbedNums;
    private Integer extrabedNums;
    @Id
    @Column(name = "id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "code", nullable = true, insertable = true, updatable = true)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "xh", nullable = true, insertable = true, updatable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Basic
    @Column(name = "name", nullable = true, insertable = true, updatable = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "short_name", nullable = true, insertable = true, updatable = true)
    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    @Basic
    @Column(name = "wb_code", nullable = true, insertable = true, updatable = true)
    public String getWbCode() {
        return wbCode;
    }

    public void setWbCode(String wbCode) {
        this.wbCode = wbCode;
    }

    @Basic
    @Column(name = "fl", nullable = true, insertable = true, updatable = true)
    public String getFl() {
        return fl;
    }

    public void setFl(String fl) {
        this.fl = fl;
    }

    @Basic
    @Column(name = "satus", nullable = true, insertable = true, updatable = true)
    public Integer getSatus() {
        return satus;
    }

    public void setSatus(Integer satus) {
        this.satus = satus;
    }

    @Basic
    @Column(name = "ks_type", nullable = true, insertable = true, updatable = true)
    public Integer getKsType() {
        return ksType;
    }

    public void setKsType(Integer ksType) {
        this.ksType = ksType;
    }

    @Basic
    @Column(name = "mz", nullable = true, insertable = true, updatable = true)
    public Boolean getMz() {
        return mz;
    }

    public void setMz(Boolean mz) {
        this.mz = mz;
    }

    @Basic
    @Column(name = "zy", nullable = true, insertable = true, updatable = true)
    public Boolean getZy() {
        return zy;
    }

    public void setZy(Boolean zy) {
        this.zy = zy;
    }

    @Basic
    @Column(name = "jz", nullable = true, insertable = true, updatable = true)
    public Boolean getJz() {
        return jz;
    }

    public void setJz(Boolean jz) {
        this.jz = jz;
    }

    @Basic
    @Column(name = "pym", nullable = true, insertable = true, updatable = true)
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "bed_nums", nullable = true, insertable = true, updatable = true)
    public Integer getBedNums() {
        return bedNums;
    }

    public void setBedNums(Integer bedNums) {
        this.bedNums = bedNums;
    }

    @Basic
    @Column(name = "fixedbed_nums", nullable = true, insertable = true, updatable = true)
    public Integer getFixedbedNums() {
        return fixedbedNums;
    }

    public void setFixedbedNums(Integer fixedbedNums) {
        this.fixedbedNums = fixedbedNums;
    }

    @Basic
    @Column(name = "extrabed_nums", nullable = true, insertable = true, updatable = true)
    public Integer getExtrabedNums() {
        return extrabedNums;
    }

    public void setExtrabedNums(Integer extrabedNums) {
        this.extrabedNums = extrabedNums;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysKsEntity that = (SysKsEntity) o;

        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (fl != null ? !fl.equals(that.fl) : that.fl != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (jz != null ? !jz.equals(that.jz) : that.jz != null) return false;
        if (ksType != null ? !ksType.equals(that.ksType) : that.ksType != null) return false;
        if (mz != null ? !mz.equals(that.mz) : that.mz != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (pym != null ? !pym.equals(that.pym) : that.pym != null) return false;
        if (satus != null ? !satus.equals(that.satus) : that.satus != null) return false;
        if (shortName != null ? !shortName.equals(that.shortName) : that.shortName != null) return false;
        if (wbCode != null ? !wbCode.equals(that.wbCode) : that.wbCode != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (zy != null ? !zy.equals(that.zy) : that.zy != null) return false;
        if (bedNums != null ? !bedNums.equals(that.bedNums) : that.bedNums != null) return false;
        if (fixedbedNums != null ? !fixedbedNums.equals(that.fixedbedNums) : that.fixedbedNums != null) return false;
        if (extrabedNums != null ? !extrabedNums.equals(that.extrabedNums) : that.extrabedNums != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (shortName != null ? shortName.hashCode() : 0);
        result = 31 * result + (wbCode != null ? wbCode.hashCode() : 0);
        result = 31 * result + (fl != null ? fl.hashCode() : 0);
        result = 31 * result + (satus != null ? satus.hashCode() : 0);
        result = 31 * result + (ksType != null ? ksType.hashCode() : 0);
        result = 31 * result + (mz != null ? mz.hashCode() : 0);
        result = 31 * result + (zy != null ? zy.hashCode() : 0);
        result = 31 * result + (jz != null ? jz.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (bedNums != null ? bedNums.hashCode() : 0);
        result = 31 * result + (fixedbedNums != null ? fixedbedNums.hashCode() : 0);
        result = 31 * result + (extrabedNums != null ? extrabedNums.hashCode() : 0);
        return result;
    }
}
