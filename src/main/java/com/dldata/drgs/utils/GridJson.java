package com.dldata.drgs.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * Created by 吴岳峰 on 2017/4/18.
 */
public class GridJson {

    private final static Logger logger = LoggerFactory.getLogger(GridJson.class);

    /**
     *
     * @param string
     * @param charsToTrim
     * @return
     */
    public static String trimEnd(String string, Character... charsToTrim) {
        if (string == null || charsToTrim == null)
            return string;

        int lengthToKeep = string.length();
        for (int index = string.length() - 1; index >= 0; index--) {
            boolean removeChar = false;
            if (charsToTrim.length == 0) {
                if (Character.isWhitespace(string.charAt(index))) {
                    lengthToKeep = index;
                    removeChar = true;
                }
            } else {
                for (int trimCharIndex = 0; trimCharIndex < charsToTrim.length; trimCharIndex++) {
                    if (string.charAt(index) == charsToTrim[trimCharIndex]) {
                        lengthToKeep = index;
                        removeChar = true;
                        break;
                    }
                }
            }
            if (!removeChar)
                break;
        }
        return string.substring(0, lengthToKeep);
    }

    /**
     * 将 object 转成 dhmlxGrid的json
     * @param idname ID 属性名 要小写
     * @param column 要生成属性名称 用,分开 要小写
     * @param _lo 类
     * @param isedt
     * @return
     */
    public static String ToDhmlxGridJson(String idname, String column, Object _lo, Boolean isedt) {
        try {
            String rowjson = "";
            String idjson = "";
            String[] arr = column.split("[,]", -1);
            rowjson = "\"data\":[";
            idjson = "";
            Class t = _lo.getClass();

            //获取属性列表
            Field[] fields = _lo.getClass().getDeclaredFields();
            String[] fieldNames = new String[fields.length];
            if (idname.equals("newid")) {
                idjson = "{\"id\":\"" + UUID.randomUUID().toString() + "\",";
            } else {
                for (int i = 0; i < fields.length; i++) {
                    if (idname.equals(fields[i].getName().toLowerCase())) {
                        idjson = "{\"id\": \"" + getFieldValueByName(fields[i].getName(), _lo) + "\",";
                        break;
                    }
                }
            }
            for (int i = 0; i < arr.length; i++) {
                for (int j = 0; j < fields.length; j++) {
                    if (arr[i].equals(fields[j].getName().toLowerCase())) {
                        rowjson += "\"" + (getFieldValueByName(fields[j].getName(), _lo) != null
                                ? getFieldValueByName(fields[j].getName(), _lo).toString().
                                replace("[", "【").replace("]", "】").replace("{", "【").replace("}", "】")
                                .replace("\"", "“").replace(",", "，").replace("\r", "").replace("\n", "") : "") + "\",";
                        break;
                    }
                }
            }
            if (isedt) {
                rowjson += "\"\",";
            }
            return idjson + trimEnd(rowjson, ',') + "]},"; // "rows: [" + gridjosn.TrimEnd(',') + "]";
        } catch (Exception ex) {
            logger.error(ex.getMessage(),ex);
            String result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            return result;
        }
    }
    public static Object getFieldValueByName(String fieldName, Object o) {
        try {
            String firstLetter = fieldName.substring(0, 1).toUpperCase();
            String getter = "get" + firstLetter + fieldName.substring(1);
            Method method = o.getClass().getMethod(getter, new Class[]{});
            Object value = method.invoke(o, new Object[]{});
            return value;
        } catch (Exception e) {
            return null;
        }
    }
    /**
     * 将 Map 转成 dhmlxGrid的json
     * @param idname ID 属性名 要小写
     * @param column 要生成属性名称 用,分开 要小写
    //     * @param _lo 类
     * @param isedt
     * @return
     */
    public static String ToDhmlxGridJson(String idname, String column, Map map, Boolean isedt) {
        try {
            String rowjson = "";
            String idjson = "";
            String[] arr = column.split("[,]", -1);
            rowjson = "\"data\":[";
            idjson = "";

            if (idname.equals("newid")) {
                idjson = "{\"id\":\"" + UUID.randomUUID().toString() + "\",";
            } else {
                //获取属性列表
                Iterator it = map.keySet().iterator();
                while(it.hasNext()){
                    String key =it.next().toString();
                    String value=(String) map.get(key);
                    if (idname.equals(key.toLowerCase())) {
                        idjson = "{\"id\": \"" + value + "\",";
                        break;
                    }
                }
            }
            for (int i = 0; i < arr.length; i++) {
                //获取属性列表
                Iterator it = map.keySet().iterator();
                while(it.hasNext()){
                    String key = it.next().toString();
                    String value = (String) map.get(key);
                    if (arr[i].equals(key.toLowerCase())) {
                        rowjson += "\"" + (value != null
                                ? value.
                                replace("[", "【").replace("]", "】").replace("{", "【").replace("}", "】")
                                .replace("\"", "“").replace(",", "，").replace("\r", "").replace("\n", "") : "") + "\",";
                        break;
                    }
                }
            }
            if (isedt) {
                rowjson += "\"\",";
            }
            return idjson + trimEnd(rowjson, ',') + "]},"; // "rows: [" + gridjosn.TrimEnd(',') + "]";
        } catch (Exception ex) {
            String result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"" + ex.getMessage().replace("\r", "").replace("\n", "") + "}";
            return result;
        }
    }
}
