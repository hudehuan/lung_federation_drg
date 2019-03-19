package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/11/3.
 */
@Entity
@Table(name = "Sjsb_Form_Step_Check_List")
public class SjsbFormStepCheckListEntity {
    private String id;
    private String formId;
    private String dataId;
    private String flowId;
    private String stepId;
    private Timestamp checktime;
    private String formName;
    private Timestamp inputTime;
    private String inputUserId;
    private Integer formStatus;
    private Timestamp dataSbrq;
    private String formTypeId;
    private String formTypeName;
    private String checkUserId;
    private String checkUserName;
    private String inputUserName;
    private String inputKsId;
    private String fgksid;

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
    @Column(name = "checktime")
    public Timestamp getChecktime() {
        return checktime;
    }

    public void setChecktime(Timestamp checktime) {
        this.checktime = checktime;
    }

    @Basic
    @Column(name = "form_name")
    public String getFormName() {
        return formName;
    }

    public void setFormName(String formName) {
        this.formName = formName;
    }

    @Basic
    @Column(name = "input_time")
    public Timestamp getInputTime() {
        return inputTime;
    }

    public void setInputTime(Timestamp inputTime) {
        this.inputTime = inputTime;
    }

    @Basic
    @Column(name = "input_user_id")
    public String getInputUserId() {
        return inputUserId;
    }

    public void setInputUserId(String inputUserId) {
        this.inputUserId = inputUserId;
    }

    @Basic
    @Column(name = "form_status")
    public Integer getFormStatus() {
        return formStatus;
    }

    public void setFormStatus(Integer formStatus) {
        this.formStatus = formStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormStepCheckListEntity that = (SjsbFormStepCheckListEntity) o;

        if (checktime != null ? !checktime.equals(that.checktime) : that.checktime != null) return false;
        if (dataId != null ? !dataId.equals(that.dataId) : that.dataId != null) return false;
        if (flowId != null ? !flowId.equals(that.flowId) : that.flowId != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (formName != null ? !formName.equals(that.formName) : that.formName != null) return false;
        if (formStatus != null ? !formStatus.equals(that.formStatus) : that.formStatus != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (inputTime != null ? !inputTime.equals(that.inputTime) : that.inputTime != null) return false;
        if (inputUserId != null ? !inputUserId.equals(that.inputUserId) : that.inputUserId != null) return false;
        if (stepId != null ? !stepId.equals(that.stepId) : that.stepId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (dataId != null ? dataId.hashCode() : 0);
        result = 31 * result + (flowId != null ? flowId.hashCode() : 0);
        result = 31 * result + (stepId != null ? stepId.hashCode() : 0);
        result = 31 * result + (checktime != null ? checktime.hashCode() : 0);
        result = 31 * result + (formName != null ? formName.hashCode() : 0);
        result = 31 * result + (inputTime != null ? inputTime.hashCode() : 0);
        result = 31 * result + (inputUserId != null ? inputUserId.hashCode() : 0);
        result = 31 * result + (formStatus != null ? formStatus.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "data_sbrq")
    public Timestamp getDataSbrq() {
        return dataSbrq;
    }

    public void setDataSbrq(Timestamp dataSbrq) {
        this.dataSbrq = dataSbrq;
    }

    @Basic
    @Column(name = "form_type_id")
    public String getFormTypeId() {
        return formTypeId;
    }

    public void setFormTypeId(String formTypeId) {
        this.formTypeId = formTypeId;
    }

    @Basic
    @Column(name = "form_type_name")
    public String getFormTypeName() {
        return formTypeName;
    }

    public void setFormTypeName(String formTypeName) {
        this.formTypeName = formTypeName;
    }

    @Basic
    @Column(name = "check_user_id")
    public String getCheckUserId() {
        return checkUserId;
    }

    public void setCheckUserId(String checkUserId) {
        this.checkUserId = checkUserId;
    }

    @Basic
    @Column(name = "check_user_name")
    public String getCheckUserName() {
        return checkUserName;
    }

    public void setCheckUserName(String checkUserName) {
        this.checkUserName = checkUserName;
    }

    @Basic
    @Column(name = "input_user_name")
    public String getInputUserName() {
        return inputUserName;
    }

    public void setInputUserName(String inputUserName) {
        this.inputUserName = inputUserName;
    }

    @Basic
    @Column(name = "input_ks_id")
    public String getInputKsId() {
        return inputKsId;
    }

    public void setInputKsId(String inputKsId) {
        this.inputKsId = inputKsId;
    }

    @Basic
    @Column(name = "fgksid")
    public String getFgksid() {
        return fgksid;
    }

    public void setFgksid(String fgksid) {
        this.fgksid = fgksid;
    }
}
