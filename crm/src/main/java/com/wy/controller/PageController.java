package com.wy.controller;

import com.wy.service.SysRuleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class PageController {
    @Resource
    private SysRuleService sysRuleService;

    @RequestMapping("/index")
    public String index(){
        return "base/index";
    }
    @RequestMapping("/error")
    public String error(){
        return "base/error";
    }

    @GetMapping("/menu")
    @ResponseBody
    public Object getMenu(HttpServletRequest request){
        Object menu = sysRuleService.getMenu(request);
        return menu;
    }
}
