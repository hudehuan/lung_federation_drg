package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Entity
@Table(name = "custom_form_type")
public class CustomFormTypeEntity {
    private String id;
    private String formId;
    private String urlType;
    private Integer xh;
    private String sm;
    private String typeId;

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
    @Column(name = "url_type", nullable = true, length = 256)
    public String getUrlType() {
        return urlType;
    }

    public void setUrlType(String urlType) {
        this.urlType = urlType;
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
    @Column(name = "sm", nullable = true, length = 2147483647)
    public String getSm() {
        return sm;
    }

    public void setSm(String sm) {
        this.sm = sm;
    }

    @Basic
    @Column(name = "type_id", nullable = true)
    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomFormTypeEntity that = (CustomFormTypeEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (urlType != null ? !urlType.equals(that.urlType) : that.urlType != null) return false;
        if (xh != null ? !xh.equals(that.xh) : that.xh != null) return false;
        if (sm != null ? !sm.equals(that.sm) : that.sm != null) return false;
        if (typeId != null ? !typeId.equals(that.typeId) : that.typeId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (urlType != null ? urlType.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (sm != null ? sm.hashCode() : 0);
        result = 31 * result + (typeId != null ? typeId.hashCode() : 0);
        return result;
    }
}
