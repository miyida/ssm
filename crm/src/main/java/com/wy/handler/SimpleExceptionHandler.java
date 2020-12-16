package com.wy.handler;


import com.alibaba.fastjson.JSON;
import com.wy.contants.StatusConstants;
import com.wy.entity.DataModel;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Component
public class SimpleExceptionHandler implements HandlerExceptionResolver{

    Logger logger = LogManager.getLogger(SimpleExceptionHandler.class);

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
        ModelAndView modelAndView = new ModelAndView();
        String header = request.getHeader("X-Requested-With");
        if("XMLHttpRequest".equals(header)){ //Ajax请求 则全局异常返回json
            DataModel<Object> dataModel = new DataModel<>(StatusConstants.FAIL_CODE, "网络错误!");
            try {
                //声明当前相应内容为json,编码为utf8
                response.setContentType("application/json;charset=utf8");
                PrintWriter writer = response.getWriter();
                writer.write(JSON.toJSONString(dataModel)); //写入json
                writer.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{ // 普通页面请求,则返回页面视图名
            modelAndView.addObject("msg", "目标无法抵达~");
            modelAndView.setViewName("/base/error");
        }
        logger.error("全局异常", ex);
        return modelAndView;
	}

	
}
