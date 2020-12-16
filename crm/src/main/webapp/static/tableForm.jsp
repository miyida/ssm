<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/taglib.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>form表单加入table示例</title>
</head>
<body>
<div class="layui-form layuimini-form" lay-filter="userForm" id="userForm">
    <div class="layui-form-item">
        <label class="layui-form-label required">表单字段1</label>
        <div class="layui-input-block">
            <input type="text" name="field1" lay-verify="field1" lay-reqtext="表单字段1不能为空" placeholder="请输入表单字段1" value="" class="layui-input">
            <tip>填写表单字段1。</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">表单字段2</label>
        <div class="layui-input-block">
            <input type="text" name="field2" lay-verify="field2" lay-reqtext="表单字段1不能为空"  placeholder="请输入表单字段2" value="" class="layui-input">
            <tip>填写表单字段2。</tip>
        </div>
    </div>
    <!-- table相关 -->
    <script type="text/html" id="simpleToolbar">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
			</div>

    </script>
    <table class="layui-hide" id="simpleTableId" lay-filter="simpleTableFilter"></table>
    

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveUser">确认保存</button>
        </div>
    </div>
</div>
</div>
<script>
	/* 
	插件地址 : https://gitee.com/sun_zoro/layuiTablePlug/tree/master/ {基本上可以不用看,文档基本等于什么都没写}
	引入 "tablePlug","renderFormSelectsIn" 两款插件, 
	插件加入方式以及在lay.config.js中集成, 使用该插件模块时,声明即可
	使用前替换resources文件夹中的layui文件,layui文件集成了本模块需求的第三方功能.
	*/
    layui.use(['form','layer','table',"tablePlug","renderFormSelectsIn"], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
            table = layui.table,
            renderFormSelectsIn = layui.renderFormSelectsIn, /* 引入renderFormSelectsIn 和tablePlug插件 */
       		tablePlug = layui.tablePlug;
        //监听提交
        form.on('submit(saveUser)', function (data) {
        	var urlData = table.cache.simpleTableId;
        	var temData = table.getTemp('simpleTableId').data;
        	var newJsonList = urlData.concat(temData);
        	console.log('url数据' + JSON.stringify(urlData));
        	console.log('临时数据' + JSON.stringify(temData));
        	console.log(newJsonList);
        	$.ajax({
        		url: '<%=basePath%>/test',
        		data: {'fdata':JSON.stringify(data.field),'tables':JSON.stringify(newJsonList)},
        		success: function (data) {
        			layer.msg(data.msg);
        			/*parent.location.reload();
        			// 关闭弹出层
        			var iframeIndex = parent.layer.getFrameIndex(window.name);
                	parent.layer.close(iframeIndex);
        			return false;*/
        		}
        	});
        });
	
        //表格渲染
       tableIndex = table.render({
            elem: '#simpleTableId',
            url: '<%=basePath%>/admin/user/list',
            toolbar: '#simpleToolbar',
            cols: [[ 
                {field: 'id', title: 'ID', sort: true},
                {field: 'username',  title: '商品名称'},
                {field: 'groupName', title: '商品价格'},
                {field: 'saleType', hide:true, title: '促销类型'}
            ]],
            limits: [100],
            limit: 100,
            skin: 'line'
        });
        
        /**
         * toolbar监听事件
         */
        table.on('toolbar(simpleTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加商品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    area: ['50%', '80%'],
                    content: 'tableFormAdd.jsp',
                    success: function(layero, index){ //窗口打开成功,回调
                    	//获取当前父窗口下的子表单
                        var editPage = layero.find('iframe').contents().find('#userForm');
                    	//获取该表单中的提交按钮,并给该按钮注册点击事件.
                        editPage.find("#saveTableForm").click(function () {
                        	
                        	//自行改造
                        	var id = editPage.find("input[name='goodId']").val();
                        	var username = editPage.find("input[name='goodName']").val();
                        	var groupName = editPage.find("input[name='goodName']").val();
                        	/*
                        		将该form中的值全部获取,然后保存至table中
                        		table.addTemp("需要添加临时数据的表格ID",{需要添加的json{table中的field名称 : 值......}})
                        	
                        	*/
                        	table.addTemp('simpleTableId', {id: id, username: username, groupName: groupName}, function (trElem) { // 新增支持传一个默认数据
                                // 进入回调的时候this是当前的表格的config
                                var that = this;
                        		console.log(trElem);
                        		/*
                        			trElem当前添加的节点信息
                        			layuiTable 固定写法,插件源码目前只提供这一种方式
                        		*/
                                renderFormSelectsIn(trElem, {}, 'layuiTable');
                              });
                        	layer.close(index);
                        });
                      }
                });
            }
        });
        
      //监听行双击事件
        table.on('rowDouble(simpleTableFilter)', function(obj){
        	obj.del();
        });

    });
</script>
</body>
</html>