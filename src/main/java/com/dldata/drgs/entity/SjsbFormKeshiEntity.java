package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 吴岳峰 on 2017/3/17.
 */
@Entity
@Table(name = "Sjsb_Form_Keshi")
public class SjsbFormKeshiEntity {
    private String id;
    private String formId;
    private String kid;

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
    @Column(name = "kid")
    public String getKid() {
        return kid;
    }

    public void setKid(String kid) {
        this.kid = kid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SjsbFormKeshiEntity that = (SjsbFormKeshiEntity) o;

        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (kid != null ? !kid.equals(that.kid) : that.kid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (kid != null ? kid.hashCode() : 0);
        return result;
    }

}
