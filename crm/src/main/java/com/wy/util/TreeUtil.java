package com.wy.util;

import com.wy.vo.MenuVo;

import java.util.ArrayList;
import java.util.List;

public class TreeUtil {

	public static List<MenuVo> toTree(List<MenuVo> treeList, Integer pid) {
		List<MenuVo> retList = new ArrayList<>();
		for (MenuVo parent : treeList) {
			if (pid.equals(parent.getPid())) {
				retList.add(findChildren(parent, treeList));
			}
		}
		return retList;
	}

	private static MenuVo findChildren(MenuVo parent, List<MenuVo> treeList) {
		for (MenuVo child : treeList) {
			if (parent.getId().equals(child.getPid())) {
				if (parent.getChild() == null) {
					parent.setChild(new ArrayList<MenuVo>());
				}
				parent.getChild().add(findChildren(child, treeList));
			}
		}
		return parent;
	}
}