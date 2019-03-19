package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Entity
@Table(name = "Dic_xzqh")
public class DicXzqhEntity {
    private Integer xh;
    private String dm;
    private String mc;
    private String wdm;
    private String sheng;
    private String shi;
    private String xian;

    @Basic
    @Column(name = "xh", nullable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Id
    @Column(name = "dm", nullable = false, length = 10)
    public String getDm() {
        return dm;
    }

    public void setDm(String dm) {
        this.dm = dm;
    }

    @Basic
    @Column(name = "mc", nullable = true, length = 200)
    public String getMc() {
        return mc;
    }

    public void setMc(String mc) {
        this.mc = mc;
    }

    @Basic
    @Column(name = "wdm", nullable = true, length = 10)
    public String getWdm() {
        return wdm;
    }

    public void setWdm(String wdm) {
        this.wdm = wdm;
    }

    @Basic
    @Column(name = "sheng", nullable = true, length = 50)
    public String getSheng() {
        return sheng;
    }

    public void setSheng(String sheng) {
        this.sheng = sheng;
    }

    @Basic
    @Column(name = "shi", nullable = true, length = 50)
    public String getShi() {
        return shi;
    }

    public void setShi(String shi) {
        this.shi = shi;
    }

    @Basic
    @Column(name = "xian", nullable = true, length = 50)
    public String getXian() {
        return xian;
    }

    public void setXian(String xian) {
        this.xian = xian;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicXzqhEntity that = (DicXzqhEntity) o;

        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (dm != null ? !dm.equals(that.dm) : that.dm != null) return false;
        if (mc != null ? !mc.equals(that.mc) : that.mc != null) return false;
        if (wdm != null ? !wdm.equals(that.wdm) : that.wdm != null) return false;
        if (sheng != null ? !sheng.equals(that.sheng) : that.sheng != null) return false;
        if (shi != null ? !shi.equals(that.shi) : that.shi != null) return false;
        if (xian != null ? !xian.equals(that.xian) : that.xian != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = xh != null ? xh.hashCode() : 0;
        result = 31 * result + (dm != null ? dm.hashCode() : 0);
        result = 31 * result + (mc != null ? mc.hashCode() : 0);
        result = 31 * result + (wdm != null ? wdm.hashCode() : 0);
        result = 31 * result + (sheng != null ? sheng.hashCode() : 0);
        result = 31 * result + (shi != null ? shi.hashCode() : 0);
        result = 31 * result + (xian != null ? xian.hashCode() : 0);
        return result;
    }
}
