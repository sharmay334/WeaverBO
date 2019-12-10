<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>
			Domain Check List
		</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
       <SCRIPT type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/dm/js/dm.js"></SCRIPT>
		<script>
			$(document).ready(function(){
				var domainId = $("#domainId").val();
				if(domainId!=-1 && domainId!=""){
					_ajaxCallDiv('st_dm_domainCheckList.action?domainId='+domainId,'','frmBox');
				}
			})
		</script>
	  
	</head>

	<body>
		<div id="container">
			<h2>
				Domain Check List
			</h2>
			<div class="FormSection">
			<div class="greyStrip">
			<h4>
			  Domain Check List
			  </h4>
			</div>
				<div class="innerBox">
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
								<ss:select name="domainId" headerKey="-1" applyscript="true"
									headerValue="-- Please Select --" cssClass="select1"
									ajaxAction="st_dm_domainCheckList.action" target="frmBox" 
									id="domainId" list="%{domainMap}" listKey="%{key}"
									listValue="%{value}"  theme="myTheme" value="%{bydefaultSelectedDomain}"/>
							</s:else>
						</div>
					</div>

				</div>
			</div>
			<div id="frmBox"></div>


		</div>
	</body>
</html>
