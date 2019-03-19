package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Entity
@Table(name = "dic_cm3")
public class DicCm3Entity {
    private String dm;
    private String mc;
    private String lx;

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

    @Basic
    @Column(name = "lx", nullable = true, length = 50)
    public String getLx() {
        return lx;
    }

    public void setLx(String lx) {
        this.lx = lx;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicCm3Entity that = (DicCm3Entity) o;

        if (dm != null ? !dm.equals(that.dm) : that.dm != null) return false;
        if (mc != null ? !mc.equals(that.mc) : that.mc != null) return false;
        if (lx != null ? !lx.equals(that.lx) : that.lx != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = dm != null ? dm.hashCode() : 0;
        result = 31 * result + (mc != null ? mc.hashCode() : 0);
        result = 31 * result + (lx != null ? lx.hashCode() : 0);
        return result;
    }
}
