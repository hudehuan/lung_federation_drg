package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/11/1.
 */
@Entity
@Table(name = "Sjsb_Form_Flow")
public class SjsbFormFlowEntity {
    private String id;
    private String name;
    private String syscode;
    private Timestamp createtime;
    private String pym;
    private Boolean status;
    private String sm;
    private String formid;
    private Boolean moren;
    private Boolean qy;
    private Integer xh;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "syscode")
    public String getSyscode() {
        return syscode;
    }

    public void setSyscode(String syscode) {
        this.syscode = syscode;
    }

    @Basic
    @Column(name = "createtime")
    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    @Basic
    @Column(name = "pym")
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "status")
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Basic
    @Column(name = "sm")
    public String getSm() {
        return sm;
    }

    public void setSm(String sm) {
        this.sm = sm;
    }

    @Basic
    @Column(name = "formid")
    public String getFormid() {
        return formid;
    }

    public void setFormid(String formid) {
        this.formid = formid;
    }

    @Basic
    @Column(name = "moren")
    public Boolean getMoren() {
        return moren;
    }

    public void setMoren(Boolean moren) {
        this.moren = moren;
    }

    @Basic
    @Column(name = "qy")
    public Boolean getQy() {
        return qy;
    }

    public void setQy(Boolean qy) {
        this.qy = qy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormFlowEntity that = (SjsbFormFlowEntity) o;

        if (createtime != null ? !createtime.equals(that.createtime) : that.createtime != null) return false;
        if (formid != null ? !formid.equals(that.formid) : that.formid != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (moren != null ? !moren.equals(that.moren) : that.moren != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (pym != null ? !pym.equals(that.pym) : that.pym != null) return false;
        if (qy != null ? !qy.equals(that.qy) : that.qy != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (syscode != null ? !syscode.equals(that.syscode) : that.syscode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (syscode != null ? syscode.hashCode() : 0);
        result = 31 * result + (createtime != null ? createtime.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        result = 31 * result + (formid != null ? formid.hashCode() : 0);
        result = 31 * result + (moren != null ? moren.hashCode() : 0);
        result = 31 * result + (qy != null ? qy.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "xh")
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }
}
