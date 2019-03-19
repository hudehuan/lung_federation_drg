package com.dldata.drgs.utils;

import com.alibaba.fastjson.serializer.SerializerFeature;
import com.dldata.drgs.businessmodel.Token;
import net.sf.ezmorph.bean.MorphDynaBean;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by Administrator on 2017-03-10.
 */
public class TokenUtil {

    private final static DesUtil desUtil = DesUtil.getDesUtil(Public.TOKEN_PRINCIPALNAME, Public.TOKEN_KEYPASSWORD);

    public static String createTokenString(Token token){
        return desUtil.encrypt(JSONSerializer.toJSON(token).toString());
    }

    /**
     * token解析失败
     * @param token
     * @return
     */
    public static Token fromTokenString(String token){

        MorphDynaBean bean=null;
        try{
            String tokenOrg= desUtil.decrypt(token);
            bean=(MorphDynaBean)JSONSerializer.toJava(JSONObject.fromObject(tokenOrg));
        }catch (Throwable e){
            return null;
        }

        if(bean==null||bean.get("st")==null||bean.get("et")==null||bean.get("uid")==null){
            return null;
        }

        Token tokenObj = new Token();
        tokenObj.setSt((int)bean.get("st"));
        tokenObj.setEt((int) bean.get("et"));
        tokenObj.setUid((String)bean.get("uid"));
        tokenObj.setUnm(bean.get("unm")==null?"":bean.get("unm").toString());
        tokenObj.setCid(bean.get("cid")==null?"":bean.get("cid").toString());
        tokenObj.setPlan(bean.get("plan")==null?"":bean.get("plan").toString());
        return tokenObj;
    }

    public static void main(String args[])  throws  Exception{
        Map<String,Object> token = new HashMap<>();
        token.put("st",System.currentTimeMillis()/1000);
        token.put("et",System.currentTimeMillis()/1000);
        token.put("uid", MD5Util.MD5Encoder("1"));
        token.put("unm", MD5Util.MD5Encoder("1"));
        token.put("cid", MD5Util.MD5Encoder("1"));

        String s = JSONSerializer.toJSON(token).toString();

        System.out.println(s);

        MorphDynaBean bean=(MorphDynaBean)JSONSerializer.toJava(JSONObject.fromObject(s));
        bean.get("st");

        System.out.println(JSONSerializer.toJava(JSONObject.fromObject(s)).getClass());

        Token tokenObj = new Token();
        tokenObj.setSt((int) (System.currentTimeMillis() / 1000));
        tokenObj.setEt((int) (System.currentTimeMillis() / 1000));
        tokenObj.setUid("uid");
        tokenObj.setUnm("unm");
        tokenObj.setCid("cid");
        tokenObj.setPlan("plan");
        String tokenString = createTokenString(tokenObj);
        System.out.println(tokenString);
        System.out.println(tokenString.length());
        System.out.println(fromTokenString(tokenString).getUid());

        String sstr = com.alibaba.fastjson.JSONObject.toJSONString(token);
        com.alibaba.fastjson.JSONObject.parseObject(s, new HashMap<String, Object>().getClass());


//        Map<String, Object> data= NetEasyIm.getNetEasyIm().userCreateAction(MD5Util.MD5Encoder("trst123456").substring(0,20));

//        System.out.println(data);

//        System.out.println("+++: "+Long.toString(36,36));
//        Long.toString(100000, 16);
//        for (long i = Long.parseLong("100000",36); i <= Long.parseLong("100010",36); i++) {
//            System.out.println("+++: "+Long.toString(i,36));
//        }

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("msg", "配置信息获取！");
        result.put("imgurl",123);
        result.put("imgurl1",tokenObj);
        System.out.println(com.alibaba.fastjson.JSON.toJSONString(result, SerializerFeature.PrettyFormat));


        long lastInviteCode = Long.parseLong("10007s",36);
        String inviteStr = Long.toString(lastInviteCode, 36);
        StringBuilder sb =new StringBuilder();
        for (int i = inviteStr.length()-1;i>=0;i--){
            sb.append(inviteStr.charAt(i));
        }
        System.out.println("inviteStr: "+sb.toString());

        Calendar ca = Calendar.getInstance();
        ca.set(Calendar.HOUR_OF_DAY,0);
        ca.set(Calendar.MINUTE,0);
        ca.set(Calendar.SECOND,0);
        System.out.println(DateUtil.formatFromDate(DateUtil.FORMATER_YYYY_MM_DD_HH_MM_SS, ca.getTime()));


//        System.out.println(OrderUtil.createFreeinquiryOrderNumber(null));


        File jpegFile = new File("C:\\Users\\Administrator.DLPC-PC\\Desktop\\QQ图片20170511101429.jpg");
//        Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
//        for (Directory directory : metadata.getDirectories()) {
//            for (Tag tag : directory.getTags()) {
//                System.out.format("[%s] - %s = %s",
//                        directory.getName(), tag.getTagName(), tag.getDescription());
//            }
//            System.out.println();
//            System.out.println(directory.getName());
//            System.out.println();
//            if (directory.hasErrors()) {
//                for (String error : directory.getErrors()) {
//                    System.err.format("ERROR: %s", error);
//                    System.out.println();
//                }
//            }
//        }

        jpegFile = new File("C:\\Users\\Administrator.DLPC-PC\\Desktop\\QQ图片20170511095755.jpg");
//        Metadata metadata1 = JpegMetadataReader.readMetadata(jpegFile);
//        Directory exif1 = metadata1.getFirstDirectoryOfType(ExifIFD0Directory.class);
//        Iterator tags1 = exif1.getTags().iterator();
//        while (tags1.hasNext()) {
//            Tag tag = (Tag)tags1.next();
//            System.out.println(tag);
//        }


    }


}
