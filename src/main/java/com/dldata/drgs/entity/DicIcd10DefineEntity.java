package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Entity
@Table(name = "dic_icd10_Define")
public class DicIcd10DefineEntity {
    private String id;
    private String code;
    private String type;
    private String sm;
    private String icd10Dm;
    private String icd10Mc;

    @Id
    @Column(name = "id", nullable = false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "code", nullable = true, length = 50)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "type", nullable = true, length = 200)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "sm", nullable = true, length = 2147483647)
    public String getSm() {
        return sm;
    }

    public void setSm(String sm) {
        this.sm = sm;
    }

    @Basic
    @Column(name = "icd10dm", nullable = true, length = 50)
    public String getIcd10Dm() {
        return icd10Dm;
    }

    public void setIcd10Dm(String icd10Dm) {
        this.icd10Dm = icd10Dm;
    }

    @Basic
    @Column(name = "icd10mc", nullable = true, length = 200)
    public String getIcd10Mc() {
        return icd10Mc;
    }

    public void setIcd10Mc(String icd10Mc) {
        this.icd10Mc = icd10Mc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicIcd10DefineEntity that = (DicIcd10DefineEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (icd10Dm != null ? !icd10Dm.equals(that.icd10Dm) : that.icd10Dm != null) return false;
        if (icd10Mc != null ? !icd10Mc.equals(that.icd10Mc) : that.icd10Mc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        result = 31 * result + (icd10Dm != null ? icd10Dm.hashCode() : 0);
        result = 31 * result + (icd10Mc != null ? icd10Mc.hashCode() : 0);
        return result;
    }
}
