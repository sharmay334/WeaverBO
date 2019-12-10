<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Deposit Response</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/old/address.css">
	<SCRIPT type="text/javascript">
			$(document).ready(function() {
				var parentWin = window.opener;
				if(parentWin!=null){
					var depositDiv = parentWin.document.getElementById("cashierWindow");
					depositDiv.innerHTML = $('#cashierResponse').html();
					parentWin.focus();
					window.close();
				}
			});
		</SCRIPT>
	</head>

	<body>
	<div id="cashierResponse">
				<div id="YelloBoxResponse">
					<div id="Responsebox">
						<div class="YeloStrip">
							<p>
								Unauthorize Page.
							</p>
						</div>
					</div>
				</div>
		</div>
	</body>
</html>
