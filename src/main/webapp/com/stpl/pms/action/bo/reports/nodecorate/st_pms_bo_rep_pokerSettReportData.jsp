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
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
		$(document).ready(function() {
	    	$('#waitDiv').hide();
  			$('#submitBtn').show();
  			$('#submitBtn').attr("disabled",false);		
  			
  			$('input[name="actionIds"]').change(function(){
  				var dataArray = $(this).val().split("_");
  				if($(this).attr('checked')){
  					$("#correctionOption_"+dataArray[1]).attr("applyscript", "true");
  					$("#reason_"+dataArray[1]).attr("applyscript", "true");
  				}else{
  					$("#correctionOption_"+dataArray[1]).removeAttr("applyscript");
  					$("#reason_"+dataArray[1]).removeAttr("applyscript");
  				}  			
  			});
		
			$(function() {
					$('#processPokerCorrectionFrm').submit(function(){
						var correctionDataArray = new Object();
						var isValid = true;
						$('#correctionTlb tbody tr').each(function(index){
							var $row = $(this);
							if($row.find('> td:first-child > input[type="checkbox"]').prop('checked')){
								isValid = true;
								var actionId = $row.find('> td:first-child > input[type="checkbox"]').val();
								var correctionOption = $row.find('> td > select[id*=correctionOption_]').val();
								var reason = $row.find('> td > input[id*=reason_]').val();
								var withdrawImpact=$row.find('> td > select[id*=withdrawImpact_]').val();
								var data = actionId.split("_");
								if(correctionOption == -1 || reason == ''){
									isValid = false;
								}else
									correctionDataArray[data[1]] = new correctionDataObj(data[0],data[1],data[2],data[3],data[4],data[5],data[6],withdrawImpact,correctionOption,reason);
							}
							return isValid;
						});
						if($('#correctionTlb tbody tr').find('> td:first-child > input[type="checkbox"]:checked').length==0){
							alert("Please select atleast one request to process.");
							isValid = false;
						}
						/* else if(!isValid){
							alert("Please fill all data for selected request.")
							isValid = false;
						} */
						$('#correctionJsonData').val(JSON.stringify(correctionDataArray));
						
						return isValid;
					});
					
				});
				
		});	
					
		function correctionDataObj(playerId,actionId,transactionId,amount,aliasId,txnTime,refActionId,withdrawImpact,correctionOption,reason) {
				this.playerId = playerId;
				this.actionId = actionId;
				if(transactionId)
					this.transactionId = transactionId;
				else
					this.transactionId = 0;
				this.amount = amount;
				this.aliasId=aliasId;
				this.txnTime=txnTime;
				this.refActionId=refActionId;
				this.withdrawImpact=withdrawImpact;
				this.correctionOption=correctionOption;
				this.reason=reason;			
		}
	</script>

  </head>
  
  <body>
   
			<div class="FormSection">
				<s:if test="%{pokerSettlementSearchList!=null && pokerSettlementSearchList.size()>0}">
					<div class="greyStrip">
						<h4>
							Search Result
						</h4>
					</div>
						<form id="processPokerCorrectionFrm" method="post">
						<div class="innerBox">
							<table width="830" cellspacing="0" cellpadding="4" border="0" id="correctionTlb" 
								align="center" class="payTransaction">
								<thead>
								<tr>
								<s:if test="%{pokerSettlstatus == 'PENDING' }">	
									<th width="5%" valign="middle" align="left">
									
									</th>
								</s:if>
									<th width="5%" valign="middle" align="left">
										S. No.
									</th>
									<th width="10%" valign="middle" align="left">
										User Name
									</th>
									<th width="10%" valign="middle" align="left">
										Action Id
									</th>
									<s:if test="%{pokerSettlstatus != 'NOT_MATCH' }">	
										<th width="10%" valign="middle" align="left" >
											Transaction Id
										</th>
									</s:if>
									<th width="15%" valign="middle" align="left" >
										Transaction Type
									</th>
									<th width="10%" valign="middle" align="left" >
										Amount
									</th>
									<s:if test="%{pokerSettlstatus != 'NOT_MATCH' }">								
										<th width="10%" valign="middle" align="left" >
											System Status
										</th>
									</s:if>	
									<th width="10%" valign="middle" align="left" >
										Poker Status
									</th>
								<s:if test="%{pokerSettlstatus == 'PENDING' }">	
									<th width="10%" valign="middle" align="left" >
										Impact On Withdrawable
									</th>
									<th width="10%" valign="middle" align="left" >
										Correction Type
									</th>
									<th width="10%" valign="middle" align="left" >
										Reason
									</th>
								</s:if>	
								</tr>
								</thead>
								 <tbody>
								<s:iterator value="%{pokerSettlementSearchList}" status="rowstatus">
									<tr>
										<s:if test="%{pokerSettlstatus == 'PENDING' }">	
											<td>
												<input name="actionIds" id="actionId_<s:property value="%{actionId}" />"
											  		 type="checkbox" value="<s:property value="%{playerId}" />_<s:property value="%{actionId}" />_<s:property value="%{transactionId}" />_<s:property value="%{amount}" />_<s:property value="%{aliasId}" />_<s:property value="txnTime" />_<s:property value="refActionId" />" />
											</td>
										</s:if>
										<td>
											<s:property value="%{#rowstatus.index+1}" />
										</td>
										<td>
											<s:property value="%{userName}" />
										</td>
										<td>
											<s:property value="%{actionId}" />
										</td>
										<s:if test="%{pokerSettlstatus != 'NOT_MATCH' }">
											<td>
												<s:property value="%{transactionId}" />
											</td>
										</s:if>
										<td>
											<s:property value="%{txnType}" />
										</td>
										<td>
											<s:property value="%{amount}" />
										</td>
										<s:if test="%{pokerSettlstatus != 'NOT_MATCH' }">
											<td>
												<s:property value="%{systemStatus}" />
											</td>
										</s:if>
										<td>
											<s:property value="%{pokerStaus}" />
										</td>
										<s:if test="%{pokerSettlstatus == 'PENDING' }">	
											 <td>
												<select class="select" name="withdrawImpact"  id="withdrawImpact_<s:property value="%{actionId}" />">
												<option value="NO">No</option>
												<option value="YES">Yes</option>
												</select>
											</td>
											 <td>
												<select class="select" name="correctionOption"  id="correctionOption_<s:property value="%{actionId}" />">
												<option value="-1">----Please Select----</option>
												<option value="CREDIT">Credit</option>
												<option value="DEBIT">Debit</option>
												</select>
											</td>
											<td>
												<input type="text" id ="reason_<s:property value="%{actionId}" />" name ="reason" maxlength="95"/>
											</td>
										</s:if>
										
									</tr>
								</s:iterator>
								</tbody> 
							</table>
						</div>
						<div class="box_footer" align="right">
							<s:hidden name="correctionJsonData" id="correctionJsonData"/>						
							<s:token name="strutsToken" id="strutsToken"></s:token>
							<s:hidden name="domainId" id="domainId"></s:hidden>	
							<s:if test="%{pokerSettlstatus == 'PENDING' }">						
								<s:submit cssClass="button" id="correctionSubmitBtn" theme="simple" value="Process Correction" action="st_pms_bo_report_plrPaymentCorrectionPoker_save" ></s:submit>
							</s:if>							
						</div>
						</form>
				
						<div class="box_footer" align="right">
						
						</div>
				</s:if>
				<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>	  			
			</s:else>
			</div>
			
		
  </body>
</html>
