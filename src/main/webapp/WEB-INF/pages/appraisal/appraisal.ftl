<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>考评激励</title>
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
                <td class="cxlabel">考评年度:&nbsp;&nbsp;</td>
                <td>
	                <select id="year" class="easyui-combobox" name="year" style="width:80px">
					<option value=""></option>
					<option value="2017">2017年</option>
					<option value="2018" selected>2018年</option>
					</select>
                </td>
                    <td class="cxlabel">&nbsp;&nbsp;月 份:&nbsp;&nbsp;</td>
                    <td>
	                    <select id="q_month" class="easyui-combobox" name="q_month" style="width:80px">
	                        <option value=""> </option>
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
                    <!--<td class="cxlabel">&nbsp;&nbsp;业务员:&nbsp;&nbsp;</td>
                    <td class="cxinput"><input name="q_userName" type="text" class="easyui-textbox" style="width:100px;"/></td>-->
                    <td class="cxlabel">
                        &nbsp;&nbsp;&nbsp;&nbsp;<a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
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
                <th data-options="field:'userName',width:10,halign:'center',align:'left'">业务员</th>                
                <th data-options="field:'score',width:10,halign:'center',align:'left'">得分</th>
                <th data-options="field:'itemScores1',width:10,halign:'center',align:'left'" formatter="appraisalItemPart1">合同金额</th>
                <th data-options="field:'itemScores2',width:10,halign:'center',align:'left'" formatter="appraisalItemPart2">回款金额</th>
                <th data-options="field:'itemScores3',width:10,halign:'center',align:'left'" formatter="appraisalItemPart3">计划完成率</th>
                <th data-options="field:'itemScores4',width:10,halign:'center',align:'left'" formatter="appraisalItemPart4">日常工作考核</th>
                <th data-options="field:'year',width:10,halign:'center',align:'left'">考评年度</th>
                <th data-options="field:'month',width:10,halign:'center',align:'left'">月份</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<!-- add -->

<div id="addWin" class="easyui-window" title="新增考评激励" style="width:650px;height:540px"
     data-options="closed:true,iconCls:'icon-add',modal:true,collapsible:false,minimizable:false,maximizable:false">
     <form id="addForm" method="post" action="/appraisal/create">   
        <table id="table1" style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">考评年度<font color="red">*</font>:</td>
                <td width="23%">
	                <select id="year" class="easyui-combobox" name="year" style="width:90%">
					<option value="2017">2017</option>
					<option value="2018" selected>2018</option>
					</select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">考评月份<font color="red">*</font>:</td>
                <td width="23%">
                    <select id="month" class="easyui-combobox" name="month" style="width:90%">
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
        </table>
        <br>
        <fieldset>
	        <legend style="color: #0e2d5f;font-size: 12px;font-weight: bold;margin-left: 20px;">业绩考评项</legend>
	        <table id="addtable" style="border-collapse:collapse; border-spacing:0;width: 100%">
	            <tr id="addThead">
	                <th></th>
	                <th>合同金额(25)</th>
	                <th>回款金额(25)</th>
	                <th>计划完成率(30)</th>
	                <th>日常工作考核(20)</th>
	            </tr>
	        </table>
	        <br>
    </fieldset >
    <br>
    <table style="border-collapse:collapse; border-spacing:0;width: 100%">
    	<tr>
	    	<td align="center">
				 <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="submitForm(1)">保存提交</a>&nbsp;&nbsp;
			     <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancel(0)">取消</a>
	    	</td>
    	</tr> 
    </table>
    </form>
</div>


