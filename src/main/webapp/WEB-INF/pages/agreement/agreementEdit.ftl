<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="wb:webmaster" content="6ffdc657eef2403e" />
	<title>合同签订</title>
	<#include "../common/easyui_core.ftl"/>
	<link href="${domainUrlUtil.staticURL}/css/styleAgreement.css"  rel="stylesheet" />
	
	<meta name="generator" content="PEC" />
</head>
<body id="ehaiertop">

<div id="loading"></div>
<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"]>
<#noescape>${header!}</#noescape>
<div class="bigwrapper">
	<div class="wrapper clearfix container-40">
		<!--位置导航-->
		<div class="">
			<a href=""><i class="icon-font icon-crumb"></i>首页</a> &gt;
				<span>合同管理</span> &gt;<strong class="now">合同签订</strong>
		</div>
		<div class="newedit">
		<strong style="color: #1361a6;line-height:30px">新增合同:</strong>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tbody>
			<@form.form method="post" class="validForm" id="addForm" name="addForm">
			<tr>
				<td class="tdright" width="130">合同签署单位：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td><input class="" name="firstParty" id="firstParty" value="${(agreementInfo.firstParty)!''}"/>     
			    </td>
		  	</tr>
		  	
		  	<tr>
				<td class="tdright" width="130">项目名称：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td><input class="" name="projectName" id="projectName" value="${(agreementInfo.projectName)!''}" />    
			    </td>
		  	</tr>
		  	
		  	<tr>
				<td class="tdright" width="130">选择客户：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td> <select id="customerId" name="customerId" style="width:170px;height: 24px;">
			           <option value="">--请选择--</option>
			           <option value="0">客户1</option>
			           <option value="1">客户2</option>
			           <option value="2">客户3</option>
			        </select>       
			    </td>
		  	</tr>
		  	
		  	<tr>
		    	<td class="tdright">联络人：</td>
		    	<td><input name="" type="text" placeholder=""/></td>
		  	</tr>
		  	
		  	<tr>
				<td class="tdright" width="130">签订日期：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td><input class="" name="agreeDate" id="agreeDate" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss'})"/>    
			    </td>
		  	</tr>
		  	
		  	<tr>
		    	<td class="tdright">合同年限：<em style="font-style:normal;color:#c7003a">*</em></td>
		    	<td><input name="serviceLife" id="serviceLife" type="text"  style="width:50px; text-align: center;"/>  年</td>
		  	</tr>
		  	
		  	<tr>
				<td class="tdright">合同金额：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td><span style="color: red;">¥</span>
					<input class="" name="agreementAmount" id="agreementAmount" style="width:80px;"/>元
			    </td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">设备费合计：</td>
		    	<td><span style="color: red;">¥</span> 
		    		<input name="hardwareAll" id="hardwareAll" type="text" style="width:80px;"/>元</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">安装费合计 ：</td>
		    	<td><span style="color: red;">¥</span> 
		    		<input name="installAll" id="installAll" type="text" style="width:80px;"/>元</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">服务费合计：</td>
		    	<td><span style="color: red;">¥</span> 
		    		<input name="serviceAll" id="serviceAll" type="text" style="width:80px;"/> 元</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">费用总合计：</td>
		    	<td><span style="color: red;">¥</span> 
		    		<input name="expensesAll" id="expensesAll" type="text" placeholder="" style="width:80px;"/> 元</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">应付款：</td>
		    	<td><span style="color: red;">¥</span> 
		    		<input name="payablesAll" id="payablesAll" type="text" placeholder="" style="width:80px;"/> 元</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">服务费：</td>
		    	<td>
		    		第二年
		    		<input name="serviceMonth" id="serviceMonth" type="text" placeholder="" style="width:30px; text-align: center;"/> 月
		    		<input name="serviceDay" id="serviceDay" type="text" placeholder="" style="width:30px; text-align: center;"/> 日
		    		起付 <span style="color: red;">¥</span> <input name="serviceYearAll" id="serviceYearAll" type="text" placeholder="" style="width:80px;"/> 元（每年）
		    	</td>
		  	</tr>
		  	<tr>
		    	<td class="tdright">合同应付款总额：</td>
		    	<td>
		    		<input name="agreementAmountUpper" id="agreementAmountUpper" type="text" placeholder="" style="width:100px; text-align: center;"/> 圆整
		    		人民币小写:<span style="color: red;">¥</span> 
		    		<input name="agreementAmount" id="agreementAmount" type="text" placeholder="" style="width:80px;"/> 元
		    	</td>
		  	</tr>
		  	
			</tbody>
		</table>		  	
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="listtable" style="text-align: center;">
                <thead bgcolor="#eef3f7">
                <tr>
                    <td>系统名称</td>
                    <td>硬件名称</td>
                    <td>数量</td>
                    <td>单价</td>
                    <td>设备费合计(元）</td>
                    <td>服务费（元/年）</td>
					<td>安装费及辅材费用合计（元/套）</td>
                    
                </tr>
                </thead>
                <#if agreementGoodsList?? >
                <#list agreementGoodsList as agreementGood >
                <tr class="table-tr">
                    <td><input type="text" name="systemName" value="${(agreementGood.systemName)!''}"  /></td>
                    <td><input type="text" name="hardwareName" value="${(agreementGood.hardwareName)!''}"   /></td>
                    <td><input type="text" name="goodsNum" value="${(agreementGood.goodsNum)!''}"  style="width:40px"  /></td>
                    <td><input type="text" name="price" value="${(agreementGood.price?string("0.00"))!''}" style="width:50px"   /></td>
                    <td><input type="text" name="hardwareAmount" value="${(agreementGood.hardwareAmount?string("0.00"))!''}" style="width:80px" /></td>
                    <td><input type="text" name="serviceAmount" value="${(agreementGood.serviceAmount?string("0.00"))!''}" style="width:80px"  /></td>
                    <td><input type="text" name="allAmount" value="${(agreementGood.allAmount?string("0.00"))!''}" style="width:80px" /></td>
                </tr>
                </#list >
                </#if>                  
                
            </table>    
            <input type="hidden" id="agreementId" name="agreementId" value="${(agreementId)!''}"/>
            <input type="hidden" id="approvalStatus" name="approvalStatus" value=""/>
            <input type="hidden" id="firstRatio" name="firstRatio" value=""/>
            <input type="hidden" id="lastRatio" name="lastRatio" value=""/>
			<div style="margin-left:60px">
			    <input id="Button1" type="button" text="添加一行" value="添加一行" onclick="addLine();" /> 
			    &nbsp;&nbsp;     
			</div>
            </@form.form>
            <div class="naebtn">
			    <input id="Button1" type="submit" text="暂存" value="暂存" onclick="javascript:saveAgreement('0');" /> 
			    &nbsp;&nbsp;     
			    <input name="" type="reset" value="提交审核"  onclick="javascript:saveAgreement('1');" />
			    &nbsp;&nbsp; 
			    <input name="" type="reset" value="返回"  onclick="javascript:saveAgreement('2');" />
			 	<div class="clear"></div>             
			</div>
		</div>
  
	<!--主要内容-->
</div>
</div>

</form>
<input type="hidden" value="${(productId)!''}" name="productId" id="productId"/>
<#noescape>${footer!}</#noescape>
<script type="text/javascript">
    var rrs= rrs||{};
    rrs.domainUrl = {
    	baseDomain : '${domainUrlUtil.staticURL}'
    }
</script>
<script type="text/javascript">
	var dataJson1 = {};
	var dataJson2 = {};
	
	var regex = /^\d+\.?\d{0,2}$/;
	var regex2= /^[1-9]\d*$/;
	
	function addLine(){
		 var _template = '';
		 _template += '<tr>';
		 _template += '<td><input type="text" value="" name="systemName" /></td>';
		 _template += '<td><input type="text" value="" name="hardwareName" /></td>';
		 _template += '<td><input type="text" value="" name="goodsNum" style="width:80px; text-align: center;"/></td>';
		 _template += '<td><input type="text" value="" name="price" style="width:80px; text-align: center;"/></td>';
		 _template += '<td><input type="text" value="" name="hardwareAmount" style="width:80px; text-align: center;"/></td>';
		 _template += '<td><input type="text" value="" name="serviceAmount" style="width:80px; text-align: center;"/></td>';
		 _template += '<td><input type="text" value="" name="allAmount" style="width:80px; text-align: center;"/></td>';
		 _template += '</tr>';
		 
		 $(".table-tr:last").after(_template);
		 
		 return;
	}
	// 保存
	function saveAgreement(approvalStatus){
		
		if(approvalStatus==2){
			window.location.href="/agreementInfo/agreement.html";
			return;
		}
		$("#approvalStatus").val(approvalStatus);
		
		var check = false;
		var firstParty = $("#firstParty").val();
        if(firstParty == null || firstParty == '') {
            $.messager.alert("提示", "合同签署单位填写不全!");
            return false;
        }
		var projectName = $("#projectName").val();
        if(projectName == null || projectName == '') {
            $.messager.alert("提示", "项目名称填写不全!");
            return false;
        }
        
        var customerId = $("#customerId").val();
        if(customerId == null || customerId == '') {
            $.messager.alert("提示", "请选择客户！");
            return false;
        }

        var agreeDate = $("#agreeDate").val();
        if(agreeDate == null || agreeDate == '') {
            $.messager.alert("提示", "请选择签订日期！");
            return false;
        }
        
        var serviceLife = $("#serviceLife").val();
        if(serviceLife == null || serviceLife == '') {
            $.messager.alert("提示", "请填写合同年限！");
            $("#serviceLife").focus();
            return false;
        }

        var agreementAmount = $("#agreementAmount").val();
        if(agreementAmount == null || agreementAmount == '') {
            $.messager.alert("提示", "合同金额不能为空！");
            return false;
        }else if (!regex.test(agreementAmount)){
			$("#agreementAmount").focus();
			$.messager.alert('提示',"合同金额只能为保留两位小数的数字！");
			return;
		}else{
            calculatePayRatio(agreementAmount);
		}
		
        var hardwareAll = $("#hardwareAll").val();
        if(hardwareAll == null || hardwareAll == '') {
            $.messager.alert("提示", "设备费合计不能为空！");
            return false;
        }else if (!regex.test(hardwareAll)){
			$("#hardwareAll").focus();
			$.messager.alert('提示',"设备费合计只能为保留两位小数的数字！");
			return;
		}
		
        var installAll = $("#installAll").val();
        if(installAll == null || installAll == '') {
            $.messager.alert("提示", "安装费合计不能为空！");
            return false;
        }else if (!regex.test(installAll)){
			$("#installAll").focus();
			$.messager.alert('提示',"安装费合计只能为保留两位小数的数字！");
			return;
		}
		
		var serviceAll = $("#serviceAll").val();
        if(serviceAll == null || serviceAll == '') {
            $.messager.alert("提示", "服务费合计不能为空！");
            return false;
        }else if (!regex.test(serviceAll)){
			$("#installAll").focus();
			$.messager.alert('提示',"服务费合计只能为保留两位小数的数字！");
			return;
		}
		
        var expensesAll = $("#expensesAll").val();
        if(expensesAll == null || expensesAll == '') {
            $.messager.alert("提示", "费用总合计不能为空！");
            return false;
        }else if (!regex.test(expensesAll)){
			$("#expensesAll").focus();
			$.messager.alert('提示',"费用总合计只能为保留两位小数的数字！");
			return;
		}
		
        var payablesAll = $("#payablesAll").val();
        if(payablesAll == null || payablesAll == '') {
            $.messager.alert("提示", "应付款不能为空！");
            return false;
        }else if (!regex.test(payablesAll)){
			$("#payablesAll").focus();
			$.messager.alert('提示',"应付款只能为保留两位小数的数字！");
			return;
		}
		
        var serviceMonth = $("#serviceMonth").val();
        if(serviceMonth != null && serviceMonth != '') {
            if(!regex2.test(serviceMonth)){
	            $("#serviceMonth").focus();
				$.messager.alert('提示',"服务费第二年起付月只能正整数！");
				return;
            }
        }
        
        var serviceDay = $("#serviceDay").val();
        if(serviceDay != null && serviceDay != '') {
            if(!regex2.test(serviceDay) ) {
	            $("#serviceDay").focus();
				$.messager.alert('提示',"服务费第二年起付日只能正整数！");
				return;
            }
        }

		var serviceYearAll = $("#serviceYearAll").val();
        if(serviceYearAll == null || serviceYearAll == '') {
            $.messager.alert("提示", "服务费第二年起付金额 不能为空！");
            return false;
        }else if (!regex.test(serviceYearAll)){
			$("#serviceYearAll").focus();
			$.messager.alert('提示',"服务费第二年起付金额 只能为保留两位小数的数字！");
			return;
		}
		
		var agreementAmountUpper = $("#agreementAmountUpper").val();
        if(agreementAmountUpper == null || agreementAmountUpper == '') {
            $.messager.alert("提示", "请填写合同应付款总额！");
            return false;
        }
        
        var agreementAmount = $("#agreementAmount").val();
        if(agreementAmount == null || agreementAmount == '') {
            $.messager.alert("提示", "应付款不能为空！");
            return false;
        }else if (!regex.test(agreementAmount)){
			$("#agreementAmount").focus();
			$.messager.alert('提示',"合同应付款总额(小写)只能为保留两位小数的数字！");
			return;
		}
		
		$("input[name='systemName']").each(function(index, element) {
			var systemName = $(this).val();
			var hardwareName = $(this).parent().parent().find("input[name='hardwareName']").val();
			var goodsNum = $(this).parent().parent().find("input[name='goodsNum']").val();
			var price = $(this).parent().parent().find("input[name='price']").val();
			var hardwareAmount = $(this).parent().parent().find("input[name='hardwareAmount']").val();
			var serviceAmount = $(this).parent().parent().find("input[name='serviceAmount']").val();
			var allAmount = $(this).parent().parent().find("input[name='allAmount']").val();
			
			if(systemName=='' && hardwareName=='' && goodsNum=='' && price=='' &&
			   hardwareAmount=='' && serviceAmount=='' && allAmount==''){
			}else if(systemName==''){
				$.messager.alert("提示", "请填写货品清单 系统名称！");
				check = true;
				return false;
			}else if(hardwareName==''){
				$.messager.alert("提示", "请填写货品清单 硬件名称！");
				check = true;
				return false;
			}else if(goodsNum==''){
				$.messager.alert("提示", "请填写货品清单 数量！");
				check = true;
				return false;
			}else if(price==''){
				$.messager.alert("提示", "请填写货品清单 单价！");
				check = true;
				return false;
			}else if(hardwareAmount==''){
				$.messager.alert("提示", "请填写货品清单 设备费合计！");
				check = true;
				return false;
			}else if(serviceAmount==''){
				$.messager.alert("提示", "请填写货品清单 服务费！");
				check = true;
				return false;
			}else if(allAmount==''){
				$.messager.alert("提示", "请填写货品清单 安装费及辅材费用合计！");
				check = true;
				return false;
			}else{
				if (!regex2.test(goodsNum)){
					$.messager.alert("提示", "货品清单 数量只能正整数！！");
					check = true;
					return false;
				}
				if (!regex.test(price)){
					$.messager.alert("提示", "货品清单 单价只能为保留两位小数的数字！");
					check = true;
					return false;
				}
				if (!regex.test(hardwareAmount)){
					$.messager.alert("提示", "货品清单 设备费合计只能为保留两位小数的数字！");
					check = true;
					return false;
				}
				if (!regex.test(serviceAmount)){
					$.messager.alert("提示", "货品清单 服务费合计只能为保留两位小数的数字！");
					check = true;
					return false;
				}
				if (!regex.test(allAmount)){
					$.messager.alert("提示", "货品清单 安装费及辅材费用合计只能为保留两位小数的数字！");
					check = true;
					return false;
				}
			}
			return;
		});
		
		if(check){
			return false;
		}
        
        $("#addForm").attr("action", "/agreementInfo/add")
                .attr("method", "POST")
                .submit();
	}

	function calculatePayRatio(payAmount){
        //合同金额 <10万 10-10.999万 20-50万 >50万
        //首付比例 100%  60%         50% 30%
        //尾款比例 0     40%         50% 70%
		if(payAmount<100000){
            $("#firstRatio").val('100');
            $("#lastRatio").val('0');
		}else if(100000<=payAmount<200000){
            $("#firstRatio").val('60');
            $("#lastRatio").val('40');
        }else if(200000<=payAmount<500000){
            $("#firstRatio").val('50');
            $("#lastRatio").val('50');
        }else if(500000<=payAmoun){
            $("#firstRatio").val('30');
            $("#lastRatio").val('70');
        }else{
            $("#firstRatio").val('100');
            $("#lastRatio").val('0');
		}
	}
</script>

</body>
</html>