<%@page import="com.stpl.pms.utility.Utility"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
session.setAttribute("localeValue", request.getParameter("request_locale"));
System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::"+session.getAttribute("localeValue"));
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><%=Utility.getClientName()%> Login</title>
<link href="<%=path%>/css/boLoginnew.css" rel="stylesheet" type="text/css" />
<link
	href="<%=path%>/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css" />
<%-- <script src="https://www.google.com/recaptcha/api.js" /> --%>	
<script
	src="<%=path%>/js/bootstrap.min.js"></script>
<link rel="shortcut icon"
	href="<%=path%>/images/client-specific/<%=Utility.getClientName()%>/favicon.ico"
	type="image/x-icon" />
<script type="text/javascript" src="<%=path%>/js/boLogin.js"></script>
<script type="text/javascript" src="<%=path%>/js/MD5.js"></script>
<script>
function isFilled() {
	var usererr = document.getElementById("usrerr").value;
	var passerr = document.getElementById("passerr").value;
	
	var isInValid = false;
	if (document.getElementById('userName').value == "") {
		isInValid = true;
		document.getElementById("userNameError").innerHTML = "<span>"+usererr+"</span>";
	} else {
		document.getElementById("userNameError").innerHTML = "";
	}

	if (document.getElementById('password').value == "") {
		document.getElementById("passwordError").innerHTML = "<span>"+passerr+"</span>";
		isInValid = true;
	} else {
		document.getElementById("passwordError").innerHTML = "";
	}
	if (isInValid) {
		return false;
	}
	document.getElementById('password').value=MD5(MD5(document.getElementById('password').value)+document.getElementsByName('loginToken')[0].value);
	return true;
}
</script>
</head>
<body onload="initialFocus()" >
<input type="hidden" id="usrerr" value='<s:text name="global.login.usernameerr"/>'/>
<input type="hidden" id="passerr" value='<s:text name="global.login.passerr"/>'/>
	<div id="loginBoxmain" class="container-fluid"
		style="margin: 15px -15px;">
		<br/>
		<br/>
		<div id="OuterLoginBox"
			style="text-align: center; margin-bottom: 15px;">
			<img
				src="<%=request.getContextPath()%>/images/client-specific/<%=Utility.getClientName()%>/logo_login.png"
				alt="logo" />
		</div>
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card">
					<header class="card-header text-center" style="background-color: #e0e0e0; border: 1px solid #BBBBBB; border-bottom: none;"><s:text name="global.login.header" /></header>
					<article class="card-body" style="border: 1px solid #BBBBBB;"> <s:form
						onsubmit="return isFilled()" name="login" action="bo_lm_login"
						method="post" namespace="/com/stpl/pms/action/bo/lm">
						<div class="errorMsg" style="font-size:12px; line-height:16px; color:#ff0000;">
							<div><s:property value="errorMsg" /></div>
							<div id="passwordError"></div>
							<div id="userNameError" class="fieldError"
									style="font-size: 12px; color: #FF0000;">									
								</div>
						</div>
						<div class="form-row" style="">
							<div class="col form-group">
								<s:token name="loginToken" id="loginToken" theme="simple"></s:token>
								
								<label><s:text name="global.login.username" /> </label> <input type="text"
									name="newLoginBean.userName" id="userName" class="form-control"
									placeholder="" />
							</div>
							<!-- form-group end.// -->
							<div class="col form-group">								
								<label><s:text name="global.login.password" /></label> <input type="password"
									name="newLoginBean.password" id="password" class="form-control"
									placeholder=" " />
							</div>
							<!-- form-group end.// -->
						</div>
						<!-- <div class="form-row" style="">
							<div class="col form-group">
								<div class="g-recaptcha" id="recapcha"
									data-sitekey="6LdPdG8UAAAAAAdzHwoRaaiGM5Zk6KwIT6fAwUec"></div>
							</div>
						</div> -->
						<!-- form-group end.// -->
						<div class="form-group">
							<input type="submit" class="btn btn-primary btn-block"
								value='<s:text name="global.login.submit" />' />
		
						</div>
						<!-- form-group// -->						
					
					</s:form> <!-- form-row end.// --> 
			
					<%-- <div class="text-left">
									<s:text name="global.login.languagelabel" />:
									 &nbsp;&nbsp;&nbsp;&nbsp;
									<a href="/WeaverBO/com/stpl/pms/action/bo/lm/locale.action?request_locale=en">English</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="/WeaverBO/com/stpl/pms/action/bo/lm/locale.action?request_locale=vi">Vietnamese</a>
								</div> --%>
					<div class="text-right">
						<a href="<%=path%>/backoffice/login/ForgotPassword"><s:text name="global.login.forgotpassword" />?</a>
					</div>
					</article>
					
					<!-- card-body end .// -->					
					<footer class="card-footer text-center" style="background-color: #e0e0e0; border: 1px solid #BBBBBB; border-top: none;">
						<small class="text-muted"><s:text name="global.login.copyright" /></small>
					</footer>	


				</div>


			</div>
		</div>
	</div>


</body>
</html>