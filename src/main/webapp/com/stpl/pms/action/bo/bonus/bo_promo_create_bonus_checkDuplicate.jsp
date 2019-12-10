<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Duplicate Bonus</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
	$(function() {
		$('input[id*="ifDuplicate"]').change(function() {
			if ($(this).val() == 'BO_SPECIFIC_ORDER') {
				$('.payTransaction').tableDnD( {
					onDrop : function(table, row) {
						var rows = table.tBodies[0].rows;
						for ( var i = 1; i < rows.length; i++) {
							$(rows[i].cells[2]).html(i);
						}
						var str='{';
						for ( var i = 1; i < rows.length; i++) {
							str+='"'+$(rows[i].cells[2]).attr('id')+'":"'+$(rows[i].cells[2]).html()+'",';
						}
						str=str.substring(0,str.length-1)+'}';
						$('#bonusOrderStr').val(str);
					},
					dragHandle : ".dragHandle"
				});

				$(".payTransaction tr").hover(function() {
					$(this.cells[0]).addClass('showDragHandle');
				}, function() {
					$(this.cells[0]).removeClass('showDragHandle');
				});
			}
		});
	});
	$(document).ready(function(){
		var rows = $('.payTransaction').get(0).tBodies[0].rows;
		var str='{';
		for ( var i = 1; i < rows.length; i++) {
			str+='"'+$.trim($(rows[i].cells[2]).attr('id'))+'":"'+$.trim($(rows[i].cells[2]).html())+'",';
		}
		str=str.substring(0,str.length-1)+'}';
		$('#bonusOrderStr').val(str);
	});
</script>
	</head>

	<body>
		<s:if test="%{bonusSearchList.size()>0}">
			<s:form action="bo_promo_create_bonus_updateOrder" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
				<h2>
					Set Preference Order Here
				</h2>
				<div class="clear2"></div>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Select a Option
						</h4>
					</div>
					<div class="innerBox">
						<s:radio name="ifDuplicate" id="ifDuplicate"
							list="#{'OFFER_PLR_CHOOSE_ONE':'Offer Player to choose only one Bonus compulsory','OFFER_PLR_CHOOSE_MUL_MIN_ONE':'Offer Player to choose multiple Bonus atleast one','OFFER_PLR_CHOOSE_MUL_DENY_ALL':'Offer Player to choose multiple Bonus or Deny all','ON_HIGHER_AMOUNT':'Give bonus who has highest amount','ON_HIGHER_WR':'Give bonus who has highest wagering requirement','ON_LOWER_AMOUNT':'Give bonus who has lowest amount','ON_LOWER_WR':'Give bonus who has lowest wagering requirement','DEFINED_ORDER':'Give bonus to system define order','BO_SPECIFIC_ORDER':'Select your own Order'}"
							value="%{'DEFINED_ORDER'}"></s:radio>
						<s:hidden name="bonusOrderStr" id="bonusOrderStr"></s:hidden>
					</div>
				</div>
				<div class="clear2"></div>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Bonus List
						</h4>
					</div>
					<div class="innerBox" style="overflow-y: auto;">
						<table id="bonusTable" width="830" cellspacing="0" cellpadding="4"
							border="0" align="center" class="payTransaction">
							<tr class="nodrop nodrag">
								<th valign="middle" align="left">

								</th>
								<th valign="middle" align="left">
									Bonus Name
								</th>
								<th valign="middle" align="left">
									Bonus Order BO Wise
								</th>
								<th valign="middle" align="left">
									Related To
								</th>
								<th valign="middle" align="left">
									Activity
								</th>
								<th valign="middle" align="left">
									Activity Value
								</th>
								<th valign="middle" align="left">
									Activity Value Min
								</th>
								<th valign="middle" align="left">
									Activity Value Max
								</th>
								<th valign="middle" align="left">
									Availability Type
								</th>
								<th valign="middle" align="left">
									From Date
								</th>
								<th valign="middle" align="left">
									To Date
								</th>
								<th valign="middle" align="left">
									Before Days
								</th>
								<th valign="middle" align="left">
									After Days
								</th>
								<th valign="middle" align="left">
									Player Event
								</th>
								<th valign="middle" align="left">
									Eligibility Group
								</th>
								<th valign="middle" align="left">
									Status
								</th>
								<th valign="middle" align="left">
									Visibility
								</th>
							</tr>
							<s:set name="rowCount" value="%{0}"></s:set>
							<s:iterator value="%{bonusSearchList}" status="bonusList">
								<s:set name="rowCount" value="%{#bonusList.index+1}"></s:set>
								<tr id="tr_<s:property value="%{#rowCount}"/>">
									<td valign="middle" align="left" class="dragHandle">

									</td>
									<td valign="middle" align="left">
										<s:property value="%{bonusDispCode}" />
									</td>
									<td valign="middle" align="left" id="<s:property value="%{bonusId}" />">
										<s:property value="%{#rowCount}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{relatedTo}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{activityName}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{activityValue}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{activityValueMin}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{activityValueMax}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{availabilityType}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{availableFromDate}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{availableToDate}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{availableBeforeDays}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{availableAfterDays}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{playerEvent}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{eligibilityGroup}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{status}" />
									</td>
									<td valign="middle" align="left">
										<s:property value="%{visibility}" />
									</td>
								</tr>
							</s:iterator>
							<tr id="tr_<s:property value="%{#rowCount+1}" />">
								<td valign="middle" align="left" class="dragHandle">
									<s:set name="newBonus" value="%{#session.tempBonus}"></s:set>
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.bonusDispCode}" />
								</td>
								<td valign="middle" align="left" id="<s:property value="%{(#newBonus.bonusId!=0)?#newBonus.bonusId:'new'}" />">
									<s:property value="%{#rowCount+1}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{relatedTo}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{activityName}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.activityValue}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.activityValueMin}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.activityValueMax}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.availabilityType}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.availableFromDate}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.availableToDate}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.availableBeforeDays}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.availableAfterDays}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.playerEvent}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.eligibilityGroup}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.status}" />
								</td>
								<td valign="middle" align="left">
									<s:property value="%{#newBonus.visibility}" />
								</td>
							</tr>
						</table>

					</div>
					<div class="box_footer">
						<s:submit value="Update Order"></s:submit>
					</div>
				</div>
				<div class="clear2"></div>
			</s:form>
		</s:if>
	</body>
</html>
