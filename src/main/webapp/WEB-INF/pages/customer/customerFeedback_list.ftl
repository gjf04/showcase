<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>客户反馈信息查询</title>
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
                    <td class="cxinput"><input name="q_customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                    <td class="cxlabel"></td>
                    <td class="cxinput"></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <#--<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteCustomer()">删除</a>-->
        <#--<a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateCustomer()">修改</a>-->
            <#--<a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="distributionCustomer()">分配</a>-->
        <#--<a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createCustomer()">新增</a>-->

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'responsiblePerson',width:100,halign:'center',align:'left'">业务人员</th>
                <th data-options="field:'description',width:350,halign:'center',align:'left'">反馈详情</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


<!-- create  -->
<div class="easyui-dialog" id="addCustomerDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">客户名称<span style="color:red;">*</span>:</td>
            <td>
                <input id="f_customerName" name="f_customerName" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">业务人员:</td>
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


<script type="text/javascript">
    var addCustomerDialog;
    function loaddata(){
        <#--$('#dg').datagrid({url:'${dynamicURL}/basic/searchCustomer.action?'+$("#searchForm").form().serialize()});-->
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

    //新增数据
    function createCustomer() {
        addCustomerDialog.dialog('open');
    }

    $(function(){
        $('#dg').datagrid({
            title:'客户反馈列表',
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
            url:'/customer/customerFeedbackList',
            nowrap : true,
            border : false
        });

        //增加网点
        addCustomerDialog = $("#addCustomerDiv").dialog({
            title: '新增',
            width: 400,
            height: 450,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitForm();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    addCustomerDialog.dialog('close');
                }
            }]
        });
    });

    //错误提示

    function submitForm(){
        var customerCode = $('#customerCode').val();
        var customerName = $('#customerName').val();
        var typeCode = $('#typeCode').val();
        var typeName = $('#typeName').val();
        var phone = $('#phone').val();
        var fax = $('#fax').val();
        var address = $('#address').val();
        var url = $('#url').val();
        //var corporate = $('#corporate').val();
        var manager = $('#manager').val();
        var contact = $('#contact').val();
        var dockDepartment = $('#dockDepartment').val();
        var dockPerson = $('#dockPerson').val();
        var dockContact = $('#dockContact').val();
        var relateDepartment = $('#relateDepartment').val();
        var relatePerson = $('#relatePerson').val();
        var relateContact = $('#relateContact').val();
        $.ajax({
            type:'post',
            url:'/customer/createCustomer',
            dataType : "json",
            data:{customerCode:customerCode, customerName:customerName, typeCode:typeCode,
                typeName:typeName, phone:phone, fax:fax, address:address,
                url:url, manager:manager,
                contact:contact, dockDepartment:dockDepartment, dockPerson:dockPerson,
                dockContact:dockContact, relateDepartment:relateDepartment, relatePerson:relatePerson,
                relateContact:relateContact},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $('#createCustomerForm').form('clear');
                addCustomerDialog.dialog('close');
                $.messager.alert('提示',"新增客户成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }


    function showErrorMsg(result){
        if(result.errorMessages && !isEmpty(result.errorMessages)){
            var error = "";
            $.each(result.errorMessages,function(index,value) {//index就是field的name,value就是该filed对应的错误列表，这里取第一个
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }else if(result.fieldErrors && !isEmpty(result.fieldErrors)){
            var error = "";
            $.each(result.fieldErrors,function(index,value) {
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }else if(result.warningMessages && !isEmpty(result.warningMessages)){
            var error = "";
            $.each(result.warningMessages,function(index,value) {
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }
    }
</script>
</body>
</html>
