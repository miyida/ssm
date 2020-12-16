<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/taglib.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品选择器</title>
</head>
<body>
	
<div class="layui-form layuimini-form">
    <div class="layuimini-main">
<!-- 搜索框 开始 -->
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户组名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="groupName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="goodsSelector-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
<!-- 搜索框 结束 -->
<!-- 列表 开始 -->
        <table class="layui-hide" id="goodsSelectorTableId" lay-filter="goodsSelectorTableFilter"></table>
<!-- 列表结束  -->
    </div>
    <button class="layui-btn  layui-btn-sm layui-btn-radius"  lay-filter="openGoodsSelector" onclick="chooseGoods()">选择商品</button>
</div>
<script>
	var parent;
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;
        	parent = parent;
        table.render({
            elem: '#goodsSelectorTableId',
            url: '<%=basePath%>/admin/group/all',
            height: 'full-200',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "radio"},
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
        form.on('submit(goodsSelector-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
        /*     layer.alert(result, {
                title: '最终的搜索信息'
            }); */

            //执行搜索重载
            table.reload('goodsSelectorTableId', {
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
        table.on('toolbar(goodsSelectorTableFilter)', function (obj) {
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
            } 
        });

    });
    
    /*
    	商品选择器.目前使用的是用户组的数据,需要自行修改
    */
    function chooseGoods(){
        layui.use(['form', 'table'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table;
        	//获取当前页面中table选中状态的json
            var checkStatus = table.checkStatus('goodsSelectorTableId');
        	//获取当前状态的数据
            var data = checkStatus.data;
        	//获取当前页面的父级页面
            var par = $(window.parent.document);
            //将当前table选中的数据带入到父级页面中
            //自行更改-data是一个数组
            par.find("input[name='goodName']").val(data[0].groupName);
            par.find("input[name='count']").val(123);
            par.find("input[name='marketPrice']").val(1300);
            
         	// 关闭弹出层
			var iframeIndex = parent.layer.getFrameIndex(window.name);
        	parent.layer.close(iframeIndex);
        });
    }
</script>
		
</body>
</html>