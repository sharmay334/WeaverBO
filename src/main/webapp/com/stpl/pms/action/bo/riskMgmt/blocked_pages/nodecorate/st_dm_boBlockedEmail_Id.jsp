<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<div class="clearFRM" style="padding-top: 18px"></div>
<div class="FormSection" style="width: 96%; margin: 10px">
	<div class="greyStrip">
		<h4>
			Blocked E-mail Information
		</h4>
	</div>

	<div class="innerBox" style="height: 130px">
		<div class="FormMainBox">

			<div class="labelDiv">
				<label>
					E-mail Address
				</label>
			</div>

			<div id="Container" style="height: auto;">
				<s:set name="count" value="1"></s:set>
				<s:iterator begin="1" end="3">
					<div class="InputDiv">
						<s:iterator begin="1" end="4">
							<ss:textfield name="emailIdList" theme="myTheme" cssStyle="width:20%"
								id="email%{#count}"
								pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$"
								errorMassage="Please Enter Valid Email Id" patternOn="blur"></ss:textfield>
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
