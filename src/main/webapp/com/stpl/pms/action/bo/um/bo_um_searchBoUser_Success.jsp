<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<div class="FormSection">
	<div class="greyStrip">
		<h4>
			<s:text name="global.subuserregistration.SuccessMessage"/>
		</h4>
	</div>
	<div class="innerBox">
		<div class="alert succes_msg">
			<span class="alert_close"> </span><strong><s:property
					value="#session.BO_USER_NAME" /> </strong><s:text name="global.scratchWeaver.msg1"></s:text>
		</div>
	</div>
</div>
<s:form action="/com/stpl/pms/action/bo/um/bo_um_searchBoUser_Menu.action" method="POST">
<%-- <s:submit value="Back To Search" cssClass="button" align="right" action="bo_um_searchBoUser_Menu"></s:submit> --%>
<input type="submit" class="button" align="right" value='<s:text name="global.scratchWeaver.BackToSearch"/>'/>
	</s:form>
