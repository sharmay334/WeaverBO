<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>Create Godown</title>
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
		Create Godown
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Godown</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_goDown.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<ss:textfield maxlength="100" name="godownName" id="godownName"
									theme="myTheme" applyscript="true"></ss:textfield>

								<div id="godownName_error" class="fieldError">
									<s:fielderror>
										<s:param>godownName</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Under </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select name="godownUnder" id="godownUnder" headerKey="-1"
									headerValue="Select choice" list="goDownUnderList"
									cssClass="select1" theme="myTheme"  applyscript="true"></s:select>

								<div id="godownUnder_error" class="fieldError">
									<s:fielderror>
										<s:param>godownUnder</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Allow storage of material </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select name="allowStorage" id="allowStorage" headerKey="-1"
									headerValue="Select choice" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"  applyscript="true"></s:select>

								<div id="allowStorage_error" class="fieldError">
									<s:fielderror>
										<s:param>allowStorage</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Our stock with third party </label>
						</div>
						<div class="InputDiv">
								<s:select name="ourStockwithTparty" id="ourStockwithTparty" headerKey="-1"
									headerValue="Select choice" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="ourStockwithTparty_error" class="fieldError">
									<s:fielderror>
										<s:param>ourStockwithTparty</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Third party stock with us </label>
						</div>
						<div class="InputDiv">
								<s:select name="thirdPartyStockWithus" id="thirdPartyStockWithus" headerKey="-1"
									headerValue="Select choice" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="thirdPartyStockWithus_error" class="fieldError">
									<s:fielderror>
										<s:param>thirdPartyStockWithus</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					
				</s:if>
			</div>
			<div class="box_footer" align="right">
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
