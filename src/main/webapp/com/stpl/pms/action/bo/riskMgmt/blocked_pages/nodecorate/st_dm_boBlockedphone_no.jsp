<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<div class="clearFRM" style="padding-top: 18px"></div>
<div class="FormSection" style="width: 96%; margin: 10px">
	<div class="greyStrip">
		<h4>
			Blocked Phone Information
		</h4>
	</div>
	<div class="innerBox" style="height: 130px">
		<div class="FormMainBox">

			<div class="labelDiv">
				<label>
					Phone Number
				</label>
			</div>
			<div id="Container" style="height: auto;">
				<s:set name="count" value="1"></s:set>
				<s:iterator begin="1" end="3">
					<div class="InputDiv">
						<s:iterator begin="1" end="4">
							<ss:textfield name="phoneNoList" theme="myTheme" maxlength="10"
								id="phoneNo%{#count}" pattern="^[7-9]{1}[0-9]{9}$"
								errorMassage="Please Enter A Valid Phone No" patternOn="blur"
								cssStyle="width:20%"></ss:textfield>
												&nbsp;&nbsp;
										<s:set name="count" value="#count+1" />
						</s:iterator>
					</div>
					<br />
					<br />
				</s:iterator>
			</div>
		</div>
	</div>
</div>
