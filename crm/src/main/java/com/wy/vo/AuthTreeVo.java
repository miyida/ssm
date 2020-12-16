package com.wy.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限树模型-->对应layui-tree插件
 * @author Albert
 */
public class AuthTreeVo {
	private Integer id; //菜单ID
	private Integer pid; //菜单父ID
	private String name; //权限名称
	private String value;  //路径
	private Boolean checked = false; //是否选中
	private Boolean disabled = false; //是否禁用
	private List<AuthTreeVo> list = new ArrayList(0); //子节点
	
	
	/**
	 * @return the pid
	 */
	public Integer getPid() {
		return pid;
	}
	/**
	 * @param pid the pid to set
	 */
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * @return the checked
	 */
	public Boolean getChecked() {
		return checked;
	}
	/**
	 * @param checked the checked to set
	 */
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	/**
	 * @return the disabled
	 */
	public Boolean getDisabled() {
		return disabled;
	}
	/**
	 * @param disabled the disabled to set
	 */
	public void setDisabled(Boolean disabled) {
		this.disabled = disabled;
	}
	/**
	 * @return the list
	 */
	public List<AuthTreeVo> getList() {
		return list;
	}
	/**
	 * @param list the list to set
	 */
	public void setList(List<AuthTreeVo> list) {
		this.list = list;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AuthTreeVo [name=" + name + ", value=" + value + ", checked=" + checked + ", disabled=" + disabled
				+ ", list=" + list + "]";
	}
	public AuthTreeVo(String name, String value, Boolean checked, Boolean disabled, List<AuthTreeVo> list) {
		super();
		this.name = name;
		this.value = value;
		this.checked = checked;
		this.disabled = disabled;
		this.list = list;
	}
	public AuthTreeVo() {
		super();
	}
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
}
