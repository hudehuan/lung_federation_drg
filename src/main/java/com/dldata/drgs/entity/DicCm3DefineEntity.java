package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/07/31.
 */
@Entity
@Table(name = "dic_cm3_Define")
public class DicCm3DefineEntity {
    private String id;
    private String code;
    private String type;
    private String sm;
    private String cm3Dm;
    private String cm3Mc;

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
    @Column(name = "cm3dm", nullable = true, length = 50)
    public String getCm3Dm() {
        return cm3Dm;
    }

    public void setCm3Dm(String cm3Dm) {
        this.cm3Dm = cm3Dm;
    }

    @Basic
    @Column(name = "cm3mc", nullable = true, length = 200)
    public String getCm3Mc() {
        return cm3Mc;
    }

    public void setCm3Mc(String cm3Mc) {
        this.cm3Mc = cm3Mc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicCm3DefineEntity that = (DicCm3DefineEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (cm3Dm != null ? !cm3Dm.equals(that.cm3Dm) : that.cm3Dm != null) return false;
        if (cm3Mc != null ? !cm3Mc.equals(that.cm3Mc) : that.cm3Mc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        result = 31 * result + (cm3Dm != null ? cm3Dm.hashCode() : 0);
        result = 31 * result + (cm3Mc != null ? cm3Mc.hashCode() : 0);
        return result;
    }
}
