package com.wy.util;

import com.wy.vo.AuthTreeVo;

import java.util.ArrayList;
import java.util.List;

public class AuthTreeUtil {

	public static List<AuthTreeVo> toTree(List<AuthTreeVo> treeList, Integer pid) {
	    //存放树形数据的list结构
		List<AuthTreeVo> retList = new ArrayList<>();
		//遍历当前所有的元素[需要变成树的每一条记录]
		for (AuthTreeVo parent : treeList) {
			if (pid.equals(parent.getPid())) { // 查找到目前数据中的所有根节点
				retList.add(findChildren(parent, treeList)); //查找当前根节点下的所有子节点
			}
		}
		return retList;
	}


	private static AuthTreeVo findChildren(AuthTreeVo parent, List<AuthTreeVo> treeList) {
		for (AuthTreeVo child : treeList) { //遍历当前集合
			if (parent.getId().equals(child.getPid())) { //根据当前节点ID查找子节点
				parent.getList().add(findChildren(child, treeList)); //添加当前的节点到父节点中
			}
		}
		return parent;
	}
}
