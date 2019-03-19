package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by admin on 2017/1/24.
 */
@Entity
@Table(name = "Sys_Menu_Template_Define")
public class SysMenuTemplateDefineEntity {
    private String tid;
    private String name;
    private Boolean status;

    @Id
    @Column(name = "tid")
    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysMenuTemplateDefineEntity that = (SysMenuTemplateDefineEntity) o;

        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (tid != null ? !tid.equals(that.tid) : that.tid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tid != null ? tid.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "status")
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
