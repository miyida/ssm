package com.wy.controller;

import com.wy.entity.DataModel;
import com.wy.entity.SysUserGroup;
import com.wy.service.SysUserGroupService;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 用户组管理
 * @author Albert
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/admin/group")
public class SysUserGroupController {

	
	@Resource
	private SysUserGroupService sysUserGroupService;
	

	
	//列表页面
	@RequestMapping("/listPage")
	public String listPage() {
		return "admin/group/groupList";
	}
	
	//编辑页面
	@RequestMapping("/editPage")
	public String editPage() {
		return "admin/group/editGroup";
	}
	
	//权限设置页面
	@RequestMapping("/authTreePage")
	public String authTreePage() {
		return "admin/group/authtree";
	}
	
	/**
	 * 列表查询
	 * @param page 当前页面
	 * @param limit 每页条数
	 * @param searchParams 搜索条件[json格式]
	 * @return
	 */
	@RequestMapping("/all")
	@ResponseBody
	public DataModel findAll(int page, int limit,String searchParams){
		SysUserGroup userGroup = JSON.parseObject(searchParams, SysUserGroup.class);
		PageHelper.startPage(page, limit);
		List<SysUserGroup> all = sysUserGroupService.getAll(userGroup);
		PageInfo<SysUserGroup> pageInfo = new PageInfo<>(all);
		return new DataModel<>(pageInfo);
	}
	
	
	/**
	 * 编辑. 新增/修改 当ID存在则是修改,不存在则是编辑
	 * @param group
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public DataModel editUserGroup(SysUserGroup group) {
		DataModel dataModel = new DataModel<>();
		try {
			if(group.getId() == null) {
				sysUserGroupService.addGroup(group);
			}else {
				sysUserGroupService.updGroup(group);
			}
		} catch (Exception e) {
			dataModel.setCode(500);
			dataModel.setMsg("操作异常!");
		}
		return dataModel;
	}
	
	/**
	 * 根据传入的字段查询唯一对象. 当前适用于根据ID查询
	 * @param group
	 * @return
	 */
	@RequestMapping("/get")
	@ResponseBody
	public SysUserGroup getUserGroup(SysUserGroup group) {
		SysUserGroup userGroup = sysUserGroupService.getUserGroup(group);
		return userGroup;
	}
	
	/**
	 * 修改状态  
	 * @param type 1:启用 0:禁用
	 * @param group
	 * @return
	 */
	@RequestMapping("/updStatus")
	@ResponseBody
	public DataModel updStatus(Integer type,SysUserGroup group) {
		if(type == 0) { //禁用
			SysUserGroup sysUserGroup = new SysUserGroup();
			sysUserGroup.setId(group.getId());
			sysUserGroup.setStatus(0);
			sysUserGroupService.updGroup(sysUserGroup);
		}else { //启用
			SysUserGroup sysUserGroup = new SysUserGroup();
			sysUserGroup.setId(group.getId());
			sysUserGroup.setStatus(1);
			sysUserGroupService.updGroup(sysUserGroup);
		}
		return new DataModel<>();
	}
	
	/**
	 * 获取用户组的权限菜单树
	 * @return
	 */
	@RequestMapping("/auth/tree")
	@ResponseBody
	public DataModel authTree(Integer groupId) {
		Map<String,Object> groupAuth = sysUserGroupService.getGroupAuth(groupId);
		DataModel<Map<String,Object>> dataModel = new DataModel<>();
		dataModel.setData(groupAuth);
		return dataModel;
	}
	
	/**
	 * 保存用户组的权限
	 * @param grids
	 * @param groupId
	 * @return
	 */
	@RequestMapping("/auth/save")
	@ResponseBody
	public DataModel saveAuth(@RequestParam(value="grids[]")Integer[] grids,Integer groupId) {
		//保存用户和菜单集合列表,每次保存前都需要删除现有用户所有的菜单
		//1.根据用户组id删除该用户组所有的纪录
		//2.将所有的grids保存到数据库中
		//3.将当前用户组的菜单生成并保存至redis
		DataModel saveAuth = sysUserGroupService.saveAuth(grids, groupId);
		return saveAuth;
	}
	
	@RequestMapping("/selectOption")
	@ResponseBody
	public DataModel getGroupOptions(){
		SysUserGroup userGroup = new SysUserGroup();
		//查询有效的用户组
		userGroup.setStatus(1);
		List<SysUserGroup> all = sysUserGroupService.getAll(userGroup);
		return new DataModel(all);
	}
	
	
}
