package com.wy.service;

import com.wy.entity.DataModel;
import com.wy.entity.SysUserGroup;

import java.util.List;
import java.util.Map;

/**
 * @author Albert
 *
 */
public interface SysUserGroupService {
	
	public List<SysUserGroup> getAll(SysUserGroup group);
	public SysUserGroup addGroup(SysUserGroup group);
	public int updGroup(SysUserGroup group);
	public void delete(SysUserGroup group);
	public SysUserGroup getUserGroup(SysUserGroup group);
	
	/**
	 * 获取用户组的权限菜单
	 * @return
	 */
	public Map<String,Object> getGroupAuth(Integer groupId);
	
	/**
	 * 保存用户组权限
	 * @param grids 菜单id集合
	 * @param groupId 用户组id
	 * @return
	 */
	public DataModel saveAuth(Integer[] grids, Integer groupId);


	/**
	 * 根据用户组重新加载权限(放置缓存)
	 * @param groupId
	 */
	public String reloadMenu(Integer groupId);
}
