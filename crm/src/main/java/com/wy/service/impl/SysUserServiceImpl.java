package com.wy.service.impl;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wy.contants.Constants;
import com.wy.contants.RedisConstants;
import com.wy.contants.StatusConstants;
import com.wy.dao.SysUserMapper;
import com.wy.entity.DataModel;
import com.wy.entity.SysUser;
import com.wy.service.SysUserService;
import com.wy.util.RedisService;
import com.wy.vo.SysUserVo;
import org.springframework.stereotype.Service;
import com.wy.util.MD5Util;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @auther wuyi
 * @create 2020-12-15 16:49
 * @Description
 */

@Service
public class SysUserServiceImpl implements SysUserService {

    @Resource
    private SysUserMapper sysUserMapper;


    @Resource
    private RedisService redisService;

    @Override
    public DataModel findAll(int page, int limit, SysUser sysUser) {
        //pageHelper分页插件.(后续查询紧跟着的第一个查询有效)
        PageHelper.startPage(page, limit);
        List<SysUserVo> all = sysUserMapper.findAll(sysUser);
        PageInfo<SysUserVo> sysUserVoPageInfo = new PageInfo<>(all);
        return new DataModel(sysUserVoPageInfo);
    }



    @Override
    public DataModel addUser(SysUser sysUser) {
        int insert = sysUserMapper.insert(sysUser);
        return new DataModel(StatusConstants.SUCCESS_CODE,"添加成功!");
    }




    @Override
    public DataModel getUser(Integer id) {
        DataModel dataModel = new DataModel();
        SysUser sysUser = sysUserMapper.selectByPrimaryKey(id);
        dataModel.setData(sysUser);
        if(sysUser == null){
            dataModel.setCode(StatusConstants.FAIL_CODE);
        }
        return dataModel;
    }




    @Override
    public DataModel updUser(SysUser sysUser) {
        int i = sysUserMapper.updateByPrimaryKeySelective(sysUser);
        if (i > 0) {
            return new DataModel(StatusConstants.SUCCESS_CODE, "修改成功!");
        } else {
            return new DataModel(StatusConstants.FAIL_CODE, "修改失败!");
        }
    }




    @Override
    public DataModel updateStatus(String[] ids, Integer status) {
        for (String id : ids) {
            if (!id.equals("1")) {
                SysUser sysUser = new SysUser();
                sysUser.setId(Integer.parseInt(id));
                sysUser.setStatus(status);
                sysUserMapper.updateByPrimaryKeySelective(sysUser);
            }
        }
        return new DataModel();
    }




    @Override
    public DataModel login(String username, String password, HttpServletRequest request, HttpServletResponse response) {
        DataModel dataModel = new DataModel<>();
        SysUser user = sysUserMapper.login(new SysUser(username, MD5Util.encrypByMd5Jar(password)));
        if(user == null){
            dataModel.setCode(StatusConstants.FAIL_CODE);
            dataModel.setMsg("用户名或密码错误");
        }else {

            //将用户对象的json转为字符串并保存至redis中
            String userKey = RedisConstants.USER_INFO + user.getId();
            redisService.setex(userKey, Constants.USER_INFO_EXPIRE, JSON.toJSONString(user));


            //将用户的id保存到cookie
            Cookie cookie = new Cookie("uid",user.getId().toString());
            cookie.setPath("/"); //将当前cookie保存到当前项目端口根目录. localhost:8088/
            cookie.setMaxAge(Constants.USER_INFO_EXPIRE); //有效期(浏览器负责失效清除)
            response.addCookie(cookie);

            String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/index";
            dataModel.setMsg("登陆成功!");
            dataModel.setData(url);
        }
        return dataModel;
    }
}
