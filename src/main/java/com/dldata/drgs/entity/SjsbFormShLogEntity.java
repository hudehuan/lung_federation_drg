package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/11/1.
 */
@Entity
@Table(name = "Sjsb_Form_Sh_log")
public class SjsbFormShLogEntity {
    private String id;
    private String formId;
    private String dataId;
    private Timestamp sjtime;
    private String userId;
    private String flowId;
    private String stepId;
    private Integer status;
    private String sm;
    private String checkId;
    private String userName;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "form_id")
    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    @Basic
    @Column(name = "data_id")
    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    @Basic
    @Column(name = "sjtime")
    public Timestamp getSjtime() {
        return sjtime;
    }

    public void setSjtime(Timestamp sjtime) {
        this.sjtime = sjtime;
    }

    @Basic
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormShLogEntity that = (SjsbFormShLogEntity) o;

        if (dataId != null ? !dataId.equals(that.dataId) : that.dataId != null) return false;
        if (flowId != null ? !flowId.equals(that.flowId) : that.flowId != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (sjtime != null ? !sjtime.equals(that.sjtime) : that.sjtime != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (stepId != null ? !stepId.equals(that.stepId) : that.stepId != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (dataId != null ? dataId.hashCode() : 0);
        result = 31 * result + (sjtime != null ? sjtime.hashCode() : 0);
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (flowId != null ? flowId.hashCode() : 0);
        result = 31 * result + (stepId != null ? stepId.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "check_id")
    public String getCheckId() {
        return checkId;
    }

    public void setCheckId(String checkId) {
        this.checkId = checkId;
    }

    @Basic
    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
