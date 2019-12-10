<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Edit Sub User</title>
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    </head>
    <body>

  <h2>Edit Domain User Privileges</h2>
          
         <!--form section first start-->
         <div class="FormSection">
         
		<div class="greyStrip"><h4>Required Information</h4></div>
		<div align="left" style="padding-left: 15px" class="fieldError">
	<s:fielderror ><s:param >rolePriv</s:param></s:fielderror>
	</div>
        <div class="innerBox">	
        <div class="FormMainBox">
			<div class="labelDiv"><label>User Name</label></div>
            <div class="InputDiv">
            <ss:select  id="userName" name="userName" theme="myTheme"
							cssClass="select1" list="%{#session.subUserList}"
							 headerKey="-1" ajaxAction="com/stpl/pms/action/bo/um/bo_um_fetchDomainUserPriv.action" target="result"
							headerValue="-- Please Select --" applyscript="true"></ss:select>
			</div>
			</div>
			</div>
			</div>
		<s:form name="editUserPriv" id="editUserPrivFrm" action="/com/stpl/pms/action/bo/um/bo_um_editDomainUserPriv.action"
			method="POST" onsubmit="return chksub();">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div id="result">
			</div>
		</s:form>
			</body>
			</html>