package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Staff")
public class SysStaffEntity {
    private String id;
    private String name;
    private String code;
    private Integer userClass;
    private Integer status;
    private String pym;
    private String ksId;
    private String kswId;
    private String yqId;
    private String zhiCheng;
    private String zhiWei;
    private String weiyiCode;
    private String xqName;

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
    @Column(name = "xia_qu")
    public String getXqName() {return xqName;}

    public void setXqName(String xqName) {this.xqName = xqName;}

    @Basic
    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "user_class")
    public Integer getUserClass() {
        return userClass;
    }

    public void setUserClass(Integer userClass) {
        this.userClass = userClass;
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
    @Column(name = "pym")
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "ks_id")
    public String getKsId() {
        return ksId;
    }

    public void setKsId(String ksId) {
        this.ksId = ksId;
    }

    @Basic
    @Column(name = "ksw_id")
    public String getKswId() {
        return kswId;
    }

    public void setKswId(String kswId) {
        this.kswId = kswId;
    }

    @Basic
    @Column(name = "yq_id")
    public String getYqId() {
        return yqId;
    }

    public void setYqId(String yqId) {
        this.yqId = yqId;
    }

    @Basic
    @Column(name = "zhi_cheng")
    public String getZhiCheng() {
        return zhiCheng;
    }

    public void setZhiCheng(String zhiCheng) {
        this.zhiCheng = zhiCheng;
    }

    @Basic
    @Column(name = "zhi_wei")
    public String getZhiWei() {
        return zhiWei;
    }

    public void setZhiWei(String zhiWei) {
        this.zhiWei = zhiWei;
    }

    @Basic
    @Column(name = "weiyi_code")
    public String getWeiyiCode() {
        return weiyiCode;
    }

    public void setWeiyiCode(String weiyiCode) {
        this.weiyiCode = weiyiCode;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysStaffEntity that = (SysStaffEntity) o;

        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (ksId != null ? !ksId.equals(that.ksId) : that.ksId != null) return false;
        if (kswId != null ? !kswId.equals(that.kswId) : that.kswId != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (pym != null ? !pym.equals(that.pym) : that.pym != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (userClass != null ? !userClass.equals(that.userClass) : that.userClass != null) return false;
        if (weiyiCode != null ? !weiyiCode.equals(that.weiyiCode) : that.weiyiCode != null) return false;
        if (yqId != null ? !yqId.equals(that.yqId) : that.yqId != null) return false;
        if (zhiCheng != null ? !zhiCheng.equals(that.zhiCheng) : that.zhiCheng != null) return false;
        if (zhiWei != null ? !zhiWei.equals(that.zhiWei) : that.zhiWei != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (userClass != null ? userClass.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (ksId != null ? ksId.hashCode() : 0);
        result = 31 * result + (kswId != null ? kswId.hashCode() : 0);
        result = 31 * result + (yqId != null ? yqId.hashCode() : 0);
        result = 31 * result + (zhiCheng != null ? zhiCheng.hashCode() : 0);
        result = 31 * result + (zhiWei != null ? zhiWei.hashCode() : 0);
        result = 31 * result + (weiyiCode != null ? weiyiCode.hashCode() : 0);
        return result;
    }
}
