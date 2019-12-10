<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
	<title>Currency Exchange</title>
	</head>
	<body>
		<div class="clear2"></div>
		<h2>
			Currency Exchange
		</h2>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Currency Information
				</h4>
			</div>
			<s:form action="st_misc_currencyExchange_save.action" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								Native Currency &nbsp;&nbsp; (1 unit)
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="nativeCurrencyId" theme="myTheme"
								maxlength="16" id="nativeCurrencyId" disabled="true"
								cssStyle="width:90%" />
							<label style="color: #2b2b2b; font-size: 16px;"></label>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="ExchangeHD">
						Exchange Rate
					</div>
					<s:set name="count" value="0"></s:set>
					<s:iterator value="%{currencyConBean}">
						<s:iterator value="%{value}" status="currId">
							<div class="Exchange">
								<s:if test="%{currencyId!=nativeId}">
									<div>
										<div
											style="font-size: 12px; text-align: center; color: #2b2b2b">
											<label>
												<s:property value="%{CurrencyName}" />
												<s:hidden name="labelValues" value="%{currencyId}"
													theme="simple"></s:hidden>
											</label>
										</div>
										<div class="InputDiv">
											<ss:textfield name="exchangeRate" theme="myTheme"
												pattern="^[0-9.]*$" id="exchangeRate%{#currId.index+1}"
												patternOn="blur" maxlength="15"
												cssStyle="width:100%;height:22px; margin-left:-18px"
												applyscript="true" errorMassage="Please enter number only"
												value="%{exchangeRate}" />
										</div>
									</div>
									<s:set name="count" value="%{#count+1}"></s:set>
								</s:if>
							</div>
						</s:iterator>
					</s:iterator>
				</div>
				<div class="box_footer" align="right">
				<input type="reset" name="Reset" value="Reset" class="button" id="Reset" />
				<s:submit id="Submit" name="Submit" value="Submit" theme="simple"
						cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>

	</body>
</html>