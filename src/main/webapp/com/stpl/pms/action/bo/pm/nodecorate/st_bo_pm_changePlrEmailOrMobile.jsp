<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/extended-struts2-tags" prefix="ss" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script>
		$(document).ready(function(){
			$("#newData").applyScriptWithBubble();
			$("#newData_bubbleTable").css("z-index","101");
		});
	</script>
  </head>
  
  <body>
  	<div id="changePlrInfoFrmDiv">
  	<s:form id="changePlrInfoFrm" name="changePlrInfoFrm"
							method="post" target="changePlrInfoFrmDiv" theme="simple"
							action="st_bo_pm_changePlrEmailOrMobile_submit">
		<s:hidden name="changeReq" value="%{changeReq}"/>
		<s:hidden name="requestPlayerId" value="%{requestPlayerId}"/>
		<s:hidden name="currentData" value="%{currentData}"/>
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Change <s:property value="%{changeReq}"/> </h4>
			</div>
			<div class="innerBox">
				<div>
					<s:fielderror theme="simple" fieldName="newData"/>
				</div>
				<div class="clearFRM">
				
				</div><div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Current <s:property value="%{changeReq}"/> : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{currentData}"/> </div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:property value="%{changeReq}"/> : </label>
					</div>
					<div class="InputDivHalf">
						<s:if test="%{changeReq=='Mobile No'}">
									<ss:textfield name="newData" id='newData' applyscript="true" maxlength="10"
										theme="myTheme" pattern="^[7-9]{1}[0-9]{9}$"  patternOn="blur"
										errorMassage="Please enter correct Phone No"></ss:textfield>
								</s:if>
						<s:elseif test="%{changeReq=='Email'}">
									<ss:textfield name="newData" id='newData' applyscript="true"
										theme="myTheme" patternOn="blur"
										pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,6})$"
										errorMassage="Please enter correct Email address"></ss:textfield>
								</s:elseif>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
			<div class="box_footer" align="right">
			<s:hidden name="domainId" id="domainId" value="%{domainId}"/>
				<s:submit value="Submit" id="submitPlrInfo"></s:submit>
			</div>
		</div>
	</s:form>
	</div>
  </body>
</html>
