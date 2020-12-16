<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath = request.getContextPath(); %>    
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<link rel="icon" href="<%=basePath%>/resources/layui/images/favicon.ico">
<link rel="stylesheet" href="<%=basePath%>/resources/layui/lib/layui-v2.5.5/css/layui.css" media="all">
<link rel="stylesheet" href="<%=basePath%>/resources/layui/css/layuimini.css?v=2.0.4.2" media="all">
<link rel="stylesheet" href="<%=basePath%>/resources/layui/css/themes/default.css" media="all">
<link rel="stylesheet" href="<%=basePath%>/resources/layui/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
<link rel="stylesheet" href="<%=basePath%>/resources/layui/css/public.css" media="all">
<script src="<%=basePath%>/resources/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>/resources/layui/js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<style>
.layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
     top: 50%;
     transform: translateY(-50%);
}
.layui-table-view .layui-form-radio {
    line-height: 1;
    padding: 0;
}
</style>

<script>
//全局定义jq的complete[请求完成回调函数,全局定义Ajax请求,filter过滤器的重定向问题]
layui.define(['jquery', 'form'], function (exports) {
	 var $ = layui.jquery;
	 $.ajaxSetup({
			//设置ajax请求结束后的执行动作
			complete: function(XMLHttpRequest, textStatus) {
				// 通过XMLHttpRequest取得响应头，REDIRECT
				var redirect = XMLHttpRequest.getResponseHeader( "REDIRECT"); //若HEADER中含有REDIRECT说明后端想重定向
				if (redirect == "REDIRECT") {
					var win = window;
					while (win != win.top) {
						win = win.top;
					}
					//将后端重定向的地址取出来,使用win.location.href去实现重定向的要求
					win.location.href = XMLHttpRequest.getResponseHeader("CONTEXTPATH");
				}
			}
		});
})
</script>
