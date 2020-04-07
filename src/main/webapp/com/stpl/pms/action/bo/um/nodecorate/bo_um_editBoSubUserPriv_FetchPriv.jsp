<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
    <base href="<%=basePath%>">
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    </head>
    <body>
<script>
	$(document).ready(
			function() {
			
			$("#accordion").accordion( {
			collapsible : true,
			clearStyle : true,
			heightStyle: "content",
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
			
				$('.chkAll').change(
						function() {
							$(this).closest('tr').siblings('tr')
									.find('.chkGrp').attr('checked',
											this.checked);
							$(this).closest('tr').siblings('tr')
									.find('.chkGrp').change();
							/*var count=0;
							var chkVal=this.checked;
							$(this).closest('tr').siblings('tr').find('.chkGrp').each(function(){
								alert(count++);
								$(this).attr('checked',chkVal);
								$(this).change();
							});*/
						});

				$('.chkGrp').change(
						function() {
							chkPriv($(this));
							$(this).closest('tr').siblings('tr')
									.find('.chkOne').attr('checked',
											this.checked);
							chkDefault($(this).closest('tr').siblings('tr')
									.find('.chkOne'));
							//setCkhDefault(resp);
							/* if($(this).val()=='MIS Report'){								
								 	$('table[id="table_MIS Sub Reports"]').parent().toggle();								 	
								 	$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').removeAttr('checked'); */
								 	
						    if($(this).val()=='MIS Report'){	
							if($('table[id="table_MIS Report"]').find('input[type=checkbox]:checked').val()!=null){
							$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').attr('checked', true);
							}	else{
								 	$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').removeAttr('checked');
							}
							}		
						});
						
			    	$('input[id="submit_assignPriv"]').click(function(){
					if($('table[id="table_MIS Report"]').find('input[type=checkbox]:checked').val()!=null){
						if($('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]:checked').val()==null){
							alert('Please select atleast one MIS Sub Report!');
			    			return false;
			    		}
					}
					else if($('table[id="table_MIS Report"]').find('input[type=checkbox]:checked').val()==null){
						if($('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]:checked').val()!=null){
							alert('Please select MIS Report, if you are expecting MIS Sub Reports!');
			    			return false;
					}
				}
				});

				$('.chkOne').change(
					function() {
							if ($(this).attr('readonly') != 'readonly') {
								var chk = true;
								$(this).closest('table').parents('td').find(
										'.chkOne').each(function() {
									if (!this.checked) {
										chk = false;
									}
								});
								$(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp').attr(
												'checked', chk);
								chkPriv($(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp'));
								chkDefault($(this).closest('table').parents(
										'td').find('.chkOne'));
									chk = true;
								$(this).closest('table').parents('td').find(
										'.chkOne').each(function() {
									if (!this.checked) {
										chk = false;
									}
								});
								$(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp').attr(
												'checked', chk);
								chkPriv($(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp'));
										
							} else {
								$(this).attr('checked', true);
							}
							if($(this).val()=='mis_fetchReportsData'){
								if($('table[id="table_MIS Report"]').find('input[type=checkbox]:checked').val()!=null){
							$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').attr('checked', true);
							}	else{
								 	$('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]').removeAttr('checked');
							};
						};
								/* $('table[id="table_MIS Sub Reports"]').parent().toggle();
							    $('table[id="table_MIS Sub Reports"]').find('input[type=checkbox]:checked').removeAttr('checked');   */
						});
			});

	
	
	
</script>
<div class="FormSection">
<s:hidden value="%{#request.userName}" name="userName"></s:hidden>
<s:hidden value="%{#request.roleId}" name="roleId"></s:hidden>
<s:hidden value="%{roleMap.get(#request.roleId)}" name="roleName"></s:hidden>
		<div class="greyStrip">
			<h4>
				<s:text name="global.subuserregistration.Privilege"></s:text>	
			</h4>
	</div>
	<div class="innerBox">
			<div class="FormMainBox1">
	<s:if test="rolePriviledgeMap != null">
		<s:if test="rolePriviledgeMap.size()!= 0">
			<div id="accordion" class="UIaccordian">
			<s:iterator value="%{rolePriviledgeMap}" status="divService"
				var="divSerVar">
				<div id="tabs-<s:property value="#divService.index+1" />"
					style="width: 100%">
					<s:set name="serviceDispName" value="%{key}"></s:set>

					<s:iterator value="%{value}" status="divInterface">
						<div class="accordianHeader" style="width: 95%;">
						<h3>
							<a href="#section<s:property value="#divInterface.index+1"  />"
								style="color: #333333; font-size: 13px"> <s:set
									name="interface" value="%{key}"></s:set> <s:property
									value="#interface.substring(0,#interface.indexOf('-'))" /> </a>
									
						</h3>
							<!--<span class="minus1" id="min"></span>
							--></div>
						<div class="accordian_content" id="accordian_content<s:property value="%{key}" />" style="display: block;padding-top: 8px;padding-bottom: 8px;margin-top:0px; border:1px #AAAAAA solid;width: 92%;">
								
						<s:hidden name="mappingId"
							value="%{#interface.substring(#interface.indexOf('-')+1)}" />
						<s:hidden name="privCount" value="0" />
						<s:iterator value="%{value}" status="divRelatedTo">
							<s:set name="count" value="0"></s:set>
						<div style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
							<table id="tlb_<s:property value="%{key}" />"  width="100%">
								<tr align="center" style="background: #e7e7e7" height="24px">
								
									<th  style="text-align: left;" >
										<input type="checkbox" class="chkAll" />
										<b> <s:if test="%{key=='ACT_MGT'}">Account Management</s:if>
												<s:elseif test="%{key=='TICKET_MGMT'}">Ticket Management</s:elseif>
												<s:elseif test="%{key=='COMPANY_MGMT'}">Company Management</s:elseif>
												<s:elseif test="%{key=='ACCOUNTING_MGMT'}">Accounting Management</s:elseif>
												<s:elseif test="%{key=='INVENTORY_MGMT'}">Inventory Management</s:elseif>
												<s:elseif test="%{key=='TRANSACTION_MGMT'}">Transaction Management</s:elseif>
													<s:elseif test="%{key=='HR_MGMT'}">HR Management</s:elseif>
													<s:elseif test="%{key=='ORDER_VCHR'}">Order Voucher</s:elseif>
											<s:elseif test="%{key=='GAME_MGT'}">Game Management</s:elseif>
											<s:elseif test="%{key=='REPORTS'}">Reports</s:elseif> <s:elseif
												test="%{key=='USER_MGT'}">User Management</s:elseif> <s:elseif
												test="%{key=='ROLE_MGT'}">Role Management</s:elseif> <s:elseif
												test="%{key=='PLAYER_MGT'}">Player Management</s:elseif> <s:elseif
												test="%{key=='MISC'}">Miscellaneous</s:elseif> <s:elseif
												test="%{key=='HURDLE_MGT'}">Hurdle Management</s:elseif><s:elseif
												test="%{key=='LOYALTY'}">Loyalty Management</s:elseif> <s:elseif
												test="%{key=='CMS'}">Content Management System</s:elseif> <s:elseif
												test="%{key=='LOGIN_MGT'}">Login Management</s:elseif> <s:elseif
												test="%{key=='DOMAIN_MGT'}">Domain Management</s:elseif> <s:elseif
												test="%{key=='RISK_MGT'}">Risk Management</s:elseif><s:elseif 
												test="%{key=='RG'}">Responsible Gaming Management</s:elseif><s:elseif 
												test="%{key=='CASHIER' }">Cashier</s:elseif> 
												<s:elseif 
												test="%{key=='BONUS' }">Bonus</s:elseif>
												<s:elseif test="%{key=='TOURNAMENT_REPORT' }">Tournament Report</s:elseif></b>
									</th>
									<th width="33%"></th>
									<th width="33%"></th>
									
								</tr>
								<tr id="test_<s:property value="%{key}" />" align="left" style="text-align: left;">
									<s:iterator value="%{value}" status="divPriv">
										<s:set name="count" value="%{#count+1}"></s:set>
										
										<td width="33%" style="border:2px #f2f2f2 solid; background: #e0e0e0;vertical-align: top;padding-bottom:4px">
											<table id="table_<s:property value="%{key}" />" >
												<tr id="parent1_<s:property value="%{key}" />">
													<td>
													<span>	<input name="rolePrivGrp" type="checkbox" class="chkGrp"
															value="<s:property value="%{key}" />" />
															
														<font style="font-weight: bold; color: #828282;line-height: 30px">
														<s:property value="%{key}" /></font></span>
													</td>
												</tr>
												<tr id="parent_<s:property value="%{key}" />">
													<td>
													<div id="d11" style="overflow: auto; height: auto; width: 258px;">
														<table >
															<s:iterator value="%{value}" status="itrPriv">
															<div id="skilrock" style="float: left;">
																<tr align="left" style="text-align: left;">
																	<td width="20px">
																		&nbsp;&nbsp;&nbsp;
																	</td>
																	<td width="auto">
																	<s:if test="%{status=='ACTIVE'}">
																		<input name="rolePriv<s:property
									value="#interface.substring(0,#interface.indexOf('-'))" />" class="chkOne" type="checkbox"
																			value="<s:property value="privTitle"/>" checked="checked"/> 
																		<s:property value="privTitle"/>
																		</s:if>
																		<s:else>
																		<input name="rolePriv<s:property
									value="#interface.substring(0,#interface.indexOf('-'))" />" class="chkOne" type="checkbox"
																			value="<s:property value="privTitle"/>" /> 
																		<s:property value="privTitle"/>
																		</s:else>
																	</td>
																
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
			
			<%-- <s:submit id="submit_assignPriv" value="Assign Privileges" align="center" cssClass="button"
				 theme="simple"/> --%>
				 <input type="submit" id="submit_assignPriv" value='<s:text name="global.editsubuserprivileges.assignprivileges"/>' align="right" class="button" />
</div>
</div>
	</body>
	</html>