<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'setRGOperatorLimit.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>RG Operator Limit</h4>
		</div>
		<s:if test="operatorLimitList.size >0 ">
			<div class="innerBox">
				<div id="errorDiv" class="fieldError"></div>
				<table id="opCriteria" class="payTransaction" align="center"
					cellspacing="0" cellpadding="4" border="0">
					<thead>
						<tr>
							<th>Criteria Description</th>
							<th>Limit</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="operatorLimitList" status="operatorLimitList">
							<tr>
								<td><s:hidden id="criteriaId_%{#operatorLimitList.index+1}"
										value="%{criteriaId}"></s:hidden> <s:property value="criteria" />
								</td>
								<td><s:textfield id="limit_%{#operatorLimitList.index+1}"
										value="%{limit}"></s:textfield></td>
								<td><s:select
										list="#{'ACTIVE':'Active','INACTIVE':'Inactive'}"
										id="status_%{#operatorLimitList.index+1}" headerKey="-1"
										headerValue="--Please Select--" value="%{status}"></s:select>
								</td>

							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>

			<div class="box_footer" align="right">
				<s:hidden name="criteriaJson" id="criteriaJson"></s:hidden>
				<s:submit cssClass="button" align="right" theme="simple"
					value="Set Limit"></s:submit>
			</div>

		</s:if>
		<s:else>
			<div class="innerBox">
				<h3>No operator Limit available for given criteria</h3>
			</div>
		</s:else>
	</div>

</body>
</html>
