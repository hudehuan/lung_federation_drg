package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2017/4/21.
 */
@Entity
@Table(name = "custom_form_template")
public class CustomFormTemplateEntity {
    private String id;
    private String formId;
    private String name;
    private String style;
    private Boolean active;
    private String savejs;
    private Timestamp createTime;
    private Boolean standard;
    private Integer xh;
    private Boolean multilineDiv;
    private Boolean lineDiv;
    private String html;
    private String formjs;
    private Boolean shenhe;
    private Boolean status;

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
    @Column(name = "name", nullable = true, length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "style", nullable = true, length = 100)
    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    @Basic
    @Column(name = "active", nullable = true)
    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Basic
    @Column(name = "savejs", nullable = true, length = 2147483647)
    public String getSavejs() {
        return savejs;
    }

    public void setSavejs(String savejs) {
        this.savejs = savejs;
    }

    @Basic
    @Column(name = "formjs", nullable = true, length = 2147483647)
    public String getFormjs() {
        return formjs;
    }

    public void setFormjs(String formjs) {
        this.formjs = formjs;
    }

    @Basic
    @Column(name = "create_time", nullable = true)
    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "standard", nullable = true)
    public Boolean getStandard() {
        return standard;
    }

    public void setStandard(Boolean standard) {
        this.standard = standard;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomFormTemplateEntity that = (CustomFormTemplateEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (formId != null ? !formId.equals(that.formId) : that.formId != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (style != null ? !style.equals(that.style) : that.style != null) return false;
        if (active != null ? !active.equals(that.active) : that.active != null) return false;
        if (savejs != null ? !savejs.equals(that.savejs) : that.savejs != null) return false;
        if (formjs != null ? !formjs.equals(that.formjs) : that.formjs != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (standard != null ? !standard.equals(that.standard) : that.standard != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (formId != null ? formId.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (style != null ? style.hashCode() : 0);
        result = 31 * result + (active != null ? active.hashCode() : 0);
        result = 31 * result + (savejs != null ? savejs.hashCode() : 0);
        result = 31 * result + (formjs != null ? formjs.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (standard != null ? standard.hashCode() : 0);
        return result;
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
    @Column(name = "multiline_div", nullable = true)
    public Boolean getMultilineDiv() {
        return multilineDiv;
    }

    public void setMultilineDiv(Boolean multilineDiv) {
        this.multilineDiv = multilineDiv;
    }

    @Basic
    @Column(name = "line_div", nullable = true)
    public Boolean getLineDiv() {
        return lineDiv;
    }

    public void setLineDiv(Boolean lineDiv) {
        this.lineDiv = lineDiv;
    }

    @Basic
    @Column(name = "html", nullable = true, length = 2147483647)
    public String getHtml() {
        return html;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    @Basic
    @Column(name = "shenhe", nullable = true)
    public Boolean getShenhe() {
        return shenhe;
    }

    public void setShenhe(Boolean shenhe) {
        this.shenhe = shenhe;
    }

    @Basic
    @Column(name = "status", nullable = true)
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
