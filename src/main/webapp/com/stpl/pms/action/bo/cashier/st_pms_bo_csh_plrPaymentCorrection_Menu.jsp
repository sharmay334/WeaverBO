<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Payment Correction</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>

	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Player Payment Correction
				</h4>
			</div>
			 <s:form id="payCorrectionSearchFrm" action="st_pms_bo_csh_payCorrec_plr_search"
				target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<s:if test="%{domainId>1}">
									<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1" name="domainId"
										list="%{domainMap}"
										id="domainId" headerKey="0"
										headerValue="--All Domain--" listKey="%{key}"
										listValue="%{value}"  value="%{bydefaultSelectedDomain}"></s:select>
								</s:else>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								User Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="userName" name="userName"  theme="myTheme" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								First Name
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="firstName"  name="firstName" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Last Name
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="lastName"  name="lastName" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				

				</div>
				<div class="box_footer" align="right">
					<s:submit name="Search" value="Search" cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
