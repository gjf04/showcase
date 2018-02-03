<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>报销管理</title>
    <style type="text/css">

    </style>
</head>
<body >

<div id="layout" class="easyui-layout" fit="true">
    <div region="north" border="false" collapsible="true" collapsed="false"
         class="zoc" title="查询条件" style="height: 60px; overflow: inherit;">
        <form onsubmit="return false;" id="searchForm">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">业务员:</td>
                    <td class="cxinput"><input name="userName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">费用类型：</td>
                    <td class="cxinput">
                        <input class="easyui-combobox" name="style" style="width:100px;"
                            data-options="
                                valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
                                data: [
                                    {value: '所有', text: '所有'},
                                    {value: '燃油费',text: '燃油费'},
                                    {value: '公交/长途车',text: '公交/长途车'},
                                    {value: '出租车',text: '出租车'},
                                    {value: '话费',text: '话费'},
                                    {value: '宴请',text: '宴请'},
                                    {value: '出差',text: '出差'}
                                ]
                            "
                        />
                    </td>
                    <#--<td class="cxlabel">审核状态:</td>-->
                    <#--<td class="cxinput">-->
                        <#--<input class="easyui-combobox" name="style" style="width:100px;"-->
                               <#--data-options="-->
                                <#--valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',-->
                                <#--data: [-->
                                    <#--{value: '所有', text: '所有'},-->
                                    <#--{value: '1',text: '业务提交'},-->
                                    <#--{value: '2',text: '销售总监已审'},-->
                                    <#--{value: '3',text: '财务已审'},-->
                                    <#--{value: '4',text: '打回'}-->
                                <#--]-->
                            <#--"-->
                        <#--/>-->
                    <#--</td>-->
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <a href="javascript:void(0);" id="approval1btn" disabled="false" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="approval()">审核通过</a>
        <a href="javascript:void(0);" id="wrong1btn" disabled="false" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="wrong()">错误打回</a>
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter: function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'userName',width:15,halign:'center',align:'center'" >业务员</th>
                <th data-options="field:'style',width:20,halign:'center',align:'center'">费用类型</th>
                <th data-options="field:'feeAmt',width:15,halign:'center',align:'center'" >费用金额</th>
                <th data-options="field:'feeDate',width:25,halign:'center',align:'center'">费用发生日期</th>
                <th data-options="field:'createdAt',width:25,halign:'center',align:'center'">申请日期</th>
                <th data-options="field:'approvalState',width:10,halign:'center',align:'center'">审核状态</th>
                <th data-options="field:'approvalMan',width:15,halign:'center',align:'center'">营销总监</th>
                <th data-options="field:'approvalDate',width:25,halign:'center',align:'center'">审核日期</th>
                <th data-options="field:'caiwuMan',width:15,halign:'center',align:'center'">财务</th>
                <th data-options="field:'caiwuDate',width:25,halign:'center',align:'center'">财务审核日期</th>

            </tr>
            </thead>
        </table>
    </div>
</div>


<!-- 提交框 -->
<div class="easyui-window" id="approvalDialog" title="提交报销费用" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="approvalData" method="post" action="/approval/approval1">
        <input id ="id" type="hidden" name = "id"/>
        <input id="approvalState" type="hidden" name="approvalState"/>
        <input id="status" type="hidden" name="status"/>
        <input id="paramstyle" type="hidden" name="paramstyle"/>
        <table style="border-collapse:collapse; border-spacing:0;width: 100%; height:100px;">
            <tr style="height: 50px;">
                <td colspan="2" align="center" class="cxlabel">确定审核通过该笔报销费用吗？</td>
            </tr>

            <tr style="height: 50px;">
                <td  colspan="2" align="center">
                    <a href="javascript:void(0);" id="checkbtn" class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="approvalForm()">通 过</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancelapproval()">取 消</a>
                </td>
            </tr>

        </table>
    </form>
</div>



<script type="text/javascript">


    function loaddata(){
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
    }
    function formatDateTime(val,row){
        if(!val.time){
            return "";
        }
        var date = new Date(val.time);
        return simpleDateTimeFormatter(date);
    }
    var statusMap = {'1':'启用','0':'禁用'};
    function statusFormater(val,row){
        return statusMap[val];
    }


    $(function(){
        Request = {
            QueryString: function(item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }
        var style = Request.QueryString("style");
        console.log("审核参数：", style);
        $("#paramstyle").val(style);

        $('#dg').datagrid({
            title:'审核报销费用表',
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
            queryParams: {
                approvalState: style,
                approvalstyle: style
            },
            url:'/approval/approvallist',
            nowrap : true,
            border : false,
            onClickRow: function(rowIndex, field, value){
                var b = true;
                if (style == 1)
                    b = (field.approvalState == 1);
                if (style == 2)
                    b = (field.approvalState == 2);
                var enablebtn = 'disable';
                if (b) {enablebtn = 'enable';}
                $('#approval1btn').linkbutton(enablebtn);
                $('#wrong1btn').linkbutton(enablebtn);
            }
        });
    });

    // 错误打回
    function wrong() {
        var rows = $('#dg').datagrid('getSelections');
        if(rows.length == 1) {
            var data = {
                'id' : rows[0].id,
                'style': rows[0].style,
                'feeAmt': rows[0].feeAmt,
                'feeDate': rows[0].feeDate,
                'approvalMan': rows[0].approvalMan,
                'caiwuMan': rows[0].caiwuMan,
                'approvalDate': rows[0].approvalDate,
                'caiwuDate': rows[0].caiwuDate,
                'approvalState': rows[0].approvalState
            };
            console.log('错误打回data:',data);
            $('#approvalData').form('load',data);

        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#approvalData #checkbtn .l-btn-text").text("打回");
        $("#approvalData #status").val(2);
        $("#approvalDialog").window("open");
    }

    // 提交框
    function approval() {
        var rows = $('#dg').datagrid('getSelections');
        if(rows.length == 1) {
            var data = {
                'id' : rows[0].id,
                'style': rows[0].style,
                'feeAmt': rows[0].feeAmt,
                'feeDate': rows[0].feeDate,
                'approvalMan': rows[0].approvalMan,
                'caiwuMan': rows[0].caiwuMan,
                'approvalDate': rows[0].approvalDate,
                'caiwuDate': rows[0].caiwuDate,
                'approvalState': rows[0].approvalState
            };
            console.log('data:',data);
            $('#approvalData').form('load',data);

        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#approvalData #checkbtn .l-btn-text").text("审核通过");
        $("#approvalData #status").val(1);  // 审核通过标记 1通过 2打回
        $("#approvalData #approvalState").val(2);   // 审核状态标记 2总监通过 3财务通过
        $("#approvalDialog").window("open");
    }

    function cancelapproval(){
        $("#approvalDialog").window("close");
    }

    // 提交费用审核
    function approvalForm(){
        var status = $("#approvalData #status").val();
        console.log("审核状态(1提交2打回)：", status);
        $('#approvalData').form('submit', {

            onSubmit: function() {
                $.messager.progress({
                    text : "正在保存，请稍后...",
                    interval : 100
                });
                return true;
            },
            success : function(result) {
                $.messager.progress('close');
                handleActionResult(result, {
                    onSuccess : function() {
                        $.messager.show({
                            title : '提示',
                            msg : '审核通过成功'
                        });
                        $('#dg').datagrid('reload');
                        $("#approvalDialog").window("close");
                    }
                });
            }
        });
    }

</script>
</body>
</html>
