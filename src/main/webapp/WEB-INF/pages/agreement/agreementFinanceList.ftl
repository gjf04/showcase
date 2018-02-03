<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>财务收款确认</title>
<#include "../common/easyui_core.ftl"/>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height:120px;" class="zoc">
        <form id="Form" action="/uploadReportFile.html" method="post">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput">
                        <input id="q_firstParty" name="q_firstParty" class="easyui-textbox" style="width:100px;">
                    </td>
                    
                    
                </tr>
                <tr>
                    <td class="cxlabel">签订日期:</td>
                    <td class="cxinput">
                    	<input type="text" id="q_agreeDate" name="q_agreeDate" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"/>
                    </td>
                    
                </tr>
              </table>
                     
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search">查询</a>
                        <a id="editPayRatio" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="false" >付款录入</a>
                        <a id="editRatio" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="false" >付款比例修改</a>
                    </td>

        </form>
    </div>
    <div data-options="region:'center',border:false" style="left: 0px; top: 240px; width: 1920px;">
        <table id="dataGrid"></table>
    </div>
</div>

<!-- create  -->
<div class="easyui-dialog" id="payListDiv" style="width:486px;height:450px;"
     data-options="modal:true,closed:true,resizable:false" >
    <div data-options="region:'center',border:false" style="left: 0px; top: 0px; width:486px;height:350px;">
        <table id="dataGridPay"></table>
    </div>
</div>

<!-- create  -->
<div class="easyui-dialog" id="addPayDiv" style="width:320px;height:780px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <!--<tr>
            <td style="text-align: right;">付款类型<span style="color:red;">*</span>:</td>
            <td>
                <input id="payType_input" name="payType_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr> -->
        
        <tr>
            <td style="text-align: right;">付款金额<span style="color:red;">*</span>:</td>
            <td>
                <input id="payAmount_input" name="payAmount_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">付款人<span style="color:red;">*</span>:</td>
            <td>
                <input id="userName_input" name="userName_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">备注信息<span style="color:red;"> </span>:</td>
            <td>
                <input id="remark_input" name="remark_input" type="text" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width:100px;"></input>
            </td>
        </tr>
        <input id="agreeId" name="agreeId" type="text"  style="width:80px;" hidden='true' />
    </table>
</div>

<div class="easyui-dialog" id="addPayDiv" style="width:320px;height:780px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <!--<tr>
            <td style="text-align: right;">付款类型<span style="color:red;">*</span>:</td>
            <td>
                <input id="payType_input" name="payType_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr> -->
        
        <tr>
            <td style="text-align: right;">付款金额<span style="color:red;">*</span>:</td>
            <td>
                <input id="payAmount_input" name="payAmount_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">付款人<span style="color:red;">*</span>:</td>
            <td>
                <input id="userName_input" name="userName_input" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:100px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">备注信息<span style="color:red;"> </span>:</td>
            <td>
                <input id="remark_input" name="remark_input" type="text" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width:100px;"></input>
            </td>
        </tr>
        <input id="agreeId" name="agreeId" type="text"  style="width:80px;" hidden='true' />
    </table>
</div>


<script type="text/javascript">
var datagrid;
var datagridPay;
var queryParameters;

// 判断是否为空
$.isNotBlank = function(value) {
    if (value != undefined && value != "undefined" && value != null && value != "null" && value != "") {
        return true;
    }
    return false;
};

//查询
$('#searchPt').click(function () {
    //grid加载
    $('#dataGrid').datagrid('load',queryParamsHandler());
});


function toAgreementDetail(id){
	//window.location.href="/agreementInfo/toAgreementUpload?id="+id;
	window.open("/agreementInfo/toAgreementDetail.html?id="+id);
};

var editRatioDivDialog;
var addPayDivDialog;
var payListDivDialog;
//修改比率
$('#editRatio').click(function () {
    //grid加载
    var row = $('#dataGrid').datagrid('getSelected');
    if(row){
    	$('#firstRatio_input').textbox('setValue',row.firstRatio);
    	$('#lastRatio_input').textbox('setValue',row.lastRatio);
    	$('#Ratio_id').val(row.id);
    	editRatioDivDialog.dialog('open');
    }else{
        $.messager.alert('提示', '请选择一条记录！', 'warning');
    }
});

//添加付款信息
$('#editPayRatio').click(function () {
    //grid加载
    var row = $('#dataGrid').datagrid('getSelected');
    if(row){
    	$('#agreeId').val(row.id);
    	addPayDivDialog.dialog('open');
    }else{
        $.messager.alert('提示', '请选择一条记录！', 'warning');
    }
});


function toPayDetail(id) {
    //grid加载
    payListDivDialog.dialog('open');
    $('#dataGridPay').datagrid({
        toolbar:'#tb',
        singleSelect:true,
        fitColumns: false,
        fit: true,
        collapsible: true,
        rownumbers: true, //显示行数 1，2，3，4...
        pagination: true, //显示最下端的分页工具栏
        pageList: [5,10], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
        pageSize: 10, //读取分页条数，即向后台读取数据时传过去的值
        url:'/agreementFinance/agreementPayList',
        queryParams: {agreeId:id},
        columns: [
            [
                {
                    field: 'id',
                    width: 10,
                    align: 'center',
                    hidden:true
                },{
                    field: 'checked',
                    width: 10,
                    align: 'center',
                    checkbox:true
                },
                {
                    field: 'userName',
                    title: '收款人',
                    width: 100,
                    align: 'center'
                },{
                    field: 'shouldPay',
                    title: '应付金额',
                    width: 60,
                    align: 'center'
                },{
                    field: 'payAmount',
                    title: '支付金额',
                    width: 60,
                    align: 'center'
                },{
                    field: 'createdAt',
                    title: '支付时间',
                    width: 100,
                    align: 'center'
                },{
                    field: 'remark',
                    title: '备注',
                    width: 100,
                    align: 'center'
                }
            ]
        ]
    });
    
    $('#dataGridPay').datagrid('load');
};
var regex = /^\d+\.?\d{0,2}$/;

