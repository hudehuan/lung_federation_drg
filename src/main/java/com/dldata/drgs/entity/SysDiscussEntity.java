package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Sys_Discuss")
public class SysDiscussEntity {
    private String disId;
    private Timestamp disTime;
    private String publisher;
    private String title;
    private String discontent;
    private String sysCode;
    private String type;
    private Integer status;
    private Timestamp huifuTime;

    @Id
    @Column(name = "dis_id")
    public String getDisId() {
        return disId;
    }

    public void setDisId(String disId) {
        this.disId = disId;
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
    @Column(name = "publisher")
    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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
    @Column(name = "sys_code")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Basic
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
    @Column(name = "huifu_time")
    public Timestamp getHuifuTime() {
        return huifuTime;
    }

    public void setHuifuTime(Timestamp huifuTime) {
        this.huifuTime = huifuTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysDiscussEntity that = (SysDiscussEntity) o;

        if (disId != null ? !disId.equals(that.disId) : that.disId != null) return false;
        if (disTime != null ? !disTime.equals(that.disTime) : that.disTime != null) return false;
        if (discontent != null ? !discontent.equals(that.discontent) : that.discontent != null) return false;
        if (huifuTime != null ? !huifuTime.equals(that.huifuTime) : that.huifuTime != null) return false;
        if (publisher != null ? !publisher.equals(that.publisher) : that.publisher != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (sysCode != null ? !sysCode.equals(that.sysCode) : that.sysCode != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = disId != null ? disId.hashCode() : 0;
        result = 31 * result + (disTime != null ? disTime.hashCode() : 0);
        result = 31 * result + (publisher != null ? publisher.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (discontent != null ? discontent.hashCode() : 0);
        result = 31 * result + (sysCode != null ? sysCode.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (huifuTime != null ? huifuTime.hashCode() : 0);
        return result;
    }
}
