package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Discuss_Item")
public class SysDiscussItemEntity {
    private String id;
    private Timestamp disTime;
    private String staffId;
    private String parentDisid;
    private String discontent;
    private Integer status;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "dis_time")
    public Timestamp getDisTime() {
        return disTime;
    }

    public void setDisTime(Timestamp disTime) {
        this.disTime = disTime;
    }

    @Basic
    @Column(name = "staff_id")
    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    @Basic
    @Column(name = "parent_disid")
    public String getParentDisid() {
        return parentDisid;
    }

    public void setParentDisid(String parentDisid) {
        this.parentDisid = parentDisid;
    }

    @Basic
    @Column(name = "discontent")
    public String getDiscontent() {
        return discontent;
    }

    public void setDiscontent(String discontent) {
        this.discontent = discontent;
    }

    @Basic
    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysDiscussItemEntity that = (SysDiscussItemEntity) o;

        if (disTime != null ? !disTime.equals(that.disTime) : that.disTime != null) return false;
        if (discontent != null ? !discontent.equals(that.discontent) : that.discontent != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (parentDisid != null ? !parentDisid.equals(that.parentDisid) : that.parentDisid != null) return false;
        if (staffId != null ? !staffId.equals(that.staffId) : that.staffId != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (disTime != null ? disTime.hashCode() : 0);
        result = 31 * result + (staffId != null ? staffId.hashCode() : 0);
        result = 31 * result + (parentDisid != null ? parentDisid.hashCode() : 0);
        result = 31 * result + (discontent != null ? discontent.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
