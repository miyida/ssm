package com.wy.vo;

import java.io.Serializable;
import java.util.List;

/**
 * 菜单扩展类，方便序列化成Json
 * @author Albert
 *
 */
public class MenuVo implements Serializable{

	private Integer id; //当前id

    private Integer pid; //上级id

    private String title; //标题

    private String icon; //图标

    private String href; //连接地址

    private String target="_self"; 

    private List<MenuVo> child; //子节点

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
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the icon
	 */
	public String getIcon() {
		return icon;
	}

	/**
	 * @param icon the icon to set
	 */
	public void setIcon(String icon) {
		this.icon = icon;
	}

	/**
	 * @return the href
	 */
	public String getHref() {
		return href;
	}

	/**
	 * @param href the href to set
	 */
	public void setHref(String href) {
		this.href = href;
	}

	/**
	 * @return the target
	 */
	public String getTarget() {
		return target;
	}

	/**
	 * @param target the target to set
	 */
	public void setTarget(String target) {
		this.target = target;
	}

	/**
	 * @return the child
	 */
	public List<MenuVo> getChild() {
		return child;
	}

	/**
	 * @param child the child to set
	 */
	public void setChild(List<MenuVo> child) {
		this.child = child;
	}

	public MenuVo(Integer id, Integer pid, String title, String icon, String href, String target, List<MenuVo> child) {
		super();
		this.id = id;
		this.pid = pid;
		this.title = title;
		this.icon = icon;
		this.href = href;
		this.target = target;
		this.child = child;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "MenuVo [id=" + id + ", pid=" + pid + ", title=" + title + ", icon=" + icon + ", href=" + href
				+ ", target=" + target + ", child=" + child + "]";
	}

	public MenuVo() {
		super();
	}
    
    
}
