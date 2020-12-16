package com.wy.controller;

import com.wy.contants.StatusConstants;
import com.wy.entity.DataModel;
import com.wy.entity.SysUser;
import com.wy.service.SysUserService;
import com.wy.util.MD5Util;
import com.alibaba.fastjson.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;


/**
 * SpringMVC中的Controller中,如果需要使用全局变量,则可以使用@Scope注解
 * Scope注解有四种值 :
 * singleton : 单例模式. 默认值
 * prototype : 每次调用都是新对象
 * request : 每次请求都是新对象
 * session : 每个会话产生一个对象
 *
 * @RestController 注解表示当前类中的每一个方法都返回json对象. 若需要返回视图则无法使用返回字符串类型来返回视图
 * 在需要返回视图的方法中将返回类型更改为ModelAndView 即可返回视图
 * 所有的返回json的方法都可以不用增加@ResponseBody注解
 */
@RestController
@RequestMapping("/admin/user")
@Scope("prototype")
public class SysUserController {

    @Resource
    private SysUserService sysUserService;

    /**
     * 在Controller中的返回值为void时,则SpringMVC自动根据访问路径返回页面
     */
    @RequestMapping("/test")
    public void test(Date time, HttpServletRequest request) {
        String username = request.getParameter("username");
        Map<String, String[]> parameterMap = request.getParameterMap();
        System.out.println(time);
        System.out.println(this);
    }


    /**
     * 列表页面视图跳转
     *
     * @return
     */
    @RequestMapping("/listPage")
    public ModelAndView userListPage() {
        return new ModelAndView("admin/user/userList");
    }

    @RequestMapping("/editUserPage")
    public ModelAndView addUserPage() {
        return new ModelAndView("admin/user/editUser");
    }


    /**
     * 返回用户的列表数据
     *
     * @param page         当前页码
     * @param limit        每页条数
     * @param searchParams 查询参数
     * @return
     */
    @RequestMapping("/list")
    public DataModel userList(int page, int limit, String searchParams) {
        //将前端传递过来的参数转换成对象
        SysUser sysUser = JSONObject.parseObject(searchParams, SysUser.class);
        DataModel dataModel = sysUserService.findAll(page, limit, sysUser);
        return dataModel;
    }

    @RequestMapping("/get")
    public DataModel getUser(SysUser sysUser) {
        DataModel user = null;
        if (sysUser.getId() == null || sysUser.getId() == 0) {
            user = new DataModel(StatusConstants.FAIL_CODE, "该用户不存在!");
        } else {
            user = sysUserService.getUser(sysUser.getId());
        }
        return user;
    }

    @RequestMapping("/edit")
    public DataModel editUser(SysUser sysUser) {
        DataModel dataModel = null;
        if (sysUser.getId() > 0) { //修改
            //根据传递的用户id进行查询
            DataModel dataModel1 = sysUserService.getUser(sysUser.getId());
            SysUser user = (SysUser)dataModel1.getData();
            //比较数据库中的密码和传递过来的密码是否相同
            if(!user.getPassword().equals(sysUser.getPassword())){
                //不相同表示密码更新过,需要对新的密码重新加密
                String newPwd = MD5Util.encrypByMd5Jar(sysUser.getPassword());
                sysUser.setPassword(newPwd);
            }
            //调用修改service
            dataModel = sysUserService.updUser(sysUser);
        } else {
            sysUser.setPassword(MD5Util.encrypByMd5Jar(sysUser.getPassword()));
            dataModel = sysUserService.addUser(sysUser);
        }
        return dataModel;
    }

    @RequestMapping("/updateStatus")
    public DataModel delUser(String idStr,Integer status) {
        String[] ids = idStr.split(",");
        DataModel dataModel = sysUserService.updateStatus(ids, status);
        return dataModel;
    }
}
