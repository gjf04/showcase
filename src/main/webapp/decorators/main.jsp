<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>欧普照明流通渠道终端销售管理系统</title>
    <link rel="stylesheet" type="text/css" href="${staticURL}/jquery-easyui-${easyUIVersion}/themes/${easyUITheme}/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="${staticURL}/jquery-easyui-${easyUIVersion}/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="${staticURL}/jquery-easyui-${easyUIVersion}/themes/hz.css?t=2"/>
    <link rel="stylesheet" type="text/css" href="${staticURL}/style/common.css"/>
<%--     <link rel="shortcut icon" href="${staticURL}/images/opple.ico"/> --%>
    <script type="text/javascript" src="${staticURL}/portal/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${staticURL}/jquery-easyui-${easyUIVersion}/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${staticURL}/jquery-easyui-${easyUIVersion}/datagrid-groupview.js"></script>
    <script type="text/javascript" src="${staticURL}/jquery-easyui-${easyUIVersion}/hz.js"></script>
    <script type="text/javascript" src="${staticURL}/jquery-easyui-${easyUIVersion}/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${staticURL}/jquery-easyui-${easyUIVersion}/jquery.easyui.patch.js"></script>
    <script type="text/javascript">
    	//easyui layout折叠后显示标题     2015-01-11 liuxin
    	$.extend($.fn.layout.paneldefaults, {
        	onCollapse : function(){
	            //获取layout容器
	        	var layout = $(this).parents("body.layout");
		    	if(layout.length == 0) layout = $(this).parents("div.layout");
	            //获取当前region的配置属性
	            var opts = $(this).panel("options");
	            //获取key
	            var expandKey = "expand" + opts.region.substring(0, 1).toUpperCase() + opts.region.substring(1);
	            //从layout的缓存对象中取得对应的收缩对象
	            var expandPanel = layout.data("layout").panels[expandKey];
	            //针对横向和竖向的不同处理方式
	            if (opts.region == "west" || opts.region == "east") {
	                //竖向的文字打竖,其实就是切割文字加br
	            	if(opts && opts.title){
	            		 var split = [];
	                     for (var i = 0; i < opts.title.length; i++) {
	                         split.push(opts.title.substring(i, i + 1));
	                     }
	                     if(expandPanel){
	                          expandPanel.panel("setTitle", "&nbsp;");
	                         expandPanel.panel("body").addClass("panel-title").css("text-align", "center").html(split.join("<br>"));
	                     }
	            	}
	            } else {
	            	if(expandPanel){
	            		expandPanel.panel("setTitle", opts.title);
	            	}
	            }
	        }
	    });
    </script>
    <decorator:head/>
</head>
<body <decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.class" writeEntireProperty="true"/> >
	<decorator:body/>
</body>
</html>