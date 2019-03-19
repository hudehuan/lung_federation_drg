package com.dldata.drgs.utils;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 倪继文 on 2017/2/28.
 */
public class StringUtil extends StringUtils {

    /**
     * 本方法封装了往前台设置的header,contentType等信息
     * @param message			需要传给前台的数据
     * @param type				指定传给前台的数据格式,如"html","json"等
     * @param response			HttpServletResponse对象
     * @throws IOException
     * @createDate 2010-12-31 17:55:41
     */
    public static void writeToWeb(String message, String type, HttpServletResponse response) throws IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setContentType("text/" + type +"; charset=utf-8");
        response.getWriter().write(message);
        response.getWriter().close();
    }



    // 将汉字转换为全拼
    public static String getPingYin(String src) {

        char[] t1 = null;
        t1 = src.toCharArray();
        String[] t2 = new String[t1.length];
        HanyuPinyinOutputFormat t3 = new HanyuPinyinOutputFormat();
        t3.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        t3.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        t3.setVCharType(HanyuPinyinVCharType.WITH_V);
        String t4 = "";
        int t0 = t1.length;
        try {
            for (int i = 0; i < t0; i++) {
                // 判断是否为汉字字符
                if (Character.toString(t1[i]).matches(
                        "[\\u4E00-\\u9FA5]+")) {
                    t2 = PinyinHelper.toHanyuPinyinStringArray(t1[i], t3);
                    t4 += t2[0];
                } else
                    t4 += Character.toString(t1[i]);
            }
            // System.out.println(t4);
            return t4;
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return t4;
    }

    // 返回中文的首字母
    public static String getPinYinHeadChar(String str) {
        String temp = "";
        String demo = "";
        String convert = "";
        for (int j = 0; j < str.length(); j++) {
            char word = str.charAt(j);
            String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
            if (pinyinArray != null) {
                convert += pinyinArray[0].charAt(0);
            } else {
                convert += word;
            }
        }
        for(int i=0;i<convert.length();i++){//convert目前为小写首字母,下面是将小写首字母转化为大写
            if(convert.charAt(i)>='a' && convert.charAt(i)<='z'){
                temp=convert.substring(i,i+1).toUpperCase();
                demo += temp;
            }
        }
        return demo;
    }


    /**
     * 判断一个字符串是不是空或者为""
     * @param s
     * @return
     */
    public static boolean isNullOrSpace(String s){
        if(null == s || s.length() == 0){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 把Map<String,Object>处理成实体类
     * @param clazz		想要的实体类
     * @param list		包含信息的列表
     * @return
     */
    public static <T> List<T> mapToList(Class<T> clazz, List<Map<String,Object>> list){

        if(null == list || list.size() == 0){
            return null;
        }
        List<T> result = new ArrayList<T>();
        Map<String,Object> map;
        for(Iterator<Map<String,Object>> iter = list.iterator(); iter.hasNext();){
            map = iter.next();
            result.add(mapToObject(clazz, map));
        }
        return result;
    }

    /**
     * 把Map<String,Object>处理成实体类
     * @param clazz		想要的实体类
     * @param p_map		包含信息的Map对象
     * @return
     */
    public static <T> T mapToObject(Class<T> clazz, Map<String,Object> p_map){
        T o = null;
        try {
            o = clazz.newInstance();
        } catch (InstantiationException e1) {
            e1.printStackTrace();
        } catch (IllegalAccessException e1) {
            e1.printStackTrace();
        }
        return mapToObject(clazz, p_map, o);
    }


    /**
     * 把Map<String,Object>处理成实体类
     * @param o		想要的实体类
     * @param p_map		包含信息的Map对象
     * @return
     */
    public static <T> T mapToObject(T o , Map<String,Object> p_map){
        Class<T> clazz = ( Class<T>)o.getClass();
        return mapToObject(clazz, p_map,o);
    }

    private static <T> T mapToObject(Class<T> clazz, Map<String, Object> p_map, T o ) {


        if(null == p_map){
            return null;
        }

        //CaseInsensitiveMap key 不区分大小写
        Map<String, Object> map = new CaseInsensitiveMap();

        map.putAll(p_map);

        Field[] fields = clazz.getDeclaredFields();	//取到所有类下的属性，也就是变量名
        Field field;
        for(int i=0; i<fields.length; i++){
            field = fields[i];
            String fieldName = field.getName();
            //把属性的第一个字母处理成大写
            String stringLetter=fieldName.substring(0, 1).toUpperCase();
            //取得set方法名，比如setBbzt
            String setName="set"+stringLetter+fieldName.substring(1);
            //真正取得get方法。
            Method setMethod = null;
            Class<?> fieldClass = field.getType();
            try {
                Object value = map.get(fieldName);
                if (value != null && String.valueOf(value).trim().length() > 0 && isHaveSuchMethod(clazz, setName)) {
                    if (fieldClass == String.class) {
                        value=unescape(String.valueOf(value));
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o, String.valueOf(value));// 为其赋值
                    } else if (fieldClass == Integer.class || fieldClass == int.class) {
                        value=unescape(String.valueOf(value));
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Integer.parseInt(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Boolean.class || fieldClass == boolean.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Boolean.getBoolean(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Short.class || fieldClass == short.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Short.parseShort(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Byte.class || fieldClass == byte.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Byte.parseByte(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Long.class || fieldClass == long.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Long.parseLong(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Double.class || fieldClass == double.class) {
                        value=unescape(String.valueOf(value));
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Double.parseDouble(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == Float.class || fieldClass == float.class) {
                        value=unescape(String.valueOf(value));
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o,
                                Float.parseFloat(String.valueOf(value)));// 为其赋值
                    } else if (fieldClass == BigInteger.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o, BigInteger.valueOf(Long
                                .parseLong(String.valueOf(value))));// 为其赋值
                    } else if (fieldClass == BigDecimal.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        value=unescape(String.valueOf(value));
                        setMethod.invoke(o, BigDecimal.valueOf(Double
                                .parseDouble(String.valueOf(value))));// 为其赋值
                    } else if(fieldClass == Timestamp.class){
                        String strValue = String.valueOf(value);
                        strValue=strValue.replaceAll("/","-");
                        if(strValue.length()<=12){
                            strValue = strValue + " 00:00:00";
                        }
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o, Timestamp.valueOf(strValue));// 为其赋值
                        //setMethod.invoke(o, new java.sql.Timestamp(date.getTime()));// 为其赋值
                    }else if (fieldClass == Date.class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        if (map.get(fieldName).getClass() == java.sql.Date.class) {
                            setMethod.invoke(o, new Date(
                                    ((java.sql.Date) value).getTime()));// 为其赋值
                        } else if (map.get(fieldName).getClass() == java.sql.Time.class) {
                            setMethod.invoke(o, new Date(
                                    ((java.sql.Time) value).getTime()));// 为其赋值
                        }
                    } else if(fieldClass == List.class){

                    }
                }
            } catch (Exception e) {
            }

        }
        return o;
    }


    public static <T> T requestToObject(HttpServletRequest request, Class<T> clazz){

        if(null == request){
            return null;
        }

        Field[] fields = clazz.getDeclaredFields();	//取到所有类下的属性，也就是变量名
        Field field;
        T o = null;
        try {
            o = clazz.newInstance();
        } catch (InstantiationException e1) {
            e1.printStackTrace();
        } catch (IllegalAccessException e1) {
            e1.printStackTrace();
        }
        for(int i=0; i<fields.length; i++){
            field = fields[i];
            String fieldName = field.getName();
            //把属性的第一个字母处理成大写
            String stringLetter=fieldName.substring(0, 1).toUpperCase();
            //取得set方法名，比如setBbzt
            String setName="set"+stringLetter+fieldName.substring(1);
            //真正取得get方法。
            Method setMethod = null;
            Class<?> fieldClass = field.getType();
            try {
                Object value = request.getParameter(fieldName);
                Object valueArray = request.getParameterValues(fieldName);
                if (value != null && isHaveSuchMethod(clazz, setName)) {
                    if(String.valueOf(value).trim().length() > 0){
                        if (fieldClass == String.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o, String.valueOf(value));// 为其赋值
                        } else if (fieldClass == Integer.class || fieldClass == int.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o, Integer.parseInt(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Boolean.class || fieldClass == boolean.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o,
                                    Boolean.getBoolean(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Short.class || fieldClass == short.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o,
                                    Short.parseShort(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Long.class || fieldClass == long.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o,
                                    Long.parseLong(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Double.class || fieldClass == double.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o,
                                    Double.parseDouble(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Float.class || fieldClass == float.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o,
                                    Float.parseFloat(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == BigInteger.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o, BigInteger.valueOf(Long
                                    .parseLong(String.valueOf(value))));// 为其赋值
                        } else if (fieldClass == BigDecimal.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(o, BigDecimal.valueOf(Double
                                    .parseDouble(String.valueOf(value))));// 为其赋值
                        } else if (fieldClass == Date.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            String tempValue = value.toString();
                            Date tempDate = null;
                            // 根据字符串长度确定要用何种形式转换
                            if (tempValue.length() > 0 && tempValue.length() < 12) {
                                tempDate = DateUtil.StringToDate(value.toString(),
                                        DateUtil.FORMATER_YYYY_MM_DD);
                            } else if (tempValue.length() >= 13
                                    && tempValue.length() < 21) {
                                tempDate = DateUtil.StringToDate(value.toString(),
                                        DateUtil.FORMATER_YYYY_MM_DD_HH_MM_SS);
                            }
                            // 如果转换成功了，就赋值，如果不成功就让它空着吧。
                            if (null != tempDate) {
                                setMethod.invoke(o, tempDate);// 为其赋值
                            }
                        }
                    }else{
                        Object oo = null;
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o, oo);// 为其赋值
                    }

                }
                if (valueArray != null && isHaveSuchMethod(clazz, setName)) {
                    if (fieldClass == String[].class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(o, value == null ? null : valueArray);// 为其赋值
                    }
                }
            } catch (Exception e) {
            }

        }
        return o;
    }
    /**
     * 自动将传过来的参数放到实体，本方法仅适用于修改页面
     * 本方法会把接到的空字符串也set进实体
     * @param request
     * @param entity
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T> T requestToObject(HttpServletRequest request, T entity){

        if(null == request || null == entity){
            return null;
        }
        Class<T> clazz = (Class<T>) entity.getClass();
        Field[] fields = clazz.getDeclaredFields();	//取到所有类下的属性，也就是变量名
        Field field;
        for(int i=0; i<fields.length; i++){
            field = fields[i];
            String fieldName = field.getName();
            //把属性的第一个字母处理成大写
            String stringLetter=fieldName.substring(0, 1).toUpperCase();
            //取得set方法名，比如setBbzt
            String setName="set"+stringLetter+fieldName.substring(1);
            //真正取得get方法。
            Method setMethod = null;
            Class<?> fieldClass = field.getType();
            try {
                Object value = request.getParameter(fieldName);
                Object valueArray = request.getParameterValues(fieldName);
                if (value != null && isHaveSuchMethod(clazz, setName)) {
                    if(String.valueOf(value).trim().length() > 0){
                        if (fieldClass == String.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity, String.valueOf(value));// 为其赋值
                        } else if (fieldClass == Integer.class || fieldClass == int.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity, Integer.parseInt(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Boolean.class || fieldClass == boolean.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity,
                                    Boolean.getBoolean(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Short.class || fieldClass == short.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity,
                                    Short.parseShort(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Long.class || fieldClass == long.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity,
                                    Long.parseLong(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Double.class || fieldClass == double.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity,
                                    Double.parseDouble(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == Float.class || fieldClass == float.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity,
                                    Float.parseFloat(String.valueOf(value)));// 为其赋值
                        } else if (fieldClass == BigInteger.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity, BigInteger.valueOf(Long
                                    .parseLong(String.valueOf(value))));// 为其赋值
                        } else if (fieldClass == BigDecimal.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            setMethod.invoke(entity, BigDecimal.valueOf(Double
                                    .parseDouble(String.valueOf(value))));// 为其赋值
                        } else if (fieldClass == Date.class) {
                            setMethod = clazz.getMethod(setName, fieldClass);
                            String tempValue = value.toString();
                            Date tempDate = null;
                            // 根据字符串长度确定要用何种形式转换
                            if (tempValue.length() > 0 && tempValue.length() < 12) {
                                tempDate = DateUtil.StringToDate(value.toString(),
                                        DateUtil.FORMATER_YYYY_MM_DD);
                            } else if (tempValue.length() >= 13
                                    && tempValue.length() < 21) {
                                tempDate = DateUtil.StringToDate(value.toString(),
                                        DateUtil.FORMATER_YYYY_MM_DD_HH_MM_SS);
                            }
                            // 如果转换成功了，就赋值，如果不成功就让它空着吧。
                            if (null != tempDate) {
                                setMethod.invoke(entity, tempDate);// 为其赋值
                            }
                        }
                    }else{
                        Object oo = null;
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(entity, oo);// 为其赋值
                    }

                }
                if (valueArray != null && isHaveSuchMethod(clazz, setName)) {
                    if (fieldClass == String[].class) {
                        setMethod = clazz.getMethod(setName, fieldClass);
                        setMethod.invoke(entity, value == null ? null : valueArray);// 为其赋值
                    }
                }
            } catch (Exception e) {
            }

        }
        return entity;
    }


    /**
     * 判断某个类里是否有某个方法
     * @param clazz
     * @param methodName
     * @return
     */
    public static boolean isHaveSuchMethod(Class<?> clazz, String methodName){
        Method[] methodArray = clazz.getMethods();
        boolean result = false;
        if(null != methodArray){
            for(int i=0; i<methodArray.length; i++){
                if(methodArray[i].getName().equals(methodName)){
                    result = true;
                    break;
                }
            }
        }
        return result;
    }



    public static void beanCopy(Object source, Object target) {

        if (null == source || null == target) {
            return ;
        }


        Class<?> sourceClazz = source.getClass();
        Class<?> targetClazz = target.getClass();
        Field[] fields = targetClazz.getDeclaredFields(); // 取到所有类下的属性，也就是变量名
        Field field;

        for (int i = 0; i < fields.length; i++) {
            field = fields[i];
            String fieldName = field.getName();
            // 把属性的第一个字母处理成大写
            String stringLetter = fieldName.substring(0, 1).toUpperCase();
            // 取得setter方法名，比如setBbzt
            String setName = "set" + stringLetter + fieldName.substring(1);
            // 取得getter方法名
            String getName = "get" + stringLetter + fieldName.substring(1);
            // 真正取得get方法。
            Method setMethod = null;
            // 真正取得set方法
            Method sourceGetMethod = null;

            Class<?> fieldClass = field.getType();
            try {
                if (isHaveSuchMethod(targetClazz, setName)) {
                    setMethod = targetClazz.getMethod(setName, fieldClass);
                    if (isHaveSuchMethod(sourceClazz, getName)) {
                        sourceGetMethod = sourceClazz.getMethod(getName);
                    }
                    Object sourceValue = sourceGetMethod.invoke(source);
                    if (null != sourceValue) {
                        setMethod.invoke(target, sourceValue);// 为其赋值
                    }
                }
            } catch (Exception e) {

            }

        }
        return ;
    }


    /**
     * 将来源对象的值 ，赋给目标对象</br>
     * @param source	来源对象
     * @param target	目标对象
     * @param isCopyNull	如果source中的值为null时，是否将其赋给target对象
     */
    public static void beanCopy(Object source, Object target, boolean isCopyNull) {

        if (null == source || null == target) {
            return ;
        }


        Class<?> sourceClazz = source.getClass();
        Class<?> targetClazz = target.getClass();
        Field[] fields = targetClazz.getDeclaredFields(); // 取到所有类下的属性，也就是变量名
        Field field;

        for (int i = 0; i < fields.length; i++) {
            field = fields[i];
            String fieldName = field.getName();
            // 把属性的第一个字母处理成大写
            String stringLetter = fieldName.substring(0, 1).toUpperCase();
            // 取得setter方法名，比如setBbzt
            String setName = "set" + stringLetter + fieldName.substring(1);
            // 取得getter方法名
            String getName = "get" + stringLetter + fieldName.substring(1);
            // 真正取得get方法。
            Method setMethod = null;
            // 真正取得set方法
            Method sourceGetMethod = null;

            Class<?> fieldClass = field.getType();
            try {
                if (isHaveSuchMethod(targetClazz, setName)) {
                    setMethod = targetClazz.getMethod(setName, fieldClass);
                    if (isHaveSuchMethod(sourceClazz, getName)) {
                        sourceGetMethod = sourceClazz.getMethod(getName);
                    }
                    Object sourceValue = sourceGetMethod.invoke(source);
                    if (null != sourceValue) {
                        setMethod.invoke(target, sourceValue);// 为其赋值
                    }else{
                        if(isCopyNull){
                            setMethod.invoke(target, sourceValue);
                        }
                    }
                }
            } catch (Exception e) {

            }
        }
        return ;
    }



    /**
     * 按照给定的分隔标志，将列表封闭成字符串
     * @param list
     * @param reg
     * @return
     */
    @SuppressWarnings("rawtypes")
    public String join(List list, String reg){
        StringBuffer sb = new StringBuffer();
        if(null == list || list.size() == 0){
            return null;
        }
        for(Iterator iter = list.iterator(); iter.hasNext();){
            sb.append(iter.next()).append(reg);
        }
        int length = sb.length();
        if(length > 0){
            sb = sb.delete(length -1, length);
        }
        return sb.toString();
    }

    /**
     * 生成六位随机数
     * @return
     */
    public static Integer getRandom(){
        Random ran=new Random();
        int r=0;
        m1:while(true){
            int n=ran.nextInt(1000000);
            r=n;
            int[] bs=new int[6];
            for(int i=0;i<bs.length;i++){
                bs[i]=n%10;
                n/=10;
            }
            Arrays.sort(bs);
            for(int i=1;i<bs.length;i++){
                if(bs[i-1]==bs[i]){
                    continue m1;
                }
            }
            break;
        }
        return r;
    }
    /**
     * url字符编码
     * @return
     */
    public static String escape(String src) {
        int i;
        char j;
        StringBuffer tmp = new StringBuffer();
        tmp.ensureCapacity(src.length() * 6);
        for (i = 0; i < src.length(); i++) {
            j = src.charAt(i);
            if (Character.isDigit(j) || Character.isLowerCase(j)
                    || Character.isUpperCase(j))
                tmp.append(j);
            else if (j < 256) {
                tmp.append("%");
                if (j < 16)
                    tmp.append("0");
                tmp.append(Integer.toString(j, 16));
            } else {
                tmp.append("%u");
                tmp.append(Integer.toString(j, 16));
            }
        }
        return tmp.toString();
    }
    /**
     * url字符解码
     * @return
     */
    public static String unescape(String src) {
        StringBuffer tmp = new StringBuffer();
        tmp.ensureCapacity(src.length());
        int lastPos = 0, pos = 0;
        char ch;
        while (lastPos < src.length()) {
            pos = src.indexOf("%", lastPos);
            if (pos == lastPos) {
                if (src.charAt(pos + 1) == 'u') {
                    ch = (char) Integer.parseInt(src
                            .substring(pos + 2, pos + 6), 16);
                    tmp.append(ch);
                    lastPos = pos + 6;
                } else {
                    ch = (char) Integer.parseInt(src
                            .substring(pos + 1, pos + 3), 16);
                    tmp.append(ch);
                    lastPos = pos + 3;
                }
            } else {
                if (pos == -1) {
                    tmp.append(src.substring(lastPos));
                    lastPos = src.length();
                } else {
                    tmp.append(src.substring(lastPos, pos));
                    lastPos = pos;
                }
            }
        }
        return tmp.toString();
    }
   
    public static  Map<String, Object>  unescapeMap(Map<String, Object> param){
        for (Iterator<String> iterator = param.keySet().iterator(); iterator.hasNext(); ) {
            String next =  iterator.next();
            Object value = param.get(next);
            if(value instanceof  String){
                param.put(next,unescape(value.toString()));
            }
        }
        return param;
    }

    public static boolean isEmptyOrLength0(Object param){
        if(param==null){
            return true;
        }
        return param.toString().trim().equalsIgnoreCase("");
    }

}
