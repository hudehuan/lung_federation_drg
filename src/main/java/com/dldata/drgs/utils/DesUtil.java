package com.dldata.drgs.utils;

/**
 * Created by 倪继文 on 2017/3/10.
 */


import net.sf.json.JSONSerializer;
import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.security.auth.kerberos.KerberosKey;
import javax.security.auth.kerberos.KerberosPrincipal;
import java.security.Key;
import java.util.HashMap;
import java.util.Map;


public class DesUtil {

    /**
     * 产生key的主体名称
     * 参考命名格式xxx@xx.xxx其他命名格式参考Java Cryptography Architecture API Specification & Reference 中的附录 A
     */
    private String principalName = "uceeehen@sinacom";

    /**
     * key的密码
     */
    private String keyPassword = "njscom";

    /**
     *
     */
    private Key key;

    public static DesUtil getDesUtil(String principalName, String keyPassword){
        return new DesUtil(principalName,keyPassword);
    }

    private DesUtil(String principalName, String keyPassword) {
        this.keyPassword=keyPassword;
        this.principalName=principalName;
        KerberosPrincipal kerberosPrincipal = new KerberosPrincipal(this.principalName);
        key = new KerberosKey(kerberosPrincipal, this.keyPassword.toCharArray(),"DES");
    }

    /**
     * DES加密字符串，返回加密后的字符串
     *
     * @param encryptString
     *            要加密的字符串
     * @return 返回base64转码后的字符串
     * @throws java.security.InvalidKeyException
     * @throws java.security.NoSuchAlgorithmException
     * @throws javax.crypto.NoSuchPaddingException
     * @throws java.io.UnsupportedEncodingException
     * @throws javax.crypto.IllegalBlockSizeException
     * @throws javax.crypto.BadPaddingException
     */
    public  String encrypt(String encryptString) {
        try {
            Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
            byte[] by = encryptString.getBytes("utf8");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] cipherText = cipher.doFinal(by);
            return Base64.encodeBase64URLSafeString(cipherText);
        } catch (Exception e) {
            //Log.error(e);
            e.printStackTrace();
            return encryptString;
        }
    }

    /**
     * DES解密字符串
     *
     * @param
     * @return
     * @throws java.security.NoSuchAlgorithmException
     * @throws javax.crypto.NoSuchPaddingException
     * @throws java.io.UnsupportedEncodingException
     * @throws java.security.InvalidKeyException
     * @throws javax.crypto.IllegalBlockSizeException
     * @throws javax.crypto.BadPaddingException
     */
    public  String decrypt(String decryptString) {
        try {
            Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
            byte[] by = Base64.decodeBase64(decryptString);
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] cipherText = cipher.doFinal(by);
            return new String(cipherText, "utf-8");
        } catch (Exception e) {
            return decryptString;
        }
    }

    public static void main(String args[]) {
        try {
            Map<String,Object> token = new HashMap<>();
            token.put("st",System.currentTimeMillis()/1000);
            token.put("et",System.currentTimeMillis()/1000);
            token.put("uid", MD5Util.MD5Encoder("1"));
            token.put("unm", MD5Util.MD5Encoder("1"));
            token.put("cid", MD5Util.MD5Encoder("1"));

            String s = JSONSerializer.toJSON(token).toString();

            DesUtil desutil= DesUtil.getDesUtil(Public.TOKEN_PRINCIPALNAME, Public.TOKEN_KEYPASSWORD);

            // 需要加密的字符串
            String str =s;// "yuchen352416";
            System.out.println(str);
            // 加密后的字符串
            String eStr = desutil.encrypt(str);
            // 解密已经加密的字符串
            String dStr = desutil.decrypt(eStr);
            System.out.println(eStr);
            System.out.println(dStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
