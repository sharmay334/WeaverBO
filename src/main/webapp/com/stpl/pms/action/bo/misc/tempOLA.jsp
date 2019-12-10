<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>OLA</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

	</head>

	<body>
		<div id="container">
			<h2>
				OLA Deposit
			</h2>
			<s:form action="saveOLAReq" theme="simple" namespace="/com/stpl/pms/action/bo/misc">
				<div class="FormSection" id="vipCriteriaDiv">
					<div class="greyStrip">
						<h4>
							OLA Deposit
						</h4>
					</div>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									User Name :
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="beanOLA.plrUserName"></s:textfield>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Amount :
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="beanOLA.amount"></s:textfield>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Mobile No:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="beanOLA.mobileNo"></s:textfield>
							</div>
						</div>

					</div>
					<div class="box_footer" align="right">
						<s:submit cssClass="button" id="vipSubmitBtn" value="Submit"></s:submit>
					</div>
				</div>
			</s:form>
		</div>
	</body>
</html>