function submitForm(){
        var firstRatio = $('#firstRatio_input').val();
        var lastRatio = $('#lastRatio_input').val();
        if (!regex.test(firstRatio)|| !regex.test(lastRatio)){
        	$.messager.alert('提示',"付款比例必须为数字！");
        	return;
        }
        var Ratio_id = $('#Ratio_id').val();
        $.ajax({
            type:'post',
            url:'/agreementInfo/saveEdit',
            dataType : "json",
            data:{id:Ratio_id,firstRatio:firstRatio, lastRatio:lastRatio},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dataGrid').datagrid('load',queryParamsHandler());
                editRatioDivDialog.dialog('close');
                $.messager.alert('提示',"修改成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

function submitAddPayForm(){
        var agreeId = $('#agreeId').val();
        var payType = $('#payType_input').val();
        var payAmount = $('#payAmount_input').val();
        var userName = $('#userName_input').val();
        var remark = $('#remark_input').val();
        if(!regex.test(payAmount) ){
        	$.messager.alert('提示',"付款金额必须为数字！");
        	return;
        }
        $.ajax({
            type:'post',
            url:'/agreementFinance/saveAgreementPay',
            dataType : "json",
            data:{agreeId:agreeId,payAmount:payAmount,remark:remark,userName:userName, payType:payType},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dataGrid').datagrid('load',queryParamsHandler());
                addPayDivDialog.dialog('close');
                $.messager.alert('提示',"修改成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }
        
function approvalStatusFormatter(value, row, index){
	//审批状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成
	var result = "";
	if(value==0){
		result = '已保存待提交';
	}else if(value==1){
		result = '待内勤初审';
	}else if(value==2){
		result = '待总监审核';
	}else if(value==3){
		result = '待合同上传';
	}else if(value==4){
		result = '签订完成';
	}
	return result;
}

$(function(){
    datagrid = $('#dataGrid').datagrid({
        title:'合同信息列表',
        toolbar:'#tb',
        singleSelect:true,
        fitColumns: false,
        fit: true,
        collapsible: true,
        rownumbers: true, //显示行数 1，2，3，4...
        pagination: true, //显示最下端的分页工具栏
        pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
        pageSize: 20, //读取分页条数，即向后台读取数据时传过去的值
        url:'/agreementFinance/agreementList',
        queryParams: queryParamsHandler(),
        columns: [
            [
                {
                    field: 'id',
                    width: 10,
                    align: 'center',
                    hidden:true
                },{
                    field: 'checked',
                    width: 10,
                    align: 'center',
                    checkbox:true
                },{
                    field: 'agreeSn',
                    title: '合同编号',
                    width: 70,
                    align: 'center'
                },
                {
                    field: 'firstParty',
                    title: '客户名称',
                    width: 150,
                    align: 'center'
                },{
                    field: 'agreementAmount',
                    title: '合同金额',
                    width: 70,
                    align: 'center'
                },{
                    field: 'approvalStatus',
                    title: '合同状态',
                    width: 100,
                    align: 'center',
                    formatter: approvalStatusFormatter
                },{
                    field: 'agreeDate',
                    title: '合同签订时间',
                    width: 120,
                    align: 'center'
                },{
                    field: 'firstRatio',
                    title: '首付款比例',
                    width: 120,
                    align: 'center',
                    formatter: function(value, row, index){
                        var result = '';
                        if(value != undefined){
                         result = value+'%';
                        }
                        return result;
                    }
                },{
                    field: 'lastRatio',
                    title: '尾款比例',
                    width: 120,
                    align: 'center',
                    formatter: function(value, row, index){
                        var result = '';
                        if(value != undefined){
                         result = value+'%';
                        }
                        return result;
                    }
                },{
                    field: 'createdBy',
                    title: '合同详情',
                    width: 70,
                    align: 'center',
                    formatter: function(value, row, index){
                    	var result = '<a href="#" onclick="toAgreementDetail(\'' + row.id + '\' )">详情</a> ';
                    	return result;
                    }
                },{
                    field: 'toPayDetail',
                    title: '付款详情',
                    width: 70,
                    align: 'center',
                    formatter: function(value, row, index){
                    	var result = '<a href="#" onclick="toPayDetail(\'' + row.id + '\' )">查看</a> ';
                    	return result;
                    }
                },{
                    field: 'operate',
                    title: '操作',
                    width: 70,
                    align: 'center',
                    formatter: function(value, row, index){
                    	var result='';
                    	if(row.approvalStatus==0){
                    		result = '<a href="#" onclick="doEdit(\'' + row.id + '\' )">编辑</a> ';
                    	}
                    	return result;
                    }
                }
            ]
        ]
    });
    
    
    editRatioDivDialog = $("#editRatioDiv").dialog({
            title: '修改合同付款比例',
            width: 250,
            height: 150,
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
                    editRatioDivDialog.dialog('close');
                }
            }]
        });
        
    addPayDivDialog = $("#addPayDiv").dialog({
            title: '添加合同付款信息',
            width: 300,
            height: 250,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitAddPayForm();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    addPayDivDialog.dialog('close');
                }
            }]
        });
        
    payListDivDialog = $("#payListDiv").dialog({
            title: '合同付款信息列表',
            width: 500,
            height: 426,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    payListDivDialog.dialog('close');
                }
            }]
        });
})
</script>
</body>