<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserDetailsBean"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Edit Stock Details</title>
<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
</head>
<body>
	
	<h2>Unit Info</h2>

	<div class="FormSection">

		<div class="greyStrip">
			<h4>Unit Info</h4>
		</div>

		<div id="errorDiv"></div>
		<div id="sucessMsg"></div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Unit_update.action"
			name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();"
			theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden name="stockItemBean.itemId" value="%{stockItemBean.itemId}"></s:hidden>
			<div class="innerBox">


				<!--form section first start-->

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Unit Type</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="stockItemBean.itemName" value="%{stockItemBean.itemName}" id="itemName"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>

				<div class="clearFRM"></div>

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Symbol</label>
					</div>
					<div class="InputDiv">
					<s:select name="stockItemBean.underGroup" value="%{stockItemBean.underGroup}" 
									 id="underGroup" list="viewStockGroupList"
									cssClass="select1" theme="myTheme" readonly="true"></s:select>
						
					</div>

				</div>

				
				
				</div>


			
			<div class="box_footer" align="right">
						<input class="button" type="button"
					value='<s:text name="global.EDIT"/>' id="editButton"
					onclick="enableStockBoxesItem()" style="float: right;" />

				
				<input type="submit" value='<s:text name="global.login.submit"/>'
					id="submitButton" style="display: none; width: 73px;"
					class="button" /> <a
					style="color: #000000; font-size: 12px; font-weight: bold; float: right; margin-right: 30px; margin-top: 15px;"
					href="bo_um_viewStockItem.action"> <s:text
						name="global.scratchWeaver.BackToSearch" /></a>
			</div>
			
		</s:form>

	</div>
</body>
</html>