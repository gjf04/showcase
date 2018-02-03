<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>订单信息查询</title>
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
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="q_customerName" id="q_customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
            <#if showFeedbackOrdersButton?? && showFeedbackOrdersButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="feedback();">跟进反馈</a>
            </#if>
            <#if showPreInstallTimeOrdersButton?? && showPreInstallTimeOrdersButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="preInstallTime();" >预约安装时间</a>
            </#if>
            <#if showAcceptanceOrdersButton?? && showAcceptanceOrdersButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="openImportWin()">验收</a>
            </#if>

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'approvalStatus',width:100,halign:'center',align:'left',formatter:statusFormater">合同状态</th>
                <th data-options="field:'feedback',width:100,halign:'center',align:'center',formatter:feedbackFormater">反馈情况</th>
                <th data-options="field:'agreeSn',width:100,halign:'center',align:'center',formatter:agreeFormater">合同</th>
                <th data-options="field:'preInstallAt',width:100,halign:'center',align:'center'">预约安装时间</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<!-- 跟进反馈  -->
<div class="easyui-dialog" id="addOrderFeedbackDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">内勤人员:</td>
            <td>
                <input id="f_responsiblePerson" name="f_responsiblePerson" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">反馈详情:</td>
            <td>
                <input id="f_description" name="f_description" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
    </table>
</div>

<!-- 预约安装时间  -->
<div class="easyui-dialog" id="preInstallTimeDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">预约安装时间:</td>
            <td>
                <input id="p_installAt" name="p_installAt" size="54" type="text" class="easyui-datebox"  data-options="sharedCalendar:'#sc',editable:false" style="width:200px;" />
                <div id="sc" class="easyui-calendar"></div>
            </td>
        </tr>
    </table>
</div>

<!-- 验收窗口 -->
<div id="importDialog" class="easyui-window" title="验收"  style="width:460px;height:120px"
     data-options="closed:true,iconCls:'icon-save',modal:true,collapsible:false,minimizable:false,maximizable:false">
    <form onsubmit="return false;" id="importForm" enctype="multipart/form-data" method="post"
          action="/system/uploadAttachment">
        <table class="fixedTb">
            <tr>
                <td class="formlabletd">文件:</td>
                <td width="200px;">
                    <input id="importFile" type="file"  name="file"  style="width:200px">
                    <input id="importFileName" type="hidden"  name="fileName" >
                    <input id="relateId" type="hidden"  name="relateId" >
                    <input id="fileType" type="hidden"  name="fileType" value="3">
                </td>
                <td style="width:100px;padding-left: 20px;padding-right: 20px;">
                    <a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-ok'" onclick="importRow();">提交</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
    var datagrid;

    function loaddata(){
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
    }

    $(function(){
        datagrid = $('#dg').datagrid({
            title:'订单列表',
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
            url:'/order/orderList',
            nowrap : true,
            border : false
        });
    });

    var statusMap = {'1':'待内勤初审','0':'已保存待提交'};
    function statusFormater(val,row){
        return statusMap[val];
    }

    function feedbackFormater(val,row){
        return '<a href="#" >查看详情</a>';
    }

    function agreeFormater(val,row){
        return '<a href="#" >查看详情</a>';
    }

    //跟进反馈
    function feedback(){
        var selectedRow = $('#dg').datagrid('getSelected');
        if(!selectedRow || selectedRow == null){
            $.messager.alert('操作提示','请选择要操作的数据！','info');
            return;
        }
        $("#addOrderFeedbackDiv").dialog({
            title: '跟进反馈',
            width: 400,
            height: 250,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitFeedback();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#addOrderFeedbackDiv').dialog('close');
                }
            }]
        });
        $('#addOrderFeedbackDiv').dialog('open');
    }

    function submitFeedback(){
        var row = $('#dg').datagrid('getSelected');
        var orderId = row.id;
        var customerCode = row.customerCode;
        var customerName = row.customerName;
        var responsiblePerson = $('#f_responsiblePerson').val();
        var description = $('#f_description').val();
        $.ajax({
            type:'post',
            url:'/order/createOrderFeedback',
            dataType : "json",
            data:{orderId:orderId, customerCode:customerCode, customerName:customerName, responsiblePerson:responsiblePerson, description:description},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                //$('#dg').datagrid('reload');
                $('#addOrderFeedbackDiv').dialog('close');
                $.messager.alert('提示',"跟进反馈成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    //预约安装时间
    function preInstallTime(){
        var selectedRow = $('#dg').datagrid('getSelected');
        if(!selectedRow || selectedRow == null){
            $.messager.alert('操作提示','请选择要操作的数据！','info');
            return;
        }
        $("#preInstallTimeDiv").dialog({
            title: '预约安装时间',
            width: 400,
            height: 250,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitPreInstallTime();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#preInstallTimeDiv').dialog('close');
                }
            }]
        });
        $('#preInstallTimeDiv').dialog('open');
    }

    function submitPreInstallTime(){
        var row = $('#dg').datagrid('getSelected');
        var orderId = row.id;
        var installAt = $('#p_installAt').datebox("getValue");
        $.ajax({
            type:'post',
            url:'/order/preInstallTime',
            dataType : "json",
            data:{orderId:orderId, installAt:installAt},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $('#preInstallTimeDiv').dialog('close');
                $.messager.alert('提示',"预约安装时间成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    //打开验收窗口
    function openImportWin(){
        var selectedRow = $('#dg').datagrid('getSelected');
        if(!selectedRow || selectedRow == null){
            $.messager.alert('操作提示','请选择要操作的数据！','info');
            return;
        }
        $('#importForm').form("clear");
        $('#relateId').val(selectedRow.id);
        $('#fileType').val(3);
        $("#importDialog").window("open");
    }

    //上传文件
    function importRow(){
        $('#importForm').form('submit',{
            onSubmit : function(param) {
                if($("#importFile").val()==""){
                    $.messager.alert('提示','请选择要上传的文件！','warning');
                    return false;
                }
                $.messager.progress({
                    text : '正在上传，请稍后...',
                    interval : 100
                });
                return true;
            },
            success : function(result) {
                $.messager.progress('close');
                var data = eval('(' + result + ')');
                var messages = data.messages;
                if(messages!=null && messages!=""){
                    $.messager.alert('提示',messages,'warning');
                }else{
                    $.messager.show({
                        title : '提示',
                        msg : '操作成功！'
                    });
                    $("#importDialog").window("close");
                }
            }
        });
    }

</script>
</body>
</html>
