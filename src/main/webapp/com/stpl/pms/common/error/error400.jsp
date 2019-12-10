<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
String path = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>www.khelplayrummy.com</title>
	<style>
		body{
			background:#000;
		}
		
		#mainbody{
			margin:0 auto;
			border:solid red 0px;
			width:1000px;
			height:auto;
		}
		.down{
			font:"Arial Black", Gadget, sans-serif;
			font-size:60px;
			color:#FFF;
			margin:130px auto 50px auto;
			width:1000px;
			text-align:center;
		}
		.down1{
			font:"Arial Black", Gadget, sans-serif;
			font-size:25px;
			color:#FFF;
			margin:30px auto 0 auto;
			width:1000px;
			text-align:center;
		}
	</style>
</head>

<body>
<div id="mainbody">
 <div class="down">Bad Request</div>

  <div class="down1"> <a href="/<%=path %>/com/stpl/pms/action/bo/lm/bo_home_page.action?serviceName=MGMT">Home</a>
  </div>
</div>
</body>
</html>
