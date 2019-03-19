package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Entity
@Table(name = "custom_type")
public class CustomTypeEntity {
    private String id;
    private String name;
    private String sm;
    private Integer xh;

    @Id
    @Column(name = "id", nullable = false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 200)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "sm", nullable = true, length = 200)
    public String getSm() {
        return sm;
    }

    public void setSm(String sm) {
        this.sm = sm;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomTypeEntity that = (CustomTypeEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "xh", nullable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }
}
