<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'st_pms_bo_rep_playerPersonalCancelEdit.jsp' starting page</title>
    
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
   <div id="plrPersonalInfo" >
	<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Personal Information
					</h4>
				</div>
				<s:property value="%{#parameters.ageVerifed}"/>
				<table width="95%" cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px" >
				<tr></tr>
				<tr>
				<td width="25%" align="center">First Name :</td>
				<td width="25%" align="center"><s:property value="%{#parameters.fName}" /><s:hidden value="%{#parameters.fName}" id="fName" name="fName"></s:hidden></td>
				<td width="25%" align="center">Last Name :</td>
				<td width="25%" align="center"><s:property value="%{#parameters.lName}"/>
				<s:hidden value="%{#parameters.lName}" id="lName" name="lName"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Date of Birth :</td>
				<td width="25%" align="center"><s:property value="%{#parameters.dob}"/>
				<s:hidden value="%{plrDetailBean.dob}" id="dob" name="dob"></s:hidden></td>
				<td width="25%" align="center">Age Verified :</td>
				<td width="25%" align="center"><s:if test="%{#parameters.ageVerifed=='Y'}">
					<label>Yes</label>
					</s:if>
					<s:elseif test="%{#parameters.ageVerifed=='N'}">
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{#parameters.ageVerifed}" id="ageVerifed" name="ageVerifed"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Email :</td>
				<td width="25%" align="center"><s:property value="%{#parameters.emailId}"/>
					<s:hidden value="%{plrDetailBean.emailId}" id="emailId" name="emailId"></s:hidden></td>
				<td width="25%" align="center">Email Verified :</td>
				<td width="25%" align="center"><s:if test='%{#parameters.emailVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{#parameters.emailVerified=="N"}'>
					<label>No</label>
					</s:elseif>
					<s:hidden value="%{#parameters.emailVerified}" id="emailVerified" name="emailVerified"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Gender :</td>
				<td width="25%" align="center"><s:if test='%{#parameters.gender=="M"}'>
					<label>Male</label>
				</s:if>
				<s:elseif test='%{#parameters.gender=="F"}'>
					<label>Female</label>
				</s:elseif>
				<s:hidden value="%{#parameters.gender}" id="gender1" name="gender1"></s:hidden></td>
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Address Line </td>
				<td width="25%" align="center"><s:property value="%{#parameters.add1}"/>
				<s:hidden value="%{#parameters.add1}" id="add1" name="add1"></s:hidden></td>
				<td width="25%" align="center">Address Verified :</td>
				<td width="25%" align="center"><s:if test='%{#parameters.addressVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{#parameters.addressVerified=="N"}'>
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{#parameters.addressVerified}" id="addressVerified" name="addressVerified"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Phone No :</td>
				<td width="25%" align="center"><s:property value="%{#parameters.mobileNo}"/>
				<s:hidden value="%{plrDetailBean.mobileNo}" id="mobileNo" name="mobileNo"></s:hidden></td>
				<td width="25%" align="center">Phone Verified :</td>
				<td width="25%" align="center"><s:if test='%{#parameters.phoneVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{#parameters.phoneVerified=="N"}'>
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{#parameters.phoneVerified}" id="phoneVerified" name="phoneVerified"></s:hidden></td>
				
				</tr>
				<tr class="clearFRM"></tr>
				<!--<tr>
				<td width="25%" align="center">Pin Number Verified :</td>
				<td width="25%" align="center"><s:if test='%{plrDetailBean.taxationIdVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.taxationIdVerified=="N"}'>
					<label>No</label>
					</s:elseif>
					<s:hidden value="%{plrDetailBean.taxationIdVerified}" id="taxationIdVerified" name="taxationIdVerified"></s:hidden></td>
				<td width="25%" align="center"></td>
				<td width="25%" align="center"></td>
				</tr>
				--></table>
			
			<s:hidden value="%{plrDetailBean.playerId}" name="playerId1" id="playerId1"></s:hidden>
			<div class="box_footer" align="right">
				<ss:button name="eDit" value="Edit" cssClass="button" ajaxAction="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerPersonalDetailsEdit.action"  target="plrPersonalInfo" ajaxParam="gender1,emailVerified,phoneVerified,addressVerified,add1,fName,lName,emailId,ageVerifed,dob,mobileNo,title,playerId1"></ss:button>
				</div>
</div>	
			
			
</div>
  </body>
</html>
