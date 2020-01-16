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
<script type="text/javascript">
	$(document).ready(function() {
		$('a[id*=resetPlayerPass_]').click(function() {
			var isValid = false;
			var name = $(this).attr('name');
			if (confirm("Do you want to reset password for User " + name)) {
				isValid = true;
			}
			if (isValid) {
				var anchor = $(this);
				var linkArr = $(this).attr('href').split('?');
				$.ajax({
					type : "POST",
					url : linkArr[0],
					data : linkArr[1],
					async : false,
					success : function(result, arguments, text) {
						alert("Reset Password mail is sent to Your mail ID.");
					}
				});
			}
			return false;
		});
	});
</script>
</head>
<body>
	<script>
		//Weaver/src/main/java/com/stpl/pms/javabeans/UserDetailsBean.java

		//  alert("loading.....");
		// var continue_button = document.getElementById('submitButton');
		// alert(document.getElementById('submitButton'));
		// continue_button.style.visibility = 'hidden';   

		function chkSub() {
			//alert($('#phoneNbr').val().length);
			var flag = true;
			var errmsg1 = document.getElementById("errmsg1").value;
			var errmsg2 = document.getElementById("errmsg2").value;
			var errmsg3 = document.getElementById("errmsg3").value;

			if ($('#phoneNbr').val() == "") {
				document.getElementById("phoneNbr_error").className = "fieldError";
				document.getElementById("phoneNbr_error").innerHTML = errmsg1;
				//alert("please fill the phone no");
				flag = false;
			}

			else if ($('#phoneNbr').val().length != 10) {
				document.getElementById("phoneNbr_error").className = "fieldError";
				document.getElementById("phoneNbr_error").innerHTML = errmsg2;
				//alert("Please Enter the 10 digits phone Number");
				flag = false;
			}
			if ($('#email').val() == "") {
				document.getElementById("email_error").className = "fieldError";
				document.getElementById("email_error").innerHTML = errmsg3;
				// alert("Please Fill the emailID");
				flag = false;
			}
			if (flag == false) {
				return false;
			} else {
				return true;
			}
		}
	</script>
	<input type="hidden" value='<s:text name="global.update.err1"/>'
		id="errmsg1" />
	<input type="hidden" value='<s:text name="global.update.err2"/>'
		id="errmsg2" />
	<input type="hidden" value='<s:text name="global.update.err3"/>'
		id="errmsg3" />
	<h2>Stock Group Info</h2>

	<div class="FormSection">

		<div class="greyStrip">
			<h4>Stock Group Info</h4>
		</div>

		<div id="errorDiv"></div>
		<div id="sucessMsg"></div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_StockGroup_Save.action"
			name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();"
			theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden name="stockBean.stGpId" value="%{stockBean.stGpId}"></s:hidden>
			<div class="innerBox">


				<!--form section first start-->

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Stock Group Name</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="stockBean.stockName" value="%{stockBean.stockName}" id="stockName"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>

				<div class="clearFRM"></div>

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Stock Under</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="stockBean.stockUnder" value="%{stockBean.stockUnder}" theme="myTheme"
							id="stockUnder" readonly="true"></ss:textfield>
					</div>

				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Qty of item be added(YES/NO)</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="stockBean.qtyCheck" value="%{stockBean.qtyCheck}" id="qtyCheck"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>set/alter GST details(YES/NO)</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="stockBean.gstDetCheck" value="%{stockBean.gstDetCheck}" id="gstDetCheck"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>
				
				</div>


			
			<div class="box_footer" align="right">
						<input class="button" type="button"
					value='<s:text name="global.EDIT"/>' id="editButton"
					onclick="enableStockBoxesGroup()" style="float: right;" />

				
				<input type="submit" value='<s:text name="global.login.submit"/>'
					id="submitButton" style="display: none; width: 73px;"
					class="button" /> <a
					style="color: #000000; font-size: 12px; font-weight: bold; float: right; margin-right: 30px; margin-top: 15px;"
					href="bo_um_viewStockGroup.action"> <s:text
						name="global.scratchWeaver.BackToSearch" /></a>
			</div>
			
		</s:form>

	</div>
</body>
</html>