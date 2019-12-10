<%@page import="com.stpl.pms.utility.Utility"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Weaver:: Logout</title>
		<link href="<%=path%>/css/boLogin.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript" src="<%=path%>/js/boLogin.js"></script>
	</head>

	<body>
		<div id="OuterLoginBox" style="text-align: center;">
			<img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo_login.png"
				alt="logo" />
			<div id="loginBoxmain" style="height: 200px;text-align: left;">
				<div class="greyStrip">
					<p>
						Logout
					</p>
				</div>

				<div class="userbox-login">
					<b style="font-size: 16px"> You have successfully logged out. </b>
					<a
						href="<%=path%>/com/stpl/pms/action/bo/lm/bo_lm_newLogin.action"
						style="text-decoration: underline"><b>Back to Login</b>
					</a>
				</div>
			</div>
			<div id="copyRight">
				<h6>
					<jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/>
				</h6>
			</div>
		</div>
	</body>
</html>







