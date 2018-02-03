<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../../common/easyui_core.ftl"/>
    <title>底薪设置</title>
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
                    <td class="cxlabel">岗位名称:</td>
                    <td class="cxinput"><input name="q_post" type="text" class="easyui-textbox" style="width:100px;"/></td>
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

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'post',width:110,halign:'center',align:'center'" formatter="formatterPost">岗位</th>
                <th data-options="field:'base',width:100,halign:'center',align:'center'">底薪基数</th>
                <th data-options="field:'baseLevel',width:100,halign:'center',align:'center'" formatter="formatterBaseLevel">底薪档位</th>
                <th data-options="field:'floatBase',width:100,halign:'center',align:'center'">浮动绩效基数</th>
                <th data-options="field:'floatProportion',width:100,halign:'center',align:'center'">浮动绩效计提比例</th>
                <th data-options="field:'floatCompletionRate',width:100,halign:'center',align:'center'">个人销售计划完成率</th>
                <th data-options="field:'percentageComplete',width:120,halign:'center',align:'center'">销售提成（完成销售计划）</th>
                <th data-options="field:'percentageIncomplete',width:120,halign:'center',align:'center'">销售提成（未完成销售计划）</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<!-- add -->

<div id="addWin" class="easyui-window" title="底薪设置" style="width:380px;height:340px"
     data-options="closed:true,iconCls:'icon-add',modal:true,collapsible:false,minimizable:false,maximizable:false">
     <form id="addForm">   
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">岗位<font color="red">*</font>:</td>
                <td width="23%">
	                <select id="postAdd" class="easyui-combobox" name="postAdd" style="width:90%">
					    <option value="1">业务员</option>
					    <option value="2">区域经理</option>
					    <option value="3">副总监</option>
					</select>
                    
                </td>
            <tr style="height: 30px;">
                <td width="25%">底薪基数:</td>
                <td width="23%">
                    <input id="base" class="easyui-textbox" name="base" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">底薪档位:</td>
                <td width="23%">
                <select id="baseLevelAdd" class="easyui-combobox" name="baseLevelAdd" style="width:90%">
					    <option value="1">一档</option>
					    <option value="2">二档</option>
					    <option value="3">三档</option>
					</select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效基数:</td>
                <td width="23%">
                    <input id="floatBase" class="easyui-textbox" name="floatBase" style="width:90%" data-options="validType:'maxLength[25]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(完成率﹤50%)</td>
                <td width="23%">
                    <input id="floatProportion1" class="easyui-textbox" name="floatProportion" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(50%≤完成率﹤80%)</td>
                <td width="23%">
                    <input id="floatProportion2" class="easyui-textbox" name="floatProportion" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(80%≤完成率)</td>
                <td width="23%">
                    <input id="floatProportion3" class="easyui-textbox" name="floatProportion" style="width:90%" data-options="validType:'maxLength[100]'" />
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
<div class="easyui-window" id="editDialog" title="底薪设置修改" style="width:380px;height:340px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateData" method="post" action="/salary/base/update">
        <input id ="id" type="hidden"  name = "id">
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">岗位<font color="red">*</font>:</td>
                <td width="23%">
                    <select id="post" class="easyui-combobox" name="post" style="width:90%">
					    <option value="1">业务员</option>
					    <option value="2">区域经理</option>
					    <option value="3">副总监</option>
					</select>
                </td>
            <tr style="height: 30px;">
                <td width="25%">底薪基数:</td>
                <td width="23%">
                    <input id="base" class="easyui-textbox" name="base" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">底薪档位:</td>
                <td width="23%">
                    <select id="baseLevel" class="easyui-combobox" name="baseLevel" style="width:90%">
					    <option value="1">一档</option>
					    <option value="2">二档</option>
					    <option value="3">三档</option>
					</select>
                </td>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效基数:</td>
                <td width="23%">
                    <input id="floatBase" class="easyui-textbox" name="floatBase" style="width:90%" data-options="validType:'maxLength[25]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(完成率﹤50%)</td>
                <td width="23%">
                	<input id="floatProportion" name="floatProportion" type="hidden" value="">
                	<input id="floatCompletionRate" name="floatCompletionRate" type="hidden" value="0.5,0.8,1">
                    <input id="floatProportionUp1" class="easyui-textbox" name="floatProportion1" style="width:90%" data-options="validType:'maxLength[20]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(50%≤完成率﹤80%)</td>
                <td width="23%">
                    <input id="floatProportionUp2" class="easyui-textbox" name="floatProportion2" style="width:90%" data-options="validType:'maxLength[20]'" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">浮动绩效计提比例:<br>(80%≤完成率)</td>
                <td width="23%">
                    <input id="floatProportionUp3" class="easyui-textbox" name="floatProportion3" style="width:90%" data-options="validType:'maxLength[20]'" />
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

<script type="text/javascript">
	function formatterPost(val,row){
		if(val == 1){
			return "业务员";
		}
		if(val == 2){
			return "区域经理";
		}
		if(val == 3){
			return "副总监";
		}
		return "--";
	}
	function formatterBaseLevel(val,row){
		if(val == 1){
			return "一档";
		}
		if(val == 2){
			return "二档";
		}
		if(val == 3){
			return "三档";
		}
		return "--";
	}
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
            title:'底薪设置列表',
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
            url:'/salary/base/ruleList',
            nowrap : true,
            border : false
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
        var post = $('#postAdd').combobox("getValue");
        var base = $('#base').val();
        var baseLevel = $('#baseLevelAdd').combobox("getValue");
        var floatBase = $('#floatBase').val();
        var floatProportion = '';
        var floatCompletionRate = '0.5,0.8,1';//$('#floatCompletionRate').val();
        
        var valArr = new Array;
	    $("#addWin input[name='floatProportion']").each(function(i){
	    	valArr[i] = $(this).val();
	      });
	    floatProportion = valArr.join(',');	    
	        
        $.ajax({
            type:'post',
            url:'/salary/base/create',
            dataType : "json",
            data:{post:post, base:base, baseLevel:baseLevel,
                floatBase:floatBase, floatProportion:floatProportion, floatCompletionRate:floatCompletionRate},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $("#addWin").window("close");
                $.messager.alert('提示',"新增底薪设置成功");
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
            url:'/salary/base/delete',
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
        	if(rows[0].floatProportion == ''){
        	rows[0].floatProportion = ',,,';
        	}
        	var strArr = rows[0].floatProportion.split(',');
            var data = {
                'id' : rows[0].id,
                'post' : rows[0].post,
                'base' : rows[0].base,
                'baseLevel' : rows[0].baseLevel,
                'floatBase' : rows[0].floatBase,
                'floatProportion1' : strArr[0],
                'floatProportion2' : strArr[1],
                'floatProportion3' : strArr[2]
            };
            
            $('#updateData').form('load',data);
            
        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#editDialog").window("open");
    }

    function editForm(){
    var floatProportion = '';
    /*var valArr = new Array;
    $("#updateData input[name='floatProportion']").each(function(i){
    	valArr[i] = $(this).val();
    });*/
	floatProportion = $("#floatProportionUp1").val()+','+$("#floatProportionUp2").val()+','+$("#floatProportionUp3").val();	
    $('#floatProportion').val(floatProportion);
        $('#updateData').form('submit', {
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
