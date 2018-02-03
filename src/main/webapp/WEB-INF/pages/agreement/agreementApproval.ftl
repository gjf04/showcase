<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="wb:webmaster" content="6ffdc657eef2403e" />
<title>合同审核</title>
<meta name="generator" content="PEC" />
	<#include "../common/easyui_core.ftl"/>
	<link href="${domainUrlUtil.staticURL}/css/styleAgreement.css"  rel="stylesheet" />
</head>
<body id="ehaiertop">

<div id="loading"></div>
<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"]>
<div class="bigwrapper">
	<div class="wrapper clearfix container-40">
		<!--位置导航-->
		<div class="right" id="right" style="width: 1057px;">
		<div class="location">
               	 当前位置：合同管理 &gt; 合同签订 &gt; 合同新增
        </div>
		<div class="mcontent">
			<div class="Progress-bar">
				<ul>
					<#if agreementInfo?? && agreementInfo.approvalStatus==1>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">客户信息<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">合同编辑<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">合同审核-内勤<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/disc.png">合同审核-总监<img src="${domainUrlUtil.staticURL}/images/right.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/disc.png">合同归档</li>
					</#if>
					<#if agreementInfo?? && agreementInfo.approvalStatus==2>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">客户信息<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">合同编辑<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">合同审核-内勤<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/bdisc.png">合同审核-总监<img src="${domainUrlUtil.staticURL}/images/bright.png"></li>
						<li><img src="${domainUrlUtil.staticURL}/images/disc.png">合同归档</li>
					</#if>
					
				</ul>
			</div>
			<div class="review">
					<p>合同审核中......</p>
			</div>
		</div>
				
		<div class="">
			
			<br/>
			<#if agreementInfo?? >
				<span style="margin-left:55px;">${agreementInfo.projectName}<em style="font-style:normal;color:#c7003a"></span>
	            <br/>
			</#if>
            
            <span style="margin-left:55px;">审核信息：<em style="font-style:normal;color:#c7003a">*</em></span>
				<textarea class="inl260" name="refuseInfo" id="refuseInfo" ></textarea>&nbsp;
			<span id="mainBankId_mes"></span>
            <br/>
            <input type="hidden" id="agreementId" name="agreementId" value="${(agreementInfo.id)!''}"/>
            
            <button class="saveAgreement"  onclick="javascript:saveAgreement('1');" >通过</button>
            <button class="saveAgreement"  onclick="javascript:saveAgreement('2');" >不通过</button>
		</div>
  
	<!--主要内容-->
	<div class="wrapper_protocol">

	</div>
</div>
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
	// 保存用户信息
	function saveAgreement(approvalStatus){
		var approvalStatus = approvalStatus;
		var agreementId = $('#agreementId').val();
		var refuseInfo = $('#refuseInfo').val();
		
		if(refuseInfo == null || refuseInfo == '') {
            $.messager.alert("提示", "请填写审核信息！");
            return false;
        }
        
		var dataJson  = {agreeId:agreementId,approvalInfo:refuseInfo,status:approvalStatus};
		$.ajax({
			url:'/agreementInfo/approval',
			type:'get',
			dataType:'json',
			data:dataJson,
			success:function(data){
				if(data.data.result==true){
					//$.messager.alert('提示',"审核成功！");
					window.location.href="/agreementInfo/agreement.html";
				}else{
					$.messager.alert('提示',"保存失败请重试！");
				}
			}
		});
	}
</script>

</body>
</html>