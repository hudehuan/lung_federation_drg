package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/09/15.
 */
@Entity
@Table(name = "Dic_jgdm_tz")
public class DicJgdmTzEntity {
    private String dm;
    private String randPass;
    private Boolean menuRole;

    @Id
    @Column(name = "dm", nullable = false, length = 50)
    public String getDm() {
        return dm;
    }

    public void setDm(String dm) {
        this.dm = dm;
    }

    @Basic
    @Column(name = "rand_pass", nullable = true, length = 500)
    public String getRandPass() {
        return randPass;
    }

    public void setRandPass(String randPass) {
        this.randPass = randPass;
    }

    @Basic
    @Column(name = "menu_role", nullable = true)
    public Boolean getMenuRole() {
        return menuRole;
    }

    public void setMenuRole(Boolean menuRole) {
        this.menuRole = menuRole;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DicJgdmTzEntity that = (DicJgdmTzEntity) o;

        if (dm != null ? !dm.equals(that.dm) : that.dm != null) return false;
        if (randPass != null ? !randPass.equals(that.randPass) : that.randPass != null) return false;
        if (menuRole != null ? !menuRole.equals(that.menuRole) : that.menuRole != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = dm != null ? dm.hashCode() : 0;
        result = 31 * result + (randPass != null ? randPass.hashCode() : 0);
        result = 31 * result + (menuRole != null ? menuRole.hashCode() : 0);
        return result;
    }
}
