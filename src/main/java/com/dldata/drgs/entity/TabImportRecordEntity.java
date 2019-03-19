package com.dldata.drgs.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 倪继文 on 2016/9/9.
 */
@Entity
@Table(name = "Tab_Import_Record")
public class TabImportRecordEntity {
    private String id;
    private String userName;
    private Timestamp importDate;
    private Timestamp inputDate;
    private Boolean isSh;
    private String tableId;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
    @Column(name = "import_date")
    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    @Basic
    @Column(name = "input_date")
    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    @Basic
    @Column(name = "is_sh")
    public Boolean getIsSh() {
        return isSh;
    }

    public void setIsSh(Boolean isSh) {
        this.isSh = isSh;
    }

    @Basic
    @Column(name = "table_id")
    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TabImportRecordEntity that = (TabImportRecordEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (importDate != null ? !importDate.equals(that.importDate) : that.importDate != null) return false;
        if (inputDate != null ? !inputDate.equals(that.inputDate) : that.inputDate != null) return false;
        if (isSh != null ? !isSh.equals(that.isSh) : that.isSh != null) return false;
        if (tableId != null ? !tableId.equals(that.tableId) : that.tableId != null) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (importDate != null ? importDate.hashCode() : 0);
        result = 31 * result + (inputDate != null ? inputDate.hashCode() : 0);
        result = 31 * result + (isSh != null ? isSh.hashCode() : 0);
        result = 31 * result + (tableId != null ? tableId.hashCode() : 0);
        return result;
    }
}
