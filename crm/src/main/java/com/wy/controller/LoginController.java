package com.wy.controller;

import com.wy.entity.DataModel;
import com.wy.service.SysUserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping
public class LoginController {

    @Resource
    private SysUserService sysUserService;

    @GetMapping("/login")
    public ModelAndView loginPage(){
        return new ModelAndView("base/login");
    }

    //ajax调用
    @PostMapping("/login")
    public DataModel login(String username, String password, HttpServletRequest request, HttpServletResponse response){
        DataModel dataModel = sysUserService.login(username, password, request, response);
        return dataModel;
    }
}
