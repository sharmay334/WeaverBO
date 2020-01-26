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

<title>Create Stock Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	function checkForAlternateUnit() {
		$("#alternate_unit_div").css("display", "none");
		$("#applicableIfalternative").css("display", "none");
		$("#applicable_when_unit_div").css("display", "none");
		if (document.getElementById('stockItemUnit').value != "-1"
				&& document.getElementById('stockItemUnit').value != "Not Applicable") {
			$("#applicable_when_unit_div").css("display", "block");
			$("#alternate_unit_div").css("display", "block");
			if (document.getElementById('stockItemAlterUnit').value != "-1"
					&& document.getElementById('stockItemAlterUnit').value != "Not Applicable") {
				document.getElementById('unitVal1').innerText = document
						.getElementById('stockItemAlterUnit').value;
				document.getElementById('unitVal2').innerText = document
						.getElementById('stockItemUnit').value;
				$("#applicableIfalternative").show();
			}
		} else {
			$("#alternate_unit_div").css("display", "none");
			$("#applicableIfalternative").css("display", "none");
			$("#applicable_when_unit_div").css("display", "none");

		}

	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Create Stock Item
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Stock Item</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_stockCatagory.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="stockItemName"
								id="stockItemName" theme="myTheme" applyscript="true"></ss:textfield>
							<div id="stockItemName_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemName</s:param>
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
							<s:select name="stockUnderItem" id="stockUnderItem"
								headerKey="-1" headerValue="Select Stock Group"
								list="viewStockGroupList" cssClass="select1" theme="myTheme"
								applyscript="true"></s:select>

							<div id="stockUnderItem_error" class="fieldError">
								<s:fielderror>
									<s:param>stockUnderItem</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Category </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="stockItemCat" id="stockItemCat" headerKey="-1"
								headerValue="Select Stock Name" list="stockItemCatList"
								cssClass="select1" theme="myTheme"></s:select>

							<div id="stockItemCat_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemCat</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Units </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="stockItemUnit" id="stockItemUnit" headerKey="-1"
								headerValue="Select Unit" list="stockItemUnitList"
								cssClass="select1" theme="myTheme" applyscript="true"
								cssStyle="width:30%" onChange="checkForAlternateUnit()"></s:select>

							<div id="stockItemCat_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemCat</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="FormMainBox" style="display: none;"
						id="alternate_unit_div">
						<div class="labelDiv">
							<label> Alternative Unit </label><em class="Req">*</em>
						</div>

						<s:select name="stockItemAlterUnit" id="stockItemAlterUnit"
							headerKey="-1" headerValue="Select Unit" list="stockItemUnitList"
							cssClass="select1" theme="myTheme" cssStyle="width:20%"
							onChange="checkForAlternateUnit()"></s:select>
						<span id="applicableIfalternative" style="display: none;">
							<label><b>Where:</b></label> <ss:textfield maxlength="100"
								name="stockItemName" id="stockItemName" theme="myTheme"
								cssStyle="width:20%" applyscript="true"></ss:textfield> <b><label
								id="unitVal1"></label>&nbsp; = &nbsp;<ss:textfield
									maxlength="100" name="stockItemName" id="stockItemName"
									theme="myTheme" cssStyle="width:20%" applyscript="true"></ss:textfield><label
								id="unitVal2"></label></b>
						</span>
						<div id="stockItemAlterUnit_error" class="fieldError">
							<s:fielderror>
								<s:param>stockItemAlterUnit</s:param>
							</s:fielderror>
						</div>

					</div>
					<div class="clearFRM"></div>
					<div id="applicable_when_unit_div" style="display: none;">
						<div class="FormMainBox">

							<div class="labelDiv">
								<label> Maintain in Batches </label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="stockUnderItem" id="stockUnderItem"
									headerKey="-1" headerValue="Select Stock Name"
									list="{'Yes','No'}" cssClass="select1" theme="myTheme"
									applyscript="true"></s:select>

								<div id="stockUnderItem_error" class="fieldError">
									<s:fielderror>
										<s:param>stockUnderItem</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label> Track date of manufacturing?</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="stockUnderItem" id="stockUnderItem"
									headerKey="-1" headerValue="Select Stock Name"
									list="{'Yes','No'}" cssClass="select1" theme="myTheme"
									applyscript="true"></s:select>

								<div id="stockUnderItem_error" class="fieldError">
									<s:fielderror>
										<s:param>stockUnderItem</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label> Use expiry dates</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="stockUnderItem" id="stockUnderItem"
									headerKey="-1" headerValue="Select Stock Name"
									list="{'Yes','No'}" cssClass="select1" theme="myTheme"
									applyscript="true"></s:select>

								<div id="stockUnderItem_error" class="fieldError">
									<s:fielderror>
										<s:param>stockUnderItem</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label> Set Standard rates?</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="stockUnderItem" id="stockUnderItem"
									headerKey="-1" headerValue="Select Stock Name"
									list="{'Yes','No'}" cssClass="select1" theme="myTheme"
									applyscript="true"></s:select>

								<div id="stockUnderItem_error" class="fieldError">
									<s:fielderror>
										<s:param>stockUnderItem</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label> Enable cost tracking?</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="stockUnderItem" id="stockUnderItem"
									headerKey="-1" headerValue="Select Stock Name"
									list="{'Yes','No'}" cssClass="select1" theme="myTheme"
									applyscript="true"></s:select>

								<div id="stockUnderItem_error" class="fieldError">
									<s:fielderror>
										<s:param>stockUnderItem</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
					</div>
					<div id="bank_acc_details_div">
						<div class="FormSectionMenu" id="bank_acc_details_div_acc">
							<div class="greyStrip">
								<h4>Statutory Information</h4>
							</div>
							<div class="innerbox">
								<div class="FormMainBox">

									<div class="labelDiv">
										<label> GST Applicable </label>
									</div>
									<div class="InputDiv">
										<s:select name="stockItemAlterUnit" id="stockItemAlterUnit"
											headerKey="-1" headerValue="Select One"
											list="{'Applicable','Not Applicable'}" cssClass="select1"
											theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Set/alter GST Details </label>
									</div>
									<div class="InputDiv">
										<s:select name="stockItemAlterUnit" id="stockItemAlterUnit"
											headerKey="-1" headerValue="Select One" list="{'Yes','No'}"
											cssClass="select1" theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Types of Supply</label>
									</div>
									<div class="InputDiv">
										<s:select name="stockItemAlterUnit" id="stockItemAlterUnit"
											headerKey="-1" headerValue="Select One"
											list="{'Goods','Services'}" cssClass="select1"
											theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Rate of Duty </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100"
											name="ledgerBankAccount.bankName" id="bankName"
											theme="myTheme" cssStyle="width:30%"></ss:textfield>


									</div>
								</div>


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
