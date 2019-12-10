<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Upload payment type content</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript">
			$(document).ready(function() {
				$('.InputDiv > select').change(function() {
					$('#searchResult').html('');
				});
			});
		</SCRIPT>
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Upload Payment Type Content</h4>
			</div>
			
			<s:form id="fetchContentFrm" action="st_pms_bo_csh_fetchPayTypeContent"
				target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name : 
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId"
									name="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select theme="simple" cssClass="select1"
								list="%{domainMap}"
								name="domainId" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" applyscript="true"></ss:select>
							</s:else>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Transaction Type : 
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="simple" cssClass="select1" id="txnType" name="txnType"
									list="{'DEPOSIT','WITHDRAWAL'}" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Device:
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select
								list="#{'-1':'----- Please Select ------','MOBILE':'Mobile','PC':'PC'}"
								applyscript="true" cssClass="select1" name="device" id="device"
								theme="myTheme"></ss:select>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit theme="simple" id="submitBtn" value="Search"></s:submit>
				</div>
			</s:form>
		</div>
		<div class="clear2"></div>
		<div id="searchResult">

		</div>
	</body>
</html>