<!-- 修改框 -->
<div class="easyui-window" id="editDialog" title="考评激励修改" style="width:650px;height:540px"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateData" method="post" action="/appraisal/update">
        <input id ="id" type="hidden"  name = "id">
        <table id="table2" style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 30px;">
                <td width="25%">考评年度<font color="red">*</font>:</td>
                <td width="23%">
	                <select id="year" class="easyui-combobox" name="year" style="width:90%">
					<option value="2017">2017</option>
					<option value="2018" selected>2018</option>
					</select>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td width="25%">考评月份<font color="red">*</font>:</td>
                <td width="23%">
                    <select id="month" class="easyui-combobox" name="month" style="width:90%">
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
        </table>
        <br>
        <fieldset>
	        <legend style="color: #0e2d5f;font-size: 12px;font-weight: bold;margin-left: 20px;">业绩考评项</legend>
	        <table id="editTable" style="border-collapse:collapse; border-spacing:0;width: 100%">
	            <tr id="editThead">
	                <th></th>
	                <th>合同金额(25)</th>
	                <th>回款金额(25)</th>
	                <th>计划完成率(30)</th>
	                <th>日常工作考核(20)</th>
	            </tr>
	            
	        </table>
	        <br>
	    </fieldset >
    	<br>
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
    	<tr>
	    	<td align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="editForm()">保 存</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-cancel" plain="false" onclick="cancelUpdate()">取 消</a>
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
       $.messager.progress({
            text : "正在加载，请稍后...",
            interval : 100
       });
    	$("#addForm").form("reset");
		$("#addtable tr:not(:first)").empty();
        $.getJSON("/appraisal/loadSalesman", function(data) {
	        $.each(data.data, function(i, item) {
	           addTr(i, item.id, item.nickName);
	        });
	      });
	      $.messager.progress('close');
	      $("#addWin").window("open");
            
    }

    $(function(){
        $('#dg').datagrid({
            title:'考评激励列表',
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
            url:'/appraisal/list',
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
		$('#addForm').form('submit', {
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
                            msg : '保存成功'
                        });
                        $('#dg').datagrid('reload');
                        $("#addWin").window("close");
                    }
                });
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
            url:'/appraisal/delete',
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
        	if(rows[0].itemScores == ''){
        		rows[0].itemScores = ',,,';
        	}
        	var strArr = rows[0].itemScores.split(',');
            var data = {
                'score' : rows[0].score,
                'month' : rows[0].month,
                'year' : rows[0].year
            };
            
            $('#updateData').form('load',data);
            
            $("#editTable tr:not(:first)").empty();
            var id = rows[0].id;
            var userId = rows[0].userId;
            var userName = rows[0].userName;
            var editItemIds = rows[0].itemIds;
            var part1 = strArr[0];
            var part2 = strArr[1];
            var part3 = strArr[2];
            var part4 = strArr[3];
	        editTr(id, userId, userName, editItemIds, part1, part2, part3, part4);
            
        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        $("#editDialog").window("open");
    }

    function editForm(){
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
   function appraisalItemPart1(val, row){
    	var strArr = row.itemScores.split(',');
    	if(strArr.length>=1){
    		return strArr[0];
    	}
    	return "";
    }
   function appraisalItemPart2(val, row){
    	var strArr = row.itemScores.split(',');
    	console.debug(strArr.length);
    	if(strArr.length>=2){
    		return strArr[1];
    	}
    	return "";
    }
   function appraisalItemPart3(val, row){
    	var strArr = row.itemScores.split(',');
    	if(strArr.length>=3){
    		return strArr[2];
    	}
    	return "";
    }
   function appraisalItemPart4(val, row){
    	var strArr = row.itemScores.split(',');
    	if(strArr.length>=4){
    		return strArr[3];
    	}
    	return "";
    }
</script>
<script type="text/javascript">
  function addTr(index, id, nickName){
     var $tr = $("#addThead");
     var trHtml = "<tr style='height: 25px;'>" +
     "<td width='15%'>"+ nickName +":" +
     "<input type='hidden' name='addIds[]' value='"+id+"'/>" +
     "<input type='hidden' name='addNames[]' value='"+nickName+"'/>" +
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='part1[]' style='width:90%' />"+
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='part2[]' style='width:90%' />"+
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='part3[]' style='width:90%' />"+
     "</td>" +
     "<td width='25%'>" +
     "<input class='easyui-textbox' name='part4[]' style='width:90%' />"+
     "</td>" +
     "</tr>";
     if($tr.size()==0){
        alert("指定的table id或行数不存在！");
        return;
     }
     $tr.after(trHtml);
     $.parser.parse($tr.parent());
  }
  
   function editTr(id, userId, userName, editItemIds, part1, part2, part3, part4){
     var $tr = $("#editThead");
     var trHtml = "<tr style='height: 25px;'>" +
     "<td width='15%'>"+ userName +":" +
     "<input type='hidden' name='editIds[]' value='"+id+"'/>" +
     "<input type='hidden' name='editUserIds[]' value='"+userId+"'/>" +
     "<input type='hidden' name='editNames[]' value='"+userName+"'/>" +
     "<input type='hidden' name='editItemIds[]' value='"+editItemIds+"'/>" +
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='editPart1[]' style='width:90%'  value='"+part1+"'/>"+
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='editPart2[]' style='width:90%'  value='"+part2+"'/>"+
     "</td>" +
     "<td width='20%'>" +
     "<input class='easyui-textbox' name='editPart3[]' style='width:90%'  value='"+part3+"'/>"+
     "</td>" +
     "<td width='25%'>" +
     "<input class='easyui-textbox' name='editPart4[]' style='width:90%'  value='"+part4+"'/>"+
     "</td>" +
     "</tr>";
     if($tr.size()==0){
        alert("指定的table id或行数不存在！");
        return;
     }
     $tr.after(trHtml);
     $.parser.parse($tr.parent());
  }
   
  function delTr(ckb){
     //获取选中的复选框，然后循环遍历删除
     var ckbs=$("input[name="+ckb+"]:checked");
     if(ckbs.size()==0){
        alert("要删除指定行，需选中要删除的行！");
        return;
     }
           ckbs.each(function(){
              $(this).parent().parent().remove();
           });
  }
   </script>
</body>
</html>
