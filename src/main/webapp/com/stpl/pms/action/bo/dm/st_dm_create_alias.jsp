<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
<title>Create Alias</title>
<!--<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/dm/js/dm.js">-->

<!--</script>-->

</head>
<body>
	<div id="mainDiv">
		<s:form id="RegistrationDomain" action="bo_dm_boAliasSave"
			theme="simple" enctype="multipart/form-data">
			<s:token name="strutsToken" id="strutsToken" />
			<div class="clear2"></div>
			<h2>Create Alias</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Required Information</h4>
				</div>

				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Domain Name </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId"
									name="aliasBean.domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select name="aliasBean.domainId" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									id="domainId" list="%{domainMap}" listKey="%{key}"
									listValue="%{value}" value="%{bydefaultSelectedDomain}"
									theme="myTheme" applyscript="true" />
							</s:else>
						</div>
					</div>
				</div><div class="clearFRM"></div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Alias Name </label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield pattern="^[a-zA-Z0-9.]*$"  name="aliasName" 
								id="aliasName"  title="ex. www.abc.com, mobile.abc.com" errorMassage="Special character is not allowed" 
								theme="myTheme" action="bo_dm_validateAlias.action" maxlength="100" applyscript="true" ></ss:textfield>
							<div id="aliasName_error" class="fieldError" >
								<s:fielderror><s:param>domainName </s:param></s:fielderror>
							</div>
						</div>
					</div>
				</div>					

				<div class="clearFRM"></div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> PC-Domain Alias </label> <em class="Req">*</em>
						</div>


						<div class="InputDiv">
							<ss:textfield name="aliasBean.pcAlias" id="pcDomainAlias"
								theme="myTheme" pattern="^[a-zA-Z.0-9]*$"
								errorMassage=" Special character not allowed"
								applyscript="true"></ss:textfield>
							<div id="pcDomainAlias_error" class="fieldError">
								<s:fielderror>
									<s:param>pcDomainAlias</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
				</div>
				

				<div class="clearFRM"></div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Mobile-Domain Alias </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="aliasBean.mobileAlias"
								id="mobileDomainAlias"							
								theme="myTheme" pattern="^[a-zA-Z.0-9]*$"
								errorMassage=" Special character not allowed" applyscript="true"></ss:textfield>
							<div id="mobileDomainAlias_error" class="fieldError">
								<s:fielderror>
									<s:param>mobileDomainAlias</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
				</div>

				
				<div class="clearFRM"></div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Tab-Domain Alias </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="aliasBean.tabAlias"
								id="tabDomainAlias"
								pattern="^[a-zA-Z.0-9]*$"
								errorMassage=" Special character not allowed" theme="myTheme"
								applyscript="true"></ss:textfield>
							<div id="tabDomainAlias_error" class="fieldError">
								<s:fielderror>
									<s:param>tabDomainAlias</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit name="createDomain" value="Create Alias"
						cssClass="button" id="submit" theme="simple"></s:submit>					
				</div>
			</div>
		</s:form>
	</div>
</body>
</html>