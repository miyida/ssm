<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户列表</title>
    <%@include file="/common/taglib.jsp"%>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <!-- 搜索条件 开始 -->
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="id" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户账户</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户角色</label>
                            <div class="layui-input-block">
                                <select name="groupId" lay-filter="groupIdFilter" id="groupId">
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
        <!-- 搜索条件 结束 -->

        <!-- 表格工具栏 开始 -->
        <script type="text/html" id="userToolbar">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 禁用 </button>
            </div>
        </script>
        <!-- 表格工具栏 结束 -->

        <!-- 数据表格 开始 -->
        <table class="layui-hide" id="userTableId" lay-filter="currentTableFilter"></table>
        <!-- 数据表格 结束 -->

        <!-- 数据表格上数据行的功能按钮  开始-->
        <script type="text/html" id="userCurrentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            {{#  if(d.status == 0){ }}
                <a class="layui-btn layui-btn-xs data-count-delete" lay-event="enable">启用</a>
            {{#  } else { }}
                <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="disable">禁用</a>
            {{# } }}
        </script>
        <!-- 数据表格上数据行的功能按钮  结束-->
    </div>
</div>
<script>
    //当前页
    var currCount = 0;

    function tableReload(table,result){
        //执行搜索重载
        console.log(table);
        table.reload('userTableId', {
            page: {
                curr: currCount
            }
            , where: {
                searchParams: result
            }
        }, 'data');
        table.render();
    }
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            laypage = layui.laypage;;

        // 渲染下拉框
        $.ajax({
            url:'<%=basePath%>/admin/group/selectOption',
            dataType:'json',
            type:'post',
            success:function(d){
                if(d.code == 0){ //判断数据返回状态
                    var data = d.data; //当前的数据
                    $("#groupId").append(new Option("请选择","")); //追加默认选项
                    $.each(data,function(i,n){ //循环json数组
                        $("#groupId").append(new Option(n.groupName,n.id)); //追加数据选项
                    })
                    form.render("select"); //渲染下拉框.否则不显式动态结果集
                }else{
                    layer.msg("数据错误!");
                }
            }
        });
        table.render({
            elem: '#userTableId',
            url: '<%=basePath%>/admin/user/list',
            toolbar: '#userToolbar',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id',  title: '用户编号'},
                {field: 'username',  title: '用户名'},
                {field: 'groupName', title: '用户角色'},
                {field: 'status', title: '状态'
                    ,templet: function(d){
                        if(d.status == 0){
                            return '<span class="layui-badge">禁用</span>';
                        }else{
                            return '<span class="layui-badge layui-bg-green">启用</span>';
                        }
                    }
                },
                {field: 'createTime', title: '创建时间'},
                {field: 'updateTime', title: '修改时间'},
                {title: '操作', minWidth: 150, toolbar: '#userCurrentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true,
            skin: 'line',
            done: function(res, curr, count){ //数据渲染之后的回调
                currCount = curr;
            }
        });
        var result;
        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            result = JSON.stringify(data.field);
            currCount = 1; //搜索重置当前页
            tableReload(table,result);
            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>/admin/user/editUserPage'
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听禁用操作
                var checkStatus = table.checkStatus('userTableId')
                    , data = checkStatus.data;
                var ids = '';
                $.each(data,function(i,n){
                    ids = ids+n.id+",";
                });
                updateStatus($,ids,0);
                tableReload(table,result);
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['50%', '50%'],
                    content: '<%=basePath%>/admin/user/editUserPage',
                    success: function(layero, index){ //窗口打开成功之后的回调
                        var childFrame = layer.getChildFrame("body",index); //获取当前窗口的子窗口
                        childFrame.find("#userId").val(data.id); //获取子窗口的隐藏的id输入框

                    },
                    end:function(){
                        tableReload(table,result);
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'enable') {
                layer.confirm('真的启用吗?', function (index) {
                    updateStatus($,data.id,1);
                    tableReload(table,result);
                    layer.close(index);
                });
            }else if (obj.event === 'disable') {
                layer.confirm('真的禁用吗?', function (index) {
                    updateStatus($,data.id,0);
                    tableReload(table,result);
                    layer.close(index);
                });
            }
        });

    });

    function updateStatus($,id,status){
        $.post({
            url:'<%=basePath%>/admin/user/updateStatus',
            data:{'idStr':id,'status':status},
            success:function(d){
                if(d.code == 0){
                    layer.msg(d.msg, {icon: 6});
                }else{
                    layer.msg(d.msg, {icon: 5});
                }
            }
        })
    }
</script>

</body>
</html>
