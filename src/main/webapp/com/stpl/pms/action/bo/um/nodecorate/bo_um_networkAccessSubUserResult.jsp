<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    </head>
    <body>
<s:form action="st_um_bo_assignSubUserNetworkAccess" theme="simple">

<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Privilege	
			</h4>
	</div>
	<div class="innerBox">
			<div class="FormMainBox">
	
	<div class="labelDiv"><label>Ip Address:</label></div>
            <div class="InputDiv">
         		<s:textfield id="ipAddress" name="ipAddress" theme="myTheme"
						applyscript="true" maxlength="25" pattern="^[0-9.]*$"
						errorMassage="Numeric and Special character not allowed"></s:textfield>
				
         	</div>
			</div>
			
			<div class="FormMainBox">
	
	<div class="labelDiv"><label>Status:</label></div>
            <div class="InputDiv">
         		  <s:select id="status" name="status" theme="myTheme"
							cssClass="select1" list="accessType"
							 headerKey="-1" target="result"
							headerValue="-- Please Select --" applyscript="true"></s:select>
			
         	</div>
			</div>
			
	</div>
	
	</div>
	<div class="box_footer" align="right">
			
			<s:submit value="Assign Access" align="center" cssClass="button"
				 theme="simple"/>
</div>
</s:form>
	</body>
	</html>