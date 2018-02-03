<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>费用支出报表-按月汇总</title>
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
                        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="exportExpense()">导出</a>
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
                <th data-options="field:'fuelCharge',width:200,halign:'center',align:'left'">燃油费</th>
                <th data-options="field:'busFee',width:200,halign:'center',align:'left'">公交/长途车</th>
                <th data-options="field:'taxiFee',width:200,halign:'center',align:'left'">出租车</th>
                <th data-options="field:'telephoneCharge',width:200,halign:'center',align:'left'">话费</th>
                <th data-options="field:'feteFee',width:200,halign:'center',align:'left'">宴请</th>
                <th data-options="field:'travellingExpenses',width:200,halign:'center',align:'left'">出差</th>
                <th data-options="field:'marketingCosts',width:200,halign:'center',align:'left'">营销费用</th>
                <th data-options="field:'allCosts',width:200,halign:'center',align:'left'">费用总计</th>
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
    function exportExpense(){
        if(!datagrid){
            $.messager.alert('提示','请先查询！','info');
            return;
        }
        $.messager.confirm('确认','确定要导出吗？', function(r){
            if (r){
                window.location.href="/report/exportMonthExpenseList?year=" + year;
            }
        });
    }

    $(function(){
        year = $("#year").val();
        datagrid = $('#dg').datagrid({
            title:'费用支出报表-按月汇总',
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
            url:'/report/findMonthExpenseList',
            nowrap : true,
            border : false
        });
    });

</script>
</body>
</html>
