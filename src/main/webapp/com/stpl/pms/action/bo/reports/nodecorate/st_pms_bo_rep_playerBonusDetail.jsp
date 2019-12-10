<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'st_pms_bo_rep_playerBonusDetail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<SCRIPT type="text/javascript">
	$(document).ready(function(){
		$("#fromBonusTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					$("#toBonusTrans").datetimepicker("option", "minDate", dateText);
					$("#toBonusTrans").datetimepicker("option", "minDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					
				}
			});
			$("#toBonusTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					$("#fromBonusTrans").datetimepicker("option", "maxDate", dateText);
					$("#fromBonusTrans").datetimepicker("option", "maxDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					
				}
			});
			
			$('#bonusDateWise').click(function(){
				if($('#toBonusTrans').val().length==11){
					$('#toBonusTrans').val($('#toBonusTrans').val()+" 00:00:00");
				}
				if($('#fromBonusTrans').val().length==11){
					$('#fromBonusTrans').val($('#fromBonusTrans').val()+" 00:00:00");
				}
			});
			$('#bonusDateWise').click(function(){	
			var txt=$(this);
			var divId = txt.attr('target');
		var param = "";
		var ajaxParam = new Array();
		var ajaxParamVal = "";
		var isChk = true;
		if (typeof txt.attr('ajaxParamPlr') !== 'undefined') {
			var ajaxParamLen =txt.attr('ajaxParamPlr').split(',').length;
			if (ajaxParamLen > 0) {
				ajaxParam = txt.attr('ajaxParamPlr').split(',');
				$.each(ajaxParam, function(index, value) {
					ajaxParamVal = $('#' + value).val();
					param = param + value + "=" + ajaxParamVal + '&';
				});
				// param.replaceLast('&','');
			} else {
				param = txt.attr('name') + "=" + txt.val();
			}
		} else {
			param = txt.attr('name') + "=" + txt.val();
		}
		$.ajax( {
			type : "POST",
			url : txt.attr('ajaxActionPlr'),
			data : param,
			async : false,
			success : function(result) {
				$("#" + divId).html(result);
			}
		});
		return false;
			});
	});
	
	</SCRIPT>
  </head>
  
  <body>
   <div class="FormSection" id="bonusDetailData">
			<div class="greyStrip">
					<h4>
					Bonus Details
						<ss:textfield id="fromBonusTrans" name="fromBonusTrans" placeholder="From Date" applyscript="true" readonly="true"></ss:textfield>
					
					<ss:textfield id="toBonusTrans" name="toBonusTrans" placeholder="To Date" applyscript="true" readonly="true"></ss:textfield>
					<input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerBonusDetail.action" ajaxParamPlr="txnPlayerId,toBonusTrans,fromBonusTrans" target="bonusDetailData" cssClass="button" value="View Bonus Details" id="bonusDateWise" checked="true" style="margin: 5px 6px 5px 0 !important;" />
					</h4>
					</div>
					<s:if test="%{plrreportBean.get(2).size()>0}">	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Rec. Date
				</th>
				<th>
					  Exp. Date 
				</th>
				<th>
					Bonus Name
				</th>
				<th>
					Bonus Criteria
				</th>
				<th>
					Target
				</th>
				<th>
					Contribution
				</th>
				<th>
					Pending
				</th>
				<th>
					Bonus Amount
				</th>
				<th>
					To Cash
				</th>
				<th>
					Status
				</th>
			</tr>

			<s:iterator value="%{plrreportBean.get(2)}" status="plrBonus">
				<tr>
					<td>
						<s:property value="%{#plrBonus.index+1}" />
					</td>
					<td>
						<s:date name="receivedDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:date name="expiredDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{bonusCode}" />
					</td>
					<td>
						<s:property value="%{bonusCriteria}" />
					</td> 
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(wrTarget)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(wrContribution)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(wrTarget-wrContribution)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(bonusAmt)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(redeemedBonusAmt)}" />
					</td>
					<td>
						<s:property value="%{wrStatus}" />
					</td>
					

				</tr>
			</s:iterator>

		</table>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
			<div class="box_footer" align="right">
			<s:hidden id="bonusPlayerId" name="bonusPlayerId" value="%{playerId}"></s:hidden>
		 
		 </div> 
		</div>
  </body>
</html>
