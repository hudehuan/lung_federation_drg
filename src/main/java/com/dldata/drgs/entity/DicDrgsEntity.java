package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/08/01.
 */
@Entity
@Table(name = "dic_drgs")
public class DicDrgsEntity {
    private Integer xh;
    private String dm;
    private String mc;

    @Basic
    @Column(name = "xh", nullable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Id
    @Column(name = "dm", nullable = true, length = 50)
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicDrgsEntity that = (DicDrgsEntity) o;

        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (dm != null ? !dm.equals(that.dm) : that.dm != null) return false;
        if (mc != null ? !mc.equals(that.mc) : that.mc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = xh != null ? xh.hashCode() : 0;
        result = 31 * result + (dm != null ? dm.hashCode() : 0);
        result = 31 * result + (mc != null ? mc.hashCode() : 0);
        return result;
    }
}
