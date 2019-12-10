<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Responsible Gaming</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="com/stpl/pms/action/bo/rg/js/rg.js" type="text/javascript"></script>
</head>
	
<body>
	<div id="container">
		<h2>RG Management</h2>
		<s:form id="operatorLimitSubmit" theme="simple"
			action="st_pms_rg_bo_SetLimit">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Domain Information</h4>
				</div>
				<div class="innerbox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:label value="Domain Name:" theme="simple" /> </label><em
								class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden id="domainId" value="%{domainId}" name="domainId"></s:hidden>
								<s:property value="%{domainName}"/>
							</s:if>
							<s:else> 
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="%{domainMap}"
								name="domainId" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" onchange="getVipLevel()"/>  
							</s:else>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:label value="VIP Level:"
									cssStyle="margin-left: 30px" theme="simple" /> </label><em class="Req">*</em>
						</div>
							<div class="InputDiv">
								<ss:select name="vipLevel" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									id="vipLevel" list="%{vipLevelBeanList}" listKey="vipLevel"
									listValue="vipCode" theme="myTheme" applyscript="true" />
							</div>
						</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:label value="Criteria Type:"
									cssStyle="margin-left: 30px" theme="simple" /> </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select name="criteriaType" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								id="criteriaType" list="{'DAILY','WEEKLY'}" theme="myTheme"
								applyscript="true" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:label value="Group:"
									cssStyle="margin-left: 30px" theme="simple" /> </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select name="group" headerKey="-1"
								ajaxAction="com/stpl/pms/action/bo/rg/st_pms_rg_fetchOperatorLimit.action"
								ajaxParam="domainId,vipLevel,criteriaType,group"
								target="opLimit" headerValue="-- Please Select --"
								cssClass="select1" id="group"
								list="{'ALL','CASINO','RUMMY','GAMES','BINGO','LIVE_CASINO','SPORTS','POKER'}"
								theme="myTheme" applyscript="true" />
						</div>
					</div>
				</div>
			</div>
			<div id="opLimit"></div>
		</s:form>
	</div>
</body>
</html>
