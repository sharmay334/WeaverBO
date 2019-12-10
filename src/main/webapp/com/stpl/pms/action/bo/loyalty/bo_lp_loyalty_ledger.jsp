<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Loyalty ledger</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/multiselect/chosen.jquery.js"></script>

<script type="text/javascript">
	$(function() {
		$('#multiselectTxType').chosen();
		$('#multiselectEventType').chosen();
		
		/* $("#searchButton").click(function() {
				 $("#searchButton").hide();
				 $("#waitDiv").show(); 
				 $("#searchButton").attr("disabled",true);	
				 $.ajax( {
					type : "POST",
					url : $("#loyaltyLedgerSearchForm").attr('action'),
					data : $("#loyaltyLedgerSearchForm").serialize(),
					async : true,
					success : function(result) {
						$("#resultDiv").html(result);
						
					}
				});
				 
				
				 return false;			
			}); */
		
		$(".dateField").datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						maxDate :serverDateStr,
						maxDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						onClose : function(dateText, inst) {
							if ($(this).attr('id').indexOf('fromDate') != -1) {
								$('#toDate').datetimepicker("option", "minDate",
										dateText);
								$('#toDate').datetimepicker("option", "minDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							} else if ($(this).attr('id').indexOf('toDate') != -1) {
								$('#fromDate').datetimepicker("option", "maxDate",
										dateText);
								$('#fromDate').datetimepicker("option", "maxDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							}
						}
					});
					
			$("#toDate").datetimepicker("setDate", $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr));  		
			$("#fromDate").datetimepicker("setDate", "-1"); 
	});
</script>

</head>

<body>

	<div class="clear2"></div>
	<h2>Loyalty ledger</h2>
	<s:form action="bo_lp_loyalty_ledger_ajax_result_page" theme="simple" id="loyaltyLedgerSearchForm"
		target="resultDiv">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Search Criteria
					<%-- <s:checkbox name="specificSearch" id="specificSearch" value="true"></s:checkbox>
					<s:label for="specificSearch" value="Specific Include Generic"></s:label> --%>
				</h4>
			</div>
			<div class="innerBox">
				<div class="clearFRM"></div>
				<div class="FormMainBox height60">
					<div class="labelDiv">
						<label> Player Id </label>
					</div>
						<div class="InputDivHalf">
							<s:textfield name="ledgerSearchForm.playerId"  id="playerId" theme="myTheme"/>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox height60">
					<div class="labelDiv">
						<label> Transaction Type </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="%{ledgerSearchForm.transactionTypeList}" listKey="%{key}"
							listValue="%{value}"
							data-placeholder="Select transaction type ....	 "
							name="ledgerSearchForm.transactionType" id="multiselectTxType"
							multiple="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox height60">
					<div class="labelDiv">
						<label> Event Type </label>
						<!-- <em class="Req">*</em> -->
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="%{ledgerSearchForm.eventTypeList}" listKey="%{key}"
							listValue="%{value}" data-placeholder="Select event type ....	 "
							name="ledgerSearchForm.eventType" id="multiselectEventType"
							multiple="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
							<label> From Date </label>
					</div>
					<div class="InputDivHalf">
							<s:textfield name="ledgerSearchForm.dateRange.from"  cssClass="dateField" id="fromDate" theme="myTheme" readonly="true" />
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> To Date </label><em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:textfield name="ledgerSearchForm.dateRange.to"  cssClass="dateField" id="toDate" theme="myTheme" readonly="true" />
						</div>
					</div>
				<div class="clearFRM"></div>	
				</div>
			</div>
			<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				<s:submit id="searchButton" value="Search"></s:submit>
			</div>
		
	</s:form>
	<div id="resultDiv"></div>
	<div class="clear2"></div>
</body>
</html>


