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
<Script>
	function get_account_interset_calculation() {
		if (document.getElementById('groupUnder').value == "Bank Account") {

			$("#account_interset_calculation").css("display", "block");
		}
		else{
			$("#account_interset_calculation").css("display", "none");
		}
	}
</Script>
<title>Create Group</title>
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
		Create Ledger
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Ledger</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_create_ledger.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Ledger Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="ledgerName" id="ledgerName"
								theme="myTheme" applyscript="true"></ss:textfield>
							<div id="ledgerName_error" class="fieldError">
								<s:fielderror>
									<s:param>ledgerName</s:param>
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
							<s:select name="groupUnder" id="groupUnder" headerKey="-1"
								headerValue="Select Group Name" list="groupNamesList"
								cssClass="select1" theme="myTheme" applyscript="true"
								onchange="get_account_interset_calculation()"></s:select>

							<div id="groupUnder_error" class="fieldError">
								<s:fielderror>
									<s:param>groupUnder</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>


					<!-- conditional for every group under -->

					<div class="FormMainBox" id="account_interset_calculation"
						style="display: none;">

						<div class="labelDiv">
							<label> Activate interest calculation</label>
						</div>
						<div class="InputDiv">
							<s:select name="bankAccActIntCalc" headerKey="-1"
								headerValue="Please select" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme"></s:select>


						</div>

					</div>




					<!-- end -->





					<div id="subdocform" style="display: none;">
						<div class="FormSectionMenu" id="subdocform">
							<div class="greyStrip">
								<h4>Bank Account Details</h4>
							</div>
							<div class="innerbox">
								<div class="FormMainBox">

									<div class="labelDiv">
										<label> A/C holder's name </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="accHolder" id="accHolder"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> A/C no </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="accNo" id="accNo"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> IFSC code </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="ifsc" id="ifsc"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> bank name </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="bankName" id="bankName"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>


								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Branch </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="branch" id="branch"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>

					<div id="subdocform">
						<div class="FormSectionMenu" id="subdocform"
							style="display: none;">
							<div class="greyStrip">
								<h4>Bank Configuration</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Set cheque books </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<s:select name="chequeBook" headerKey="-1"
											headerValue="Select Any One" list="{'Yes','No'}"
											cssClass="select1" theme="myTheme"></s:select>
									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Cheque printing </label>
									</div>
									<div class="InputDiv">
										<s:select name="chequePrinting" headerKey="-1"
											headerValue="Select Any One" list="{'Yes','No'}"
											cssClass="select1" theme="myTheme"></s:select>
									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>

					<div id="subdocform">
						<div class="FormSectionMenu" id="subdocform">
							<div class="greyStrip">
								<h4>Mailing Details</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Name </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="name" id="name"
											theme="myTheme" applyscript="true"></ss:textfield>

										<div id="name_error" class="fieldError">
											<s:fielderror>
												<s:param>name</s:param>
											</s:fielderror>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Address </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="150" name="address" id="address"
											theme="myTheme" applyscript="true"></ss:textfield>

										<div id="address_error" class="fieldError">
											<s:fielderror>
												<s:param>address</s:param>
											</s:fielderror>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Country </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="country" id="country"
											theme="myTheme" applyscript="true"></ss:textfield>

										<div id="country_error" class="fieldError">
											<s:fielderror>
												<s:param>country</s:param>
											</s:fielderror>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>State </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="state" id="state"
											theme="myTheme" applyscript="true"></ss:textfield>

										<div id="state_error" class="fieldError">
											<s:fielderror>
												<s:param>state</s:param>
											</s:fielderror>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Pincode </label><em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="pincode" id="pincode"
											theme="myTheme"></ss:textfield>

										<div id="pincode_error" class="fieldError">
											<s:fielderror>
												<s:param>pincode</s:param>
											</s:fielderror>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>

					<div id="subdocform">
						<div class="FormSectionMenu" id="subdocform">
							<div class="greyStrip">
								<h4>Tax Registration Details</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>GSTIN/UN </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="gstin" id="state"
											theme="myTheme"></ss:textfield>
									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>
				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit" value='Create Group' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
