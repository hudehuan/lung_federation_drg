package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2017/5/16.
 */
@Entity
@Table(name = "custom_form_field")
public class CustomFormFieldEntity {
    private String id;
    private String formId;
    private String fieldName;
    private String fieldZhname;
    private String fieldCode;
    private String fieldType;
    private String controlType;
    private String  dataSql;
    private Integer xh;
    private Boolean pkey;
    private Integer typeLength;

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
    @Column(name = "field_name", nullable = true, length = 100)
    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    @Basic
    @Column(name = "field_zhname", nullable = true, length = 100)
    public String getFieldZhname() {
        return fieldZhname;
    }

    public void setFieldZhname(String fieldZhname) {
        this.fieldZhname = fieldZhname;
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
    @Column(name = "field_type", nullable = true, length = 100)
    public String getFieldType() {
        return fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    @Basic
    @Column(name = "control_type", nullable = true, length = 100)
    public String getControlType() {
        return controlType;
    }

    public void setControlType(String controlType) {
        this.controlType = controlType;
    }

    @Basic
    @Column(name = "data_sql", nullable = true, length = 1000)
    public String getdataSql() {
        return dataSql;
    }

    public void setdataSql(String dataSql) {
        this.dataSql = dataSql;
    }

    @Basic
    @Column(name = "xh", nullable = true)
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
    }

    @Basic
    @Column(name = "pkey", nullable = true)
    public Boolean getPkey() {
        return pkey;
    }

    public void setPkey(Boolean pkey) {
        this.pkey = pkey;
    }

    @Basic
    @Column(name = "type_length", nullable = true)
    public Integer getTypeLength() {
        return typeLength;
    }

    public void setTypeLength(Integer typeLength) {
        this.typeLength = typeLength;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomFormFieldEntity that = (CustomFormFieldEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (fieldName != null ? !fieldName.equals(that.fieldName) : that.fieldName != null) return false;
        if (fieldZhname != null ? !fieldZhname.equals(that.fieldZhname) : that.fieldZhname != null) return false;
        if (fieldCode != null ? !fieldCode.equals(that.fieldCode) : that.fieldCode != null) return false;
        if (fieldType != null ? !fieldType.equals(that.fieldType) : that.fieldType != null) return false;
        if (controlType != null ? !controlType.equals(that.controlType) : that.controlType != null) return false;
        if (dataSql != null ? !dataSql.equals(that.dataSql) : that.dataSql != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (pkey != null ? !pkey.equals(that.pkey) : that.pkey != null) return false;
        if (typeLength != null ? !typeLength.equals(that.typeLength) : that.typeLength != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (fieldName != null ? fieldName.hashCode() : 0);
        result = 31 * result + (fieldZhname != null ? fieldZhname.hashCode() : 0);
        result = 31 * result + (fieldCode != null ? fieldCode.hashCode() : 0);
        result = 31 * result + (fieldType != null ? fieldType.hashCode() : 0);
        result = 31 * result + (controlType != null ? controlType.hashCode() : 0);
        result = 31 * result + (dataSql != null ? dataSql.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (pkey != null ? pkey.hashCode() : 0);
        result = 31 * result + (typeLength != null ? typeLength.hashCode() : 0);
        return result;
    }
}
