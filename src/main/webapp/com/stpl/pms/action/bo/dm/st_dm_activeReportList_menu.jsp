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
		<title>Active Reports List</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function(){
				var domainId=$("#domainId").val();
				if(domainId!="" &&domainId!=-1){
					_ajaxCallDiv('st_dm_activeReportsList.action?domainId='+domainId,'','frmBox');
				}
			});
			$(document).on("click", "#submit", function(){
				var str = "{";
				$('#activeMisReport tr').each(function() {
				    $(this).find('td').each(function() {
				    	if($(this).attr('id')=='misName') {
				    		str += '"' + $(this).text().trim();
					    } else {
					    	str += '":"' +$(this).children('select').val().trim()+ '",';
					    }
					});
				});
			 str =str.substring(0, str.length - 1) + "}";
			 $('#newActiveReportList').val(str);
			});
		</script>
	</head>
	<body>
		<s:form id="activeReportsave"
			action="st_dm_activeReportList_save.action" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div id="container">
				<h2>
					Active Reports List
				</h2>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Active Reports List
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
									<s:hidden id="domainId" name="domainId" value="%{domainId}"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<ss:select name="domainId" headerKey="-1" applyscript="true"
										headerValue="-- Please Select --" cssClass="select1"
										ajaxAction="st_dm_activeReportsList.action" target="frmBox"
										id="domainId" list="%{domainMap}" listKey="%{key}"
										listValue="%{value}" theme="myTheme" />
								</s:else>
							</div>
						</div>
					</div>
				</div>
				<div id="frmBox"></div>
			</div>
		</s:form>
	</body>
</html>
