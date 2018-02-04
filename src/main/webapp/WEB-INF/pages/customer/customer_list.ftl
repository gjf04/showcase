<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>客户信息查询</title>
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
        <#--<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteCustomer()">删除</a>-->
        <#--<a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateCustomer()">修改</a>-->
            <#if showCreateCustomerButton?? && showCreateCustomerButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createCustomer()">新增</a>
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateCustomer()">修改</a>
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-excel" plain="false" onclick="openImportWin()">导入</a>
            </#if>
            <#if showDistributionCustomerButton?? && showDistributionCustomerButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="distributionCustomer()">分配</a>
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="assistCustomer()">协助</a>
            </#if>
            <#if showFeedbackCustomerButton?? && showFeedbackCustomerButton == "YES">
                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="feedback()">反馈</a>
            </#if>

            <!-- 更多按钮 -->
            <a href="javascript:void(0)" id="morefunction" class="easyui-menubutton"  plain="false"
               data-options="menu:'#functions',iconCls:'icon-task'">更多</a>
            <div id="functions" style="width:100px;">
                <div data-options="iconCls:'icon-edit'" onclick="auditCustomer(2)">审核通过</div>
                <div data-options="iconCls:'icon-edit'" onclick="auditCustomer(3)">审核拒绝</div>
                <div data-options="iconCls:'icon-edit'" onclick="updateCustomerToOpenSea()">移入公海</div>
                <div data-options="iconCls:'icon-excel'" onclick="exportCustomer()">导出</div>
            </div>

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'phone',width:100,halign:'center',align:'left'">电话</th>
                <th data-options="field:'address',width:250,halign:'center',align:'left'">地址</th>
                <th data-options="field:'manager',width:100,halign:'center',align:'left'">公司法人/总经理</th>
                <th data-options="field:'responsiblePerson',width:100,halign:'center',align:'left'">业务人员</th>
                <th data-options="field:'assistPerson',width:100,halign:'center',align:'left'">协助人</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


