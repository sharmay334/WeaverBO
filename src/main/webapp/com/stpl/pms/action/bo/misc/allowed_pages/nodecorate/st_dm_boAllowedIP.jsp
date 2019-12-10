<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<div class="clearFRM" style="padding-top: 18px"></div>
<div class="FormSection" style="width: 96%; margin: 10px">
	<div class="greyStrip">
		<h4>
			Add Allow IP
		</h4>
	</div>
	<div class="innerBox" style="height: 130px">

		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					IP Address
				</label>
			</div>
			<div id="Container" style="height: auto;">
				<s:set name="count" value="1"></s:set>
				<s:iterator begin="1" end="3">
					<div class="InputDiv">
						<s:iterator begin="1" end="4">
							<ss:textfield name="domainIpList" id="Ip%{#count}"
								theme="myTheme" maxlength="15"
								pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
								patternOn="blur" errorMassage="Enter a valid IP Address"
								cssStyle="width:20%"></ss:textfield>
									&nbsp;&nbsp;
							<s:set name="count" value="#count+1" />
						</s:iterator>
					</div>
					<br />
					<br />
				</s:iterator>
			</div>




			<!--<div class="InputDiv">
					<ss:textfield name="ip" id="ip1" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" required="true"
						errorMassage="Enter Correct IP Address" cssStyle="width:20%"></ss:textfield>

					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip2" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip3" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>

					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip4" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>

					
		
					<input type="text" name="dmDomainInfo.emailId" />
				
				</div>
				<br />

				<br />
				<div class="InputDiv">
					<ss:textfield name="ip" id="ip5" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip6" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip7" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip8" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					
		
					<input type="text" name="dmDomainInfo.emailId" />
				
				</div>

				<br />
				<br />
				<div class="InputDiv">
					<ss:textfield name="ip" id="ip9" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip10" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip11" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					&nbsp;&nbsp;
					<ss:textfield name="ip" id="ip12" theme="myTheme" maxlength="15"
						pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
						patternOn="blur" errorMassage="Enter Correct IP Address"
						cssStyle="width:20%"></ss:textfield>
					
		
					<input type="text" name="dmDomainInfo.emailId" />
				
					<br />
					<br />
				</div>

			</div>


			<div class="clearFRM" style="padding-top: 18px"></div>

			<div class="FormMainBox">

				<div class="labelDiv">
					<label>
						Reason for Allow IP
					</label>
				</div>
				<div class="InputDiv">
					<ss:textfield name="reason" id="reason" theme="myTheme"
						maxlength="50" pattern="^[a-zA-Z]*$"
						errorMassage="Number and Special Character not allowed"
						required="true"></ss:textfield>
					<div id="reason_error" class="fieldError">
						<s:fielderror>
							<s:param>reason</s:param>
						</s:fielderror>
					</div>
					
		
					<input type="text" name="dmDomainInfo.emailId" />
				
				</div>
			</div>
		</div>
	</div>
	<div class="box_footer" align="right">
		<s:submit name="submit" value="Allow IP" cssClass="button" id="submit"
			theme="myTheme"></s:submit>

		<s:submit name="createDomain" value="Block IP" cssClass="button"
						id="submit" theme="simple" action="bo_dm_blockIpSave.action"></s:submit>
					

		<ss:button name="Cancel" value="Cancel" cssClass="button"
						id="Cancel" target=""
						ajaxAction="/com/stpl/pms/action/bo/dm/bo_home_page.action" theme="myTheme"></ss:button>
				
	</div>

-->
		</div>
	</div>
</div>
