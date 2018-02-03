<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>勘查反馈</title>
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
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">勘查状态</td>
                    <td class="cxinput">
                        <input class="easyui-combobox" name="status" style="width:100px;" data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '所有'},
												{value: '0',text: '已派单，待勘查'},
										       {value: '1',text: '勘查完成'}
												]" />
                    </td>
                    <td class="cxlabel">
                        <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createProspect()">新增</a>
        <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="feedback()">勘查反馈</a>
        <a href="${domainUrlUtil.dynamicURL}/downloadTemplate?location=template/prospectTemplate.docx&fileName=客户勘查模板.docx" class="easyui-linkbutton" iconCls="icon-edit" plain="false">勘查模板下载</a>
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'prospectFileAddress',width:150,halign:'center',align:'left',
                        formatter : function(value, row, index) {
                            if(row.prospectFileAddress != null && row.prospectFileAddress != '')
                                return '<a href=\''+row.prospectFileAddress+'\' class=\'easyui-linkbutton\'>下载</a>';
                        }">勘查报告</th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'prospectAddress',width:300,halign:'center',align:'left'">勘查地址</th>
                <th data-options="field:'name',width:150,halign:'center',align:'left'">联系人</th>
                <th data-options="field:'mobile',width:150,halign:'center',align:'left'">联系电话</th>
                <th data-options="field:'status',width:150,halign:'center',align:'left',
						formatter:function(value,row,index){
                            if(value == '0') return '已派工，待勘查';
                            if(value == '1') return '勘查完成';
                            return '';
                        }">勘查状态</th>
                <th data-options="field:'prospectConfirmTime',width:200,halign:'center',align:'left'">确定勘查时间</th>
                <th data-options="field:'prospectContent',width:500,halign:'center',align:'left'">勘查内容</th>
                <th data-options="field:'prospectRequire',width:300,halign:'center',align:'left'">勘查要求</th>
                <th data-options="field:'prospectStartTime',width:200,halign:'center',align:'left'">实际勘查时间</th>
                <th data-options="field:'prospectEndTime',width:200,halign:'center',align:'left'">勘查结束时间</th>
                <th data-options="field:'prospectName',width:150,halign:'center',align:'left'">勘查人员</th>
                <th data-options="field:'createdBy',width:150,halign:'center',align:'left'">下单人员</th>
                <th data-options="field:'createdAt',width:200,halign:'center',align:'left'">下单日期</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div class="easyui-dialog" id="addProspectDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">客户名称<span style="color:red;">*</span>:</td>
            <td>
                <input id="customerName" name="customerName" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">勘查地址<span style="color:red;">*</span>:</td>
            <td>
                <input id="prospectAddress" name="prospectAddress" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">联系人<span style="color:red;">*</span>:</td>
            <td>
                <input id="name" name="name" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">联系电话<span style="color:red;">*</span>:</td>
            <td>
                <input id="mobile" name="mobile" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">勘查时间<span style="color:red;">*</span>:</td>
            <td>
                <input id="prospectConfirmTime" name="prospectConfirmTime" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss'})" data-options="required:true,missingMessage:'该输入项为必输项'" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">勘查内容<span style="color:red;">*</span>:</td>
            <td>
                <input id="contentOne" name="prospectContent" type="checkbox" value="1" />
                <label for="contentOne">电气火灾监测系统</label><br/>
                <input id="contentTwo" name="prospectContent" type="checkbox" value="2" />
                <label for="contentTwo">安全隐患巡查系统</label><br/>
                <input id="contentThree" name="prospectContent" type="checkbox" value="3" />
                <label for="contentThree">建筑消防用水监测系统</label><br/>
                <input id="contentFour" name="prospectContent" type="checkbox" value="4" />
                <label for="contentFour">重点部位可视化监管系统</label><br/>
                <input id="contentFive" name="prospectContent" type="checkbox" value="5" />
                <label for="contentFive">火灾在线联网报警系统</label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">勘查要求:</td>
            <td>
                <input id="prospectRequire" name="prospectRequire" type="text" class="easyui-textbox" style="width:200px;" />
            </td>
        </tr>
    </table>
