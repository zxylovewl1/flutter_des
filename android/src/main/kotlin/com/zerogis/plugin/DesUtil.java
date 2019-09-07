package com.zerogis.plugin;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

/*
 * 类描述：Des加密解密
 * 作者：郑朝军 on 2019/4/29
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/4/29
 * 修改备注：
 */
public class DesUtil
{
    private static String password = "WUHANZHIBOCHUANGXIANG";//默认密钥

    public static void main(String[] args)
    {
//        {'_major': 98, '_minor': 23, 'cmd': 'query', 'sessionid': '7D2907E8DF8E6A200CF985ED6AB5536D', 'count': 2});
        setPassword("7D2-whzbc");
        String majorMinorCmd = "cmd=query&_major=98&_minor=23";
        System.out.println(DesUtil.encrypt(majorMinorCmd));
    }

    public static void setPassword(String psd)
    {
        password = psd;
    }

    /**
     * @param data
     * @return
     * @throws Exception
     * @Method: DES 加密
     * @Description: 加密数据
     * @date 2016年7月26日
     */
    public static String encrypt(String data)
    {
        String strs = null;
        try
        {
            //对string进行BASE64Encoder转换
            byte[] bt = encryptByKey(data.getBytes("UTF-8"), password);
            strs = new String(Base64.encode(bt));
        }
        catch (Exception e)
        {
        }

        return strs;
    }

    /**
     * @param data
     * @return
     * @throws Exception
     * @Method: encrypt
     * @Description: 解密数据
     * @date 2016年7月26日
     */
    public static String decryptor(String data) throws Exception
    {
        //对string进行BASE64Encoder转换
        byte[] bt = decrypt(Base64.decode(data), password);
        String strs = new String(bt, "UTF-8");
        return strs;
    }

    /**
     * 加密
     *
     * @param data byte[]
     * @param key String
     * @return byte[]
     */
    public static byte[] encryptByKey(byte[] data, String key) throws Exception
    {
        SecureRandom random = new SecureRandom();

        DESKeySpec desKey = new DESKeySpec(key.getBytes());
        //创建一个密匙工厂，然后用它把DESKeySpec转换成
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey securekey = keyFactory.generateSecret(desKey);
        //Cipher对象实际完成加密操作
        Cipher cipher = Cipher.getInstance("DES");
        //用密匙初始化Cipher对象
        cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
        //现在，获取数据并加密
        //正式执行加密操作
        return cipher.doFinal(data);
    }

    /**
     * 解密
     *
     * @param src byte[]
     * @param key String
     * @return byte[]
     * @throws Exception
     */
    public static byte[] decrypt(byte[] src, String key) throws Exception
    {
        // DES算法要求有一个可信任的随机数源
        SecureRandom random = new SecureRandom();
        // 创建一个DESKeySpec对象
        DESKeySpec desKey = new DESKeySpec(key.getBytes());
        // 创建一个密匙工厂
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        // 将DESKeySpec对象转换成SecretKey对象
        SecretKey securekey = keyFactory.generateSecret(desKey);
        // Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance("DES");
        // 用密匙初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, random);
        // 真正开始解密操作
        return cipher.doFinal(src);
    }
}
