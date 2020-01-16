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
	function callactivateInterestCalculation() {
		if (document.getElementById('activateInterestCalculation').value == "Yes")
			$("#interest_parameter").css("display", "block");
		else
			$("#interest_parameter").css("display", "none");
	}
	
	/* function functionMaintainBillByBill(){
		if (document.getElementById('balance_billbybill').value == "Yes"){
			$("#balance_billbybill_div").css("display", "block");
			$("#defCreditPeriod_div").css("display", "block");
			$("#creditDayDuringVoucher_div").css("display", "block");
			$("#specify_credit_limit_div").css("display", "block");
		}
		else{
			$("#defCreditPeriod_div").css("display", "none");
			$("#creditDayDuringVoucher_div").css("display", "none");
		}
			
		
	} */
	function get_account_interset_calculation() {
		$("#use_for_payroll_div").css("display", "none");
		$("#specify_credit_limit_div").css("display", "none");
		$("#balance_billbybill_div").css("display", "none");
		$("#balance_billbybill_div").css("display", "none");
		$("#defCreditPeriod_div").css("display", "none");
		$("#creditDayDuringVoucher_div").css("display", "none");
		if (document.getElementById('groupUnder').value == "Bank Account") {

			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "block");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "block");
			$("#invtry_values_affect").css("display", "none");
			$("#pan_It_Number_div").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "stock in hand") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#od_oc_LimitBankAcc").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Suspense account") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
		} else if (document.getElementById('groupUnder').value == "Bank occ a/c") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "block");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "block");
			$("#pan_It_Number_div").css("display", "none");
			$("#invtry_values_affect").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Bank od a/c") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "block");
			$("#pan_It_Number_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "block");

		} else if (document.getElementById('groupUnder').value == "Cash in hand") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#invtry_values_affect").css("display", "none");
			$("#bank_configuration").css("display", "none");
			$("#od_oc_LimitBankAcc").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Branch/Division") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "block");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Capital account") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "block");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Deposit(assets)") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
		} else if (document.getElementById('groupUnder').value == "Investment") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
		} else if (document.getElementById('groupUnder').value == "Misc. expense(assets)") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
		} else if (document.getElementById('groupUnder').value == "Reserves & surplus") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
		} else if (document.getElementById('groupUnder').value == "Retained earning") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
		}
		else if (document.getElementById('groupUnder').value == "Current assets") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#use_for_payroll_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Current liabilities") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#use_for_payroll_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Loans & advances(assets)") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#use_for_payroll_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Loans(liabilities)") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#use_for_payroll_div").css("display", "none");
		}
		else if (document.getElementById('groupUnder').value == "Provision") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#pan_It_Number_div").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#use_for_payroll_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Unsecured Loans") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Secured loans") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Sundry creditors") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
			$("#balance_billbybill_div").css("display", "block");
			$("#specify_credit_limit_div").css("display", "block");
			$("#defCreditPeriod_div").css("display", "block");
			$("#creditDayDuringVoucher_div").css("display", "block");
		}
		else if (document.getElementById('groupUnder').value == "Sundry debtors") {
			$("#account_interset_calculation").css("display", "block");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "block");
			$("#bank_configuration").css("display", "none");
			$("#invtry_values_affect").css("display", "block");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#pan_It_Number_div").css("display", "block");
			$("#balance_billbybill_div").css("display", "block");
			$("#specify_credit_limit_div").css("display", "block");
			$("#defCreditPeriod_div").css("display", "block");
			$("#creditDayDuringVoucher_div").css("display", "block");
		}
		else {
			$("#account_interset_calculation").css("display", "none");
			$("#bank_acc_details_div").css("display", "none");
			$("#tax_reg_detail_div").css("display", "none");
			$("#bank_configuration").css("display", "none");
			$("#interest_parameter").css("display", "none");
			$("#od_oc_LimitBankAcc").css("display", "none");
			$("#invtry_values_affect").css("display", "none");
			$("#pan_It_Number_div").css("display", "none");
			$("#balance_billbybill_div").css("display", "none");
			$("#specify_credit_limit_div").css("display", "none");
			$("#use_for_payroll_div").css("display", "none");
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
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Employee Under </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="employeeUnder" headerKey="-1"
								headerValue="Select Employee Name" list="employeeUnderList"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
								
							<div id="employeeUnder_error" class="fieldError">
								<s:fielderror>
									<s:param>employeeUnder</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					

					<!-- conditional for every group under -->


						<div class="FormMainBox" id="balance_billbybill_div"
						style="display: none;">

						<div class="labelDiv">
							<label> Maintain balances bill-by-bill</label>
						</div>
						<div class="InputDiv">
							<s:select name="blcBillByBill" headerKey="-1"
								id="balance_billbybill" headerValue="Please select"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>


						</div>

					</div>
					
					<div class="FormMainBox" id="defCreditPeriod_div"
						style="display: none;">

						<div class="labelDiv">
							<label> Default credit period</label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="defCreditPeriod" id="defCreditPeriod"
								theme="myTheme"></ss:textfield>


						</div>

					</div>
					<div class="FormMainBox" id="creditDayDuringVoucher_div"
						style="display: none;">

						<div class="labelDiv">
							<label> Check for credit day during voucher entry</label>
						</div>
						<div class="InputDiv">
							<s:select name="creditDayDuringVoucher" headerKey="-1"
								id="creditDayDuringVoucher" headerValue="Please select"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>


						</div>

					</div>
					
					
					<div class="FormMainBox" id="specify_credit_limit_div"
						style="display: none;">

						<div class="labelDiv">
							<label> Specify credit limit</label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="specifyCreditLimit" id="specifyCreditLimit"
								theme="myTheme"></ss:textfield>


						</div>

					</div>

					<div class="FormMainBox" id="invtry_values_affect"
						style="display: none;">

						<div class="labelDiv">
							<label> Inventory values are affected</label>
						</div>
						<div class="InputDiv">
							<s:select name="invtryValuesAffect" headerKey="-1"
								id="invtryValuesAffect" headerValue="Please select"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>


						</div>

					</div>
					
					
					<div class="FormMainBox" id="use_for_payroll_div"
						style="display: none;">

						<div class="labelDiv">
							<label> Use for payroll</label>
						</div>
						<div class="InputDiv">
							<s:select name="use_for_payroll" headerKey="-1"
								id="use_for_payroll" headerValue="Please select"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>


						</div>

					</div>


					<div class="FormMainBox" id="account_interset_calculation"
						style="display: none;">

						<div class="labelDiv">
							<label> Activate interest calculation</label>
						</div>
						<div class="InputDiv">
							<s:select name="ledgerBankAccount.activateInterestCalculation"
								headerKey="-1" id="activateInterestCalculation"
								headerValue="Please select" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme"
								onchange="callactivateInterestCalculation();"></s:select>


						</div>

					</div>
					<div class="FormMainBox" id="od_oc_LimitBankAcc"
						style="display: none;">

						<div class="labelDiv">
							<label> Set OD limit</label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="odLimit" id="od_limit"
								theme="myTheme" style="width:50%"></ss:textfield>


						</div>

					</div>

					<!-- bank acount ledger -->

					<div id="interest_parameter" style="display: none;">
						<div class="FormSectionMenu" id="subdocform_ip">
							<div class="greyStrip">
								<h4>Interset Parameter</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Calculate interest based on </label>
									</div>
									<div class="InputDiv">
										<s:select name="intesestBasedOn" headerKey="-1"
											headerValue="Select Any One"
											list="{'Bank/Reco date','Voucher date'}" cssClass="select1"
											theme="myTheme"></s:select>
									</div>
								</div>

								<div class="FormSectionMenu" id="subdocform_ic">
									<div class="greyStrip">
										<h4>Include transaction date for interest calculation:</h4>
									</div>
									<div class="innerbox">

										<div class="FormMainBox">

											<div class="labelDiv">
												<label>for amount added </label>
											</div>
											<div class="InputDiv">
												<s:select name="foramtAdded" headerKey="-1"
													headerValue="Select Any One" list="{'Yes','No'}"
													cssClass="select1" theme="myTheme"></s:select>
											</div>
										</div>
										<div class="FormMainBox">

											<div class="labelDiv">
												<label>for amount deducted </label>
											</div>
											<div class="InputDiv">
												<s:select name="foramtDeduct" headerKey="-1"
													headerValue="Select Any One" list="{'Yes','No'}"
													cssClass="select1" theme="myTheme"></s:select>
											</div>
										</div>

										<div class="clearFRM"></div>
										<div class="FormMainBox">

											<div class="labelDiv">
												<label> Rate </label>
											</div>
											<div class="InputDiv">
												<ss:textfield maxlength="100" name="rate" id="accHolder"
													theme="myTheme" style="width:30%"></ss:textfield>

											</div>
										</div>
										<div class="FormMainBox">

											<div class="labelDiv">
												<label>Rate % per </label>
											</div>
											<div class="InputDiv">
												<s:select name="ratePer" headerKey="-1"
													headerValue="Select Any One"
													list="{'30-Day Month','356-Day Year','Calendar Month','Calendar Year'}"
													cssClass="select1" theme="myTheme"></s:select>

											</div>
										</div>

										<div class="FormMainBox">

											<div class="labelDiv">
												<label> on </label>
											</div>
											<div class="InputDiv">
												<s:select name="on" headerKey="-1"
													headerValue="Select Any One"
													list="{'All Balances','Credit Balances Only','Debit Balances Only'}"
													cssClass="select1" theme="myTheme"></s:select>

											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>

					<!-- end -->


					<!-- end -->





					<div id="bank_acc_details_div" style="display: none;">
						<div class="FormSectionMenu" id="bank_acc_details_div_acc">
							<div class="greyStrip">
								<h4>Bank Account Details</h4>
							</div>
							<div class="innerbox">
								<div class="FormMainBox">

									<div class="labelDiv">
										<label> A/C holder's name </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100"
											name="ledgerBankAccount.accHolderName" id="accHolder"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> A/C no </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100"
											name="ledgerBankAccount.accNumber" id="accNo" theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> IFSC code </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="ledgerBankAccount.ifsc"
											id="ifsc" theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label> bank name </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100"
											name="ledgerBankAccount.bankName" id="bankName"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>


								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Branch </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="ledgerBankAccount.branch"
											id="branch" theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>

					<div id="bank_configuration" style="display: none;">
						<div class="FormSectionMenu" id="subdocform">
							<div class="greyStrip">
								<h4>Bank Configuration</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Set cheque books </label>
									</div>
									<div class="InputDiv">
										<s:select name="ledgerBankAccount.chequeBook" headerKey="-1"
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
										<s:select name="ledgerBankAccount.chequePrinting"
											headerKey="-1" headerValue="Select Any One"
											list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>
									</div>
								</div>
								<div class="clearFRM"></div>

							</div>
						</div>
					</div>

					<div id="subdocform1">
						<div class="FormSectionMenu" id="subdocform">
							<div class="greyStrip">
								<h4>Mailing Details</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Name </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="100" name="name" id="name"
											theme="myTheme"></ss:textfield>


									</div>
								</div>
								<div class="clearFRM"></div>

								<div class="FormMainBox">

									<div class="labelDiv">
										<label>Address </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="150" name="address" id="address"
											theme="myTheme"></ss:textfield>

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
										<label>Country </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="country" id="country"
											theme="myTheme"></ss:textfield>

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
										<label>State </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="state" id="state"
											theme="myTheme"></ss:textfield>

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
										<label>Pincode </label>
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

					<div id="tax_reg_detail_div" style="display: none;">
						<div class="FormSectionMenu" id="tax_reg_detail_div_acc">
							<div class="greyStrip">
								<h4>Tax Registration Details</h4>
							</div>
							<div class="innerbox">

								<div class="FormMainBox" id="pan_It_Number_div"
									style="disply: none;">

									<div class="labelDiv">
										<label>PAN/IT No. </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40" name="panItNumber"
											id="panItNumber" theme="myTheme"></ss:textfield>
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">

									<div class="labelDiv">
										<label>GSTIN/UN </label>
									</div>
									<div class="InputDiv">
										<ss:textfield maxlength="40"
											name="ledgerBankAccount.gstNumber" id="gstin" theme="myTheme"></ss:textfield>
									</div>
								</div>



							</div>
						</div>
					</div>
				</s:if>

			</div>
			<div class="box_footer" align="right">
				<input type="submit" value='Create Ledger' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
