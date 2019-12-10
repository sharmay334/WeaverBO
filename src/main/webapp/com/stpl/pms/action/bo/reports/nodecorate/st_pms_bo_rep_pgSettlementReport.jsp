<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<html>
<head>
<base href="<%=basePath%>">

<title>PG Settlement Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
	var txnType, reportType;
	$.fn.dataTable.ext.search.push(function( settings, data, dataIndex ) {
		if(typeof(txnType)!="undefined" && "-1"==$.inArray(data[6],txnType) && reportType=="missingRequests")
			return false;
		return true;
	});
	$(document).ready(function(){
	 	$("#submitBtn").show();
        $("#waitDiv").hide();
		$("#submitBtn").attr("disabled",false);
		var table = $("#reportTable").dataTable({
				    	"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action?count=1',
				      	"sAjaxDataProp":"dataListReqNotFound",
					  	"sServerMethod": "POST",
					  	"deferRender": true,
					    "scrollX": "100%",
				      	"aaSorting":[],
				      	"aoColumnDefs": [{
							"aTargets": [0],
							"mRender": function (data, type, full) {
								if(full[6]!='DONE')
									return '<input name="requestIds" id="requestId_'+data+'" type="checkbox" value="'+data+'">&nbsp;'+data+'</input>';
								else 
									return data;
							}	
						}],
						"fnDrawCallback": function() {
							var status  = $("input[name='requestStatus']:checked").val();
							if(typeof($("#reportTable tbody tr:visible ").eq(0).find("td:eq(6)").html())!='undefined'){
								if(status=='PROCESSED'){
									$('#missingRequestForm').find('#submitBtn_CREDIT_MISSING_REQUEST').show();
									$('#missingRequestForm').find('#submitBtn_CANCEL_BY_BO').show();
								}else if(status=='DONE'){
									$('#missingRequestForm').find('#submitBtn_CREDIT_MISSING_REQUEST').hide();
									$('#missingRequestForm').find('#submitBtn_CANCEL_BY_BO').hide();
								}else {
									$('#missingRequestForm').find('#submitBtn_CREDIT_MISSING_REQUEST').hide();
									$('#missingRequestForm').find('#submitBtn_CANCEL_BY_BO').show();
								}
							}else{
								$('#missingRequestForm').find('#submitBtn_CREDIT_MISSING_REQUEST').hide();
								$('#missingRequestForm').find('#submitBtn_CANCEL_BY_BO').hide();
							}
   						 }
					});
					
					$("#settPendingTable").DataTable({
				    	"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action?count=2',
				      	"sAjaxDataProp":"dataListStatusUnmatched",
					  	"sServerMethod": "POST",
					  	"deferRender": true,
					    "scrollX": "100%",
				      	"aaSorting":[],
				      	"aoColumnDefs": [{
							"aTargets": [0],
							"mRender": function (data, type, full) {
									return '<input name="requestIds" id="requestId_'+data+'" type="checkbox" value="'+data+'">&nbsp;'+data+'</input>';
							}	
						}],
					});
					
					$("#pgTxnNotExist").dataTable( {
	    				"scrollX": true
    				});
					
					$(".settPendingTable,.pgTxnNotExist").hover(function(){
						reportType = "";
					});
	
					$(".requestNotFound").hover(function(){
						reportType="missingRequests";
					});
					
		$('input[id*=requestStatus]').click(function(){
			txnType=[];
			reportType="missingRequests";
			$('input[id*=requestStatus]:checked').each(function() {
				txnType.push($(this).val());
			});
			table.fnDraw();	
		});
		$('input:radio[name="requestStatus"]').filter('[value="INITIATED"]').click();
		var settlementType = null;
		$('.settlementSubmitBtn').click(function(){
			settlementType = $(this).attr('id').replace('submitBtn_','');
		});
		$('#missingRequestForm,#pendingRequestForm').submit(function(){
			$(this).append($('<input type="hidden" name="settlementType"/>').val(settlementType));
			$(this).append($('<input type="hidden" name="providerName"/>').val($('#providerId').find('option:selected').text()));
		});
	});
 	$("#submitBtn_CANCEL_BY_BO,#submitBtn_CREDIT_PENDING_REQUEST,#submitBtn_REVERSED_TO_PLR").click(function() {
		if($('[id*=requestId_]:checked').length > 0){
			$('[id*=requestId__]:checked').each(function(index,value){
				var checkBox = $(this);
				if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
					isValid = true;
				}
			});
		}else{
			alert("Please select atleast one Request Id");
			return false;
		}
	}); 
	
