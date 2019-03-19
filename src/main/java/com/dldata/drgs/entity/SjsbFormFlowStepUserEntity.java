package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/12/14.
 */
@Entity
@Table(name = "Sjsb_Form_Flow_Step_User")
public class SjsbFormFlowStepUserEntity {
    private String id;
    private String userid;
    private String username;
    private String flowId;
    private String stepId;
    private String syscode;
    private Boolean isOnlyKs;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "userid")
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Basic
    @Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Basic
    @Column(name = "flow_id")
    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    @Basic
    @Column(name = "step_id")
    public String getStepId() {
        return stepId;
    }

    public void setStepId(String stepId) {
        this.stepId = stepId;
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
    @Column(name = "is_only_ks")
    public Boolean getIsOnlyKs() {
        return isOnlyKs;
    }

    public void setIsOnlyKs(Boolean isOnlyKs) {
        this.isOnlyKs = isOnlyKs;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormFlowStepUserEntity that = (SjsbFormFlowStepUserEntity) o;

        if (flowId != null ? !flowId.equals(that.flowId) : that.flowId != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (isOnlyKs != null ? !isOnlyKs.equals(that.isOnlyKs) : that.isOnlyKs != null) return false;
        if (stepId != null ? !stepId.equals(that.stepId) : that.stepId != null) return false;
        if (syscode != null ? !syscode.equals(that.syscode) : that.syscode != null) return false;
        if (userid != null ? !userid.equals(that.userid) : that.userid != null) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (userid != null ? userid.hashCode() : 0);
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (flowId != null ? flowId.hashCode() : 0);
        result = 31 * result + (stepId != null ? stepId.hashCode() : 0);
        result = 31 * result + (syscode != null ? syscode.hashCode() : 0);
        result = 31 * result + (isOnlyKs != null ? isOnlyKs.hashCode() : 0);
        return result;
    }
}
