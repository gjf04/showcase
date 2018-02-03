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
				<td><input class="" name="firstParty" id="firstParty" />     
			    </td>
		  	</tr>
		  	
		  	<tr>
				<td class="tdright" width="130">项目名称：<em style="font-style:normal;color:#c7003a">*</em></td>
				<td><input class="" name="projectName" id="projectName" />    
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
                <tr>
                	<td><input type="text" value="系统名称" name="systemName" /></td>
                	<td><input type="text" value="硬件名称" name="hardwareName" /></td>
                	<td><input type="text" value="3" name="goodsNum" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="500.0" name="price" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="200.0" name="hardwareAmount" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="100.0" name="serviceAmount" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="300.0" name="allAmount" style="width:80px; text-align: center;"/></td>
                </tr>
                <tr>
                	<td><input type="text" value="系统名称2" name="systemName" /></td>
                	<td><input type="text" value="硬件名称2" name="hardwareName" /></td>
                	<td><input type="text" value="4" name="goodsNum" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="501.0" name="price" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="201.0" name="hardwareAmount" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="101.0" name="serviceAmount" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="301.0" name="allAmount" style="width:80px; text-align: center;"/></td>
                </tr>
                <tr>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                </tr> 
                <tr>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                </tr> 
                <tr>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" /></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                	<td><input type="text" value="" name="" style="width:80px; text-align: center;"/></td>
                </tr> 
            </table>    
            <input type="hidden" id="agreementId" name="agreementId" value="${(agreementId)!''}"/>
            
            </@form.form>
            <div class="naebtn">
			    <input id="Button1" type="submit" text="暂存" value="暂存" onclick="javascript:saveAgreement('0');" /> 
			    &nbsp;&nbsp;     
			    <input name="" type="reset" value="提交审核"  onclick="javascript:saveAgreement('1');" />
			 	<div class="clear"></div>             
			</div>
		</div>
  
	<!--主要内容-->
	<div class="wrapper_protocol">
		<div class="wrapper_bg">
			<div class="l_sign">
				<p class="p-title"><em style="height: 16px;"></em>智慧消防安全服务云平台服务合同</p>
			</div>
			<div class="p-cnt">
			<div style="width:1136px;height:520px;overflow-y:scroll;border:1px solid #dfdfdf;padding:0 10px;">
				<p style="margin-top: 0;line-height: 34px;">甲    方：（以下简称甲方）</p>
				<p style="margin-top: 0;line-height: 34px;">乙    方：青岛淼盾八哥网络科技有限公司（以下简称已方）</p>
				<p style="margin-top: 0;line-height: 34px;">协议编号：</p>
                <p style="margin-top: 0;line-height: 34px;">现为保证双方利益，甲乙双方在平等自愿、诚实守信、合作共赢的基础上达成本协议，共同信守。</p>
                <ul class="protocols">
	                <li>
	                    <dl>
	                    	<strong>一、服务内容和服务期限</strong>
	                		<dt>1.1乙方依托智慧消防安全服务云平台监管服务系统（简称“监管系统”）为甲方安全数据，实时传输，隐患预警等服务，以便于甲方查看安装有乙方产品的电气线路运行情况，人员巡查情况，建筑用水信息，消防控制室和消防通道情况及相关的传感数据、统计管理数据和其他分析数据。为甲方提供实时信息传输。</dt>
	                		<dt>1.2乙方向甲方提供自数据生成之日起合同期内3年内被监测设备运行数据的保存和查询服务。</dt>
	                		<dt>1.3乙方向甲方提供电气火灾隐患/故障分析在线支持服务。</dt>
	                		<dt>1.4乙方发现安装产品的线路有异常情况，将立即通过APP及短信方式通知甲方指定的通讯联络人，如发现重大问题时将直接电话通知。</dt>
	                		<dt>1.5甲乙双方约定上述服务的期限为3年（简称“服务期限”）。自设备安装调试完成之日起算。在服务期限届满之后，甲方同意继续由乙方提供服务，甲方按原合同约定内的定价服务费给乙方，若甲方对乙方的设备及服务满意，甲乙双方按原合同执行或重新签署服务协议。</dt>
	                		<dt>1.6乙方将电气火灾隐患监管服务系统的设备安装至甲方指定的地点并安装调试正常运转后，向甲方发出书面通知，若无异议，监管平台正式运行。</dt>
	                		<dt>1.7甲方接到报警信息未及时处理，造成火灾与乙方无关；</dt>
	                		<dt>1.8甲方不准私自拆除或者断掉网络，如因甲方人为造成网络信号掉线等甲方负责一切损失。</dt>
	                		</dl>
	                </li>
	                <li>
	                    <dl>
	                    	<strong>二、安全平台设置及使用的约定</strong>
	                    	<dt>2.1安全平台的设置目的：依托智慧消防安全服务云平台，便于甲方实时监管自有设备的安全使用情况、监督检查执行人员工作情况，通过数据的反馈更简便的掌握监管数据和查询功能。</dt>
	                    	<dt>2.2服务内容：乙方定期（每周）通过电子邮件方式，向甲方指定的联系人发送指定主干线路的用电安全报告、电气火灾隐患/故障分析在线支持服务，监督检查执行人员的工作进展。乙方向甲方提供自数据生成之日起3年内被监测设备运行数据的保存和查询服务。</dt>
	                    	<dt>2.3乙方拥有监管系统服务平台的所有权，给甲方提供的安全平台设置、开通后一次性收取第一年服务费，乙方开据正式发票，以后每年的服务费在相关年度年终前30日内支付。若在服务期限届满之后，甲方愿意继续由乙方提供服务，则由双方另行签署相关协议，并在到期前30日续交次年平台服务费。如没有变动项，也可按合同制定的服务费标准执行。</dt>
	                    	<dt>2.4在服务期限内，乙方有权对监管系统及服务系统进行维护、更新和升级，甲方对此予以认可。乙方提供给甲方的监管系统服务账户和密码，是乙方在提供服务过程中识别甲方的唯一依据，甲方应当严格保密并指定专人妥善保管。甲方及指定保管人均不得将账户和密码提供给除甲方指定的监管系统操作人员以外的任何第三方使用。因甲方及指定保管人泄露账户密码造成的损失后果，由甲方承担。</dt>
	                    	<dt>2.5在服务期限内，乙方负责对甲方指定的监管系统操作人员进行培训，培训至操作人员达到熟练操作系统的水平，甲方予以协助和配合。</dt>
	                	</dl>
	                </li>
	                <li>
	                    <dl>
	                    	<strong>三、设备检验标准、方法及质保期限约定</strong>
	                    	<dt>3.1 在签署本合同后，乙方有义务为甲方进行安装点的勘测、评估，并出具初步的勘测报告以及建议；甲方应予以安排人员配合并确认；</dt>
	                    	<dt>3.2 乙方接到甲方安装同意意见书后15个工作日内进入现场安装、调试设备，甲方应为乙方提供安装、调试的便利；</dt>
	                    	<dt>3.3 安装过程中，乙方应严格按照现行的《中华人民共和国安全生产法》及《施工现场临时用电安全技术规范》中的有关安全操作规程施工，甲方应予配合；</dt>
	                    	<dt>3.4 乙方将设备安装至甲方指定的地点并调试正常运转后，向甲方发出书面通知，由甲方进行验收。甲方应在收到通知后3日内安排人员前往现场进行验收。若无异议，甲方应当当场签署验收合格文件；如甲方对产品质量存有异议，也亦于当日书面提出异议。《设备安装调试合格单》作为验收合格的依据，设备质保期自验收合格之日起12个月内。</dt>
	                	</dl>
	                </li>
	                <li>
	                    <dl>
	                    	<strong>四、质量负责的条件及期限</strong>
	                    	<dt>甲、乙双方交易产品自交（提）货之日起一年内，因产品本身的质量原因引起的故障，乙方免费更换，若因非产品本身的质量原因所引起的故障，甲方需根据乙方的收费标准支付必要的费用。乙方仅负责所提供货物的自身价值，而不承担超越货物自身价值的其他任何责任。</dt>
	                	</dl>
	                </li>
	                <li>
	                    <dl>
	                    	<strong>五、货物所有权及风险转移</strong>
	                    	<dt>货物的所有权及货物的灭失、损毁的风险责任自甲方收到货物之日起转移至甲方。但甲方未履行支付价款义务的,货物所有权不发生转移，乙方有权自行处理货物而无须通知甲方。</dt>
	                	</dl>
	                </li>
	                <li>
	                    <dl>
	                    	<strong>六、免责和责任限制条款</strong>
	                    	<dt>因下列原因导致设备或监管平台无法正常运作的，乙方不承担责任：</dt>
	                    	<dt>6.1乙方预先通知的监管平台停机维护期间；</dt>
	                    	<dt>6.2因台风、地震、海啸、洪水、恐怖袭击等不可抗力之因素，造成乙方设备或监管平台故障不能提供服务的；</dt>
	                    	<dt>6.3安装过程中，若由甲方原因导致安装过程中发生人身、财产的损害事故的，甲方自行承担全部责任或者损失，与乙方无关。</dt>
	                	</dl>
	                </li>          
	                <li>
	                    <dl>
	                    	<strong>七、保密</strong>
	                    	<dt>甲方有对其获取的任何乙方保密信息（包括但不限于技术信息、价格等）承担保密义务，乙方有权自行保有、使用、处置服务平台监测到的信息；但未经甲方同意不得对外公布。</dt>
	                	</dl>
	                </li>          
	                <li>
	                    <dl>
	                    	<strong>八、违约责任</strong>
	                    	<dt>甲方未按合同约定付款或未履行合同约定的其他相关义务致使提供服务时间推迟，乙方不承担任何责任，同时有权停止后期服务。若甲方未按照合同约定的义务使用产品，履行合同约定的相关义务，乙方有权解除合同，还应向乙方支付合同金额20%的违约金。给乙方造成损失的，甲方应予以赔偿。</dt>
	                    	<dt>乙方未按照合同约定期限按期交货的、乙方交付的产品不符合合同约定质量的、乙方未及时维修设备、系统故障的，甲方有权解除合同，已支付的款项乙方应当退还，还应向甲方支付合同金额20%的违约金。给甲方造成损失的，乙方应予以赔偿。</dt>
	                	</dl>
	                </li>          
	                <li>
	                    <dl>
	                    	<strong>九、合同争议的解决方式</strong>
	                    	<dt>本合同在履行过程中发生争议，由双方协商解决。协商不成，任何一方均可向双方所在地或合同签订地人民法院诉讼解决。</dt>
	                	</dl>
	                </li>          
	                <li>
	                    <dl>
	                    	<strong>十、协议的生效</strong>
	                    	<dt>10.1本合同自双方授权代表签字或加盖公章后生效。</dt>
	                    	<dt>10.2本合同壹式叁份，甲、乙双方各持壹份，消防支队留存壹份，具有同等的法律效力。</dt>
	                	</dl>
	                </li>          
	                <li>
	                    <dl>
	                    	<strong>协议附件及因本协议未尽事宜而签订的补充协议与本协议具有同等法律效力。</strong>
	                	</dl>
	                </li>          
            	</ul>
			</div>
				
			</div>
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
	var dataJson1 = {};
	var dataJson2 = {};
	
	var regex = /^\d+\.?\d{0,2}$/;
	var regex2= /^[1-9]\d*$/;
	// 保存
	function saveAgreement(approvalStatus){
	
		var check = false;
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
		return;
		
		
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
		
		$("input[name='price']").each(function(index, element) {
			var price = $(this).val();
			var systemName = $(this).parent().children("input[name='systemName']").val();
			alert(systemName);
			return;
		})
		if(check) {
            return false;
        }
        
        $("#addForm").attr("action", "/agreementInfo/add")
                .attr("method", "POST")
                .submit();
	}
</script>

</body>
</html>