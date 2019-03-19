package com.dldata.drgs.entity;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by 吴岳峰 on 2017/08/07.
 */
@Entity
@Table(name = "Dic_jgdm")
public class DicJgdmEntity {
    private Integer xh;
    private String dm;
    private String mc;
    private String xzqh;
    private String xzqhmc;
    private String sheng;
    private String shi;
    private String xian;
    private String jgdm;
    private String yyfr;
    private String yyzrr;
    private String tel;
    private String yyjb;
    private String yydj;
    private String yylb;
    private String issz;
    private Integer isbjorqg;
    private Integer iscwtj;
    private String jc;
    private Integer sysb;
    private Integer bzcw;
    private Integer sjkfcw;
    private Integer zbys;
    private Integer zbzyhs;
    private Integer htyss;
    private Integer hthss;
    private BigDecimal zymj;
    private BigDecimal mzmj;
    private String gid;
    private String jglbdm;

    @Basic
    @Column(name = "xh", nullable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Id
    @Column(name = "dm", nullable = false, length = 50)
    public String getDm() {
        return dm;
    }

    public void setDm(String dm) {
        this.dm = dm;
    }

    @Basic
    @Column(name = "mc", nullable = true, length = 300)
    public String getMc() {
        return mc;
    }

    public void setMc(String mc) {
        this.mc = mc;
    }

    @Basic
    @Column(name = "xzqh", nullable = true, length = 20)
    public String getXzqh() {
        return xzqh;
    }

    public void setXzqh(String xzqh) {
        this.xzqh = xzqh;
    }

    @Basic
    @Column(name = "xzqhmc", nullable = true, length = 300)
    public String getXzqhmc() {
        return xzqhmc;
    }

    public void setXzqhmc(String xzqhmc) {
        this.xzqhmc = xzqhmc;
    }

    @Basic
    @Column(name = "sheng", nullable = true, length = 200)
    public String getSheng() {
        return sheng;
    }

    public void setSheng(String sheng) {
        this.sheng = sheng;
    }

    @Basic
    @Column(name = "shi", nullable = true, length = 200)
    public String getShi() {
        return shi;
    }

    public void setShi(String shi) {
        this.shi = shi;
    }

    @Basic
    @Column(name = "xian", nullable = true, length = 300)
    public String getXian() {
        return xian;
    }

    public void setXian(String xian) {
        this.xian = xian;
    }

    @Basic
    @Column(name = "jgdm", nullable = true, length = 20)
    public String getJgdm() {
        return jgdm;
    }

    public void setJgdm(String jgdm) {
        this.jgdm = jgdm;
    }

    @Basic
    @Column(name = "yyfr", nullable = true, length = 30)
    public String getYyfr() {
        return yyfr;
    }

    public void setYyfr(String yyfr) {
        this.yyfr = yyfr;
    }

    @Basic
    @Column(name = "yyzrr", nullable = true, length = 30)
    public String getYyzrr() {
        return yyzrr;
    }

    public void setYyzrr(String yyzrr) {
        this.yyzrr = yyzrr;
    }

    @Basic
    @Column(name = "tel", nullable = true, length = 50)
    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    @Basic
    @Column(name = "yyjb", nullable = true, length = 200)
    public String getYyjb() {
        return yyjb;
    }

    public void setYyjb(String yyjb) {
        this.yyjb = yyjb;
    }

    @Basic
    @Column(name = "yydj", nullable = true, length = 200)
    public String getYydj() {
        return yydj;
    }

    public void setYydj(String yydj) {
        this.yydj = yydj;
    }

    @Basic
    @Column(name = "yylb", nullable = true, length = 20)
    public String getYylb() {
        return yylb;
    }

    public void setYylb(String yylb) {
        this.yylb = yylb;
    }

    @Basic
    @Column(name = "issz", nullable = true, length = 200)
    public String getIssz() {
        return issz;
    }

    public void setIssz(String issz) {
        this.issz = issz;
    }

    @Basic
    @Column(name = "isbjorqg", nullable = true)
    public Integer getIsbjorqg() {
        return isbjorqg;
    }

    public void setIsbjorqg(Integer isbjorqg) {
        this.isbjorqg = isbjorqg;
    }

    @Basic
    @Column(name = "iscwtj", nullable = true)
    public Integer getIscwtj() {
        return iscwtj;
    }

    public void setIscwtj(Integer iscwtj) {
        this.iscwtj = iscwtj;
    }

    @Basic
    @Column(name = "jc", nullable = true, length = 200)
    public String getJc() {
        return jc;
    }

    public void setJc(String jc) {
        this.jc = jc;
    }

    @Basic
    @Column(name = "sysb", nullable = true)
    public Integer getSysb() {
        return sysb;
    }

    public void setSysb(Integer sysb) {
        this.sysb = sysb;
    }

    @Basic
    @Column(name = "bzcw", nullable = true)
    public Integer getBzcw() {
        return bzcw;
    }

    public void setBzcw(Integer bzcw) {
        this.bzcw = bzcw;
    }

    @Basic
    @Column(name = "sjkfcw", nullable = true)
    public Integer getSjkfcw() {
        return sjkfcw;
    }

    public void setSjkfcw(Integer sjkfcw) {
        this.sjkfcw = sjkfcw;
    }

    @Basic
    @Column(name = "zbys", nullable = true)
    public Integer getZbys() {
        return zbys;
    }

    public void setZbys(Integer zbys) {
        this.zbys = zbys;
    }

    @Basic
    @Column(name = "zbzyhs", nullable = true)
    public Integer getZbzyhs() {
        return zbzyhs;
    }

    public void setZbzyhs(Integer zbzyhs) {
        this.zbzyhs = zbzyhs;
    }

    @Basic
    @Column(name = "htyss", nullable = true)
    public Integer getHtyss() {
        return htyss;
    }

    public void setHtyss(Integer htyss) {
        this.htyss = htyss;
    }

    @Basic
    @Column(name = "hthss", nullable = true)
    public Integer getHthss() {
        return hthss;
    }

    public void setHthss(Integer hthss) {
        this.hthss = hthss;
    }

    @Basic
    @Column(name = "zymj", nullable = true, precision = 2)
    public BigDecimal getZymj() {
        return zymj;
    }

    public void setZymj(BigDecimal zymj) {
        this.zymj = zymj;
    }

    @Basic
    @Column(name = "mzmj", nullable = true, precision = 2)
    public BigDecimal getMzmj() {
        return mzmj;
    }

    public void setMzmj(BigDecimal mzmj) {
        this.mzmj = mzmj;
    }

    @Basic
    @Column(name = "gid", nullable = true, length = 200)
    public String getGid() {
        return gid;
    }

    public void setGid(String gid) {
        this.gid = gid;
    }

    @Basic
    @Column(name = "jglbdm", nullable = true, length = 10)
    public String getJglbdm() {
        return jglbdm;
    }

    public void setJglbdm(String jglbdm) {
        this.jglbdm = jglbdm;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicJgdmEntity that = (DicJgdmEntity) o;

        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (dm != null ? !dm.equals(that.dm) : that.dm != null) return false;
        if (mc != null ? !mc.equals(that.mc) : that.mc != null) return false;
        if (xzqh != null ? !xzqh.equals(that.xzqh) : that.xzqh != null) return false;
        if (xzqhmc != null ? !xzqhmc.equals(that.xzqhmc) : that.xzqhmc != null) return false;
        if (sheng != null ? !sheng.equals(that.sheng) : that.sheng != null) return false;
        if (shi != null ? !shi.equals(that.shi) : that.shi != null) return false;
        if (xian != null ? !xian.equals(that.xian) : that.xian != null) return false;
        if (jgdm != null ? !jgdm.equals(that.jgdm) : that.jgdm != null) return false;
        if (yyfr != null ? !yyfr.equals(that.yyfr) : that.yyfr != null) return false;
        if (yyzrr != null ? !yyzrr.equals(that.yyzrr) : that.yyzrr != null) return false;
        if (tel != null ? !tel.equals(that.tel) : that.tel != null) return false;
        if (yyjb != null ? !yyjb.equals(that.yyjb) : that.yyjb != null) return false;
        if (yydj != null ? !yydj.equals(that.yydj) : that.yydj != null) return false;
        if (yylb != null ? !yylb.equals(that.yylb) : that.yylb != null) return false;
        if (issz != null ? !issz.equals(that.issz) : that.issz != null) return false;
        if (isbjorqg != null ? !isbjorqg.equals(that.isbjorqg) : that.isbjorqg != null) return false;
        if (iscwtj != null ? !iscwtj.equals(that.iscwtj) : that.iscwtj != null) return false;
        if (jc != null ? !jc.equals(that.jc) : that.jc != null) return false;
        if (sysb != null ? !sysb.equals(that.sysb) : that.sysb != null) return false;
        if (bzcw != null ? !bzcw.equals(that.bzcw) : that.bzcw != null) return false;
        if (sjkfcw != null ? !sjkfcw.equals(that.sjkfcw) : that.sjkfcw != null) return false;
        if (zbys != null ? !zbys.equals(that.zbys) : that.zbys != null) return false;
        if (zbzyhs != null ? !zbzyhs.equals(that.zbzyhs) : that.zbzyhs != null) return false;
        if (htyss != null ? !htyss.equals(that.htyss) : that.htyss != null) return false;
        if (hthss != null ? !hthss.equals(that.hthss) : that.hthss != null) return false;
        if (zymj != null ? !zymj.equals(that.zymj) : that.zymj != null) return false;
        if (mzmj != null ? !mzmj.equals(that.mzmj) : that.mzmj != null) return false;
        if (gid != null ? !gid.equals(that.gid) : that.gid != null) return false;
        if (jglbdm != null ? !jglbdm.equals(that.jglbdm) : that.jglbdm != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = xh != null ? xh.hashCode() : 0;
        result = 31 * result + (dm != null ? dm.hashCode() : 0);
        result = 31 * result + (mc != null ? mc.hashCode() : 0);
        result = 31 * result + (xzqh != null ? xzqh.hashCode() : 0);
        result = 31 * result + (xzqhmc != null ? xzqhmc.hashCode() : 0);
        result = 31 * result + (sheng != null ? sheng.hashCode() : 0);
        result = 31 * result + (shi != null ? shi.hashCode() : 0);
        result = 31 * result + (xian != null ? xian.hashCode() : 0);
        result = 31 * result + (jgdm != null ? jgdm.hashCode() : 0);
        result = 31 * result + (yyfr != null ? yyfr.hashCode() : 0);
        result = 31 * result + (yyzrr != null ? yyzrr.hashCode() : 0);
        result = 31 * result + (tel != null ? tel.hashCode() : 0);
        result = 31 * result + (yyjb != null ? yyjb.hashCode() : 0);
        result = 31 * result + (yydj != null ? yydj.hashCode() : 0);
        result = 31 * result + (yylb != null ? yylb.hashCode() : 0);
        result = 31 * result + (issz != null ? issz.hashCode() : 0);
        result = 31 * result + (isbjorqg != null ? isbjorqg.hashCode() : 0);
        result = 31 * result + (iscwtj != null ? iscwtj.hashCode() : 0);
        result = 31 * result + (jc != null ? jc.hashCode() : 0);
        result = 31 * result + (sysb != null ? sysb.hashCode() : 0);
        result = 31 * result + (bzcw != null ? bzcw.hashCode() : 0);
        result = 31 * result + (sjkfcw != null ? sjkfcw.hashCode() : 0);
        result = 31 * result + (zbys != null ? zbys.hashCode() : 0);
        result = 31 * result + (zbzyhs != null ? zbzyhs.hashCode() : 0);
        result = 31 * result + (htyss != null ? htyss.hashCode() : 0);
        result = 31 * result + (hthss != null ? hthss.hashCode() : 0);
        result = 31 * result + (zymj != null ? zymj.hashCode() : 0);
        result = 31 * result + (mzmj != null ? mzmj.hashCode() : 0);
        result = 31 * result + (gid != null ? gid.hashCode() : 0);
        result = 31 * result + (jglbdm != null ? jglbdm.hashCode() : 0);
        return result;
    }
}
