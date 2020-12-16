package com.wy.util;

import com.wy.contants.RedisConstants;
import com.wy.entity.SysUser;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * 获取用户信息
 * @author Albert
 *
 */
public class SessionUtil {

	/**
	 * 根据cookie中的用户id获取当前用户信息
	 * @param redis
	 * @param request
	 * @return
	 */
	public static SysUser getUserInfo(RedisService redis, HttpServletRequest request) {
		SysUser sysUser = null;
		Cookie[] cookies = request.getCookies();
		String uid = null;
		for(Cookie k : cookies) {
			if(k.getName().equals("uid")) {
				uid = k.getValue();
			}
		}
		if(StringUtils.isNotEmpty(uid)) {
			String userStr = redis.get(RedisConstants.USER_INFO+uid);
			sysUser = JSON.parseObject(userStr, SysUser.class);
		}
		return sysUser;
	}
}
