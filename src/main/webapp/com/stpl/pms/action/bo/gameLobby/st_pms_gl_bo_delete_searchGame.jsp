<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Search User</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="clear2"></div>
	<h2>Delete Existing Games</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Required Information</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/gl/st_delete_game.action"
			id="searchGameFrm" theme="simple" target="searchDiv">

			<div class="FormMainBox">
				<div class="labelDiv">
					<label>User Name </label><em class="Req">*</em>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="userName" name="userName" theme="myTheme"
						applyscript="true" maxlength="25" pattern="^[a-zA-Z]*$"
						errorMassage="Numeric and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>

			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Game Name</label><em class="Req">*</em>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="gameName" name="gameName" theme="myTheme"
						applyscript="true" maxlength="25" pattern="^[a-zA-Z0-9 ]*$"
						errorMassage="Numeric and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>




			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Game No</label><em class="Req">*</em>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="gameNO" applyscript="true" name="gameNO" value=""
						theme="myTheme" value="" maxlength="3" pattern="^[0-9]*$"
						errorMassage="Alphabet and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Ticket Prize </label>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="ticketPrize" name="ticketPrize" theme="myTheme"
						theme="myTheme" maxlength="10" pattern="^[0-9.]*$"
						errorMassage="Alphabet and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="box_footer" align="right">
				<s:submit value="Delete" align="left" cssStyle="margin-left:0px"
					cssClass="button" theme="simple"></s:submit>
			</div>
		</s:form>
		
		<div id="searchDiv"></div>
	</div>
	
	
</body>
</html>