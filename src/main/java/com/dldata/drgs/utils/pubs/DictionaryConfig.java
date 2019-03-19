package com.dldata.drgs.utils.pubs;

import javax.annotation.ManagedBean;

/**
 * Created by admin on 2016/9/8.
 */
@ManagedBean
public class DictionaryConfig {
    // 职称代码
    private String zhiChengCode;

    // 职位代码
    private String zhiWeiCode;

    // 人员类型
    private String staffType;

    // 字典代码
    private String dicType;

    // 科室类型
    private String keshiType;

    private String systemCode;

    private String dataDownUpCode;

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getDataDownUpCode() {
        return dataDownUpCode;
    }

    public void setDataDownUpCode(String dataDownUpCode) {
        this.dataDownUpCode = dataDownUpCode;
    }

    public String getDicType() {
        return dicType;
    }

    public void setDicType(String dicType) {
        this.dicType = dicType;
    }

    public String getKeshiType() {
        return keshiType;
    }

    public void setKeshiType(String keshiType) {
        this.keshiType = keshiType;
    }

    public String getZhiChengCode() {
        return zhiChengCode;
    }

    public void setZhiChengCode(String zhiChengCode) {
        this.zhiChengCode = zhiChengCode;
    }

    public String getZhiWeiCode() {
        return zhiWeiCode;
    }

    public void setZhiWeiCode(String zhiWeiCode) {
        this.zhiWeiCode = zhiWeiCode;
    }

    public String getStaffType() {
        return staffType;
    }

    public void setStaffType(String staffType) {
        this.staffType = staffType;
    }
}
