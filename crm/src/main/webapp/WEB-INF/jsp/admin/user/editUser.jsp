<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑用户</title>
</head>
<%@include file="/common/taglib.jsp" %>
<body>
<form class="layui-form" action="" lay-filter="userForm">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <!-- 编辑时需要给当前id赋值. 隐藏域的输入框的值来描述是修改还是添加 -->
            <input type="hidden" name="id" id="userId" value="0">
            <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入用户名"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码框</label>
        <div class="layui-input-block">
            <input type="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">用户角色</label>
        <div class="layui-input-block">
            <select name="groupId" lay-filter="groupIdFilter" id="groupId">
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="userFormSubmit">立即提交</button>
        </div>
    </div>
</form>
<script>

    // 自定义表单加载
    function loadFormData($,form){
        var userId = $("#userId").val();
        if(userId == 0){ //添加
            //自定义验证规则
            form.verify({
                title: function (value) {
                    if (value.length < 5) {
                        return '用户名至少得5个字符啊';
                    }
                }
                , pass: [
                    /^[\S]{6,12}$/
                    , '密码必须6到12位，且不能出现空格'
                ]
                , content: function (value) {
                    layedit.sync(editIndex);
                }
            });
        }else{ //修改
            $.ajax({
                url:'<%=basePath%>/admin/user/get',
                type:'post',
                data:{'id':userId},
                success:function(d){
                    $("input[name='username']").prop('readonly',true);
                    form.val('userForm',d.data);
                }
            })

        }
    }

    // 初始化layui组件
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate
            ,$ = layui.jquery;

        // 渲染下拉框
        $.ajax({
            url: '<%=basePath%>/admin/group/selectOption',
            dataType: 'json',
            type: 'post',
            success: function (d) {
                if (d.code == 0) { //判断数据返回状态
                    var data = d.data; //当前的数据
                    $("#groupId").append(new Option("请选择", "")); //追加默认选项
                    $.each(data, function (i, n) { //循环json数组
                        $("#groupId").append(new Option(n.groupName, n.id)); //追加数据选项
                    })
                    form.render("select"); //渲染下拉框.否则不显式动态结果集
                } else {
                    layer.msg("数据错误!");
                }
                loadFormData($,form);
            }
        });



        //监听提交
        form.on('submit(userFormSubmit)', function (data) {
            $.ajax({
                url:'<%=basePath%>/admin/user/edit',
                type:'post',
                data:data.field,
                success:function (d) {
                    if(d.code == 0){
                        layer.msg(d.msg, {icon: 6});
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭
                    }else{
                        layer.msg(d.msg, {icon: 5});
                    }
                }
            });
            return false;
        });




    });
</script>
</body>
</html>
