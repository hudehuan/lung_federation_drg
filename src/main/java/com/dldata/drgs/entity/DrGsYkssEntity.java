package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/10/11.
 */
@Entity
@Table(name = "DRGs_ykss")
public class DrGsYkssEntity {
    private String id;
    private String year;
    private String address;
    private String ckqz;
    private String yjqz;
    private String fffl;
    private String name;
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
    @Column(name = "year", nullable = true, length = 50)
    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    @Basic
    @Column(name = "address", nullable = true, length = 50)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "ckqz", nullable = true, length = 50)
    public String getCkqz() {
        return ckqz;
    }

    public void setCkqz(String ckqz) {
        this.ckqz = ckqz;
    }

    @Basic
    @Column(name = "yjqz", nullable = true, length = 50)
    public String getYjqz() {
        return yjqz;
    }

    public void setYjqz(String yjqz) {
        this.yjqz = yjqz;
    }

    @Basic
    @Column(name = "fffl", nullable = true, length = 50)
    public String getFffl() {
        return fffl;
    }

    public void setFffl(String fffl) {
        this.fffl = fffl;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

        DrGsYkssEntity that = (DrGsYkssEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (year != null ? !year.equals(that.year) : that.year != null) return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;
        if (ckqz != null ? !ckqz.equals(that.ckqz) : that.ckqz != null) return false;
        if (yjqz != null ? !yjqz.equals(that.yjqz) : that.yjqz != null) return false;
        if (fffl != null ? !fffl.equals(that.fffl) : that.fffl != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (year != null ? year.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (ckqz != null ? ckqz.hashCode() : 0);
        result = 31 * result + (yjqz != null ? yjqz.hashCode() : 0);
        result = 31 * result + (fffl != null ? fffl.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
