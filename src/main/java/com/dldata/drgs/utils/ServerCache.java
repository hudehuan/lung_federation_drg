package com.dldata.drgs.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * Created by 倪继文 on 2016/8/22.
 */
public class ServerCache {

    public static Map<String, String> TICKET_AND_NAME = new HashMap<String, String>();


    public static Map<String, LoginMap> LOGIN_AND_NAME = new HashMap<String, LoginMap>();

    public static class ClearInvalideCache implements  Runnable{

        private Logger logger = LoggerFactory.getLogger(this.getClass());

        @Override
        public void run() {
            try{
                innerRun();
            }catch(Throwable e){

            }
        }

        private void innerRun() {
//            logger.info("remove LOGIN_AND_NAME cache start.");
            List<String> needRemoveKes=new LinkedList<>();
            Iterator<Map.Entry<String, LoginMap>> iterator = LOGIN_AND_NAME.entrySet().iterator();
            while (iterator.hasNext()){
                Map.Entry<String, LoginMap> entry= iterator.next();
                if(entry.getValue().isValide()){
                    needRemoveKes.add(entry.getKey());
                }
            }
            for (int j = 0; j < needRemoveKes.size(); j++) {
                logger.info("remove LOGIN_AND_NAME cache key:"+needRemoveKes.get(j));
                LOGIN_AND_NAME.remove(needRemoveKes.get(j));
            }
        }
    }



}
