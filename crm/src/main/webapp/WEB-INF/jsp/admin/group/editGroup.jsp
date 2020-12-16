<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/taglib.jsp" %>
<title></title>
</head>
<body>
	<div class="layui-form layuimini-form" lay-filter="groupForm" id="groupForm">
    <div class="layui-form-item">
        <label class="layui-form-label required">用户组名</label>
        <div class="layui-input-block">
            <input type="hidden" name="id" id="groupId">
            <input type="text" name="groupName" lay-verify="required" lay-reqtext="用户组名不能为空" placeholder="请输入用户组名" value="" class="layui-input">
            <tip>填写用户组名称。</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">权限描述</label>
        <div class="layui-input-block">
            <input type="text" name="authDesc" placeholder="请输入权限描述" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注信息</label>
        <div class="layui-input-block">
            <textarea name="describle" class="layui-textarea" placeholder="请输入备注信息"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
</div>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;
        //监听提交
        form.on('submit(saveBtn)', function (data) {
        	$.ajax({
        		url: '<%=basePath%>/admin/group/edit',
        		data: data.field,
        		success: function (data) {
        			layer.msg(data.msg);
        			parent.location.reload();
        			// 关闭弹出层
        			var iframeIndex = parent.layer.getFrameIndex(window.name);
                	parent.layer.close(iframeIndex);
        			return false;
        		}
        	});
        });

        
        
        
        //获取当前表单的对象
        var formData = form.val("groupForm");
   		$.post("<%=basePath%>/admin/group/get", { id: formData.id }, function (d) {
        	//form表单填充值,val(lay-filter,data数据json)
   			form.val("groupForm",d);
        });
    });
</script>
</body>
</html>