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
<title>Invalidate Cache</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="Duplication Weightage">

</head>
<body>
	<s:form theme="myTheme" action="st_pms_bo_riskMgmt_dbConfing"
		namespace="/com/stpl/pms/action/bo/riskMgmt">
		<div class="clear2"></div>
		<h2>Database Configuration</h2>
		<!--form section first start-->
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
						<div>
							<s:textfield id="domainName" name="configBean.domainName"
								cssClass="select1" theme="myTheme" value="%{configBean.domainName}"></s:textfield>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.aliasName"
								cssClass="select1" theme="myTheme" value="%{configBean.aliasName}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Portal Content Domain name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.portalContDmName"
								cssClass="select1" theme="myTheme" value="%{configBean.portalContDmName}"></s:textfield>
						</div>
					</div>
				</div>


				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Desktop Site URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.pcSiteName"
								cssClass="select1" theme="myTheme" value="%{configBean.pcSiteName}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Mobile Site URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.msiteName"
								cssClass="select1" theme="myTheme" value="%{configBean.msiteName}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Content Type </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:select id="aliasName" name="configBean.contentType"
								cssClass="select1" theme="myTheme"
								value="%{configBean.contentType}"
								list="#{'PORTALCONTENT':'PORTALCONTNET','JOOMLA':'JOOMLA'}" />
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Public URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.publicURL"
								cssClass="select1" theme="myTheme" value="%{configBean.publicURL}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Private URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.privateURL"
								cssClass="select1" theme="myTheme" value="%{configBean.privateURL}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Send Mail</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.sendmail"
								cssClass="select1" theme="myTheme" value="%{configBean.sendmail}"></s:textfield>
						</div>
					</div>
				</div>


				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Send SMS </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.sendSms"
								cssClass="select1" theme="myTheme" value="%{configBean.sendSms}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Cashier Domain Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.cshDmName"
								cssClass="select1" theme="myTheme" value="%{configBean.cshDmName}"></s:textfield>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Common Content Domain Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.commonContDmName"
								cssClass="select1" theme="myTheme" value="%{configBean.commonContDmName}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Place Holder Content URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.plrContentURL"
								cssClass="select1" theme="myTheme" value="%{configBean.plrContentURL}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Landing Page URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.landingPageURL"
								cssClass="select1" theme="myTheme" value="%{configBean.landingPageURL}"></s:textfield>
						</div>
					</div>
				</div>


				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Email Tempplate URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.emailTempURL"
								cssClass="select1" theme="myTheme" value="%{configBean.emailTempURL}"></s:textfield>
						</div>
					</div>
				</div>


				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Current Rummy URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.rummyIpCur"
								cssClass="select1" theme="myTheme" value="%{configBean.rummyIpCur}"></s:textfield>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> New Rummy URL </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield id="aliasName" name="configBean.rummyIplive"
								cssClass="select1" theme="myTheme" value="%{configBean.rummyIplive}"></s:textfield>
						</div>
					</div>
				</div>

			</div>


			<div class="box_footer" align="right">
				<s:submit theme="simple" value="Submit"></s:submit>
			</div>
		</div>
	</s:form>
</body>
</html>