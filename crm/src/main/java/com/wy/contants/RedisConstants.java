package com.wy.contants;

/**
 * 存放redis所有的key的前缀
 * @author Albert
 *
 */
public interface RedisConstants {
	/**
	 * 用户信息的key
	 * user_info_10001 存放用户id为10001的 json对象
	 */
	String USER_INFO = "user_info_";
	/**
	 * 用户组的权限字符串key
	 * menu_group_1  存放用户组id为1的权限树字符串
	 */
	String MENU_GROUP = "menu_group_";
}
