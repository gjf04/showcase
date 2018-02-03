<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="hasActionErrors()||hasFieldErrors()">
	<div class="message-error" id="_error_message_box">
      <s:iterator value="actionErrors">
        <s:property/><br />
      </s:iterator>
      <s:iterator value="fieldErrors">
          <s:iterator value="value">
             <s:property/><br />
          </s:iterator>
      </s:iterator>
    </div>
</s:if>
<s:elseif test="hasActionMessages()">
	<div class="valid_box" id="_action_message_box">
		<s:iterator value="actionMessages">
          <s:iterator value="value">
             <s:property/><br />
          </s:iterator>
      	</s:iterator>
	</div>
</s:elseif> 
<s:else>
	<div id="_error_message_box">
	</div>
</s:else>