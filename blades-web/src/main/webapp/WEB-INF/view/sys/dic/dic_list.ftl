<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/resource/sys/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/sys/css/select.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/common/css/sys.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/resource/common/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/sys/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/sys/js/select-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/resource/common/js/sys.js"></script>
<script type="text/javascript" src="${ctx}/resource/plugins/layer-v2.1/layer/layer.js"></script>
<!-- 时间控件 -->
<script type="text/javascript" src="${ctx}/resource/plugins/calendar/WdatePicker.js"></script>
<style type="">
body {
	min-width: 820px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(e) {

		$(".select3").uedSelect({
			width : 152
		});

		//全选、全不选
		allCheckOrNot("all", "del");

		//初始化已选中的checkbox
		initCheckBox("idValues", "del");

		//提示层
		layer.msg('加载完成');
	});

	function toAdd() {
		window.location.href = "./save.do?pid=${pdic.id}";
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var checkVal = [];
		$(".click").click(function() {
			
			//跨页选中
			selectBoxs("idValues","del");
			
			if($("input[name='idValues']").val() ==""){
				layer.msg('请选择要删除的对象!');
				return;
			}
			
			checkVal = $("input[name='idValues']").val().split(",");
			
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			var url = "${ctx }/sys/dic/removes.do";
			//批量删除
			doDeletes(checkVal,url);
			
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
			$(".tip").fadeOut(100);
		});

	});

	//切换分页
	function page(pageNo, pageSize, comment) {
		//跨页选中
		selectBoxs("idValues","del");

		$("#queryForm").attr(
				"action",
				$("#queryForm").attr("action") + "?pageNo=" + pageNo
						+ "&pageSize=" + pageSize);
		$("#queryForm").submit();
	}

	function doRemove(id, name) {
		//询问框
		layer.confirm('你确定要删除『' + name + '』吗？', {
			btn : [ '确定', '取消' ], //按钮
			title : '友情提醒'
		}, function() {
			$.ajax({
				type : "POST",
				url : "remove.do?id=" + id,
				async : false,
				error : function(request) {
					layer.msg("服务器繁忙！");
				},
				success : function(res) {
					layer.msg("删除成功");
                    jumpPageNum();
				}
			});
		}, function() {

		});
	}

	function toView(id) {
		layer.open({
			type : 2,
			title : "字典信息",
			shade : false,
			area : [ '600px', '500px' ],
			maxmin : true,
			content : 'view.do?id=' + id,
			zIndex : layer.zIndex, //重点1
			success : function(layero) {
				layer.setTop(layero); //重点2
			}
		});
	}
</script>


</head>


<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li>系统管理</li>
			<li><a href="list.do">字典管理</a></li>
			<c:if test="${pdic!=null }">
				<li><a href="#">${pdic.name }</a></li>
				<li><a href="list.do?pid=${pdic.pid }" style="color: #00a4ac;">返回上一级</a></li>
			</c:if>
		</ul>
	</div>

	<div class="rightinfo">
		<form id="queryForm" action="list.do" method="post">
			<input name="pid" type="hidden" value="${pdic.id }" />
			<input id="idValues" name="idValues" type="hidden" value="${idValues}" />
			<div id="usual1" class="usual">
				<ul class="seachform">
					<li><label>字典名称</label><input name="name" type="text" class="scinput" value="${dic.name }" /></li>
					<li><label>字典代码</label><input name="code" type="text" class="scinput" value="${dic.code }" /></li>
				</ul>
				<!-- <div class="formtitle"><span>用户列表</span></div>-->
			</div>

			<div class="tools">

				<ul class="toolbar">
					<li onclick="toAdd()"><span><img src="${ctx}/resource/sys/images/t01.png" /></span>添加</li>
					<li class="click"><span><img src="${ctx}/resource/sys/images/t03.png" /></span>删除</li>
				</ul>

				<ul style="float: right;">
					<li><input name="" type="submit" class="scbtn" value="查询" /></li>
				</ul>

			</div>
		</form>

		<table class="tablelist">
			<thead>
				<tr>
					<th><input name="all" type="checkbox" value=""/></th>
					<th>序号</th>
					<th>字典名称</th>
					<th>字典代码</th>
					<th>别称</th>
					<th>字典类型</th>
					<th>系统启动加载</th>
					<th>更新时间</th>
					<th>排序号</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list page.list as dic>
					<tr>
						<td><input name="del" type="checkbox" value="${dic.id}" /></td>
						<td>${page.startIndex+dic_index+1 }</td>
						<td>${dic.name }</td>
						<td>${dic.code }</td>
						<td>${dic.alias }</td>
						<td><@dict.getName type = "DIC_TYPE" value=dic.classify/></td>
						<td>${dic.cacheAble }</td>
						<td><@date.convertStrDate dateStr=dic.updateTime mask="yyyy-MM-dd HH:mm:ss" /></td>
						<td>${dic.orderNo }</td>
						<td><a href="#" onclick="toView('${dic.id}')" class="tablelink">查看</a> <a href="update.do?id=${dic.id }"
							class="tablelink"> 编辑</a> <a href="list.do?pid=${dic.id }" class="tablelink"> 子项</a> 
							<#if dic.classify=='02' >
								<a href="tree_manage.do?id=${dic.id}" class="tablelink"> 树形管理</a>
							</#if> <a href="#" class="tablelink" onclick="doRemove('${dic.id}','${dic.name }')"> 删除</a></td>
					</tr>
				</#list>
			</tbody>
		</table>


		<div class="page blue">${page.html2 }</div>


		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="${ctx}/resource/sys/images/ticon.png" /></span>
				<div class="tipright">
					<p>是否确认对字典的批量删除？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定" />&nbsp; <input name="" type="button" class="cancel"
					value="取消" />
			</div>

		</div>


	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
