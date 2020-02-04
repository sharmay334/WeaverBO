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
	$(document).ready(function() {
		$('#payTransaction').dataTable();
	});
	function setalterGSTDiv(){
		$("#set_alter_gst_form_div").css("display", "none");
		if(document.getElementById('alterGst').value=='Yes'){
			$("#set_alter_gst_form_div").css("display", "block");
		}
	}
	function maintainBatchesDetails() {
		$("#trackDateOfManDiv").css("display", "none");
		$("#useExpiryDateDiv").css("display", "none");
		if (document.getElementById('isbatches').value == 'Yes') {
			$("#trackDateOfManDiv").css("display", "block");
			$("#useExpiryDateDiv").css("display", "block");
		}
	}

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
			action="/com/stpl/pms/action/bo/um/bo_um_create_stockItem.action"
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
							cssClass="select1" theme="myTheme" cssStyle="width:15%"
							onChange="checkForAlternateUnit()"></s:select>
						<span id="applicableIfalternative" style="display: none;">
							<label><b>Where:</b></label> <ss:textfield maxlength="100"
								name="funit" id="funit" theme="myTheme" cssStyle="width:20%"></ss:textfield>
							<b><label id="unitVal1"></label>&nbsp; = &nbsp;<ss:textfield
									maxlength="100" name="sunit" id="sunit" theme="myTheme"
									cssStyle="width:20%"></ss:textfield><label id="unitVal2"></label></b>
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
								<s:select name="isbatches" id="isbatches" headerKey="-1"
									headerValue="Select Stock Name" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"
									onchange="maintainBatchesDetails()"></s:select>

								<div id="isbatches_error" class="fieldError">
									<s:fielderror>
										<s:param>isbatches</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox" id="trackDateOfManDiv"
							style="display: none;">

							<div class="labelDiv">
								<label> Track date of manufacturing?</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="dom" id="dom" headerKey="-1"
									headerValue="Select Stock Name" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="dom_error" class="fieldError">
									<s:fielderror>
										<s:param>dom</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox" id="useExpiryDateDiv"
							style="display: none;">

							<div class="labelDiv">
								<label> Use expiry dates</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="expDate" id="expDate" headerKey="-1"
									headerValue="Select Stock Name" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="expDate_error" class="fieldError">
									<s:fielderror>
										<s:param>expDate</s:param>
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
								<s:select name="standRate" id="standRate" headerKey="-1"
									headerValue="Select Stock Name" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="standRate_error" class="fieldError">
									<s:fielderror>
										<s:param>standRate</s:param>
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
								<s:select name="costTrack" id="costTrack" headerKey="-1"
									headerValue="Select Stock Name" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>

								<div id="costTrack_error" class="fieldError">
									<s:fielderror>
										<s:param>costTrack</s:param>
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
										<label> GST Applicable </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<s:select name="isGst" id="isGst" headerKey="-1"
											headerValue="Select One"
											list="{'Applicable','Not Applicable'}" applyscript="true"
											cssClass="select1" theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Set/alter GST Details </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<s:select name="alterGst" id="alterGst" headerKey="-1"
											headerValue="Select One" list="{'Yes','No'}"
											cssClass="select1" applyscript="true" theme="myTheme"
											cssStyle="width:50%" onchange="setalterGSTDiv()"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Types of Supply</label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<s:select name="supplyType" id="supplyType" headerKey="-1"
											applyscript="true" headerValue="Select One"
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
										<ss:textfield maxlength="100" name="dutyRate" id="dutyRate"
											theme="myTheme" cssStyle="width:30%"></ss:textfield>


									</div>
								</div>


							</div>
						</div>
					</div>

					<!-- set/alter GST details -->


					<div id="set_alter_gst_form_div" style="display: none;">
						<div class="FormSectionMenu" id="set_alter_gst_form">
							<div class="greyStrip">
								<h4>GST Details For Stock Item</h4>
							</div>
							<div class="innerbox">
								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Description </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="gst_description"
											id="gst_description" theme="myTheme" cssStyle="width:30%"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> HSN/SAC </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="hsn_sac" id="hsn_sac"
											theme="myTheme" cssStyle="width:30%"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Is non GST goods</label>
									</div>
									<div class="InputDiv">
										<s:select name="non_gst_goods" id="non_gst_goods"
											headerKey="-1" headerValue="Select One" list="{'Yes','No'}"
											cssClass="select1" theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Calculation Type</label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="calcType" value="On Value"
											id="calcType" theme="myTheme" cssStyle="width:30%"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> Taxability</label>
									</div>
									<div class="InputDiv">
										<s:select name="taxability" id="taxability" headerKey="-1"
											headerValue="Select One"
											list="{'UNKNOWN','EXEMPT','NILL RATED','TAXABLE'}"
											cssClass="select1" theme="myTheme" cssStyle="width:50%"></s:select>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox1">
									<table width="100%" cellspacing="0" align="center"
										id="payTransaction" class="transactionTable">
										<thead>
											<tr>
												<th style="text-align: center;" nowrap="nowrap">Tax
													Type</th>
												<th style="text-align: center;" nowrap="nowrap">Valuation
													Type</th>
												<th style="text-align: center;" nowrap="nowrap">Rate</th>

											</tr>
										</thead>
										<tbody>

											<tr>
												<td style="text-align: center;" nowrap="nowrap">Integrated
													Tax</td>
												<td style="text-align: center;" nowrap="nowrap">Based
													on value</td>
												<td style="text-align: center;" nowrap="nowrap"><ss:textfield
														maxlength="30" name="rate" value="0" id="rate"
														theme="myTheme" cssStyle="width:20%"></ss:textfield>%</td>


											</tr>
											<tr>
												<td style="text-align: center;" nowrap="nowrap">Central
													Tax</td>
												<td style="text-align: center;" nowrap="nowrap">Based
													on value</td>
												<td style="text-align: center;" nowrap="nowrap"><ss:textfield
														maxlength="30" name="rate" value="0" id="rate"
														theme="myTheme" cssStyle="width:20%"></ss:textfield>%</td>


											</tr>
											<tr>
												<td style="text-align: center;" nowrap="nowrap">State
													Tax</td>
												<td style="text-align: center;" nowrap="nowrap">Based
													on value</td>
												<td style="text-align: center;" nowrap="nowrap"><ss:textfield
														maxlength="30" name="rate" value="0" id="rate"
														theme="myTheme" cssStyle="width:20%"></ss:textfield>%</td>


											</tr>
											<tr>
												<td style="text-align: center;" nowrap="nowrap">Cess</td>
												<td style="text-align: center;" nowrap="nowrap">Based
													on value</td>
												<td style="text-align: center;" nowrap="nowrap"><ss:textfield
														maxlength="30" name="rate" value="0" id="rate"
														theme="myTheme" cssStyle="width:20%"></ss:textfield>%</td>


											</tr>
										</tbody>
									</table>
								</div>


							</div>
						</div>
					</div>


					<!-- end of set/alter GST details -->

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
