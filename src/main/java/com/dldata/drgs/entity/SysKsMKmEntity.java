package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by admin on 2016/9/5.
 */
@Entity
@Table(name = "M_Km")
public class SysKsMKmEntity {
    private String dm;
    private String mc;
    private String dlmc;
    private Integer xh;

    @Id
    @Column(name = "dm", nullable = false, insertable = true, updatable = true)
    public String getDm() {
        return dm;
    }

    public void setDm(String dm) {
        this.dm = dm;
    }

    @Basic
    @Column(name = "mc", nullable = false, insertable = true, updatable = true)
    public String getMc() {
        return mc;
    }

    public void setMc(String mc) {
        this.mc = mc;
    }

    @Basic
    @Column(name = "dlmc", nullable = false, insertable = true, updatable = true)
    public String getDlmc() {
        return dlmc;
    }

    public void setDlmc(String dlmc) {
        this.dlmc = dlmc;
    }

    @Basic
    @Column(name = "xh", nullable = true, insertable = true, updatable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }
}
