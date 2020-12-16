package com.wy.service;

import com.wy.entity.DataModel;
import com.wy.entity.SysUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @auther wuyi
 * @create 2020-12-15 16:45
 * @Description
 */

public interface SysUserService {
    /**
     * 分页查询所有记录
     *
     * @param page    当前页面
     * @param limit   每页条数
     * @param sysUser 查询的条件
     * @return
     */
    DataModel findAll(int page, int limit, SysUser sysUser);

    /**
     * 添加用户
     *
     * @param sysUser
     * @return
     */
    DataModel addUser(SysUser sysUser);

    /**
     * 根据用户id查询
     *
     * @param id
     * @return
     */
    DataModel getUser(Integer id);

    /**
     * 修改用户
     *
     * @param sysUser
     * @return
     */
    DataModel updUser(SysUser sysUser);

    /**
     * 批量修改状态
     * @param ids  一个或者多个id
     * @param status
     * @return
     */
    DataModel updateStatus(String[] ids, Integer status);

    /**
     * 登陆
     * @param username
     * @param password
     * @return
     */
    DataModel login(String username, String password, HttpServletRequest request, HttpServletResponse response);

}
