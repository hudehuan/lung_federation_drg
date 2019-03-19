package com.dldata.drgs.utils.pubs;

import javax.annotation.ManagedBean;

/**
 * Created by 倪继文 on 2016/7/20.
 */
@ManagedBean
public class DirectoryConfig {

    private String login_ip ; //登录IP
    private String login_url ; //登录URL
    private String login_port ; //登录端口
    private String login_dir; //路劲
    private String temp_dir;//临时目录
    private String templateExcel;//元数据表
    private String home_page_url;//首页路劲
    private String sys_udun_vali;//系统U盾验证标识
    public static String SYS="";

    public String getSys_udun_vali() {
        return sys_udun_vali;
    }

    public void setSys_udun_vali(String sys_udun_vali) {
        this.sys_udun_vali = sys_udun_vali;
    }

    public String getHome_page_url() {
        return home_page_url;
    }

    public void setHome_page_url(String home_page_url) {
        this.home_page_url = home_page_url;
    }

    public String getLogin_dir() {
        return login_dir;
    }

    public void setLogin_dir(String login_dir) {
        this.login_dir = login_dir;
    }

    public String getLogin_ip() {
        return login_ip;
    }

    public void setLogin_ip(String login_ip) {
        this.login_ip = login_ip;
    }

    public String getLogin_url() {
        return login_url;
    }

    public void setLogin_url(String login_url) {
        this.login_url = login_url;
    }

    public String getLogin_port() {
        return login_port;
    }

    public void setLogin_port(String login_port) {
        this.login_port = login_port;
    }

    public String getTemp_dir() {
        return temp_dir;
    }

    public void setTemp_dir(String temp_dir) {
        this.temp_dir = temp_dir;
    }


    public String getTemplateExcel() {
        return templateExcel;
    }

    public void setTemplateExcel(String templateExcel) {
        this.templateExcel = templateExcel;
    }



}
