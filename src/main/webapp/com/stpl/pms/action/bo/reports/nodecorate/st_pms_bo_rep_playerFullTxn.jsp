<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'st_pms_bo_rep_playerFullTxn.jsp' starting page</title>
    
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
	
		$("#fromLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					$("#toLastTrans").datetimepicker("option", "minDate", dateText);
					$("#toLastTrans").datetimepicker("option", "minDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					
				}
			});
			$("#toLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					$("#fromLastTrans").datetimepicker("option", "maxDate", dateText);
					$("#fromLastTrans").datetimepicker("option", "maxDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					
				}
			});
			
			$('#txnDateWise').click(function(){
				if($('#toLastTrans').val().length==11){
					$('#toLastTrans').val($('#toLastTrans').val()+" 00:00:00");
				}
				if($('#fromLastTrans').val().length==11){
					$('#fromLastTrans').val($('#fromLastTrans').val()+" 00:00:00");
				}
			});
			$('#txnDateWise').click(function(){
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
   <div class="FormSection" id="lastTransactionData">
			<div class="greyStrip">
					<h4>
					Last Transaction
					<ss:textfield id="fromLastTrans" name="fromLastTrans" placeholder="From Date" applyscript="true" readonly="true"></ss:textfield>
					
					<ss:textfield id="toLastTrans" name="toLastTrans" placeholder="To Date" applyscript="true" readonly="true"></ss:textfield>
					<input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerFullTxn.action" ajaxParamPlr="txnPlayerId,toLastTrans,fromLastTrans" target="lastTransactionData" class="button" value="View Txn Details" id="txnDateWise"  style="margin: 5px 6px 5px 0 !important;"/>
					</h4>
					</div>
					<s:if test="%{plrreportBean.get(2).size()>0}">	
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Date
				</th>
				<th>
					  Transaction Id 
				</th>
				<th>
					Particulars
				</th>
				<th>
					Credit 
				</th>

				<th>
					Debit  
				</th>

				<th>
					Balance
				</th>
				<th>
					Withdrawable Balance
				</th>
			</tr>
			
			<s:iterator value="%{plrreportBean.get(2)}" status="plrTxnList">
				<tr>
					<td>
						<s:property value="%{#plrTxnList.index+1}" />
					</td>
					<td>
						<s:date name="transactionDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{transactionId}" />
					</td>
					<td>
						<s:property value="%{particular}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(creditAmount)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(debitAmount)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(balance)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(withdrawableBalance)}" />
					</td>
				</tr>
			</s:iterator>
		</table>
		<div style="margin-left: 85%">
		<h3><label style="font-size: 12px">Opening Balance: <s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrreportBean.get(2).get(getPlrreportBean().get(2).size()-1).openingBalance)}"/></label></h3>
		</div>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
			<div class="box_footer" align="right">
			<s:hidden id="txnPlayerId" name="txnPlayerId" value="%{txnPlayerId}"></s:hidden>
		 </div> 
		</div>
  </body>
</html>
