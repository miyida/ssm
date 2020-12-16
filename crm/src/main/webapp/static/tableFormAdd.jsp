<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/taglib.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加商品</title>
</head>
<body>
<div class="layui-form layuimini-form" lay-filter="userForm" id="userForm">
    <div class="layui-form-item">
        <label class="layui-form-label required">商品Id</label>
        <div class="layui-input-inline">
            <input type="text" name="goodId" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">
        	<button class="layui-btn  layui-btn-sm layui-btn-radius"  lay-filter="openGoodsSelector" onclick="openGoodsSelector()">选择商品</button>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-block">
            <input type="text" name="goodName" id="goodName" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">促销数量</label>
        <div class="layui-input-block">
            <input type="text" name="count"  lay-verify="required" lay-reqtext="促销数量不能为空" placeholder="请输入促销数量" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
    	<label class="layui-form-label">市场价</label>
            <div class="layui-input-block">
                 <input type="text" name="marketPrice"  lay-verify="required" lay-reqtext="市场价格不能为空" placeholder="￥" class="layui-input">
            </div>
    </div>
    <div class="layui-form-item">
    	<label class="layui-form-label">商城价</label>
            <div class="layui-input-block">
                 <input type="text" name="mallPrice"  lay-verify="required" lay-reqtext="商城价格不能为空" placeholder="￥" class="layui-input">
            </div>
    </div>
    <div class="layui-form-item">
    	<label class="layui-form-label">百分比/绝对值</label>
            <div class="layui-input-block">
                <input type="checkbox" id="priceType" value="1" name="close" lay-skin="switch" lay-filter="priceTypeFilter" lay-text="百分比|绝对值" >
            </div>
    </div>
    <div class="layui-form-item" id="salesDiv" style="display:none">
    	<label class="layui-form-label">百分比</label>
            <div class="layui-input-inline">
                <input type="text" id="sales"  name="close"  lay-filter="priceTypeFilter" onblur="changeSalePrice(this.value)" placeholder="'50' 表示50%的折扣" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">% 输入折扣率,将会自动算出促销价格</div>
    </div>
	<div class="layui-form-item">
    	<label class="layui-form-label">促销价</label>
            <div class="layui-input-block">
                 <input type="text" name="salePrice"  lay-verify="required" lay-reqtext="促销价格不能为空" placeholder="￥" class="layui-input">
            </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" id="saveTableForm" lay-filter="saveUser">确认保存</button>
        </div>
    </div>
</div>
</div>
<script>
    layui.use(['form','layer','table'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
            table = layui.table;
        //监听提交
        //form.on('submit(saveUser)', function (data) {
        	//console.log(data.field);
       // });
        form.on('switch(priceTypeFilter)', function(data){
        	  if(data.elem.checked){
        		  data.value = 2; //百分比,方便后台做判断
        		  //百分比价格,则自动显示促销率
        		  $("#salesDiv").css("display","block");
        	  }else{
        		  //绝对值则手动输入价格
        		  data.value = 1; //绝对值,方便后台做判断
        		  $("#salesDiv").css("display","none");
        	  }
        });  
    });
    
    /* 
    	打开商品表格选择器
    */
    function openGoodsSelector(){
    	 layui.use(['form','layer','table'], function () {
    	        var form = layui.form,
    	            layer = layui.layer,
    	            $ = layui.$,
    	            table = layui.table;
    	        var index = layer.open({
                    title: '选择商品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    area: ['100%', '100%'],
                    content: 'tableSelector.jsp'
                });
    	        
    	 })
    }
    
    function changeSalePrice(sales){
    	layui.use(['form'], function () {
	        var form = layui.form,
	            layer = layui.layer,
	            $ = layui.$
	    	var market = $("input[name='marketPrice']").val();
	        $("input[name='salePrice']").val(market*(sales/100));
    	})
    }
 </script>
</body>
</html>