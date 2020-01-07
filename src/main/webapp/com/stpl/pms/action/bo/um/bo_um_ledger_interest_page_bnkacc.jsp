<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<title>Ledger created</title>
<div class="FormSection">
	<div class="greyStrip">
		<h4>Interset Parameter</h4>
	</div>
	<s:form action="/com/stpl/pms/action/bo/um/bo_um_create_ledger.action"
		id="searchUserFrm" theme="simple" target="searchDiv">
		<div class="innerBox">
			<div class="FormMainBox" id="account_interset_calculation"
				style="display: none;">

				<div class="labelDiv">
					<label> Calculate interset based on </label>
				</div>
				<div class="InputDiv">
					<s:select name="intestBasesOn" headerKey="-1"
						headerValue="Please select"
						list="{'Bank/Reco Date','Voucher Date'}" cssClass="select1"
						theme="myTheme"></s:select>


				</div>

			</div>

			<div id="tax_reg_detail_div" style="display: none;">
				<div class="FormSectionMenu" id="tax_reg_detail_div_acc">
					<div class="greyStrip">
						<h4>Include transaction date for interest calculation</h4>
					</div>
					<div class="innerbox">

						<div class="FormMainBox">

							<div class="labelDiv">
								<label>for amount added</label>
							</div>
							<div class="InputDiv">
								<s:select name="forAmtAdded" headerKey="-1"
									headerValue="Please select" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label>for amount deducted</label>
							</div>
							<div class="InputDiv">
								<s:select name="forAmtAdded" headerKey="-1"
									headerValue="Please select" list="{'Yes','No'}"
									cssClass="select1" theme="myTheme"></s:select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="box_footer" align="right">
			<input type="submit" value='Save' align="left"
				style="margin-left: 0px" class="button" />
		</div>
	</s:form>
</div>
