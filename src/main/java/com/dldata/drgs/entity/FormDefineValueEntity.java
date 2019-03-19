package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/8/12.
 */
@Entity
@Table(name = "Form_Define_Value")
public class FormDefineValueEntity {
    private String tvId;
    private String tdId;
    private Timestamp inputDate;
    private String rq;
    private String userId;
    private Boolean isSh;
    private String cxrq;

    @Id
    @Column(name = "tv_id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getTvId() {
        return tvId;
    }

    public void setTvId(String tvId) {
        this.tvId = tvId;
    }

    @Basic
    @Column(name = "td_id", nullable = true, insertable = true, updatable = true, length = 36)
    public String getTdId() {
        return tdId;
    }

    public void setTdId(String tdId) {
        this.tdId = tdId;
    }

    @Basic
    @Column(name = "input_date", nullable = true, insertable = true, updatable = true)
    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    @Basic
    @Column(name = "rq", nullable = true, insertable = true, updatable = true)
    public String getRq() {
        return rq;
    }

    public void setRq(String rq) {
        this.rq = rq;
    }

    @Basic
    @Column(name = "user_id", nullable = true, insertable = true, updatable = true, length = 36)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "is_sh", nullable = true, insertable = true, updatable = true)
    public Boolean getIsSh() {
        return isSh;
    }

    public void setIsSh(Boolean isSh) {
        this.isSh = isSh;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormDefineValueEntity that = (FormDefineValueEntity) o;

        if (inputDate != null ? !inputDate.equals(that.inputDate) : that.inputDate != null) return false;
        if (isSh != null ? !isSh.equals(that.isSh) : that.isSh != null) return false;
        if (rq != null ? !rq.equals(that.rq) : that.rq != null) return false;
        if (tdId != null ? !tdId.equals(that.tdId) : that.tdId != null) return false;
        if (tvId != null ? !tvId.equals(that.tvId) : that.tvId != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tvId != null ? tvId.hashCode() : 0;
        result = 31 * result + (tdId != null ? tdId.hashCode() : 0);
        result = 31 * result + (inputDate != null ? inputDate.hashCode() : 0);
        result = 31 * result + (rq != null ? rq.hashCode() : 0);
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (isSh != null ? isSh.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "cxrq")
    public String getCxrq() {
        return cxrq;
    }

    public void setCxrq(String cxrq) {
        this.cxrq = cxrq;
    }
}
