<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Create Role</title>

<script>
	$(document)
			.ready(
					function() {
						$("#accordion").accordion({
							collapsible : true,
							clearStyle : true,
							heightStyle : "content",
							header : 'div[class*="accordianHeader"]',
							icons : {
								header : "plus1",
								headerSelected : "minus1"
							},
							active : false
						});
						$('.chkAll').change(
								function() {
									$(this).closest('tr').siblings('tr').find(
											'.chkGrp').attr('checked',
											this.checked);
									$(this).closest('tr').siblings('tr').find(
											'.chkGrp').change();

								});

						$('.chkGrp')
								.change(
										function() {
											chkPriv($(this));
											$(this).closest('tr')
													.siblings('tr').find(
															'.chkOne').attr(
															'checked',
															this.checked);
											chkDefault($(this).closest('tr')
													.siblings('tr').find(
															'.chkOne'));
											/* if($(this).val()=='MIS Report'){								
												 	$('table[id="table_MIS Sub Reports"]').parent().toggle();								 	
												 	$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').removeAttr('checked');
											}	 */

											if ($(this).val() == 'MIS Report') {
												if ($(
														'table[id="table_MIS Report"]')
														.find(
																'input[type=checkbox]:checked')
														.val() != null) {
													$(
															'table[id="table_MIS Sub Reports"]')
															.find(
																	'input[type=checkbox]')
															.attr('checked',
																	true);
												} else if ($(
														'table[id="table_MIS Report"]')
														.find(
																'input[type=checkbox]:checked')
														.val() == null) {
													$(
															'table[id="table_MIS Sub Reports"]')
															.find(
																	'input[type=checkbox]')
															.removeAttr(
																	'checked');
												}
											}
										});

						$('input[id*="bo_rm_create_role_save"]')
								.click(
										function() {
											if ($(
													'table[id="table_MIS Report"]')
													.find(
															'input[type=checkbox]:checked')
													.val() != null) {
												if ($(
														'table[id="table_MIS Sub Reports"]')
														.find(
																'input[type=checkbox]:checked')
														.val() == null) {
													alert('Please select atleast one MIS Sub Report!');
													return false;
												}
											} else if ($(
													'table[id="table_MIS Report"]')
													.find(
															'input[type=checkbox]:checked')
													.val() == null) {
												if ($(
														'table[id="table_MIS Sub Reports"]')
														.find(
																'input[type=checkbox]:checked')
														.val() != null) {
													alert('Please select MIS Report, if you are expecting MIS Sub Reports!');
													return false;
												}
											}
										});

						$('.chkOne')
								.change(
										function() {
											if ($(this).attr('readonly') != 'readonly') {
												var chk = true;
												$(this).closest('table')
														.parents('td').find(
																'.chkOne')
														.each(function() {
															if (!this.checked) {
																chk = false;
															}
														});
												$(this).closest('table')
														.closest('tr')
														.siblings('tr').find(
																'.chkGrp')
														.attr('checked', chk);
												chkPriv($(this)
														.closest('table')
														.closest('tr')
														.siblings('tr').find(
																'.chkGrp'));
												chkDefault($(this).closest(
														'table').parents('td')
														.find('.chkOne'));
												chk = true;
												$(this).closest('table')
														.parents('td').find(
																'.chkOne')
														.each(function() {
															if (!this.checked) {
																chk = false;
															}
														});
												$(this).closest('table')
														.closest('tr')
														.siblings('tr').find(
																'.chkGrp')
														.attr('checked', chk);
												chkPriv($(this)
														.closest('table')
														.closest('tr')
														.siblings('tr').find(
																'.chkGrp'));

											} else {
												$(this).attr('checked', true);
											}
											if ($(this).val() == 'mis_fetchReportsData') {

												if ($(
														'table[id="table_MIS Report"]')
														.find(
																'input[type=checkbox]:checked')
														.val() != null) {
													$(
															'table[id="table_MIS Sub Reports"]')
															.find(
																	'input[type=checkbox]')
															.attr('checked',
																	true);
												} else if ($(
														'table[id="table_MIS Report"]')
														.find(
																'input[type=checkbox]:checked')
														.val() == null) {
													$(
															'table[id="table_MIS Sub Reports"]')
															.find(
																	'input[type=checkbox]')
															.removeAttr(
																	'checked');
												}
												;
											}
											;
											/* $('table[id="table_MIS Sub Reports"]').parent().toggle();
											$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]:checked').removeAttr('checked');   */
										});
					});

	function chkDefault(objArr) {
		var defChk;
		var count = 0;
		objArr.each(function() {
			if (this.value.indexOf('*') != -1) {
				defChk = this;
			}
			if (this.value.indexOf('*') == -1 && this.checked) {
				count++;
			}
		});
		if (defChk != undefined) {
			if (count > 0) {
				defChk.checked = true;
				defChk.readOnly = true;
			} else {
				defChk.readOnly = false;
			}
		}

	}
	function chkPriv(obj) {
		var chk = true;
		obj.closest('table').closest('tr').closest('table').find('.chkGrp')
				.each(function() {
					if (!this.checked) {
						chk = false;
					}
				});
		obj.closest('table').closest('tr').closest('table').find('.chkAll')
				.attr('checked', chk);
	}
	function chksub() {
		var c = false;
		var flag = true;
		$('.fieldError').each(function() {
			this.innerHTML = "";
		});

		$('.chkOne').each(function() {
			if (this.checked) {
				c = true;
			}
		});
		if (c == false) {
			alert("Please Check Atleast One Role Privilege");
			flag = false;
		}

		if (flag == false) {
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>Create Role</h2>

	<s:form
		action="/com/stpl/pms/action/bo/um/bo_rm_create_role_save.action"
		method="POST" name="rolePrivForm" theme="simple"
		onsubmit="return chksub();">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>Information</h4>
			</div>
			<div align="left"
				style="font-family: Arial; font-size: 15px; color: #000000; padding-left: 5px">
				<font style="color: red">* </font>All fields are mandatory.
			</div>

			<div align="left" style="padding-left: 15px" class="fieldError">
				<s:fielderror>
					<s:param>rolePriv</s:param>
				</s:fielderror>
			</div>

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Role Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield theme="myTheme" name="roleName" id="roleName"
							pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special character not allowed"
							maxLength="30" action="bo_um_validateRole.action"
							applyscript="true"></ss:textfield>
						<div id="roleName_error" class="fieldError">
							<s:fielderror>
								<s:param>roleName</s:param>
							</s:fielderror>

						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Role Description </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield theme="myTheme" maxlength="500" name="roleDesc"
							id="roleDesc" pattern="^[a-zA-Z0-9. ]*$"
							errorMassage="Special Character is not allowed"
							applyscript="true"></ss:textfield>
						<div id="roleDesc_error" class="fieldError">
							<s:fielderror>
								<s:param>roleDesc</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="FormSection">
			<div class="greyStrip">
				<h4>Privilege</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox1">
					<s:if test="rolePrivMap != null">
						<s:if test="rolePrivMap.size()!= 0">
							<div id="accordion" class="UIaccordian">
								<s:iterator value="%{rolePrivMap}" status="divService"
									var="divSerVar">
									<div id="tabs-<s:property value="#divService.index+1" />"
										style="width: 100%">
										<s:set name="serviceDispName" value="%{key}"></s:set>

										<s:iterator value="%{value}" status="divInterface">

											<div class="accordianHeader" style="width: 95%;">
												<h3>
													<a
														href="#section<s:property value="#divInterface.index+1"  />"
														style="color: #333333; font-size: 13px"> <s:set
															name="interface" value="%{key}"></s:set> <s:property
															value="#interface.substring(0,#interface.indexOf('-'))" />
													</a>

												</h3>
												<!--<span class="minus1" id="min"></span>
							-->
											</div>
											<div class="accordian_content"
												id="accordian_content<s:property value="%{key}" />"
												style="display: block; padding-top: 8px; padding-bottom: 8px; margin-top: 0px; border: 1px #AAAAAA solid; width: 92.5%;">

												<s:hidden name="mappingId"
													value="%{#interface.substring(#interface.indexOf('-')+1)}" />
												<s:hidden name="privCount" value="0" />
												<s:iterator value="%{value}" status="divRelatedTo">
													<s:set name="count" value="0"></s:set>
													<div
														style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
														<table id="tlb_<s:property value="%{key}" />" width="100%">
															<tr align="center" style="background: #e7e7e7"
																height="24px">

																<th style="text-align: left;"><input
																	type="checkbox" class="chkAll" /> <b> <s:if
																			test="%{key=='ACT_MGT'}">Account Management</s:if> <s:elseif
																			test="%{key=='GAME_MGT'}">Game Management</s:elseif>
																		<s:elseif test="%{key=='REPORTS'}">Reports</s:elseif>
																		<s:elseif test="%{key=='USER_MGT'}">User Management</s:elseif>
																		<s:elseif test="%{key=='ROLE_MGT'}">Role Management</s:elseif>
																		<s:elseif test="%{key=='PLAYER_MGT'}">Player Management</s:elseif>
																		<s:elseif test="%{key=='MISC'}">Misc</s:elseif>
																		<s:elseif test="%{key=='HURDLE_MGT'}">Hurdle Management</s:elseif>
																		<s:elseif test="%{key=='LOYALTY'}">Loyalty Management</s:elseif>
																		<s:elseif test="%{key=='CMS'}">Content Management System</s:elseif>
																		<s:elseif test="%{key=='LOGIN_MGT'}">Login Management</s:elseif>
																		<s:elseif test="%{key=='DOMAIN_MGT'}">Domain Management</s:elseif>
																		<s:elseif test="%{key=='RISK_MGT'}">Risk Management</s:elseif>
																		<s:elseif test="%{key=='CASHIER' }">Cashier</s:elseif>
																		<s:elseif test="%{key=='BONUS' }">Bonus</s:elseif> <s:elseif
																			test="%{key=='MERCHANT_GAME_MGT'}">Merchant Game Managment</s:elseif>
																		<s:elseif test="%{key=='RG'}">Responsible Gaming Managment</s:elseif>
																		<s:elseif test="%{key=='MERCHANT_MGT'}">Merchant Managment</s:elseif>
																		<s:elseif test="%{key=='TOURNAMENT_REPORT' }">Tournament Report</s:elseif>
																</b></th>
																<th width="33%"></th>
																<th width="33%"></th>

															</tr>
															<tr id="test_<s:property value="%{key}" />" align="left"
																style="text-align: left;">
																<s:iterator value="%{value}" status="divPriv">
																	<s:set name="count" value="%{#count+1}"></s:set>

																	<td width="33%"
																		style="border: 2px #f2f2f2 solid; background: #e0e0e0; vertical-align: top; padding-bottom: 4px">
																		<table id="table_<s:property value="%{key}" />">
																			<tr id="parent1_<s:property value="%{key}" />">
																				<td><span> <input name="rolePrivGrp"
																						type="checkbox" class="chkGrp"
																						value="<s:property value="%{key}" />" /> <font
																						style="font-weight: bold; color: #828282; line-height: 30px">
																							<s:property value="%{key}" />
																					</font></span></td>
																			</tr>
																			<tr id="parent_<s:property value="%{key}" />">
																				<td>
																					<div id="d11"
																						style="overflow: auto; height: auto; width: 258px;">
																						<table>
																							<s:iterator value="%{value}" status="itrPriv">
																								<div id="skilrock" style="float: left;">
																									<tr align="left" style="text-align: left;">
																										<td width="20px">&nbsp;&nbsp;&nbsp;</td>
																										<td width="auto"><input
																											name="rolePriv<s:property
									value="#interface.substring(0,#interface.indexOf('-'))" />"
																											class="chkOne" type="checkbox"
																											value="<s:property/>" /> <s:property /></td>

																									</tr>
																								</div>
																							</s:iterator>
																						</table>
																					</div>
																				</td>
																			</tr>
																		</table>
																	</td>
																	<s:if test="%{#count==3}">
																		<s:set name="count" value="0"></s:set>
															</tr>
															<tr align="left" style="text-align: left;">
																</s:if>
																</s:iterator>
															</tr>
														</table>
													</div>
												</s:iterator>
											</div>

										</s:iterator>
									</div>
								</s:iterator>
							</div>
						</s:if>
					</s:if>
				</div>
			</div>
			<div class="box_footer" align="right">
				<s:submit value="Create Role" align="center" cssClass="button"
					theme="simple" />
			</div>
		</div>
	</s:form>
</body>
</html>