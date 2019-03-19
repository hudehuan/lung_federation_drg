package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Entity
@Table(name = "custom_form_field_template")
public class CustomFormFieldTemplateEntity {
    private String id;
    private String formId;
    private String templateId;
    private String fieldId;
    private String fieldCode;
    private String dataSql;
    private String js;
    private String controlType;

    @Id
    @Column(name = "id", nullable = false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "form_id", nullable = true)
    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    @Basic
    @Column(name = "template_id", nullable = true)
    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    @Basic
    @Column(name = "field_id", nullable = true)
    public String getFieldId() {
        return fieldId;
    }

    public void setFieldId(String fieldId) {
        this.fieldId = fieldId;
    }

    @Basic
    @Column(name = "field_code", nullable = true, length = 100)
    public String getFieldCode() {
        return fieldCode;
    }

    public void setFieldCode(String fieldCode) {
        this.fieldCode = fieldCode;
    }

    @Basic
    @Column(name = "data_sql", nullable = true, length = 2147483647)
    public String getdataSql() {
        return dataSql;
    }

    public void setdataSql(String dataSql) {
        this.dataSql = dataSql;
    }



    @Basic
    @Column(name = "js", nullable = true, length = 2147483647)
    public String getJs() {
        return js;
    }

    public void setJs(String js) {
        this.js = js;
    }

    @Basic
    @Column(name = "control_type", nullable = true, length = 100)
    public String getControlType() {
        return controlType;
    }

    public void setControlType(String controlType) {
        this.controlType = controlType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomFormFieldTemplateEntity that = (CustomFormFieldTemplateEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (templateId != null ? !templateId.equals(that.templateId) : that.templateId != null) return false;
        if (fieldId != null ? !fieldId.equals(that.fieldId) : that.fieldId != null) return false;
        if (fieldCode != null ? !fieldCode.equals(that.fieldCode) : that.fieldCode != null) return false;
        if (dataSql != null ? !dataSql.equals(that.dataSql) : that.dataSql != null) return false;

        if (js != null ? !js.equals(that.js) : that.js != null) return false;
        if (controlType != null ? !controlType.equals(that.controlType) : that.controlType != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (templateId != null ? templateId.hashCode() : 0);
        result = 31 * result + (fieldId != null ? fieldId.hashCode() : 0);
        result = 31 * result + (fieldCode != null ? fieldCode.hashCode() : 0);
        result = 31 * result + (dataSql != null ? dataSql.hashCode() : 0);
        result = 31 * result + (js != null ? js.hashCode() : 0);
        result = 31 * result + (controlType != null ? controlType.hashCode() : 0);
        return result;
    }


}
