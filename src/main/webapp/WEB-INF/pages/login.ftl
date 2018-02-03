<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>淼盾CRM系统</title>
<link href="assets/css/login_index.css"  rel="stylesheet" />
<#include "./common/easyui_core.ftl"/>
<script type="text/javascript">
    //回车登录提交
    function keyLogin() {
        document.onkeydown=function mykeyDown(e){
            e = e||event;
            if(e.keyCode == 13) {//回车键的键值为13
                loginCommit(); //调用登录按钮的登录事件
            }
            return;
        }
    }

        function loginCommit() {
        	var userName = $("#userName").val();
        	var password = $("#password").val();
            if (userName == "") {
                $("#userName").focus();
                alert("用户名不能为空");
                return false;
            }
            if (password == "") {
                $("#password").focus();
                alert("密码不能为空");
                return false;
            }
           $.ajax({
		        url:'/loginCommit',
		        dataType : 'json',
		        type : 'POST',
		        async:false,
		        data:{userName:userName, password:password},
		        success: function (data){
					if(data.data){
	            		window.location.href = "/index.html";
	                }else{
                        $.messager.alert('提示',data.message);
	                }
		        }
			});
        }

        function apply(){
            $("#applyDiv").dialog({
                title: '注册账号',
                width: 400,
                height: 350,
                top: 60,
                closed: true,
                cache: false,
                modal: true,
                buttons:[{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){
                        applyCommit();
                    }
                },{
                    text:'取消',
                    iconCls:'icon-cancel',
                    handler:function(){
                        $('#applyDiv').dialog('close');
                    }
                }]
            });
            $('#duserName').textbox("setValue","");
            $('#dpassword').textbox("setValue","");
            $('#dmobile').textbox("setValue","");
            $('#demail').textbox("setValue","");
            $('#dnickName').textbox("setValue","");
            $("input[name='dsex'][value='男']").attr("checked",true);
            $('#didentityNo').textbox("setValue","");
            $('#dbirthday').textbox("setValue","");
            $('#daddress').textbox("setValue","");
            $("#applyDiv").dialog("open");
        }

        function applyCommit(){
            var userName = $('#duserName').val();
            var password = $('#dpassword').val();
            var mobile = $('#dmobile').val();
            var email = $('#demail').val();
            var nickName = $('#dnickName').val();
            var sex = $("input[name='dsex'][checked]").val();
            var identityNo = $('#didentityNo').val();
            var birthday = $('#dbirthday').datebox("getValue");
            var address = $('#daddress').val();
            if (userName == "") {
                $("#userName").duserName();
                alert("用户名不能为空");
                return false;
            }
            if (password == "") {
                $("#dpassword").focus();
                alert("密码不能为空");
                return false;
            }
            if (nickName == "") {
                $("#dnickName").focus();
                alert("真实姓名不能为空");
                return false;
            }
            $.ajax({
                type:'post',
                url:'/system/createUser',
                dataType : "json",
                data:{userName:userName, password:password, mobile:mobile, email:email, nickName:nickName, sex:sex, identityNo:identityNo, birthday:birthday, address:address},
                cache:false,
                async:false,
                success:function(data){
                    $.messager.progress('close');
                    if(!data.success){
                        $.messager.alert('提示',data.message);
                    }
                    $('#applyDiv').dialog('close');
                    $.messager.alert('提示',"您的注册信息已提交成功，审核通过后即可登录使用系统");
                },
                error:function(d){
                    $.messager.alert('提示',"请刷新重试");
                }
            });
        }

    </script>
</head>
<body onkeydown="keyLogin();">
    <div class="login-all">   	    
	    <div class="login">
	     	<img src="assets/images/loginlong.png" width="342" height="95" alt="" />
		    <div class="loginfrom">
		        <ul>
		            <li>用 &nbsp;&nbsp;户：  <input type="text" id="userName" name="userName" ></input></li>
		            <li>密 &nbsp;&nbsp;码：   <input id="password" id="password"  type="password" ></input></li>
		            <li style="text-align: right;padding-top:0 ;"><a href="#" onclick="apply();"/> 注册账号</a></li>
		        </ul>
		    </div>
		    <div class="loginbtn">
		    	<input ID="ImageButton1"  type="image" 
		    		src="assets/images/login.png" width="275" height="33" 
		    		onclick="loginCommit();"
		    	/>               
	       </div>	        
	    </div> 
	    <div class="logincopy">版权所有 @ 淼盾物联 Copyright &copy; 2015 </div>
		    
	    
    </div>

    <!-- 注册 -->
    <div id="applyDiv"  class="easyui-dialog" title=""   closed="true"
         data-options="resizable:true,modal:true" >
        <table style="font-weight: 400;" border="0">
            <tr>
                <td style="text-align: right;">用户名<span class="star">*</span>:</td>
                <td>
                    <input id="duserName" name="duserName" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>
            <tr>
                <td style="text-align: right;">密码<span class="star">*</span>:</td>
                <td><input id="dpassword" name="dpassword" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">手机号<span class="star">*</span>:</td>
                <td><input id="dmobile" name="dmobile" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">邮箱:</td>
                <td><input id="demail" name="demail" size="54" class="easyui-textbox" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">真实姓名<span class="star">*</span>:</td>
                <td><input id="dnickName" name="dnickName" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">性别<span class="star">*</span>:</td>
                <td>
                    <input id="dsex1" type="radio" name="dsex"
                           class="easyui-validatebox" checked="checked" value="男"><label>男</label></input>
                    <input id="dsex2" type="radio" name="dsex"
                           class="easyui-validatebox" value="女"><label>女</label></input>
                </td>
            </tr>

            <tr>
                <td style="text-align: right;">身份证号:</td>
                <td><input id="didentityNo" name="didentityNo" size="54" class="easyui-textbox" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">生日:</td>
                <td>
                    <input id="dbirthday" name="dbirthday" size="54" type="text" class="easyui-datebox"  data-options="sharedCalendar:'#sc',editable:false" style="width:200px;" />
                    <div id="sc" class="easyui-calendar"></div>
                </td>
            </tr>

            <tr>
                <td style="text-align: right;">家庭住址:</td>
                <td><input id="daddress" name="daddress" size="54" class="easyui-textbox" style="width: 200px;"/></td>
            </tr>

        </table>

    </div>
    
</body>
</html>
