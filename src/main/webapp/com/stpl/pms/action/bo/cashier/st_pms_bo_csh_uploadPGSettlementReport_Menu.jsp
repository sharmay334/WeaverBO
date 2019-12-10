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

		<title>Upload Payment Gateway Settlement</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%-- <script type="text/javascript">
			$(function() {
			$("#providerName").find('option[value=PAYTM]').remove();
				$("#providerName").change(function(){
					$('#pgSettlementReport').val('');
				});
			});
		</script> --%>
		
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Upload Payment Provider's Settlement Data
				</h4>
			</div>

			<s:form id="uploadData"
				action="st_pms_bo_csh_uploadPGSettlementReport_Save" theme="simple" enctype="multipart/form-data" method="post">
				<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Provider Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="%{paymentProviderMap}" name="providerName" id="providerName" listKey="%{value}" listValue="%{value}"
								headerKey="-1" headerValue="--Please Select--" ></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Upload File
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:file name="pgSettlementReport" id="pgSettlementReport" applyscript="true" accept=".xls,.xlsx" theme="myTheme"></s:file>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit theme="simple" id="submitBtn" value="Upload File"></s:submit>
				</div>
			</s:form>
		</div>
	</body>
</html>
