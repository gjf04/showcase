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
			</div>
			
			<div class="review">
				<p>合同已经审核通过，可下载打印</p>
                <input name="" type="button" value="合同打印下载" class="downloadbtn" style="margin:20px 0;">
			</div>
			
		</div>
				
		<div class="">
			
			<br/>
			<#if agreementInfo?? >
				<span style="margin-left:55px;">${agreementInfo.projectName}<em style="font-style:normal;color:#c7003a"></span>
	            <br/>
			</#if>
            
            <input type="hidden" id="agreementId" name="agreementId" value="${(agreementInfo.id)!''}"/>
            
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
	var agreementId = $('#agreementId').val();
	$(".downloadbtn").click(function(){
	    //window.location.href="/agreementInfo/toAgreementDetail.html?id="+agreementId;
	    window.open("/agreementInfo/toAgreementDetail.html?id="+agreementId);
	});
	
</script>

</body>
</html>