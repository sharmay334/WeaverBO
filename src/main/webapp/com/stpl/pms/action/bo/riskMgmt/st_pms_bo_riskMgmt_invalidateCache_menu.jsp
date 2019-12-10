<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Invalidate Cache</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="Duplication Weightage">

</head>
<body>
	<s:form theme="myTheme" action="st_pms_bo_riskMgmt_invalidateCache"
		namespace="/com/stpl/pms/action/bo/riskMgmt">
		<div class="clear2"></div>
		<h2>Invalidate Cache</h2>
		<!--form section first start-->
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Required Information</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Table Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<ss:select id="tableName" name="tableName" cssClass="select1"
								list="%{cachedTable}" headerKey="-1"
								headerValue="-- Please Select --" theme="myTheme"></ss:select>
						</div>
					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
				<s:submit theme="simple" value="Invalidate"></s:submit>
			</div>
		</div>
	</s:form>

	<div class="clear2"></div>
	<div class="FormSection">
		<div class="innerBox" style="margin: 29px auto 0;">
			<table width="830" cellspacing="0" cellpadding="4" border="1"
				align="center" class="payTransaction" id="activeMisReport">
				<thead>
					<tr>
						<th width="15%" valign="middle" align="left" class="name">
							Table Name</th>
						<th width="15%" valign="middle" align="left" class="status">
							Hit Count</th>
						<th width="15%" valign="middle" align="left" class="status">
							Miss Count</th>
						<th width="15%" valign="middle" align="left" class="status">
							Put Count</th>	
						<th width="15%" valign="middle" align="left" class="status">
							Element Count In Memory</th>
						<th width="15%" valign="middle" align="left" class="status">
							Element Count On Disk</th>
						<th width="15%" valign="middle" align="left" class="name">
							Size In Memory</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{hitStatus}" status="index">
						<tr>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][0]}" /></td>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][1]}" /></td>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][2]}" /></td>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][3]}" /></td>		
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][4]}" /></td>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][5]}" /></td>
							<td id="misName"><s:property
									value="%{hitStatus[#index.index][6]}" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	<br/> <br/>
</body>
</html>