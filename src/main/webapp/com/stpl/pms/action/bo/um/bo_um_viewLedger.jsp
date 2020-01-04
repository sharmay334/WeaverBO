<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		
		<title>View Group</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<div class="clear2"></div>
		<h2>
			View Ledger
			<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
		</h2>

		<!--form section first start-->
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					View Ledger
				</h4>
			</div>
			<s:form action="/com/stpl/pms/action/bo/um/bo_um_BoLedger_Search.action" id="searchUserFrm"
				theme="simple" target="searchDiv">
				<div class="innerBox">
					
					<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">


						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									Select Ledger
								</label>
							</div>
							<div class="InputDiv">
								<s:select name="ledgerName" headerKey="-1"
									headerValue="Select Ledger Name" list="ledgerNamesList"
									cssClass="select1" theme="myTheme"></s:select>
							</div>
						</div>
					</s:if>
					
				</div>
				<div class="box_footer" align="right">
					<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>	
						<input type="submit" value='View' align="left" style="margin-left:0px"
						class="button"/>
				</div>
			</s:form>
		</div>
		<div id="searchDiv"></div>
		<br />
		<br />
	</body>
</html>
