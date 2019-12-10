<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Duplication</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="Duplication Weightage">

		<script type="text/javascript">
	$(document).ready(function() {
		var domainId = $("#domainId").val();
		if(domainId!="" && domainId!=-1) {
			$('#sectionName').prop('disabled', false);
		}
		$('#domainId').change(function() {
			if ($(this).val() == -1)
				$('#sectionName').prop('disabled', true);
			else
				$('#sectionName').prop('disabled', false);
			$('#sectionName').val('-1');
			$('#result').html("");
		});
	});
</script>
		<SCRIPT type="text/javascript"
			src="com/stpl/pms/action/bo/riskMgmt/js/duplication.js"></SCRIPT>
	</head>

	<body>

		<div class="clear2"></div>
		<h2>
			Duplication Weightage
		</h2>
		<!--form section first start-->
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Required Information
				</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Domain Name
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>

							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId"
									name="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select id="domainId" name="domainId" cssClass="select1"
								list="domainPropertyBeanList" listValue="%{domainName}"
								listKey="%{domainId}" headerKey="-1"
								headerValue="-- Please Select --" theme="myTheme"></ss:select>
							</s:else>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Section Name
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<ss:select id="sectionName" name="sectionName" cssClass="select1"
								list="{'REGISTRATION','DEPOSIT','WITHDRAWAL'}"
								ajaxAction="com/stpl/pms/action/bo/riskMgmt/st_pms_bo_riskMgmt_showDLFieldWeightage.action"
								ajaxParam="domainId,sectionName" headerKey="-1" target="result"
								headerValue="-- Please Select --" disabled="true"
								callback="duplicationReady()" theme="simple"></ss:select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="result"></div>
	</body>
</html>