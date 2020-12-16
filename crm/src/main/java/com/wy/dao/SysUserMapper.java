package com.wy.dao;


import com.wy.entity.SysUser;
import com.wy.vo.SysUserVo;

import java.util.List;

public interface SysUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);

    /**
     * 查询所有.返回用户信息以及用户组名
     * @param sysUser 查询条件
     * @return
     */
    List<SysUserVo> findAll(SysUser sysUser);

    /**
     * 登陆查询方案
     * @return
     */
    SysUser login(SysUser sysUser);
}