</div>

<!-- 勘查反馈  -->
<div class="easyui-dialog" id="addProspectFeedbackDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <form action="/prospect/uploadReportFile.html" id="uploadForm" enctype="multipart/form-data" method="post">
        <table>
            <tr>
                <td style="text-align: right;">勘查人员:</td>
                <td>
                    <input id="prospectName" name="prospectName" type="text" class="easyui-textbox" style="width:200px;" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">实际勘查时间:</td>
                <td>
                    <input id="prospectStartTime" name="prospectStartTime" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss'})" style="width:200px;" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">勘查结束时间:</td>
                <td>
                    <input id="prospectEndTime" name="prospectEndTime" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss'})" style="width:200px;" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">备注:</td>
                <td>
                    <input id="remark" name="remark" type="text" class="easyui-textbox" style="width:200px;" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">勘查报告:</td>
                <td>
                    <#--<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="uploadData()">勘查数据上传</a>-->
                    <input type="file" name="file" id="file"/>
                    <input type="hidden" name="id" id="id"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
    var addProspectDialog;
    var prospectFeedbackDialog;

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

    //新增勘查派工单
    function createProspect() {
        addProspectDialog.dialog('open');
    }

    //勘查反馈
    function feedback() {
        var rows = $('#dg').datagrid('getSelected');
        if(rows) {
            if(rows.status != 0){
                $.messager.alert('错误','请先选择一条状态为待勘查的记录！','error');
                return;
            }
            $("#id").val(rows.id);
            prospectFeedbackDialog.dialog('open');
        }else{
            $.messager.alert('操作提示', '请先选择一条状态为待勘查的记录！', 'info');
            return;
        }
    }

    $(function(){
        $('#dg').datagrid({
            title:'勘查反馈列表',
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
            url:'/prospect/findProspectList.html',
            nowrap : true,
            border : false
        });

        //新增派工单
        addProspectDialog = $("#addProspectDiv").dialog({
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
                    addProspectDialog.dialog('close');
                }
            }]
        });

        //勘查反馈
        prospectFeedbackDialog = $("#addProspectFeedbackDiv").dialog({
            title: '反馈',
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
                    prospectFeedbackDialog.dialog('close');
                }
            }]
        });
    });

    function submitForm(){
        var customerName = $('#customerName').val();
        var prospectAddress = $('#prospectAddress').val();
        var name = $('#name').val();
        var mobile = $('#mobile').val();
        var prospectConfirmTime = $('#prospectConfirmTime').val();
        var prospectRequire = $('#prospectRequire').val();

        var check_box = $("input[type='checkbox']:checked");
        if(check_box.length <= 0) {
            $.messager.alert('提示', '请勾选勘查内容！');
            return;
        }
        var prospectContent = "";
        $("input[type='checkbox']:checked").each(function(){
            prospectContent += this.value +",";
        })

        $.ajax({
            type:'post',
            url:'/prospect/createProspect',
            dataType : "json",
            data:{customerName:customerName, prospectAddress:prospectAddress,
                name:name, mobile:mobile, prospectConfirmTime:prospectConfirmTime,
                prospectContent:prospectContent, prospectRequire:prospectRequire},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                    return;
                }
                $('#dg').datagrid('reload');
                addProspectDialog.dialog('close');
                $.messager.alert('提示',"保存成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });
    }

    function submitFeedback(){
        /*var id = $("#id").val();
        var prospectName = $("#prospectName").val();
        var prospectStartTime = $("#prospectStartTime").val();
        var prospectEndTime = $("#prospectEndTime").val();
        var remark = $("#remark").val();

        $.ajax({
            type:'post',
            url:'/prospect/createProspectFeedback',
            dataType : "json",
            data:{id:id, prospectName:prospectName, prospectStartTime:prospectStartTime, prospectEndTime:prospectEndTime, remark:remark},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                    return false;
                }
                $('#dg').datagrid('reload');
                customerFeedbackDialog.dialog('close');
                $.messager.alert('提示',"保存成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });*/

        $("#uploadForm").submit();
    }

</script>
</body>
</html>
