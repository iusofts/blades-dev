﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/resource/sys/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${ctx}/resource/sys/js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson .header").click(function(){
		var $parent = $(this).parent();
		$(".menuson>li.active").not($parent).removeClass("active open").find('.sub-menus').hide();
		
		$parent.addClass("active");
		if(!!$(this).next('.sub-menus').size()){
			if($parent.hasClass("open")){
				$parent.removeClass("open").find('.sub-menus').hide();
			}else{
				$parent.addClass("open").find('.sub-menus').show();	
			}
			
			
		}
	});
	
	// 三级菜单点击
	$('.sub-menus li').click(function(e) {
        $(".sub-menus li.active").removeClass("active")
		$(this).addClass("active");
    });
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('.menuson').slideUp();
		if($ul.is(':visible')){
			$(this).next('.menuson').slideUp();
		}else{
			$(this).next('.menuson').slideDown();
		}
	});
})	
</script>


</head>

<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>主菜单</div>
    
    <dl class="leftmenu">
        
    <dd>
    <div class="title">
    <span><img src="${ctx}/resource/sys/images/leftico01.png" /></span>系统管理
    </div>
    	<ul class="menuson">
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/sys/user/list.do" target="rightFrame">用户管理</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/sys/role/list/.do" target="rightFrame">角色管理</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/sys/org/manage.do" target="rightFrame">机构管理</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/sys/module/manage.do" target="rightFrame">模块管理</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/sys/dic/list.do" target="rightFrame">字典管理</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="${ctx }/druid/index.html" target="rightFrame">系统监控</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="login_log.html" target="rightFrame">登陆日志</a>
            <i></i>
            </div>
        </li>
        
        <li>
            <div class="header">
            <cite></cite>
            <a href="operation_log.html" target="rightFrame">操作日志</a>
            <i></i>
            </div>
        </li>

        </ul>    
    </dd>
        
    
    <dd>
        <div class="title">
        <span><img src="${ctx}/resource/sys/images/leftico02.png" /></span>系统设置
        </div>
        <ul class="menuson">
            <li>
                <div class="header">
                <cite></cite>
                <a href="upload_settings.html" target="rightFrame">上传设置</a>
                <i></i>
                </div>
            </li>
        </ul>     
    </dd>
    
    </dl>
    
</body>
</html>
