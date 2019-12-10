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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
		
		<s:if test="%{duplicatePlrInfo!=null}">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Duplicate Player's Information
				</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Name : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{duplicatePlrInfo.firstName+' '+duplicatePlrInfo.lastName}"/> </div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	User Name : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{duplicatePlrInfo.userName}"/> </div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Mobile No. : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{duplicatePlrInfo.mobileNo}"/> </div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Email ID : </label>
					</div>
					<div class="InputDivHalf">
						<s:property value="%{duplicatePlrInfo.emailId}"/> 
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Status : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{duplicatePlrInfo.status}"/> </div>
				</div>
				<div class="clearFRM"></div>
				
			</div>
			
		
		</div>
		</s:if>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Player's Information
				</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Name : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{playerInfo.firstName+' '+playerInfo.lastName}"/> </div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	User Name : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{playerInfo.userName}"/> </div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Status : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{playerInfo.status}"/> </div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Current <s:property value="%{changeReq}"/> : </label>
					</div>
					<div class="InputDiv"> <s:property value="%{currentData}"/> </div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> New <s:property value="%{changeReq}"/> : </label>
					</div>
					<div class="InputDivHalf">
						<s:property value="%{newData}"/> 
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
			<div class="box_footer" align="right">
				<s:hidden name="changeReq" id="changeReq" value="%{changeReq}"/>
				<s:hidden name="domainId" id="domainId" value="%{domainId}"/>
				<s:hidden name="requestPlayerId" id="requestPlayerId" value="%{requestPlayerId}"/>
				<s:hidden name="currentData" id="currentData" value="%{currentData}"/>
				<s:hidden name="newData" id="newData" value="%{newData}"/>
				<s:hidden name="duplicatePlrId" id="duplicatePlrId" value="%{duplicatePlrInfo.playerId}"/>
				<ss:button cssClass="button" id="plrInfoEditBtn" theme="simple" value="Edit" target="changePlrInfoFrmDiv" 
				 ajaxAction="com/stpl/pms/action/bo/pm/st_bo_pm_changePlrEmailOrMobile.action" ajaxParam="requestPlayerId,changeReq,domainId,currentData" />
				
				<ss:button cssClass="button" id="plrInfoCnfrmBtn" theme="simple" value="Confirm" target="changePlrInfoFrmDiv" 
				 ajaxAction="com/stpl/pms/action/bo/pm/st_bo_pm_changePlrEmailOrMobile_confirm.action" ajaxParam="requestPlayerId,changeReq,domainId,newData,duplicatePlrId" />
				
				<button id="cancelPlrInfoBtn" name="Cancel"  class="button" onclick="$.facebox.close();">Cancel</button>
			</div> 
			</div>
  </body>
</html>
