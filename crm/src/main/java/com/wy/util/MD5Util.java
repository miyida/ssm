package com.wy.util;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * 
 */
public class MD5Util {

	
	/**
	 * 
	 * @param context
	 * @return
	 */
    public static String encrypByMd5Jar(String context) {  
        String md5Str = DigestUtils.md5Hex(context);
        return md5Str;
    }
    
    public static void main(String[] args) {  
       System.out.println(MD5Util.encrypByMd5Jar("123456"));
    }  
}
