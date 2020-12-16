<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>权限树</title>
</head>
<body>
	<script type="text/javascript">
	
	// 全选样例
	function checkAll(dst){
	  layui.use(['jquery', 'layer', 'authtree'], function(){
	    var layer = layui.layer;
	    var authtree = layui.authtree;

	    authtree.checkAll(dst);
	  });
	}
	// 全不选样例
	function uncheckAll(dst){
	  layui.use(['jquery', 'layer', 'authtree'], function(){
	    var layer = layui.layer;
	    var authtree = layui.authtree;

	    authtree.uncheckAll(dst);
	  });
	}
	// 显示全部
	function showAll(dst){
	  layui.use(['jquery', 'layer', 'authtree'], function(){
	    var layer = layui.layer;
	    var authtree = layui.authtree;

	    authtree.showAll(dst);
	  });
	}
	// 隐藏全部
	function closeAll(dst){
	  layui.use(['jquery', 'layer', 'authtree'], function(){
	    var layer = layui.layer;
	    var authtree = layui.authtree;

	    authtree.closeAll(dst);
	  });
	}
	
	</script>
	<form class="layui-form" id="authForm">

		<div class="layui-row">
			<div class="layui-col-xs12">
				<div class="grid-demo grid-demo-bg1">

					<div class="layui-form-item">
						<label class="layui-form-label">角色名称</label>
						<div class="layui-input-block">
							<input type="hidden" name="id" id="groupId">
							<input class="layui-input" type="text" name="name" id="groupName" disabled="disabled"
								   placeholder="请输入角色名称" />
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-xs12">
				<div class="grid-demo grid-demo-bg1">

					<div class="layui-form-item">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-primary" onclick="checkAll('#LAY-auth-tree-index')">全选
							</button>
							<button type="button" class="layui-btn layui-btn-primary" onclick="uncheckAll('#LAY-auth-tree-index')">全不选
							</button>
							<button type="button" class="layui-btn layui-btn-primary" onclick="showAll('#LAY-auth-tree-index')">全部展开
							</button>
							<button type="button" class="layui-btn layui-btn-primary" onclick="closeAll('#LAY-auth-tree-index')">全部隐藏
							</button>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-xs12">
				<div class="grid-demo grid-demo-bg1">

					<div class="layui-form-item">
						<label class="layui-form-label">选择权限</label>
						<div class="layui-input-block">
							<div id="LAY-auth-tree-index"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-xs12">
				<div class="grid-demo grid-demo-bg1">

					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" type="button" lay-submit lay-filter="LAY-auth-tree-submit">提交</button>
						</div>
					</div>

				</div>
			</div>
		</div>


	</form>

	<script type="text/javascript">
		var groupId;
		layui.use([ 'jquery', 'authtree', 'form', 'layer'], function() {
			var $ = layui.jquery;
			var authtree = layui.authtree;
			var form = layui.form;
			var layer = layui.layer;
			groupId = $("#groupId").val();
			$.ajax({
				url : '<%=basePath%>/admin/group/auth/tree', 
				dataType : 'json',
				data: {'groupId':groupId},
				success : function(data) {
					var trees = data.data.trees;
					authtree.render('#LAY-auth-tree-index', trees, {
						inputname : 'authids[]',
						layfilter : 'lay-check-auth',
						autowidth : true,
					});
				}
			});
			
			 // 监听提交操作
	        form.on('submit(LAY-auth-tree-submit)', function (data) {
	        	
	        	// 获取所有已选中节点
	    	    var checked = authtree.getChecked('#LAY-auth-tree-index');
	    	    $.post({
	        		url: '<%=basePath%>/admin/group/auth/save',
	        		data: {'grids':checked,'groupId':groupId},
	        		success: function (data) {
	        			layer.msg(data.msg);
	        			// 关闭弹出层
	        			var iframeIndex = parent.layer.getFrameIndex(window.name);
	                	parent.layer.close(iframeIndex); 
	        		}
	        	});
	        });
		});
	</script>
</body>
</html>