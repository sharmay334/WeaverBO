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

<title>Search Result</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
	var _error = '<s:property value="%{errorMessage}"/>';
	var render = '<s:property value="%{render}"/>';
</script>
<%-- <script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/ledger_search_result_ajax.js"></script> --%>
<%-- <script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/loyaltybo.js"></script> --%>
<script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/simple_numbers_no_ellipses.js"></script>
	
<!-- <link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" /> -->
</head>
<style>
.dataTables_processing{
	color: transparent !important;
	background-color: transparent !important;
	/* background-color: black; */
	top: 30% !important;
	left:50% !important;
    height: 57% !important;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
		showWait();
		var transactionType = $('#transactionType').val();
		var eventType = $('#eventType').val();
		var todate = $('#toDate').val();
		var fromDate = $('#fromDate').val();
		var ledgerSearchForm = $("#ledgerSearchFormAjax").serialize();

		var table = $('#lpLedgerList').DataTable( {
        "processing": true,
        "serverSide": true,
        "searching":true,
        "processing":false,
         "aLengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
         "pages": 4,
         "pagingType": "simple_numbers_no_ellipses",
        "ajax": {
            "url": "com/stpl/pms/action/bo/loyalty/bo_lp_loyalty_ledger_search_ajax.action?"+ledgerSearchForm,
            "type": "POST",
        },
        "aoColumnDefs" : [ {
				"bSortable" : false,
				"aTargets" : []
			} ],
			
        "columns": [
            { "data": "txDate","name": "txDate",title:"Transaction Date",
            	"render": function (data) {
					        var date = new Date(data);
					        var month = date.getMonth() + 1;
					        debugger;
					        return (month > 9 ? month : "0" + month) + "/" + (date.getDate()>9?date.getDate():"0"+date.getDate()) + "/" + date.getFullYear()+" "+(date.getHours()>9?date.getHours():"0"+date.getHours())+":"+(date.getMinutes()>9?date.getMinutes():"0"+date.getMinutes())+":"+(date.getSeconds()>9?date.getSeconds():"0"+date.getSeconds());
  						  }
            },
            { "data": "playerMaster.playerId","name": "playerMaster.playerId"},
            { "data": "playerMaster.username","name": "playerMaster.username"},
            { "data": "detail","name": "detail"},
            { "data": "type","name": "type"},
            { "data": "event","name": "event"},
            { "data": "subevent","name": "subevent"},
            { "data": "preBalance.other","name": "preBalance.other"},
            { "data": "preBalance.cash","name": "preBalance.cash"},
            { "data": "preBalance.total","name": "preBalance.total"},
            { "data": "amount","name": "amount"},
            { "data": "amountAs","name": "amountAs"}, 
            { "data": "postBalance.other","name": "postBalance.other"},
            { "data": "postBalance.cash","name": "postBalance.cash"},
            { "data": "postBalance.total","name": "postBalance.total"}
        ],
        /* scrollY: 260, */
        scrollX: true,
        
        "language": {
					<%-- "processing": function(){
							showWait();
							 return "<img src='<%=path%>/com/stpl/pms/action/bo/loyalty/ajax-loader.gif'/>";
					} --%>
		},
    } );
   
    table.on( 'load.dt', showWait);
   /* table.on( 'page.dt', showWait); */ 
   /*  table.on( 'preXhr.dt', showWait);*/ 
	table.on( 'xhr.dt', hideWait); 
    
});

function hideWait(){
		 $("#searchButton").show();
		 $("#waitDiv").hide(); 
		 $("#searchButton").removeAttr("disabled");
		 console.log("complete");
}

function showWait(){
         $("#searchButton").hide();
		 $("#waitDiv").show(); 
		 $("#searchButton").attr("disabled",true);
		 console.log("wait");
}
    
</script>
<body>
	<div id="ledgerSearchRes">
				<div class="clear2"></div>
				<div class="FormSection" id="formBonus">
					<div class="greyStrip">
						<h4>Ledger Report</h4>
					</div>
					<div class="innerBox">
		<!-- <table id="lpLedgerList" class="display" cellspacing="0" width="100%"> -->
		<table cellspacing="4" cellpadding="0" border="0" align="center"
							class="payTransaction" id="lpLedgerList">
			<thead>
				<tr>
					<th colspan="7"></th>
					<th colspan="3" valign="middle" style="text-align: center;"
						nowrap="nowrap">Previous Balance</th>
					<th colspan="2"></th>
					<th colspan="3" valign="middle" style="text-align: center;"
						nowrap="nowrap">Post Balance</th>
				</tr>

				<tr>
					<%-- <th valign="middle" style="text-align: center;" nowrap="nowrap">
									<s:checkbox id="allCheckBox" fieldValue="false"
										name="allCheckBox" theme="simple"></s:checkbox></th> --%>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Transaction Date</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Player Id</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						UserName</th>	
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Detail</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Type</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Event</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Sub Event</th>

					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Other Points</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Cash Points</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Total Points</th>

					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Amount</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Amount Type</th>

					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Other Points</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Cash Points</th>
					<th valign="middle" style="text-align: center;" nowrap="nowrap">
						Total Points</th>
				</tr>
			</thead>
		</table>
	</div>
					<div class="box_footer"></div>
				</div>
				<div class="clear2"></div>
		<br />

	</div>

	<s:form id="ledgerSearchFormAjax">
		<s:hidden name="ledgerSearchForm.playerId" id="playerId" />
		<s:hidden name="ledgerSearchForm.transactionType" id="transactionType" />
		<s:hidden name="ledgerSearchForm.eventType" id="eventType" />
		<s:hidden name="ledgerSearchForm.dateRange.to" id="toDate" />
		<s:hidden name="ledgerSearchForm.dateRange.from" id="fromDate" />
	</s:form>
</body>
</html>
