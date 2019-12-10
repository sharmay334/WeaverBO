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
		<title>Referral Management</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/dm/js/dm.js"></SCRIPT>
		<script>
		$(document).ready(function(){
			var domainId = <%=request.getAttribute("bydefaultSelectedDomain") %>;
			if(domainId != 0 && domainId != "-1"){
				$("#domainId").val(domainId);
				_ajaxCallDiv('com/stpl/pms/action/bo/dm/st_pms_dm_bo_loadRefferalList.action?domainId='+domainId,'','formDiv');
			}
		});
		
		</script>

	</head>

	<body>
		<div id="container">
			<h2>
				Referral Management
			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Referral Form
					</h4>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							<s:label value="Domain Name:" />
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1}">
							<s:hidden value="%{domainId}" id="domainId"
								name="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select list="%{domainMap}" name="domainId" id="domainId"
								cssClass="select1" theme="myTheme" headerKey="-1"
								headerValue="Please Select"
								ajaxAction="com/stpl/pms/action/bo/dm/st_pms_dm_bo_loadRefferalList.action"
								ajaxParam="domainId" target="formDiv"></ss:select>
						</s:else>
					</div>
				</div>
			</div>
			<div id="formDiv"></div>
		</div>
	</body>
</html>
