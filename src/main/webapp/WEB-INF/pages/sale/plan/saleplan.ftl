<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../../common/easyui_core.ftl"/>
    <title>销售计划</title>
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
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="create()">新增</a>
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="update()">修改</a>
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteRow()">删除</a>
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="importxls()">导入Excel</a>
        <#--<input type="file" name="fileString" multiple class="file"/>-->
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'userName',width:50,halign:'center',align:'center'" >业务员</th>
                <th data-options="field:'planYear',width:100,halign:'center',align:'center'">计划年</th>
                <th data-options="field:'planMonth',width:100,halign:'center',align:'center'" >计划月</th>
                <th data-options="field:'planAmt',width:100,halign:'center',align:'center'">销售计划</th>

            </tr>
            </thead>
        </table>
    </div>
</div>
<!-- add -->

<div id="addWin" class="easyui-window" title="添加销售计划" style="width:380px;height:340px"
     data-options="closed:true,iconCls:'icon-add',modal:true,collapsible:false,minimizable:false,maximizable:false">
     <form id="addForm">   
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">业务员<font color="red">*</font>:</td>
                <td width="23%">
	                <select id="userId" class="easyui-combobox" name="userId" style="width:90%"
                            data-options="
                                valueField: 'id',
                                textField: 'nickName',
                                url: '/sale/plan/getusers',
                                panelHeight: 'auto'
                            ">

					</select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">计划年:</td>
                <td width="23%">
                    <input id="planYear" class="easyui-textbox" name="planYear" style="width:90%" data-options="validType:'maxLength[9999]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">计划月:</td>
                <td width="23%">
                    <select id="planMonth" class="easyui-combobox" name="planMonth" style="width:90%">
                        <option value="1">1月</option>
                        <option value="2">2月</option>
                        <option value="3">3月</option>
                        <option value="4">4月</option>
                        <option value="5">5月</option>
                        <option value="6">6月</option>
                        <option value="7">7月</option>
                        <option value="8">8月</option>
                        <option value="9">9月</option>
                        <option value="10">10月</option>
                        <option value="11">11月</option>
                        <option value="12">12月</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">销售计划:</td>
                <td width="23%">
                    <input id="planAmt" class="easyui-textbox" name="planAmt" style="width:90%" />
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
<div class="easyui-window" id="editDialog" title="修改销售计划" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateData" method="post" action="/sale/plan/update">
        <input id ="id" type="hidden"  name = "id">
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">业务员<font color="red">*</font>:</td>
                <td width="23%">
                    <select id="userId" class="easyui-combobox" name="userId" style="width:90%"
                            data-options="
                                valueField: 'id',
                                textField: 'nickName',
                                url: '/sale/plan/getusers',
                                panelHeight: 'auto'
                            ">
                    </select>
                    <input type="hidden" id="userName" name="userName" class="textbox-value" value=""/>
                </td>

            </tr>
            <tr style="height: 30px;">
                <td width="25%">计划年:</td>
                <td width="23%">
                    <input id="planYear" class="easyui-textbox" name="planYear" style="width:90%" data-options="validType:'maxLength[9999]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">计划月:</td>
                <td width="23%">
                    <select id="planMonth" class="easyui-combobox" name="planMonth" style="width:90%">
                        <option value="1">1月</option>
                        <option value="2">2月</option>
                        <option value="3">3月</option>
                        <option value="4">4月</option>
                        <option value="5">5月</option>
                        <option value="6">6月</option>
                        <option value="7">7月</option>
                        <option value="8">8月</option>
                        <option value="9">9月</option>
                        <option value="10">10月</option>
                        <option value="11">11月</option>
                        <option value="12">12月</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">销售计划:</td>
                <td width="23%">
                    <input id="planAmt" class="easyui-textbox" name="planAmt" style="width:90%" />
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

<#--导入Excel窗口-->
<div class="easyui-window" id="importExcelDlg" title="导入Excel" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="importExcel" method="post" action="/sale/plan/uploadfile" enctype="multipart/form-data">
        <input id ="id" type="hidden"  name = "id">
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <input type="file" name="xlsFile" id="xlsFile" multiple class="file"/>
            </tr>
            <tr style="height: 50px;">
                <td  colspan="2" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="doImport()">导 入</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancelImport()">取 消</a>
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
            title:'销售计划列表',
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
            url:'/sale/plan/saleplan',
            nowrap : true,
            border : false
        });

//        $('#updateData #userId').combobox({
//            onChange: function(n,o){
//                console.log($('#updateData #userId').combobox("getText"));
//                $('#updateData #userName').val($('#updateData #userId').combobox("getText"));
//                console.log('first',n);
//                console.log('second',o);
//            }
//        })

        $("#fileString").change(function(){
//            var xslfile = this.files[0].val();
            console.log('选择的文件为：',$("#fileString").val());
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
        var userId = $('#userId').combobox("getValue");
        var userName =  $('#userId').combobox("getText");
        var planYear = $('#planYear').val();
        var planMonth = $('#planMonth').combobox("getValue");
        var planAmt = $('#planAmt').val();

        $.ajax({
            type:'post',
            url:'/sale/plan/create',
            dataType : "json",
            data:{
                userId:userId,
                userName: userName,
                planYear:planYear,
                planMonth:planMonth,
                planAmt:planAmt
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
            url:'/sale/plan/delete',
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
                'userId': rows[0].userId,
                'userName': rows[0].userName,
                'planYear': rows[0].planYear,
                'planMonth': rows[0].planMonth,
                'planAmt': rows[0].planAmt
            };
            console.log('data:',data);
            $('#updateData').form('load',data);
            
        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#editDialog").window("open");
    }

    // 选择Excel
    function importxls() {
        $("#importExcelDlg").window("open");
    }

    function cancelImport(){
        $("#importExcelDlg").window("close");
    }

    function doImport() {

        $('#importExcel').form('submit', {

            onSubmit : function() {

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
                        console.log('导入成功日志')
                        $.messager.show({
                            title : '提示',
                            msg : '导入成功'
                        });
                        $('#dg').datagrid('reload');
                        $("#importExcelDlg").window("close");
                    }
                });
            }
        });
    }

    function editForm(){

        $('#updateData').form('submit', {

            onSubmit : function() {
                $('#updateData #userName').val($('#updateData #userId').combobox("getText"));
                console.log($('#updateData #userName').val());
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
</script>
</body>
</html>
