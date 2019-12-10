<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="FormSection">
	<div class="greyStrip">
		<h4>
			<s:text name="global.subuserregistration.SuccessMessage"></s:text>
		</h4>
	</div>
	<div class="innerBox">
		<div class="alert succes_msg">
			<span class="alert_close"> </span><strong><s:text name="global.itgs.105"></s:text>: </strong><s:text name="global.um.msg6"></s:text>:
			<font color=red> <s:property value="#session.USER_NAME" /> </font>
			<s:text name="global.editsubuserprivileges.hasbeenEditedSuccessfully"></s:text>
		
		
		</div>
	</div>
</div>