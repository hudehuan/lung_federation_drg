package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/5.
 */
@Entity
@Table(name = "Tab_Define")
public class TabDefineEntity {
    private String id;
    private String name;
    private String zhName;
    private Integer status;
    private String bz;
    private String pym;
    private String excelName;
    private String sysCode;
    private String tableSql;

    @Id
    @Column(name = "id", nullable = false, insertable = true, updatable = true, length = 36)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = true, insertable = true, updatable = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "zh_name", nullable = true, insertable = true, updatable = true)
    public String getZhName() {
        return zhName;
    }

    public void setZhName(String zhName) {
        this.zhName = zhName;
    }

    @Basic
    @Column(name = "status", nullable = true, insertable = true, updatable = true)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Basic
    @Column(name = "bz", nullable = true, insertable = true, updatable = true)
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Basic
    @Column(name = "pym", nullable = true, insertable = true, updatable = true)
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "excel_name", nullable = true, insertable = true, updatable = true)
    public String getExcelName() {
        return excelName;
    }

    public void setExcelName(String excelName) {
        this.excelName = excelName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TabDefineEntity entity = (TabDefineEntity) o;

        if (bz != null ? !bz.equals(entity.bz) : entity.bz != null) return false;
        if (excelName != null ? !excelName.equals(entity.excelName) : entity.excelName != null) return false;
        if (id != null ? !id.equals(entity.id) : entity.id != null) return false;
        if (name != null ? !name.equals(entity.name) : entity.name != null) return false;
        if (pym != null ? !pym.equals(entity.pym) : entity.pym != null) return false;
        if (status != null ? !status.equals(entity.status) : entity.status != null) return false;
        if (zhName != null ? !zhName.equals(entity.zhName) : entity.zhName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (zhName != null ? zhName.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (excelName != null ? excelName.hashCode() : 0);
        return result;
    }

    @Basic
    @Column(name = "sys_code")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    @Basic
    @Column(name = "table_sql")
    public String getTableSql() {
        return tableSql;
    }

    public void setTableSql(String tableSql) {
        this.tableSql = tableSql;
    }
}
