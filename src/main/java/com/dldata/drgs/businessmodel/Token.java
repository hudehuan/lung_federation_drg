package com.dldata.drgs.businessmodel;

/**
 * Created by Administrator on 2017-03-10.
 */
public class Token {

    /**
     * 登陆时间戳
     */
    private int st;

    /**
     * 失效时间戳
     */
    private int et;

    /**
     * 用户ID
     */
    private String uid;

    /**
     * 用户名称
     */
    private String unm;

    /**
     * 终端ID
     */
    private String cid;

    /**
     * 登陆平台
     */
    private String plan;

    public int getSt() {
        return st;
    }

    public void setSt(int st) {
        this.st = st;
    }

    public int getEt() {
        return et;
    }

    public void setEt(int et) {
        this.et = et;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUnm() {
        return unm;
    }

    public void setUnm(String unm) {
        this.unm = unm;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getPlan() {
        return plan;
    }

    public void setPlan(String plan) {
        this.plan = plan;
    }


    public boolean isTokenValid(){
        return System.currentTimeMillis()/1000<et;
    }

}
