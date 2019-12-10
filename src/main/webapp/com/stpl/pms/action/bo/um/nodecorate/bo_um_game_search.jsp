<%-- 
<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Game XML Validation</title>
		<link type="text/css"
			href="<%=request.getContextPath()%>/com/skilrock/itg/img/validation.css"
			media="all" rel="stylesheet" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/com/skilrock/itg/common/js/validate.js"></script>
	</head> --%>
	
	
	
	
	
	
	
	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tech Support</title>
</head>
<body>

<div class="clear2"></div>
<h2>
Search Player</h2>
	
	<body>
		<div id="wrap_body">

			<s:form action="gameSearch.action"
				onsubmit="return checkGameNum()" theme="simple">
				<div class="logo" style="float: left">
					<img
						src=""
						width="212" height="54" />
				</div>
				<div class="login_panel">
					Welcome :
					<span class="uname"><s:property
							value="#session.USER_INFO.userName" />
					</span> |
					<a
						href="">Home</a>|
					<a
						href="">Logout</a>
				</div>
				<hr style="clear: both; color: #CCCCCC; height: 1px; width: 100%" />


				<div align="right">
					<a
						href=""
							border="0" width="157" height="36" />
					</a>
					<a
						href=""
							border="0" width="157" height="36" />
					</a>
				</div>
				<h3>
					Search Existing Tickets
				</h3>
				<div id="divMainCont">
				<div style="width:100%; height:6px;"></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" style="">
						<tr style="margin-top: 10px">
							<td width="200" align="right">
								Game Number :
							</td>
							<td align="left">
								<input type="text" name="gameNumber" id="gameNo" />
							</td>
							<td>
								<div id="gameNoDiv"></div>
							</td>
						</tr>
						<tr>
							<td align="right" class="normalText">
								Game Name :
							</td>
							<td align="left">
								<input type="text" name="gameName" />
							</td>
						</tr>
						<tr>
							<td align="right">
								&nbsp;
							</td>
							<td align="left">
								<table>
									<s:submit cssClass="button" align="left" value="Submit"></s:submit>
								</table>
							</td>
						</tr>
					</table>

				</div>

			</s:form>
		</div>
	</body>
</html>