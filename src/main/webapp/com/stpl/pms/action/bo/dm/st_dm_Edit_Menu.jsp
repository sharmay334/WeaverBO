<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
<title>Edit Domain Registration</title>
<!--<script type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js">-->

<!--</script>-->

<script type="text/javascript">
	$(document).ready(function(){
		var domainId=$("#domainId").val();
		if(domainId!="" &&domainId!=-1){
			_ajaxCallDiv('bo_dm_boDomainEdit_Fetch.action?domainId='+domainId,'','result');
		}
	});
</script>

</head>
<body>
<div id="mainDiv">
	<s:form id="RegistrationDomain" action="bo_dm_boDomainEdit_Save" theme="simple" enctype="multipart/form-data">
	<s:token name="strutsToken" id="strutsToken" />
		<div class="clear2"></div>
		<h2> Domain Edit </h2>
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Required Information </h4>
			</div>
		
			<div class="innerBox" >
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId" name="domainBean.domainId" ></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select name="domainBean.domainId" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								ajaxAction="bo_dm_boDomainEdit_Fetch.action" target="result" 
								id="domainId" list="%{domainMap}" listKey="%{key}"
								listValue="%{value}" value="%{bydefaultSelectedDomain}" theme="myTheme" />
							</s:else>
					</div>
				</div>
			</div>
		</div>
		<div id="result"> </div>
	</s:form>
</div>
</body>
</html>