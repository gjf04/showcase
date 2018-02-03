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
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <a href="javascript:void(0);" id="newbtn" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="create()">新增</a>
        <a href="javascript:void(0);" id="updatebtn" disabled="false" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="update()">修改</a>
        <a href="javascript:void(0);" id="delbtn" disabled="false" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteRow()">删除</a>
        <a href="javascript:void(0);" id="approvalbtn" disabled="false" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="approval()">提交</a>
        <#--<input type="file" name="fileString" multiple class="file"/>-->
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
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
<!-- add -->

<div id="addWin" class="easyui-window" title="添加报销费用" style="width:380px;height:340px"
     data-options="closed:true,iconCls:'icon-add',modal:true,collapsible:false,minimizable:false,maximizable:false">
     <form id="addForm">   
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">费用类型:</td>
                <td width="23%">
                    <select id="style" class="easyui-combobox" name="style" style="width:90%">
                        <option value="燃油费">燃油费</option>
                        <option value="公交/长途车">公交/长途车</option>
                        <option value="出租车">出租车</option>
                        <option value="话费">话费</option>
                        <option value="宴请">宴请</option>
                        <option value="出差">出差</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">费用金额:</td>
                <td width="23%">
                    <input id="feeAmt" class="easyui-numberbox" name="feeAmt" style="width:90%" data-options="min:0,precision:2" required="required"/>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">费用日期:</td>
                <td width="23%">
                    <input id="feeDate" name="feeDate" type="text" class="easyui-datebox" required="required">
                </td>
            </tr>


            <tr style="height: 50px;">
                <td  colspan="2" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="submitForm()">保 存</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancel()">取 消</a>
                </td>
            </tr>

        </table>
        </form>
</div>


<!-- 修改框 -->
<div class="easyui-window" id="editDialog" title="修改报销费用" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateData" method="post" action="/fee/update">
        <input id ="id" type="hidden"  name = "id">
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">费用类型:</td>
                <td width="23%">
                    <select id="style" class="easyui-combobox" name="style" style="width:90%">
                        <option value="燃油费">燃油费</option>
                        <option value="公交/长途车">公交/长途车</option>
                        <option value="出租车">出租车</option>
                        <option value="话费">话费</option>
                        <option value="宴请">宴请</option>
                        <option value="出差">出差</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">费用金额:</td>
                <td width="23%">
                    <input id="feeAmt" class="easyui-numberbox" name="feeAmt" style="width:90%" data-options="min:0,precision:2" required="required"/>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">费用日期:</td>
                <td width="23%">
                    <input id="feeDate" name="feeDate" type="text" class="easyui-datebox" required="required">
                    <input type="hidden" id="approvalMan" name="approvalMan" class="textbox-value" value=""/>
                    <input type="hidden" id="caiwuMan" name="caiwuMan" class="textbox-value" value=""/>
                    <input type="hidden" id="approvalDate" name="approvalDate" class="textbox-value" value=""/>
                    <input type="hidden" id="caiwuDate" name="caiwuDate" class="textbox-value" value=""/>
                    <input type="hidden" id="approvalState" name="approvalState" class="textbox-value" value=""/>
                </td>
            </tr>


            <tr style="height: 50px;">
                <td  colspan="2" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="editForm()">保 存</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancelUpdate()">取 消</a>
                </td>
            </tr>

        </table>
    </form>
</div>

<!-- 提交框 -->
<div class="easyui-window" id="approvalDialog" title="提交报销费用" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="approvalData" method="post" action="/fee/approval">
        <input id ="id" type="hidden"  name = "id">
        <table style="border-collapse:collapse; border-spacing:0;width: 100%; height:100px;">
            <tr style="height: 50px;">
                <td colspan="2" align="center" class="cxlabel">确定提交该笔报销费用吗？</td>
            </tr>

            <tr style="height: 50px;">
                <td  colspan="2" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="approvalForm()">提 交</a>&nbsp;&nbsp;&nbsp;&nbsp;
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

    //新增数据
    function create() {
    	$("#addForm").form("reset");
        $("#addWin").window("open");
    }

    $(function(){
        $('#dg').datagrid({
            title:'报销费用表',
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
            url:'/fee/feelist',
            nowrap : true,
            border : false,
            onClickRow: function(rowIndex, field, value){
                var b = (field.approvalState == 0 || field.approvalState == 4);
                var enablebtn = 'disable';
                if (b) {enablebtn = 'enable';}
                $('#updatebtn').linkbutton(enablebtn);
                $('#delbtn').linkbutton(enablebtn);
                $('#approvalbtn').linkbutton(enablebtn);
            }
        });
    });
    //错误提示

	function cancelUpdate(){
		$("#editDialog").window("close");
	}

	function cancel(){
		$("#addWin").window("close");
	}

    function submitForm(){
        var style = $('#addForm #style').combobox("getValue");
        var feeAmt = $('#addForm #feeAmt').val();
        var feeDate = $('#addForm #feeDate').datebox("getValue");

        $.ajax({
            type:'post',
            url:'/fee/create',
            dataType : "json",
            data:{
                style: style,
                feeAmt: feeAmt,
                feeDate: feeDate
            },
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $("#addWin").window("close");
                $.messager.alert('提示',"新增成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });
    }
    
    //删除数据
     function deleteRow() {
        var rows = $('#dg').datagrid('getSelections');
        var ids = '';
        if(rows.length >= 1) {
        var valArr = new Array;
    	for(var i=0;i<rows.length;i++){
    		valArr[i] = rows[i].id;
    	}
    
	    ids = valArr.join(',');
        $.ajax({
            type:'post',
            url:'/fee/delete',
            dataType : "json",
            data:{id:ids},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $.messager.alert('提示',"删除成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });
        }else{
            $.messager.alert('操作提示', '请选择要删除的数据！', 'info');
            return;
        }
        
    }

    //修改数据
    function update() {
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
            $('#updateData').form('load',data);
            
        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#editDialog").window("open");
    }

    function editForm(){

        $('#updateData').form('submit', {

            onSubmit: function() {
                var flag = $(this).form('validate');
                if(flag==true){
                    $.messager.progress({
                        text : "正在保存，请稍后...",
                        interval : 100
                    });
                }
                return flag;
            },
            success : function(result) {
                $.messager.progress('close');
                handleActionResult(result, {
                    onSuccess : function() {
                        $.messager.show({
                            title : '提示',
                            msg : '修改成功'
                        });
                        $('#dg').datagrid('reload');
                        $("#editDialog").window("close");
                    }
                });
            }
        });
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
        $("#approvalDialog").window("open");
    }

    function cancelapproval(){
        $("#approvalDialog").window("close");
    }

    // 提交费用审核
    function approvalForm(){

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
                            msg : '提交报销成功'
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
