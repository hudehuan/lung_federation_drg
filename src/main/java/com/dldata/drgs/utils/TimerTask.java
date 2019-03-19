package com.dldata.drgs.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

/**
 * Created by 倪继文 on 2016/9/23.
 */
public class TimerTask {

    public void printTimeStamp(){
        Calendar ca= Calendar.getInstance();
        ca.setTimeInMillis(System.currentTimeMillis());
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS ", Locale.CHINA);
        //显示当前时间 精确到毫秒
        System.out.print(sdf.format(ca.getTime()));
    }
    public TimerTask(){
        this.printTimeStamp();
        System.out.println("计划任务被初始化了");
    }


    public void doTask(){
//        this.printTimeStamp();
//        System.out.print("计划任务被执行,线程id:");
//        System.out.println(Thread.currentThread().getId());
//
//        String path =System.getProperty("user.dir");
//        System.out.println(path);
//        System.out.println(DirectoryConfigOld.TBZ3);
        deleteDir(new File(DirectoryConfigOld.TBZ3));
//        String path2 = Class.class.getClass().getResource("/").getPath();
//        System.out.println(path2);
    }

    private static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                boolean success = deleteChildDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }

        return true;
    }

    //递归删除子目录和子目录下的全部文件
    private static boolean deleteChildDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                boolean success = deleteChildDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }
        // 目录此时为空，可以删除
        return dir.delete();
    }


}
