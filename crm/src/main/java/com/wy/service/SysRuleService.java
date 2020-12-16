package com.wy.service;


import com.wy.entity.SysRule;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface SysRuleService {

	/**
	 * 获取所有
	 */
	public List<SysRule> getAll();
	
	/**
	 * 获取菜单
	 * @return
	 */
	public Object getMenu(HttpServletRequest request);
}