</script>
</head>
<body>
	<s:if test="%{reportResult.size()>0}">
		<s:iterator value="%{reportResult}">
			<s:if test="%{key == 'SETTLEMENT_DONE' && value.size()>=0}">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>Settlement Done</h4>
					</div>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Total Request Settled : </label>
							</div>
							<div class="InputDiv">
								<s:property value="%{value.size()}" />
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Total Amount Settled : </label>
							</div>
							<div class="InputDiv">
								<s:set name="totalSettledAmt" value="0" />
								<s:iterator value="%{value}" status="reportList">
									<s:set name="totalSettledAmt"
										value="%{#totalSettledAmt+ fromAmount}" />
								</s:iterator>
								<s:property
									value="%{@com.stpl.pms.utility.Utility@roundingNumber(#totalSettledAmt)}" />
							</div>
						</div>
						<div class="clearFRM"></div>
					</div>
				</div>
			</s:if>
			<s:elseif test="%{key == 'STATUS_UNMATCHED' && value.size()>=0}">
				<div class="FormSection" id="pendingRequestFormSection">

					<s:form id="pendingRequestForm" name="pendingRequestForm"
						method="post" target="pendingRequestFormSection" theme="simple"
						action="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_depositRequestSettlement.action">
						<s:token name="strutsToken1" id="strutsToken1"></s:token>

						<div class="greyStrip">
							<h4>PG Transaction Done - Settlement Pending</h4>
						</div>
						<s:if test="%{value.size()>0}">
							<div class="settPendingTable">
								<div class="innerBox">
									<table width="830" cellspacing="0" cellpadding="4" border="0"
										align="center" class="payTransaction" id="settPendingTable">
										<thead>
											<tr>
												<th valign="middle" style="text-align: center;">Request
													Id</th>
												<th valign="middle" style="text-align: center;">Player
													Id</th>
												<th valign="middle" style="text-align: center;">User
													Name</th>
												<th valign="middle" style="text-align: center;">Domain</th>
												<th style="text-align: center;">Request Amount</th>
												<th style="text-align: center;">Request Date</th>
												<th valign="middle" style="text-align: center;">Request
													Status</th>
												<th valign="middle" style="text-align: center;">Merchant
													Request Id</th>
												<th valign="middle" style="text-align: center;">Txn
													Amount</th>
												<th valign="middle" style="text-align: center;">Txn
													Date</th>
												<th valign="middle" style="text-align: center;">PG Ref
													No</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
							<div class="box_footer" align="right">
								<s:submit cssClass="button settlementSubmitBtn"
									id="submitBtn_CREDIT_PENDING_REQUEST" theme="simple"
									value="Credit Player Account"></s:submit>
								<s:submit cssClass="button settlementSubmitBtn"
									id="submitBtn_REVERSED_TO_PLR" theme="simple"
									value="Reverse to Player"></s:submit>
							</div>
						</s:if>
						<s:else>
							<div class="alert info_msg" id="extraTxnError">
								<span class="alert_close"></span><strong>Msg: </strong>No Record
								Found.
							</div>
						</s:else>
					</s:form>
				</div>
			</s:elseif>
			<s:elseif test="%{key == 'REQUEST_NOT_FOUND' && value.size()>=0}">
				<div class="FormSection" id="missingRequestFormSection">
					<s:form id="missingRequestForm" name="missingRequestForm"
						method="post" target="missingRequestFormSection" theme="simple"
						action="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_depositRequestSettlement.action">
						<s:token name="strutsToken2" id="strutsToken2"></s:token>
						<div class="greyStrip">
							<h4>Request not found in PG report (Missing Requests)</h4>
						</div>
						<div class="dataTbl_top">
							<div class="dataTbl_top">
								<p>
									<s:radio
										list="#{'INITIATED':'Initiated','PENDING':'Pending','FAILED':'Failed','PROCESSED':'Processed','DONE':'Done'}"
										name="requestStatus" id="requestStatus" value="%{'INITIATED'}" />
								</p>
							</div>
						</div>
						<div class="requestNotFound">
							<div class="innerBox">
								<table cellspacing="0" cellpadding="4" border="0"
									id="reportTable" align="center" class="payTransaction">
									<thead>
										<tr>
											<th valign="middle" style="text-align: center;">Request
												Id</th>
											<th valign="middle" style="text-align: center;">Player
												Id</th>
											<th valign="middle" style="text-align: center;">User
												Name</th>
											<th valign="middle" style="text-align: center;">Domain</th>
											<th style="text-align: center;">Total Amount</th>
											<th style="text-align: center;">Request Date</th>
											<th valign="middle" style="text-align: center;">Request
												Status</th>
											<th valign="middle" style="text-align: center;">Settlement
												Status</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
						</div>
						<div class="box_footer" align="right">
							<s:submit type="button" cssClass="button settlementSubmitBtn"
								id="submitBtn_CREDIT_MISSING_REQUEST" cssStyle="display:none;"
								theme="simple" value="Credit Player Account"></s:submit>
							<s:submit type="button" cssClass="button settlementSubmitBtn"
								id="submitBtn_CANCEL_BY_BO" theme="simple"
								value="Cancel Request"></s:submit>
						</div>
					</s:form>
				</div>
			</s:elseif>
			<s:elseif test="%{key == 'PG_TXN_NOT_EXIST' && value.size()>=0}">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>PG Transaction Done - No System Request (Extra
							Transactions)</h4>
					</div>
					<div class="pgTxnNotExist">
						<div class="innerBox">
							<s:if test="%{value.size()>0}">
								<table cellspacing="0" cellpadding="4" border="0" align="center"
									class="payTransaction" id="pgTxnNotExist">
									<thead>
										<tr>
											<th valign="middle" align="left">Merchant Request Id</th>
											<th valign="middle" align="left">Txn Amount</th>
											<th valign="middle" align="left">Txn Date</th>
											<th valign="middle" align="left">PG Ref No</th>
										</tr>
									</thead>
									<tbody>
										<s:iterator value="%{value}" status="reportList">
											<tr>
												<td><s:property value="%{merchantRequestId}" /></td>
												<td><s:property
														value="%{@com.stpl.pms.utility.Utility@roundingNumber(transactionAmount)}" />
												</td>
												<td><s:date name="%{transactionDate}"
														format="dd/MM/yyyy HH:mm:ss" /></td>
												<td><s:property value="%{pgRefNo}" /></td>
											</tr>
										</s:iterator>
									</tbody>
								</table>
							</s:if>
							<s:else>
								<div class="alert info_msg" id="extraTxnError">
									<span class="alert_close"></span><strong>Msg: </strong>No
									Record Found.
								</div>
							</s:else>
						</div>
					</div>
				</div>
			</s:elseif>
		</s:iterator>
	</s:if>
	<s:else>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</div>
	</s:else>
	<br>
	<br>
</body>
</html>