<!-- add -->
<div id="addCustomerWin" class="easyui-window" title="客户接入" style="width:800px;height:440px"
     data-options="closed:true,iconCls:'icon-add',modal:true,collapsible:false,minimizable:false,maximizable:false">
    <fieldset>
        <legend style="color: #0e2d5f;font-size: 12px;font-weight: bold;margin-left: 20px;">客户基本信息</legend>
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 25px;">
                <td width="10%">客户名称<font color="red">*</font>:</td>
                <td width="23%">
                    <input id="customerName" class="easyui-textbox" name="customerName" style="width:90%" data-options="required:true,missingMessage:'该输入项为必输项',validType:'maxLength[100]'"/>
                </td>
                <td width="10%">所属行业:</td>
                <td width="23%">
                    <input id="typeName" class="easyui-textbox" name="typeName" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
                <td width="10%">电话:</td>
                <td width="23%">
                    <input id="phone" class="easyui-textbox" name="phone" style="width:90%" data-options="validType:'maxLength[25]'" />
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="10%">传真:</td>
                <td width="23%">
                    <input id="fax" class="easyui-textbox" name="fax" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="10%">地址:</td>
                <td width="23%">
                    <input id="address" class="easyui-textbox" name="address" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
                <td width="10%">网址:</td>
                <td width="23%">
                    <input id="url" class="easyui-textbox" name="url" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="10%">总经理/董事长:</td>
                <td width="23%">
                    <input id="manager" class="easyui-textbox" name="manager" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="10%">联系方式:</td>
                <td width="23%">
                    <input id="contact" class="easyui-textbox" name="contact" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
                <td width="10%"></td>
                <td width="23%">
                </td>
            </tr>
        </table>
    </fieldset >

    <fieldset>
        <legend style="color: #0e2d5f;font-size: 12px;font-weight: bold;margin-left: 20px;">业务对接信息</legend>
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr style="height: 25px;">
                <td width="10%">对接部门:</td>
                <td width="23%">
                    <input id="dockDepartment" class="easyui-textbox" name="dockDepartment" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="10%">联系人:</td>
                <td width="23%">
                    <input id="dockPerson" class="easyui-textbox" name="dockPerson" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
                <td width="10%">联系方式:</td>
                <td width="23%">
                    <input id="dockContact" class="easyui-textbox" name="dockContact" style="width:90%" data-options="validType:'maxLength[25]'" />
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="10%">关联部门:</td>
                <td width="23%">
                    <input id="relateDepartment" class="easyui-textbox" name="relateDepartment" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="10%">联系人:</td>
                <td width="23%">
                    <input id="relatePerson" class="easyui-textbox" name="relatePerson" style="width:90%" data-options="validType:'maxLength[100]'" />
                </td>
                <td width="10%">联系方式:</td>
                <td width="23%">
                    <input id="relateContact" class="easyui-textbox" name="relateContact" style="width:90%" data-options="validType:'maxLength[25]'" />
                </td>
            </tr>
        </table>
    </fieldset >

    <fieldset>
        <legend style="color: #0e2d5f;font-size: 12px;font-weight: bold;margin-left: 20px;">售后服务信息</legend>
        <table style="border-collapse:collapse; border-spacing:0;width: 100%">
            <tr>
                <th></th>
                <th>姓名</th>
                <th>职务</th>
                <th>手机</th>
                <th>电话</th>
            </tr>
            <tr style="height: 25px;">
                <td width="20%">设备用电管理人:</td>
                <td width="20%">
                    <input id="electric_contactName" class="easyui-textbox" name="electric_contactName" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="electric_contactPost" class="easyui-textbox" name="electric_contactPost" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="electric_phone" class="easyui-textbox" name="electric_phone" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="electric_mobile" class="easyui-textbox" name="electric_mobile" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="20%">建筑消防用水:</td>
                <td width="20%">
                    <input id="water_contactName" class="easyui-textbox" name="water_contactName" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="water_contactPost" class="easyui-textbox" name="water_contactPost" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="water_phone" class="easyui-textbox" name="water_phone" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="water_mobile" class="easyui-textbox" name="water_mobile" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="20%">安全巡检:</td>
                <td width="20%">
                    <input id="safe_contactName" class="easyui-textbox" name="safe_contactName" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="safe_contactPost" class="easyui-textbox" name="safe_contactPost" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="safe_phone" class="easyui-textbox" name="safe_phone" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="safe_mobile" class="easyui-textbox" name="safe_mobile" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="20%">可视化监管:</td>
                <td width="20%">
                    <input id="visual_contactName" class="easyui-textbox" name="visual_contactName" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="visual_contactPost" class="easyui-textbox" name="visual_contactPost" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="visual_phone" class="easyui-textbox" name="visual_phone" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="visual_mobile" class="easyui-textbox" name="visual_mobile" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
            </tr>
            <tr style="height: 25px;">
                <td width="20%"><font color="red">紧急联系人:</font></td>
                <td width="20%">
                    <input id="emergency_contactName" class="easyui-textbox" name="emergency_contactName" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="emergency_contactPost" class="easyui-textbox" name="emergency_contactPost" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="emergency_phone" class="easyui-textbox" name="emergency_phone" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
                <td width="20%">
                    <input id="emergency_mobile" class="easyui-textbox" name="emergency_mobile" style="width:90%" data-options="validType:'maxLength[100]'"/>
                </td>
            </tr>

            <tr id="button_tr" style="height: 25px;">
                <td width="50%" colspan="5" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="submitForm(1)">保存提交</a>
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="submitForm(0)">保存草稿</a>
                </td>
            </tr>

            <tr id="edit_button_tr" style="height: 25px;">
                <td width="50%" colspan="5" align="center">
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-ok" plain="false" onclick="submitEditForm(1)">保存提交</a>
                    <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="submitEditForm(0)">保存草稿</a>
                </td>
            </tr>

        </table>
    </fieldset >
</div>

<!-- 分配  -->
<div class="easyui-dialog" id="distributionCustomerDiv" style="width:320px;height:280px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">业务人员<span style="color:red;">*</span>:</td>
            <td>
                <select id="responsiblePersonId" name="responsiblePersonId" size="54" class="easyui-combotree" style="width:200px;"
                        data-options="required:true,url:'/system/searchUserByRoleIdCombo?roleId=5'"></select>
            </td>
        </tr>

    </table>
