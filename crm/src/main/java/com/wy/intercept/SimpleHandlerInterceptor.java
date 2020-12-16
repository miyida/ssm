package com.wy.intercept;

import com.wy.contants.Constants;
import com.wy.contants.RedisConstants;
import com.wy.util.RedisService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户Session拦截器
 */
public class SimpleHandlerInterceptor implements HandlerInterceptor {

    @Resource
    private RedisService redisService;

	/**
	 * 执行方法前执行
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

	    ////	    //获取当前session
//        HttpSession session = request.getSession();
//        Object userInfo = session.getAttribute("userInfo");

        boolean isAlive = false; //是否存活
        //获取当前请求的cookie
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){ //遍历cookie
                if ("uid".equals(cookie.getName())) { //判断当前cookie是否是用户id

                    String userKey = RedisConstants.USER_INFO + cookie.getValue(); //用户的redis key

                    String userInfoStr = redisService.get(userKey); //根据key去redis中查找

                    if(StringUtils.isNotBlank(userInfoStr)){ //判断查找到的内容是否非空
                        redisService.expire(userKey, Constants.USER_INFO_EXPIRE); //当用户在登陆状态,则将redis的过期时间重置为30分钟
                        //更新客户端的cookie的有效期
                        cookie.setMaxAge(Constants.USER_INFO_EXPIRE);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        isAlive = true;
                    }
                }
            }
        }

        if(isAlive){//会话还在有效期内
            return true;
        }else {
            String contextPath = request.getContextPath();
            String header = request.getHeader("X-Requested-With");
            if("XMLHttpRequest".equals(header)){ //Ajax请求
                /*
                    Ajax全局回调重定向
                    @see /common/taglib.jsp
                 */
                response.setHeader("REDIRECT", "REDIRECT"); //需要重定向
                response.setHeader("CONTEXTPATH", contextPath+"/login");
            }else{ //不是AJax请求
                response.sendRedirect(contextPath+"/login"); //重定向
                // request.getRequestDispatcher(contextPath+"/login").forward(request, response); //转发
            }
            return false;
        }
	}

}
