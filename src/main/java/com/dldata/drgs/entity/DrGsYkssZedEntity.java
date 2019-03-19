package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Entity
@Table(name = "DRGs_ykss_zed")
public class DrGsYkssZedEntity {
    private String id;
    private String ykid;
    private String gs;
    private Boolean status;

    @Id
    @Column(name = "id", nullable = false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ykid", nullable = true)
    public String getYkid() {
        return ykid;
    }

    public void setYkid(String ykid) {
        this.ykid = ykid;
    }

    @Basic
    @Column(name = "gs", nullable = true, length = 2000)
    public String getGs() {
        return gs;
    }

    public void setGs(String gs) {
        this.gs = gs;
    }

    @Basic
    @Column(name = "status", nullable = true)
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DrGsYkssZedEntity that = (DrGsYkssZedEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (ykid != null ? !ykid.equals(that.ykid) : that.ykid != null) return false;
        if (gs != null ? !gs.equals(that.gs) : that.gs != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (ykid != null ? ykid.hashCode() : 0);
        result = 31 * result + (gs != null ? gs.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
