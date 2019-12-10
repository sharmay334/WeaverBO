<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>PlaceHolder-Content Mapping</title>
<base href="<%=basePath%>">

<title></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	$("document").ready(function() {
		$("#menuTitle").val($("#menuId option:selected").text());
		createBubble();
	});
</script>
</head>
<body>
	<div class="FormSection">
		<s:if test="%{plrCritData!=null && plrCritData.size()>0}">
			<div class="greyStrip">
				<h4>PlaceHolder-Content Mapping</h4>
			</div>
			<s:hidden name="menuTitle" id="menuTitle" />
			<s:set name="count" value="0" />
			<s:iterator value="plrCritData" status="plrCritList">
				<div class="FormSection" style="width: 95%; margin-left: 15px;">
					<div class="greyStrip">
						<h4>
							<s:property value="%{key}" />
						</h4>
					</div>
					<div class="innerBox">
						<table class="payTransaction">
							<tr>
								<th>Content-Name</th>
								<th>Specific-Criteria</th>
								<th>Mapping Status</th>
								<!-- <th>Add More</th> -->
							</tr>
							<s:iterator value="%{value}" var="data">
								<tr>
									<s:hidden name="critBean[%{#count}].position"
										value="%{#data.position}" cssClass="position" />
									<s:hidden name="critBean[%{#count}].id" value="%{#data.id}"
										cssClass="critId" />
									<s:hidden id="moduleTitle_%{#count}"
										name="critBean[%{#count}].moduleTitle" cssClass="moduleTitle" />
									<td width="27%"><s:select id="moduleId_%{#count}"
											headerKey="-1" headerValue="--Please Select Content--"
											list="%{modulePosMap.get(#data.position)}" listKey="%{key}"
											listValue="%{value}" value="%{#data.moduleId}"
											cssClass="select1 moduleId" theme="simple"
											name="critBean[%{#count}].moduleId" cssStyle="width:85%;"
											applyscript="true"></s:select>
									</td>
									<td width="27%"><s:select id="phCritSelect_%{#count}"
											headerKey="-1" headerValue="--Please Select Content--"
											list="%{phCritMap}" listKey="%{key}" listValue="%{value}"
											value="%{#data.phCritId}" cssClass="select1 phCritSelect"
											theme="simple" name="critBean[%{#count}].phCritId"
											cssStyle="width:85%;" applyscript="true"></s:select>
									</td>
									<td width="27%"><s:select headerKey="-1"
											id="mappStatus_%{#count}" headerValue="--Please Select--"
											list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
											value="%{status}" cssClass="select1 mappStatus"
											theme="simple" name="critBean[%{#count}].status"
											cssStyle="width:85%;" applyscript="true"></s:select></td>
									<%-- <td width="19%"><input type="button"
									id='spCrit_<s:property value="%{#count}" />'
									value="Add Criteria"
									style="float: left;margin-top: 7px !important;width: 85%;" />
								</td> --%>
								</tr>
								<s:set name="count" value="%{#count+1}"></s:set>
							</s:iterator>
						</table>
					</div>
					<div class="box_footer" align="right">
						<input type="button" id='spCrit_<s:property value="%{#count}" />'
							value="Add More" />
					</div>
				</div>
			</s:iterator>
			<div class="box_footer" align="right">
				<s:submit value="Submit" id="formSubmit"></s:submit>
			</div>
			<s:hidden id="count" value="%{#count}" />
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</s:else>
	</div>
	<br />
</body>
</html>