</div>

<!-- 分配  -->
<div class="easyui-dialog" id="assistCustomerDiv" style="width:320px;height:280px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">业务人员<span style="color:red;">*</span>:</td>
            <td>
                <select id="assistPersonId" name="assistPersonId" size="54" class="easyui-combotree" style="width:200px;"
                        data-options="required:true,url:'/system/searchUserByRoleIdCombo?roleId=5'"></select>
            </td>
        </tr>

    </table>
</div>

<!-- 反馈  -->
<div class="easyui-dialog" id="addCustomerFeedbackDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
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

<!-- 导入窗口 -->
<div id="importDialog" class="easyui-window" title="导入客户"  style="width:460px;height:120px"
     data-options="closed:true,iconCls:'icon-excel',modal:true,collapsible:false,minimizable:false,maximizable:false">
    <form onsubmit="return false;" id="importForm" enctype="multipart/form-data" method="post"
          action="/customer/importCustomer">
        <table class="fixedTb">
            <tr>
                <td class="formlabletd">文件:</td>
                <td width="200px;">
                    <input id="importFile" type="file"  name="file" onchange="checkExt(this.id, 'xls',this.value)" style="width:200px">
                    <input id="importFileName" type="hidden"  name="fileName" >
                </td>
                <td style="width:100px;padding-left: 20px;padding-right: 20px;">
                    <a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-excel'" onclick="importRow();">导入</a>
                </td>
            </tr>
            <tr>
                <td class="formlabletd">模板下载:</td>
                <td>
                    <a href="${domainUrlUtil.dynamicURL}/downloadTemplate?location=template/customer.xls&fileName=客户导入模板.xls">客户导入模板.xls</a>
                </td>
                <td></td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
    var distributionCustomerDialog;
    var assistCustomerDialog;
    var customerFeedbackDialog;
    var customerName;

    function loaddata(){
        customerName = $("#q_customerName").val();
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

    //客户禁用
    function deleteCustomer(){
        var row = $('#dg').datagrid('getSelected');
        var ids = "";
        if(row){
            $.ajax({
                url : '/customer/deleteCustomer',
                data : {id : row.id},
                dataType : 'json',
                cache : false,
                success : function(result) {
                    $.messager.progress('close');
                    if(result.success){
                        $('#dg').datagrid('unselectAll');
                        $('#dg').datagrid('reload');
                        $.messager.show({
                            title:'成功',
                            msg:'操作成功'
                        });
                    }else{
                        showErrorMsg(result.errorMsg);
                    }
                },
                error: function(){
                    $.messager.progress('close');
                    $.messager.alert('提示', '操作失败！', 'error');
                }
            });
        }else{
            $.messager.alert('提示', '请选择一条记录！', 'warning');
        }

    }

    //新增数据
    function createCustomer() {
        $('#customerName').textbox("setValue","");
        $('#typeName').textbox("setValue","");
        $('#phone').textbox("setValue","");
        $('#fax').textbox("setValue","");
        $('#address').textbox("setValue","");
        $('#url').textbox("setValue","");
        $('#manager').textbox("setValue","");
        $('#contact').textbox("setValue","");
        $("#dockDepartment").textbox("setValue","");

        $('#dockPerson').textbox("setValue","");
        $('#dockContact').textbox("setValue","");
        $('#relateDepartment').textbox("setValue","");
        $('#relatePerson').textbox("setValue","");
        $('#relateContact').textbox("setValue","");

        $('#electric_contactName').textbox("setValue","");
        $('#electric_contactPost').textbox("setValue","");
        $('#electric_phone').textbox("setValue","");
        $('#electric_mobile').textbox("setValue","");

        $('#water_contactName').textbox("setValue","");
        $('#water_contactPost').textbox("setValue","");
        $('#water_phone').textbox("setValue","");
        $('#water_mobile').textbox("setValue","");

        $('#safe_contactName').textbox("setValue","");
        $('#safe_contactPost').textbox("setValue","");
        $('#safe_phone').textbox("setValue","");
        $('#safe_mobile').textbox("setValue","");

        $('#visual_contactName').textbox("setValue","");
        $('#visual_contactPost').textbox("setValue","");
        $('#visual_phone').textbox("setValue","");
        $('#visual_mobile').textbox("setValue","");

        $('#emergency_contactName').textbox("setValue","");
        $('#emergency_contactPost').textbox("setValue","");
        $('#emergency_phone').textbox("setValue","");
        $('#emergency_mobile').textbox("setValue","");
        $("#addCustomerWin").window("open");
        $("#button_tr").show();
        $("#edit_button_tr").hide();
    }

    //修改数据
    function updateCustomer(){
        var selectedRow = $('#dg').datagrid('getSelected');
        $('#customerName').textbox("setValue",selectedRow.customerName);
        $('#typeName').textbox("setValue",selectedRow.typeName);
        $('#phone').textbox("setValue",selectedRow.phone);
        $('#fax').textbox("setValue",selectedRow.fax);
        $('#address').textbox("setValue",selectedRow.address);
        $('#url').textbox("setValue",selectedRow.url);
        $('#manager').textbox("setValue",selectedRow.manager);
        $('#contact').textbox("setValue",selectedRow.contact);
        $("#dockDepartment").textbox("setValue",selectedRow.dockDepartment);

        $('#dockPerson').textbox("setValue",selectedRow.dockPerson);
        $('#dockContact').textbox("setValue",selectedRow.dockContact);
        $('#relateDepartment').textbox("setValue",selectedRow.relateDepartment);
        $('#relatePerson').textbox("setValue",selectedRow.relatePerson);
        $('#relateContact').textbox("setValue",selectedRow.relateContact);

        $('#electric_contactName').textbox("setValue",selectedRow.electric.contactName);
        $('#electric_contactPost').textbox("setValue",selectedRow.electric.contactPost);
        $('#electric_phone').textbox("setValue",selectedRow.electric.phone);
        $('#electric_mobile').textbox("setValue",selectedRow.electric.mobile);

        $('#water_contactName').textbox("setValue",selectedRow.water.contactName);
        $('#water_contactPost').textbox("setValue",selectedRow.water.contactPost);
        $('#water_phone').textbox("setValue",selectedRow.water.phone);
        $('#water_mobile').textbox("setValue",selectedRow.water.mobile);

        $('#safe_contactName').textbox("setValue",selectedRow.safe.contactName);
        $('#safe_contactPost').textbox("setValue",selectedRow.safe.contactPost);
        $('#safe_phone').textbox("setValue",selectedRow.safe.phone);
        $('#safe_mobile').textbox("setValue",selectedRow.safe.mobile);

        $('#visual_contactName').textbox("setValue",selectedRow.visual.contactName);
        $('#visual_contactPost').textbox("setValue",selectedRow.visual.contactPost);
        $('#visual_phone').textbox("setValue",selectedRow.visual.phone);
        $('#visual_mobile').textbox("setValue",selectedRow.visual.mobile);

        $('#emergency_contactName').textbox("setValue",selectedRow.emergency.contactName);
        $('#emergency_contactPost').textbox("setValue",selectedRow.emergency.contactPost);
        $('#emergency_phone').textbox("setValue",selectedRow.emergency.phone);
        $('#emergency_mobile').textbox("setValue",selectedRow.emergency.mobile);

        $("#addCustomerWin").window("open");
        $("#button_tr").hide();
        $("#edit_button_tr").show();
    }

    //分配
    function distributionCustomer() {
        distributionCustomerDialog.dialog('open');
    }

    //协助
    function assistCustomer() {
        assistCustomerDialog.dialog('open');
    }

    //反馈
    function feedback() {
        customerFeedbackDialog.dialog('open');
    }

    //导出
    function exportCustomer(){
        if(!datagrid){
            $.messager.alert('提示','请先查询！','info');
            return;
        }
        $.messager.confirm('确认','确定要导出吗？', function(r){
            if (r){
                window.location.href="/customer/exportCustomerList?customerName=" + customerName;
            }
        });
    }

    $(function(){
        customerName = $("#q_customerName").val();
        datagrid = $('#dg').datagrid({
            title:'客户列表',
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
            url:'/customer/customerList',
            nowrap : true,
            border : false,
            onDblClickRow : function(rowIndex,rowData){
                showFormWin(rowIndex,rowData);
            }
        });

        //分配
        distributionCustomerDialog = $("#distributionCustomerDiv").dialog({
            title: '分配',
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
                    submitDistribution();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    distributionCustomerDialog.dialog('close');
                }
            }]
        });

        //协助
        assistCustomerDialog = $("#assistCustomerDiv").dialog({
            title: '协助',
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
                    submitAssist();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    assistCustomerDialog.dialog('close');
                }
            }]
        });

        //反馈
        customerFeedbackDialog = $("#addCustomerFeedbackDiv").dialog({
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
                    customerFeedbackDialog.dialog('close');
                }
            }]
        });
    });

    function submitForm(draft){
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

        var electric_contactName = $('#electric_contactName').val();
        var electric_contactPost = $('#electric_contactPost').val();
        var electric_phone = $('#electric_phone').val();
        var electric_mobile = $('#electric_mobile').val();

        var water_contactName = $('#water_contactName').val();
        var water_contactPost = $('#water_contactPost').val();
        var water_phone = $('#water_phone').val();
        var water_mobile = $('#water_mobile').val();

        var safe_contactName = $('#safe_contactName').val();
        var safe_contactPost = $('#safe_contactPost').val();
        var safe_phone = $('#safe_phone').val();
        var safe_mobile = $('#safe_mobile').val();

        var visual_contactName = $('#visual_contactName').val();
        var visual_contactPost = $('#visual_contactPost').val();
        var visual_phone = $('#visual_phone').val();
        var visual_mobile = $('#visual_mobile').val();

        var emergency_contactName = $('#emergency_contactName').val();
        var emergency_contactPost = $('#emergency_contactPost').val();
        var emergency_phone = $('#emergency_phone').val();
        var emergency_mobile = $('#emergency_mobile').val();
        $.ajax({
            type:'post',
            url:'/customer/createCustomer',
            dataType : "json",
            data:{customerCode:customerCode, customerName:customerName, typeCode:typeCode,
                typeName:typeName, phone:phone, fax:fax, address:address,
                url:url, manager:manager,
                contact:contact, dockDepartment:dockDepartment, dockPerson:dockPerson,
                dockContact:dockContact, relateDepartment:relateDepartment, relatePerson:relatePerson,
                relateContact:relateContact,
                electric_contactName:electric_contactName, electric_contactPost:electric_contactPost, electric_phone:electric_phone, electric_mobile:electric_mobile,
                water_contactName:water_contactName, water_contactPost:water_contactPost, water_phone:water_phone, water_mobile:water_mobile,
                safe_contactName:safe_contactName, safe_contactPost:safe_contactPost, safe_phone:safe_phone, safe_mobile:safe_mobile,
                visual_contactName:visual_contactName, visual_contactPost:visual_contactPost, visual_phone:visual_phone, visual_mobile:visual_mobile,
                emergency_contactName:emergency_contactName, emergency_contactPost:emergency_contactPost, emergency_phone:emergency_phone, emergency_mobile:emergency_mobile,
                draft:draft
            },
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                //$('#dg').datagrid('reload');
                loaddata();
                $("#addCustomerWin").window("close");
                //addCustomerDialog.dialog('close');
                $.messager.alert('提示',"新增客户成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    function submitEditForm(draft){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
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

        var electric_contactName = $('#electric_contactName').val();
        var electric_contactPost = $('#electric_contactPost').val();
        var electric_phone = $('#electric_phone').val();
        var electric_mobile = $('#electric_mobile').val();

        var water_contactName = $('#water_contactName').val();
        var water_contactPost = $('#water_contactPost').val();
        var water_phone = $('#water_phone').val();
        var water_mobile = $('#water_mobile').val();

        var safe_contactName = $('#safe_contactName').val();
        var safe_contactPost = $('#safe_contactPost').val();
        var safe_phone = $('#safe_phone').val();
        var safe_mobile = $('#safe_mobile').val();

        var visual_contactName = $('#visual_contactName').val();
        var visual_contactPost = $('#visual_contactPost').val();
        var visual_phone = $('#visual_phone').val();
        var visual_mobile = $('#visual_mobile').val();

        var emergency_contactName = $('#emergency_contactName').val();
        var emergency_contactPost = $('#emergency_contactPost').val();
        var emergency_phone = $('#emergency_phone').val();
        var emergency_mobile = $('#emergency_mobile').val();
        $.ajax({
            type:'post',
            url:'/customer/updateCustomer',
            dataType : "json",
            data:{customeId:customeId, customerCode:customerCode, customerName:customerName, typeCode:typeCode,
                typeName:typeName, phone:phone, fax:fax, address:address,
                url:url, manager:manager,
                contact:contact, dockDepartment:dockDepartment, dockPerson:dockPerson,
                dockContact:dockContact, relateDepartment:relateDepartment, relatePerson:relatePerson,
                relateContact:relateContact,
                electric_contactName:electric_contactName, electric_contactPost:electric_contactPost, electric_phone:electric_phone, electric_mobile:electric_mobile,
                water_contactName:water_contactName, water_contactPost:water_contactPost, water_phone:water_phone, water_mobile:water_mobile,
                safe_contactName:safe_contactName, safe_contactPost:safe_contactPost, safe_phone:safe_phone, safe_mobile:safe_mobile,
                visual_contactName:visual_contactName, visual_contactPost:visual_contactPost, visual_phone:visual_phone, visual_mobile:visual_mobile,
                emergency_contactName:emergency_contactName, emergency_contactPost:emergency_contactPost, emergency_phone:emergency_phone, emergency_mobile:emergency_mobile,
                draft:draft
            },
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                //$('#dg').datagrid('reload');
                loaddata();
                $("#addCustomerWin").window("close");
                //addCustomerDialog.dialog('close');
                $.messager.alert('提示',"修改客户成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    //双击看明细
    function showFormWin(rowIndex,rowData){
        var selectedRow = $('#dg').datagrid('getSelected');
        $('#customerName').textbox("setValue",selectedRow.customerName);
        $('#typeName').textbox("setValue",selectedRow.typeName);
        $('#phone').textbox("setValue",selectedRow.phone);
        $('#fax').textbox("setValue",selectedRow.fax);
        $('#address').textbox("setValue",selectedRow.address);
        $('#url').textbox("setValue",selectedRow.url);
        $('#manager').textbox("setValue",selectedRow.manager);
        $('#contact').textbox("setValue",selectedRow.contact);
        $("#dockDepartment").textbox("setValue",selectedRow.dockDepartment);

        $('#dockPerson').textbox("setValue",selectedRow.dockPerson);
        $('#dockContact').textbox("setValue",selectedRow.dockContact);
        $('#relateDepartment').textbox("setValue",selectedRow.relateDepartment);
        $('#relatePerson').textbox("setValue",selectedRow.relatePerson);
        $('#relateContact').textbox("setValue",selectedRow.relateContact);

        $('#electric_contactName').textbox("setValue",selectedRow.electric.contactName);
        $('#electric_contactPost').textbox("setValue",selectedRow.electric.contactPost);
        $('#electric_phone').textbox("setValue",selectedRow.electric.phone);
        $('#electric_mobile').textbox("setValue",selectedRow.electric.mobile);

        $('#water_contactName').textbox("setValue",selectedRow.water.contactName);
        $('#water_contactPost').textbox("setValue",selectedRow.water.contactPost);
        $('#water_phone').textbox("setValue",selectedRow.water.phone);
        $('#water_mobile').textbox("setValue",selectedRow.water.mobile);

        $('#safe_contactName').textbox("setValue",selectedRow.safe.contactName);
        $('#safe_contactPost').textbox("setValue",selectedRow.safe.contactPost);
        $('#safe_phone').textbox("setValue",selectedRow.safe.phone);
        $('#safe_mobile').textbox("setValue",selectedRow.safe.mobile);

        $('#visual_contactName').textbox("setValue",selectedRow.visual.contactName);
        $('#visual_contactPost').textbox("setValue",selectedRow.visual.contactPost);
        $('#visual_phone').textbox("setValue",selectedRow.visual.phone);
        $('#visual_mobile').textbox("setValue",selectedRow.visual.mobile);

        $('#emergency_contactName').textbox("setValue",selectedRow.emergency.contactName);
        $('#emergency_contactPost').textbox("setValue",selectedRow.emergency.contactPost);
        $('#emergency_phone').textbox("setValue",selectedRow.emergency.phone);
        $('#emergency_mobile').textbox("setValue",selectedRow.emergency.mobile);

        $("#addCustomerWin").window("open");
        $("#button_tr").hide();
        $("#edit_button_tr").hide();
    }

    function submitDistribution(){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
        var responsiblePersonId = $('#responsiblePersonId').combotree("getValue");
        var responsiblePerson = $('#responsiblePersonId').combotree("getText");
        $.ajax({
            type:'post',
            url:'/customer/distributionCustomer',
            dataType : "json",
            data:{customeId:customeId, responsiblePersonId:responsiblePersonId, responsiblePerson:responsiblePerson},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                distributionCustomerDialog.dialog('close');
                $.messager.alert('提示',"客户分配成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    function submitAssist(){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
        var assistPersonId = $('#assistPersonId').combotree("getValue");
        var assistPerson = $('#assistPersonId').combotree("getText");
        $.ajax({
            type:'post',
            url:'/customer/assistCustomer',
            dataType : "json",
            data:{customeId:customeId, assistPersonId:assistPersonId, assistPerson:assistPerson},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                assistCustomerDialog.dialog('close');
                $.messager.alert('提示',"客户谢祖成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    function submitFeedback(){
        var row = $('#dg').datagrid('getSelected');
        var customerCode = row.customerCode;
        var customerName = row.customerName;
        var responsiblePerson = $('#f_responsiblePerson').val();
        var description = $('#f_description').val();
        $.ajax({
            type:'post',
            url:'/customer/createCustomerFeedback',
            dataType : "json",
            data:{customerCode:customerCode, customerName:customerName, responsiblePerson:responsiblePerson, description:description},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                customerFeedbackDialog.dialog('close');
                $.messager.alert('提示',"客户反馈成功");
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

    //打开导入窗口
    function openImportWin(){
        $('#importForm').form("clear");
        $("#importDialog").window("open");
    }
    //检查导入文件种类
    function checkExt(fileId, ext, val) {
        var result = true;
        var tempext = ext;
        ext = ',' + ext + ','; // ,xls,xlxs,
        var value = $("#" + fileId).val(); // 111.xlxs
        if (value == "")
            return false;
        if (value.indexOf(".") > 0) {
            var o = value.split("."); // 111.xlxs ==> o[111] o[xlxs]
            var e = ',' + o[o.length - 1].toLowerCase() + ','; // ,xlxs,
            if (ext.indexOf(e) == -1) // ext中不包含e
                result = false;
        } else{
            result = false;
        }
        if (!result) {
            $.messager.alert('提示', '请选择Excel文件！', 'warning');
            document.getElementById(fileId).outerHTML = document
                    .getElementById(fileId).outerHTML.replace(/(value=\").+\"/i,
                    "$1\"");
        } else {
            $('#importFileName').val(val);
        }
    }
    //上传文件
    function importRow(){
        $('#importForm').form('submit',{
            onSubmit : function(param) {
                if($("#importFile").val()==""){
                    $.messager.alert('提示','请选择要上传的Excel！','warning');
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
                        msg : '导入成功！'
                    });
                    $("#importDialog").window("close");
                    //$('#dg').datagrid('reload');
                    loaddata();
                }
            }
        });
    }

    //审核
    function auditCustomer(status){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
        $.ajax({
            type:'post',
            url:'/customer/auditCustomer',
            dataType : "json",
            data:{customeId:customeId, status:status},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $.messager.alert('提示',"客户审核成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    //移入公海
    function updateCustomerToOpenSea(status){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
        $.ajax({
            type:'post',
            url:'/customer/updateCustomerToOpenSea',
            dataType : "json",
            data:{customeId:customeId, status:status},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $.messager.alert('提示',"客户移入公海成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

</script>
</body>
</html>
