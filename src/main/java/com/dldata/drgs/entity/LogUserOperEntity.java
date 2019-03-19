package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/7/30.
 */
@Entity
@Table(name = "Log_User_Oper")
public class LogUserOperEntity {
    private String id;
    private String loginName;
    private String userName;
    private Timestamp optDate;
    private String url;
    private String formTitle;
    private String menuCode;
    private String modelName;
    private String optBrowse;
    private String optIp;
    private String sessionId;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "login_name")
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    @Basic
    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "opt_date")
    public Timestamp getOptDate() {
        return optDate;
    }

    public void setOptDate(Timestamp optDate) {
        this.optDate = optDate;
    }

    @Basic
    @Column(name = "url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Basic
    @Column(name = "form_title")
    public String getFormTitle() {
        return formTitle;
    }

    public void setFormTitle(String formTitle) {
        this.formTitle = formTitle;
    }

    @Basic
    @Column(name = "menu_code")
    public String getMenuCode() {
        return menuCode;
    }

    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    @Basic
    @Column(name = "model_name")
    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    @Basic
    @Column(name = "opt_browse")
    public String getOptBrowse() {
        return optBrowse;
    }

    public void setOptBrowse(String optBrowse) {
        this.optBrowse = optBrowse;
    }

    @Basic
    @Column(name = "opt_ip")
    public String getOptIp() {
        return optIp;
    }

    public void setOptIp(String optIp) {
        this.optIp = optIp;
    }

    @Basic
    @Column(name = "session_id")
    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LogUserOperEntity that = (LogUserOperEntity) o;

        if (formTitle != null ? !formTitle.equals(that.formTitle) : that.formTitle != null) return false;
        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (loginName != null ? !loginName.equals(that.loginName) : that.loginName != null) return false;
        if (menuCode != null ? !menuCode.equals(that.menuCode) : that.menuCode != null) return false;
        if (modelName != null ? !modelName.equals(that.modelName) : that.modelName != null) return false;
        if (optBrowse != null ? !optBrowse.equals(that.optBrowse) : that.optBrowse != null) return false;
        if (optDate != null ? !optDate.equals(that.optDate) : that.optDate != null) return false;
        if (optIp != null ? !optIp.equals(that.optIp) : that.optIp != null) return false;
        if (sessionId != null ? !sessionId.equals(that.sessionId) : that.sessionId != null) return false;
        if (url != null ? !url.equals(that.url) : that.url != null) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (loginName != null ? loginName.hashCode() : 0);
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (optDate != null ? optDate.hashCode() : 0);
        result = 31 * result + (url != null ? url.hashCode() : 0);
        result = 31 * result + (formTitle != null ? formTitle.hashCode() : 0);
        result = 31 * result + (menuCode != null ? menuCode.hashCode() : 0);
        result = 31 * result + (modelName != null ? modelName.hashCode() : 0);
        result = 31 * result + (optBrowse != null ? optBrowse.hashCode() : 0);
        result = 31 * result + (optIp != null ? optIp.hashCode() : 0);
        result = 31 * result + (sessionId != null ? sessionId.hashCode() : 0);
        return result;
    }
}
