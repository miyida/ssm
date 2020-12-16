package com.wy.service.impl;

import com.wy.contants.RedisConstants;
import com.wy.dao.SysGroupRuleMapper;
import com.wy.dao.SysRuleMapper;
import com.wy.dao.SysUserGroupMapper;
import com.wy.entity.DataModel;
import com.wy.entity.SysGroupRule;
import com.wy.entity.SysRule;
import com.wy.entity.SysUserGroup;
import com.wy.service.SysUserGroupService;
import com.wy.util.AuthTreeUtil;
import com.wy.util.TreeUtil;
import com.wy.vo.AuthTreeVo;
import com.wy.vo.MenuVo;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysUserGroupServiceImpl implements SysUserGroupService {

	@Resource
	private SysUserGroupMapper groupMapper;
	@Resource
	private SysRuleMapper ruleMapper;
	@Resource
	private SysGroupRuleMapper groupRuleMapper;


	
	@Override
	public List<SysUserGroup> getAll(SysUserGroup group) {
		List<SysUserGroup> groups = groupMapper.selectByParam(group);
		return groups;
	}

	@Override
	public SysUserGroup addGroup(SysUserGroup group) {
		groupMapper.insertSelective(group);
		return group;
	}

	@Override
	public int updGroup(SysUserGroup group) {
		int updateByPrimaryKeySelective = groupMapper.updateByPrimaryKeySelective(group);
		return updateByPrimaryKeySelective;
	}

	@Override
	public void delete(SysUserGroup group) {
		groupMapper.deleteByPrimaryKey(group.getId());
	}

	@Override
	public SysUserGroup getUserGroup(SysUserGroup group) {
		SysUserGroup sysUserGroup = groupMapper.selectByPrimaryKey(group.getId());
		return sysUserGroup;
	}

	/* (non-Javadoc)
	 * @see com.wy.service.SysUserGroupService#getGroupAuth()
	 */
	@Override
	public Map<String,Object> getGroupAuth(Integer groupId) {
		List<AuthTreeVo> authTreeVos = new ArrayList<AuthTreeVo>();
		//查询所有的菜单
		List<SysRule> rules = ruleMapper.selectAll();
		//根据当前用户组ID获取当前用户组的菜单
		List<SysGroupRule> groupRules = groupRuleMapper.getGroupRuleByGroupId(groupId);
		//两个菜单进行比较,若用户组的权限包含某个菜单,则将该菜单设置为选中
		//将菜单封装成layUi的需求数据模型
		for (SysRule rule : rules) {
			AuthTreeVo e = new AuthTreeVo();
			e.setId(rule.getId());
			e.setPid(rule.getParentId());
			e.setValue(rule.getId().toString());
			e.setName(rule.getRname());
			
			//将当前对象与用户中的菜单ID进行比较
			for(SysGroupRule groupRule : groupRules) {
				if(groupRule.getRuleId().equals(rule.getId())) {
					e.setChecked(true);
				}
			}
			authTreeVos.add(e);
		}
		
		//将创建好的菜单数据模型遍历成树形列表
		List<AuthTreeVo> tree = AuthTreeUtil.toTree(authTreeVos, 0);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("trees", tree);
		
		return map;
	}

	/* (non-Javadoc)
	 * @see com.wy.service.admin.SysUserGroupService#saveAuth(java.lang.Integer[], java.lang.Integer)
	 */
	@Override
	public DataModel saveAuth(Integer[] grids, Integer groupId) {
		//删除当前用户组对应的菜单ID
		groupRuleMapper.delRulesByGroupId(groupId);
		//将传递过来的菜单id一一保存
		for(Integer grid : grids) {
			groupRuleMapper.insert(new SysGroupRule(groupId,grid));
		}
        reloadMenu(groupId);
		return new DataModel<>();
	}

    @Override
	public String reloadMenu(Integer groupId){
		//使用用户组的权限菜单left join 菜单表
		List<SysRule> selectAll = ruleMapper.selectRuleByGroupId(groupId);

		Map<String, Object> map = new HashMap<>(16);
		Map<String, Object> home = new HashMap<>(16);
		Map<String, Object> logo = new HashMap<>(16);
		List<MenuVo> menus = new ArrayList<MenuVo>();
		//将菜单封装成layUi的需求数据模型
		for (SysRule rule : selectAll) {
			MenuVo menuVo = new MenuVo();
			menuVo.setId(rule.getId());
			menuVo.setPid(rule.getParentId());
			menuVo.setIcon(rule.getPic());
			menuVo.setTitle(rule.getRname());
			menuVo.setHref(rule.getUrl());
			menus.add(menuVo);
		}
		//使用map创建菜单的基础数据
		home.put("title", "首页");
		home.put("href", "/page/welcome-1");// 控制器路由,自行定义
		logo.put("title", "后台管理系统");
		logo.put("image", "/resources/layui/images/back.jpg");// 静态资源文件路径,可使用默认的logo.png
		Map<String, Object> homeInfo = new HashMap<>(16);
		homeInfo.put("title", "首页");
		homeInfo.put("href", "/");
		Map<String, Object> logoInfo = new HashMap<>(16);
		logoInfo.put("title", "HiCDMA");
		logoInfo.put("image", "/resources/layui/images/logo.png");
		map.put("homeInfo", homeInfo);
		map.put("logoInfo", logoInfo);

		//将创建好的菜单数据模型遍历成树形列表
		List<MenuVo> tree = TreeUtil.toTree(menus, 0);
		MenuVo menuvo = new MenuVo();
		menuvo.setTitle("管理系统");
		menuvo.setIcon("fa fa-address-book");
		menuvo.setTarget("_self");
		menuvo.setChild(tree);
		List<MenuVo> menuInfo = new ArrayList<MenuVo>();
		menuInfo.add(menuvo);
		map.put("menuInfo", menuInfo);
		String menuStr = JSON.toJSONString(map);
		return menuStr;
	}
}
