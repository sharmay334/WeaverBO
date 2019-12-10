<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<div class="innerBox">
	<div class="alert info_msg " style="width: auto">
		<span class="alert_close"></span><strong>Info: </strong> Payment Sub Type Saved.
		<br>
		To add new PODM entry <strong><a href="<%=basePath%>com/stpl/pms/action/bo/cashier/st_pms_csh_podmMapSubType.action">Click here</a></strong>.
	</div>
</div>