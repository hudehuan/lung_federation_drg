package com.dldata.drgs.utils;

import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledThreadPoolExecutor;

/**
 * Created by 倪继文 on 2017/3/9.
 */
public class Public {

    //手机号码验证
    public final static String MOBILE_VALIDATE = "mobileerror";
    //密码验证
    public final static String PWDE_VALIDATE="pwderror";
    //短信验证码验证
    public final static String SMSCAPTCHA_VALIDATE="smscaptchaerror";

    //订单表找不到省集团和代理商
    public final static String UNKNOWN="unknown";

    /**
     * 验证码有效时长
     */
    public static int SMSCODEVALIDTIMELEN = 60*3;

    /**
     * 分页容量最大值
     */
    public final static  int FENYEMAX = 6000;

    /**
     * 默认分页数据
     */
    public final static Integer[] DEFAULTFENYE={0,1000};

    /**
     * 多SQL分隔符
     */
    public final static String SQLSPLIT = "90C18768-611E-4752-BE6D-408476E59B6B-SPLIT";

    /**
     *系统可以用来定时执行可以重复的线程池
     */
    public final static ScheduledThreadPoolExecutor SCHEDULEDTHREADPOOLEXECUTOR =(ScheduledThreadPoolExecutor)Executors.newScheduledThreadPool(6);

    /**
     * token加密密钥主体
     * 参考命名格式xxx@xx.xxx其他命名格式参考Java Cryptography Architecture API Specification & Reference 中的附录 A
     */
    public final static String TOKEN_PRINCIPALNAME="zhongyi@dldata.cn";

    /**
     * token加密密钥
     */
    public final static String TOKEN_KEYPASSWORD="zhongyi@dldata.cn";

    /**
     * token有效时长 秒
     */
    public static int TOKEN_VALIDTIMELEN=86400 * 3*10;

    /**
     * 医助权重
     */
    public final static String YIZHU_ROLE_WEITE="2";

    /**
     * 通用接口日志保存目录
     */
    public final static String INTERFACELOG="/static/interfacelog";


    /**
     * 云信KEY
     */
//    public static final String APP_KEY = "dd5996ee5cdfb4b1c6e4baeb7a7195ef";
    public static final String APP_KEY = "32326d76d2b014c65d92af6defafecc7";

    /**
     * 云信密码
     */
//    public static final String APP_SECRET = "701da72e8a1e";
    public static final String APP_SECRET = "4eb46cb46bb2";

    /**
     * 云信IM服务器
     */
    public static final String NIMSERVER = "https://api.netease.im/nimserver";

    /**
     * 云信系统通知账户
     */
    public static final String NETEASY_SYSTEM_USER = "system" ;

    /**
     * 图文咨询医生回复次数自动结束
     */
    public static int SERVICEENDNUM = 20 ;

    /**
     * 图文咨询自动结束 时长 小时
     */
    public static int SERVICEENDTIMELENHOUR = 24 ;

    /**
     * 免费咨询自动结束 时长 小时
     */
    public static int SERVICEENDTIMELENHOUR_FREEINQUIRY = 24 ;

//    个推（钰医-正式版）
//    AppID:7ps94keHrW73MFc5QJMQP4
//    AppSecret：w86CctnrxJ8GNIIt5TA3u4
//    AppKey：F0bVDbS0qH84wk7ef0zft7
//    MasterSecret：2NyYJUIly594RoUwYMqUq9
    /**
     * 个推AppID
     */
    public static String getui_appId_p = "7ps94keHrW73MFc5QJMQP4";

    /**
     * 个推AppKey
     */
    public static String getui_appKey_p = "F0bVDbS0qH84wk7ef0zft7";

    /**
     * 个推masterSecret
     */
    public static String getui_appSecret_p = "w86CctnrxJ8GNIIt5TA3u4";

    /**
     * 个推masterSecret
     */
    public static String getui_masterSecret_p = "2NyYJUIly594RoUwYMqUq9";

//    个推（钰医云诊所-正式版）
//    AppID：mzTpW44uD76aR7JqKph7R3
//    AppSecret：f68HNxpNJY7VbwquxyeMR4
//    AppKey：x3JA8JSlTe6Mih9ePwGyO7
//    MasterSecret：WZW7LixnIB8V2p9Z3dW195
    /**
     * 个推AppID
     */
    public static String getui_appId_d = "mzTpW44uD76aR7JqKph7R3";

    /**
     * 个推AppKey
     */
    public static String getui_appKey_d = "x3JA8JSlTe6Mih9ePwGyO7";

    /**
     * 个推masterSecret
     */
    public static String getui_appSecret_d= "f68HNxpNJY7VbwquxyeMR4";

    /**
     * 个推masterSecret
     */
    public static String getui_masterSecret_d = "WZW7LixnIB8V2p9Z3dW195";


    /**
     * 个推resturl
     */
    public static String getui_url = "http://sdk.open.api.igexin.com/apiex.htm";

    public static String kefu_phone="400 9659 211";

    /**
     * 免费问诊限额
     */
    public static int mianfei_wenzhen_xiane=10;

    public static final String BJZB = "ZBJT";

    public static final String ZBJT_NAME = "总部集团";

    public static String NOTIFY_URL_WX = "http://restapi.dryuyi.com:8080/zyPay/wx_return_url";

    public static String NOTIFY_URL_ALI = "http://restapi.dryuyi.com:8080/zyPay/notify_url;";

    /**
     * 转诊医生的有效时间 单位天
     */
    public static int zhuanzhen_timelen=3;


    /**
     * 不需要验证token的路径
     */
    public static String NoNeedAuthorizedToken="";


    /**
     * 测试用户id
     */
    public static List<String> test_user_id=new LinkedList<>();


    /**
     * 测试医生获取接口代码 "zy_p_finddoc_search"
     */
    public static List<String> test_p_dm=new LinkedList<>();


    /**
     * 测试接口代码后缀
     */
    public static String test_p_dm_ext="_test";

    /**
     * 测试服务器ip地址
     */
    public static String test_ip="";

}
