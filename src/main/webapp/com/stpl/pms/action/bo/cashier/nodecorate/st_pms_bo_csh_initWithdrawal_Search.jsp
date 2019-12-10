<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<base href="<%=basePath%>">

		<title>Initiate Withdrawal</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="js/facebox.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
	
	$(document).ready(function() {
	 $('a[rel*="facebox"]').facebox({
	 		
	 		faceboxHtml  : '\
    <div id="facebox" style="display:none;"> \
      <div class="popup" style="box-shadow: 0px 0px;moz-box-shadow: 0px 0px;"> \
      <div class="body"> \
      </div>\
        <div class="content" style="padding:0px"> \
        </div> \
         <a href="#" class="close" id="close_image" style="display:none;"><img src="" title="close" class="close_image" /></a> \
      </div> \
    </div>',
	 		
	 		
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
			loadingImage : '<%=request.getContextPath()%>/images/4.gif',
  	 		});
  	 });
  	 
  	 			$(function() {
				$('#initWdrFrm').submit(function(){
					if($( "input[id*=txnId_]:checked" ).length==0){
						alert('Please select Atleast one withdrawal request!!');
						return false;
					}
				});
			});
			$(function() {
				$('input[id*=cancelWdrTxn_]').click(function(){
				$(".ui-dialog-content").dialog('close');
					var msg = 'Do you want to cancel the withdrawal ?';
					var cancelId=$(this).attr('id');
			        var div = $("<div>" + msg + "</div>");
			        div.dialog({
			        	resizable: "false",
			            title: "Confirm",
			            buttons: [ {text: "Yes",
			                            click: function () {$(".ui-dialog-content").dialog('close');
											var reason="";
                                            var flagCond=false;
                                            do {
                                                if(!flagCond)
                                                    reason = prompt('Kindly enter the reason of cancellation!');
                                                else
                                                    reason = prompt('Kindly enter the reason of cancellation! (Word Limit is 70)',reason);
                                                if(reason.length>70)
                                                    flagCond=true;
                                                else
                                                    flagCond=false;
                                            }while(flagCond);
			                            	var txnId=$('#'+cancelId.replace('cancelWdrTxn_','txnId_')).val();
									   		if(reason != "" && reason !== null && reason.trim().length>0){
									   		var resp = _ajaxCallText('com/stpl/pms/action/bo/cashier/st_pms_bo_csh_cancelWithdrawal_Ajax.action', 'txnIds='+txnId+'&reason='+reason);
											if(resp=='success'){
											$('#'+cancelId).parent().parent().remove();
											alert("Selected Withdrawal cancelled successfully.");
											}else{
												alert(resp);
											} }else if (reason=="" || reason.trim().length==0) {
											alert("Please Enter The Reason !");}
		                            }
			                        },
			                        {
			                            text: "No",
			                            click: function () {
			                                div.dialog("close");
			                            }
			                        }
			                    ]
			       		 });
					});
				});
			
			$(function() {
				$("#cancelAll").click(function() {
				if($( "input[id*=txnId_]:checked" ).length==0){
				alert('Please select Atleast one withdrawal request!!');
				return false;
			}
			var msg = 'Do you want to cancel the withdrawal ?';
	        var div = $("<div>" + msg + "</div>");
	        div.dialog({
	        	resizable: "false",
	            title: "Confirm",
	            buttons: [ {text: "Yes",
                    click: function () {$(".ui-dialog-content").dialog('close');
                        var reason_value="";
                        var flagCondAll=false;
                        do {
                            if(!flagCondAll)
                                reason_value = prompt('Kindly enter the reason of cancellation!');
                            else
                                reason_value = prompt('Kindly enter the reason of cancellation! (Word Limit is 70)',reason_value);
                            if(reason_value.length>70)
                                flagCondAll=true;
                            else
                                flagCondAll=false;
                        }while(flagCondAll);
					if(reason_value != "" && reason_value !== null && reason_value.trim().length>0){
					$("#reason").val(reason_value);
					$('#initWdrFrm').submit();
					}else if (reason_value=="" || reason_value.trim().length==0) {
					alert("Please Enter The Reason !");
					}}},
                       {text: "No",
                           click: function () {
                               div.dialog("close");}}
                  	 ]
				});
			});

			});
			function loadFacebox(ele) {
			$("#close_image").hide();
				var playerId = ele.id.split("_")[1];
				var reqstd_amnt = $(ele).parent().siblings(
						"td[id*='_with_amt']").attr("abbr");
				var val = $("#payTypeList").val();
				//var mode = $("option[value='" + val + "']").html();
				var mode =$("#payTypeList option:selected").text();
				var currReqTime = $(ele).parent().siblings("td[id*='_time']")
						.html();
				$(ele)
						.attr(
								'href',
								'com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getFraudReport.action?plrFraudReqBean.playerId='
										+ playerId
										+ '&plrFraudReqBean.withdrawalAmt='
										+ reqstd_amnt
										+ '&plrFraudReqBean.withdrawalMode='
										+ mode
										+ '&plrFraudReqBean.currentReqTime='
										+ currReqTime);
			}
		</SCRIPT>
	
	</head>

	<body>
		<s:if test="%{wdrTxnMap.size()>0}">
			<div class="greyStrip">
				<h4>
					Withdrawal Request
				</h4>
			</div>
			<form id="initWdrFrm" method="post" action="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_cancelWithdrawal_Submit.action">
			 <s:hidden name="reason" id="reason"></s:hidden>
			<div class="innerBox">
				<table width="830" cellspacing="0" cellpadding="4" border="0"
					align="center" class="payTransaction">
					<thead>
					<tr>
						<th width="5%" valign="middle" align="left">
							
						</th>
						<th width="10%" valign="middle" align="left">
							Transaction Id
						</th>
						<th width="20%" valign="middle" align="left" >
							User Name
						</th>
						<th width="10%" valign="middle" align="left" >
							VIP Level
						</th>
						<th width="13%" valign="middle" align="left" >
							Date
						</th>
						<th width="10%" valign="middle" align="left" >
							Amount
						</th>
						<th width="10%" valign="middle" align="left" >
							Balance
						</th>
						<th width="12%" valign="middle" align="left" >
							Withdrawable Bal
						</th>
						<th width="10%" valign="middle" align="left" >
							
						</th>
					</tr>
					</thead>
					<tbody>
					<s:iterator value="%{wdrTxnMap}" status="wdrTxn">
						<tr>
							<td>
								<input name="txnIds" id="txnId_<s:property value="%{value.transactionId}" />"
									   type="checkbox" value="<s:property value="%{value.transactionId}" />" />
							</td>
							<td>
								<s:property value="%{value.transactionId}" />
							</td>
							<td><s:a href="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getFraudReport.action" rel="facebox" id="fraud_%{value.playerId}" onclick="loadFacebox(this)">
							<s:if test="value.countCancelByBo>3">
								<span style="color:red"><s:property value="%{value.userName}" /></span>
							</s:if>
							<s:else>
								<s:property value="%{value.userName}" />
							</s:else>
								</s:a>
							</td>
							<td>
								<s:property value="%{value.vipLevel}" />
							</td>
							<td id="<s:property value="%{value.transactionId}" />_time">
								<s:property value="%{value.transactionDate}" />
							</td>
							<td id="<s:property value="%{value.transactionId}" />_with_amt" abbr="<s:property value="%{value.amount}" />">
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.amount)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.cashBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.withdrawableBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<input type="button" id="cancelWdrTxn_<s:property value="%{value.transactionId}" />" value="Cancel">
							</td>
							
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:token name="initWdrToken" id="initWdrToken" />
				<s:submit cssClass="button" id="vipSubmitBtn" theme="simple" value="Initiate Withdrawal" action="st_pms_bo_csh_initWithdrawal_Save" ></s:submit>
				<input type="button"  id="cancelAll"  value="Cancel Withdrawal"  />
			</div>
			</form>
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

	</body>
</html>
