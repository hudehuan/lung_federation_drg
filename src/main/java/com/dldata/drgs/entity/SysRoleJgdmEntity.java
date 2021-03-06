package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/08/08.
 */
@Entity
@Table(name = "sys_role_jgdm")
public class SysRoleJgdmEntity {
    private String id;
    private String jgdm;
    private Boolean isBrowse;
    private String roleId;


    @Id
    @Column(name = "id", nullable = false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "jgdm", nullable = true, length = 50)
    public String getJgdm() {
        return jgdm;
    }

    public void setJgdm(String jgdm) {
        this.jgdm = jgdm;
    }

    @Basic
    @Column(name = "is_browse", nullable = true)
    public Boolean getBrowse() {
        return isBrowse;
    }

    public void setBrowse(Boolean browse) {
        isBrowse = browse;
    }

    @Basic
    @Column(name = "role_id", nullable = true)
    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysRoleJgdmEntity that = (SysRoleJgdmEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (roleId != null ? !roleId.equals(that.roleId) : that.roleId != null) return false;
        if (jgdm != null ? !jgdm.equals(that.jgdm) : that.jgdm != null) return false;
        if (isBrowse != null ? !isBrowse.equals(that.isBrowse) : that.isBrowse != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (roleId != null ? roleId.hashCode() : 0);
        result = 31 * result + (jgdm != null ? jgdm.hashCode() : 0);
        result = 31 * result + (isBrowse != null ? isBrowse.hashCode() : 0);
        return result;
    }

}
