<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>业绩完成率报表-月度累计</title>
    <style type="text/css">

    </style>
</head>
<body >

<div id="layout" class="easyui-layout" fit="true">
    <div region="north" border="false" collapsible="true" collapsed="false"
         class="zoc" title="查询条件" style="height: 60px; overflow: inherit;">
        <form onsubmit="return false;" action="" id="searchForm" enctype="multipart/form-data" method="post">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">年份:</td>
                    <td class="cxinput">
                        <input class="easyui-combobox" id="year" name="year" style="width:100px;" data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '2018',text: '2018年'},
										       {value: '2017',text: '2017年'},
										       {value: '2016',text: '2016年'}
												]"/>
                    </td>
                    <td class="cxlabel">
                        <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="exportPerformance()">导出</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'month',width:150,halign:'center',align:'left'">月份</th>
                <th data-options="field:'orderMonthTarget',width:200,halign:'center',align:'left'">订单完成目标</th>
                <th data-options="field:'orderMonthActual',width:200,halign:'center',align:'left'">订单完成实际</th>
                <th data-options="field:'orderMonthRate',width:200,halign:'center',align:'left'">订单完成率</th>
                <th data-options="field:'orderQuarterTarget',width:200,halign:'center',align:'left'">订单季度目标</th>
                <th data-options="field:'orderQuarterActual',width:200,halign:'center',align:'left'">订单季度实际</th>
                <th data-options="field:'orderQuarterRate',width:200,halign:'center',align:'left'">订单季度完成率</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<script type="text/javascript">
    var datagrid;
    var year;

    function loaddata(){
        year = $("#year").val();
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
    }

    //导出
    function exportPerformance(){
        if(!datagrid){
            $.messager.alert('提示','请先查询！','info');
            return;
        }
        $.messager.confirm('确认','确定要导出吗？', function(r){
            if (r){
                window.location.href="/report/exportMonthPerformanceList?year=" + year;
            }
        });
    }

    $(function(){
        year = $("#year").val();
        datagrid = $('#dg').datagrid({
            title:'业绩完成率报表-月度累计',
            toolbar:'#tb',
            singleSelect:true,
            fit:true,
            fitColumns:true,
            collapsible: true,
            rownumbers: true, //显示行数 1，2，3，4...
            pagination: true, //显示最下端的分页工具栏
            pagePosition : 'bottom',
            pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
            pageSize: 20, //读取分页条数，即向后台读取数据时传过去的值
            url:'/report/findMonthPerformanceList',
            nowrap : true,
            border : false
        });
    });

</script>
</body>
</html>
