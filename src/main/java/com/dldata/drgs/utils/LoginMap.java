package com.dldata.drgs.utils;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Created by 吴岳峰 on 2017/11/03.
 */
public class LoginMap {
    private String key;
    private long firstLongTime;
    private long lastLongTime;
    private int loginTimes = 0;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public long getFirstLongTime() {
        return firstLongTime;
    }

    public void setFirstLongTime(long firstLongTime) {
        this.firstLongTime = firstLongTime;
    }

    public long getLastLongTime() {
        return lastLongTime;
    }

    public void setLastLongTime(long lastLongTime) {
        this.lastLongTime = lastLongTime;
    }

    public int getLoginTimes() {
        return loginTimes;
    }

    public void setLoginTimes(int loginTimes) {
        this.loginTimes = loginTimes;
    }

    public boolean isValide(){
        return (new Timestamp(new Date().getTime()).getTime()-lastLongTime> Public.SMSCODEVALIDTIMELEN*5*1000)||
                (loginTimes<3&&new Timestamp(new Date().getTime()).getTime()-firstLongTime>60*1000);
    }

}
