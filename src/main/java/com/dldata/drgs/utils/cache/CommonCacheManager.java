package com.dldata.drgs.utils.cache;

import com.dldata.drgs.utils.MD5Util;
import com.dldata.drgs.utils.StringUtil;


import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import java.io.Serializable;
import java.util.Objects;

/**
 * Created by Administrator on 2017-03-10.
 */
public class CommonCacheManager {

    private CacheManager cacheManager = CacheManager.create(getClass().getResource("/ehcache/ehcache-shiro.xml"));

    private Object cacheLock = new Object();

    private static CommonCacheManager commonCacheManager = new CommonCacheManager();

    public static CommonCacheManager  getCommonCacheManager(){
        return  commonCacheManager;
    }


    /**
     *
     * @param name 缓存名字
     * @param maxElementsInMemory 内存最大个数
     * @param overflowToDisk 内存超过是否写磁盘
     * @param eternal 是否永久有效
     * @param timeToLiveSeconds 最大生命时间
     * @param timeToIdleSeconds 最大空闲时间
     */
    public void addCacheValue(String name, int maxElementsInMemory, boolean overflowToDisk,
                              boolean eternal, long timeToLiveSeconds, long timeToIdleSeconds){
        synchronized (cacheLock){
            if(cacheManager.cacheExists(name)){
                cacheManager.removeCache(name);
            }
            Cache cache = new Cache(name,maxElementsInMemory,overflowToDisk,eternal,timeToLiveSeconds,timeToIdleSeconds);
            cacheManager.addCache(cache);
        }
    }


    public void addCacheValue(String cacheName, String key ,Serializable value,Integer maxCacheTime){

        synchronized (cacheLock){
            Cache cache= cacheManager.getCache(cacheName);
            if(cache==null){
//                String name, int maxElementsInMemory, boolean overflowToDisk,
//                boolean eternal, long timeToLiveSeconds, long timeToIdleSeconds
                //没有就默认创建一个Cache
                cache = new Cache(cacheName,120,true,false,(StringUtil.isEmptyOrLength0(maxCacheTime))?300:maxCacheTime,(StringUtil.isEmptyOrLength0(maxCacheTime))?300:maxCacheTime);
                cacheManager.addCache(cache);
            }
            Element element = new Element(MD5Util.MD5Encoder(key.trim()),value);
            cache.put(element);
        }
    }

    public Serializable getCacheValue(String cacheName, String key){

        synchronized (cacheLock){
            Cache cache= cacheManager.getCache(cacheName);
            if(cache==null){
                return null;
            }
            Element element =cache.get(MD5Util.MD5Encoder(key.trim()));
            if(element==null){
                return null;
            }
            return (Serializable)element.getObjectValue();
        }
    }

    public void removeCacheValue(String cacheName, String key){

        synchronized (cacheLock){
            Cache cache= cacheManager.getCache(cacheName);
            if(!StringUtil.isNullOrSpace(key)&&!StringUtil.isNullOrSpace(key.trim())){
                cache.remove(MD5Util.MD5Encoder(key.trim()));
            }
        }
    }

    public void clearCache(String cacheName){

        synchronized (cacheLock){
            if(StringUtil.isEmptyOrLength0(cacheName)){
                cacheManager.clearAll();
            }else{
                cacheManager.removeCache(cacheName);
            }
        }
    }

    public static enum CACHENAME{
        COMMONAPICONFIG
    }

    public static class  CacheAble implements Serializable{

        private Object cacheObj;

        public  CacheAble(Object cacheObj){
            this.cacheObj=cacheObj;
        }

        public Object getCacheObj() {
            return cacheObj;
        }
    }
}
