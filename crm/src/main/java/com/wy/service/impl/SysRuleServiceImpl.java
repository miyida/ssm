package com.wy.service.impl;

import com.wy.contants.RedisConstants;
import com.wy.dao.SysRuleMapper;
import com.wy.entity.SysRule;
import com.wy.entity.SysUser;
import com.wy.service.SysRuleService;
import com.wy.service.SysUserGroupService;
import com.wy.util.RedisService;
import com.wy.util.SessionUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class SysRuleServiceImpl implements SysRuleService {

	@Resource
	private SysRuleMapper ruleMapper;
	@Resource
	private RedisService redisService;

	@Resource
    private SysUserGroupService sysUserGroupService;

	public List<SysRule> getAll() {
		return ruleMapper.selectAll();
	}

	@Override
	public Object getMenu(HttpServletRequest request) {
		//通过redis获取当前用户的信息
		SysUser userInfo = SessionUtil.getUserInfo(redisService, request);
		//获取当前用户所在的用户组,并获取对应用户组的菜单权限
		String menuStr = redisService.get(RedisConstants.MENU_GROUP + userInfo.getGroupId());
		//若该用户的用户组权限不存在,则重新加载权限
		if(StringUtils.isEmpty(menuStr)){
		    //刷新权限,并放入缓存
            menuStr = sysUserGroupService.reloadMenu(userInfo.getGroupId());
        }
		//菜单字符串转换为json对象并返回
		JSONObject parseObject = JSON.parseObject(menuStr);

		return parseObject;
	}

}
