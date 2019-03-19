package com.dldata.drgs.entity;

import javax.persistence.*;

/**
 * Created by 倪继文 on 2016/8/29.
 */
@Entity
@Table(name = "Tab_Structure")
public class TabStructureEntity {
    private String id;
    private String tableId;
    private String name;
    private String zhName;
    private String type;
    private Integer colLength;
    private Boolean isKey;
    private Integer xh;
    private Integer status;
    private String pym;
    private String bz;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "table_id")
    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "zh_name")
    public String getZhName() {
        return zhName;
    }

    public void setZhName(String zhName) {
        this.zhName = zhName;
    }

    @Basic
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "col_length")
    public Integer getColLength() {
        return colLength;
    }

    public void setColLength(Integer colLength) {
        this.colLength = colLength;
    }

    @Basic
    @Column(name = "is_key")
    public Boolean getIsKey() {
        return isKey;
    }

    public void setIsKey(Boolean isKey) {
        this.isKey = isKey;
    }

    @Basic
    @Column(name = "xh")
    public Integer getXh() {
        return xh;
    }

    public void setXh(Integer xh) {
        this.xh = xh;
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
    @Column(name = "pym")
    public String getPym() {
        return pym;
    }

    public void setPym(String pym) {
        this.pym = pym;
    }

    @Basic
    @Column(name = "bz")
    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TabStructureEntity entity = (TabStructureEntity) o;

        if (bz != null ? !bz.equals(entity.bz) : entity.bz != null) return false;
        if (colLength != null ? !colLength.equals(entity.colLength) : entity.colLength != null) return false;
        if (id != null ? !id.equals(entity.id) : entity.id != null) return false;
        if (isKey != null ? !isKey.equals(entity.isKey) : entity.isKey != null) return false;
        if (name != null ? !name.equals(entity.name) : entity.name != null) return false;
        if (pym != null ? !pym.equals(entity.pym) : entity.pym != null) return false;
        if (status != null ? !status.equals(entity.status) : entity.status != null) return false;
        if (tableId != null ? !tableId.equals(entity.tableId) : entity.tableId != null) return false;
        if (type != null ? !type.equals(entity.type) : entity.type != null) return false;
        if (xh != null ? !xh.equals(entity.xh) : entity.xh != null) return false;
        if (zhName != null ? !zhName.equals(entity.zhName) : entity.zhName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (tableId != null ? tableId.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (zhName != null ? zhName.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (colLength != null ? colLength.hashCode() : 0);
        result = 31 * result + (isKey != null ? isKey.hashCode() : 0);
        result = 31 * result + (xh != null ? xh.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (pym != null ? pym.hashCode() : 0);
        result = 31 * result + (bz != null ? bz.hashCode() : 0);
        return result;
    }
}
