package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/11/1.
 */
@Entity
@Table(name = "Sjsb_Form_Flow_Step")
public class SjsbFormFlowStepEntity {
    private String id;
    private String name;
    private String shks;
    private Integer xh;
    private String sm;
    private String syscode;
    private String flowId;
    private Boolean status;

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
    @Column(name = "shks")
    public String getShks() {
        return shks;
    }

    public void setShks(String shks) {
        this.shks = shks;
    }

    @Basic
    @Column(name = "xh")
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
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
    @Column(name = "syscode")
    public String getSyscode() {
        return syscode;
    }

    public void setSyscode(String syscode) {
        this.syscode = syscode;
    }

    @Basic
    @Column(name = "flow_id")
    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormFlowStepEntity that = (SjsbFormFlowStepEntity) o;

        if (flowId != null ? !flowId.equals(that.flowId) : that.flowId != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (shks != null ? !shks.equals(that.shks) : that.shks != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (syscode != null ? !syscode.equals(that.syscode) : that.syscode != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (shks != null ? shks.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        result = 31 * result + (syscode != null ? syscode.hashCode() : 0);
        result = 31 * result + (flowId != null ? flowId.hashCode() : 0);
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
