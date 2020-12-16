<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/common/taglib.jsp" %>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
<!-- 搜索框 开始 -->
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户组名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="groupName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
<!-- 搜索框 结束 -->
<!-- 列表 开始 -->
		<!-- 列表头部的按钮 -->
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
		
		<!-- /*操作栏的按钮*/ 
		
			操作栏按钮独立渲染
			//独立渲染的按钮在JS块中,使用如下代码进行包裹表示使用js语法
			{{# }} 
		-->
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
			{{#  if(d.status == 1){ }}
   			 <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="disable">禁用</a>
    		{{#  } }}
    		{{#  if(d.status == 0){ }}
    		<a class="layui-btn layui-btn-xs layui-btn" lay-event="enable">启用</a>
    		{{#  } }}	
            <a class="layui-btn layui-btn-normal layui-btn-xs fa fa-cog" lay-event="auth">权限</a>
        </script>
<!-- 列表结束  -->
    </div>
</div>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>/admin/group/all',
            height: 'full-200',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox"},
                {field: 'id', title: 'ID', sort: true},
                {field: 'groupName', title: '用户组名'},
                {field: 'authDesc', title: '权限描述'},
                {field: 'describle', title: '备注'},
                {field: 'status', title: '状态',templet:function(d){
                	if(d.status==0){ //禁用状态
                		return '<span class="layui-badge">已禁用</span>';
                	}else{ //启用状态
                		return '<span class="layui-badge layui-bg-green">已启用</span>';
                	}
                }},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true,
            skin: 'line'
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

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
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '<%=basePath%>/admin/group/editPage',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
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
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '<%=basePath%>/admin/group/editPage',
                    success: function(layero, index){ //窗口打开成功,回调
                    	//获取当前父窗口下的子表单
                        var editPage = layero.find('iframe').contents().find('#groupForm');
                    	//为当前表单的隐藏域赋值
                        editPage.find("#groupId").val(data.id);
                      }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                
                
                return false;
            } else if (obj.event === 'disable') {
                layer.confirm('真的禁用 '+data.groupName+' 吗?', function (index) {
                	$.ajax({
                		url: '<%=basePath%>/admin/group/updStatus?type=0',
                		data: data,
                		success: function (data) {
                			layer.msg(data.msg);
                			location.reload();
                			layer.close(index);
                		}
                	});
                	
                });
            } else if(obj.event === 'enable'){
            	layer.confirm('真的启用 '+data.groupName+' 吗?', function (index) {
            		console.log(data);
            		$.ajax({
                		url: '<%=basePath%>/admin/group/updStatus?type=1',
                		data: data,
                		success: function (data) {
                			layer.msg(data.msg);
                			location.reload(); //刷新当前页面,相当于刷新table
                			layer.close(index);
                		}
                	});
                });
            } else if(obj.event === 'auth'){
            	var authIndex = layer.open({
                    title: '配置权限',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    area: ['50%', '85%'],
                    content: '<%=basePath%>/admin/group/authTreePage',
                    success: function(layero, index){ //窗口打开成功,回调
                    	//获取当前父窗口下的子表单
                        var editPage = layero.find('iframe').contents().find('#authForm');
                    	//为当前表单的隐藏域赋值
                        editPage.find("#groupId").val(data.id);
                        editPage.find("#groupName").val(data.groupName);
                      }
                });
            }
        });

    });
</script>

</body>
</html>