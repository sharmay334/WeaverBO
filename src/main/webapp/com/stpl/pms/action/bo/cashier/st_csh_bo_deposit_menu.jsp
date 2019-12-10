<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Update Players Ledger</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(document).ready(function(){
			/* 	if($("#actionMessage").val()=="SUCCESS")
					$("#depositSuccessDiv").show();
				else
					$("#depositSuccessDiv").hide(); */
              
			});
		</script>
	</head>
	<body>
		<div id="container">
			<h2>
				Back Office Deposit Option 

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Deposit in Player Wallet
					</h4>
				</div>
				<s:form theme="simple" id="depositBOform" method="POST"  action="st_pms_bo_csh_deposit_submit" >
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden name="actionMessage" id="actionMessage"></s:hidden>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										name="domainId" id="domainId" headerKey="-1"
										headerValue="--Please Select--"
										listKey="%{key}"
										listValue="%{value}" applyscript="true"  value="%{bydefaultSelectedDomain}"></ss:select>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Mobile No.<em class="Req" style="color:red;">*</em></label>
					</div>
					<div class="InputDiv">
						<s:textfield id="userName" name="userName" pattern="^[0-9]*$" errorMassage="Enter numeric character only" applyscript="true" maxlength="10"/>
					</div>
				</div>
				<div class="clearFRM"></div>
				
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Amount <em class="Req"  style="color:red;">*</em></label>
						</div>
						<div class="InputDiv">
							<s:textfield id="amt" name="amt" maxlength="9" max="100000000" min="500" errormassage="Only Numeric Character allowed" pattern="^[0-9]*$"  patternon="both" applyscript="true" value="" />
						</div>
					</div>
						</div>
						<div class="box_footer" align="right">
						<ss:submit theme="myTheme" id="submitBtn" value="submit" ></ss:submit>
					</div>
				</s:form>
			</div>
<%-- 			<div id="depositSuccessDiv">
		<div class="FormSection">
				<div class="greyStrip"><h4>Success Message</h4></div>
			<div class="innerBox">	
						<div class="alert saved_msg">
							<strong>Success: </strong>Players Ledger has successfully updated.
						</div>
			</div>
		</div>
			</div> --%>
		</div>
	</body>
</html>
