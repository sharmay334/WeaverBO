$(document).ready(function(){
			$(".view-btn").show();
			$(".animated-button-div").hide();
			
			$('#txnDateWise').click(function(){
				if($('#toLastTrans').val().length==11){
					$('#toLastTrans').val($('#toLastTrans').val()+" 23:59:59");
				}
				if($('#fromLastTrans').val().length==11){
					$('#fromLastTrans').val($('#fromLastTrans').val()+" 00:00:00");
				}
			});
			$('#thirdPartyTxnDateWise').click(function(){
				if($('#toThirdTrans').val().length==11){
					$('#toThirdTrans').val($('#toThirdTrans').val()+" 23:59:59");
				}
				if($('#fromThirdTrans').val().length==11){
					$('#fromThirdTrans').val($('#fromThirdTrans').val()+" 00:00:00");
				}
			});
			$('#bonusDateWise').click(function(){
				if($('#toBonusTrans').val().length==11){
					$('#toBonusTrans').val($('#toBonusTrans').val()+" 23:59:59");
				}
				if($('#fromBonusTrans').val().length==11){
					$('#fromBonusTrans').val($('#fromBonusTrans').val()+" 00:00:00");
				}
			});
			$('#thirdPartyTxnDateWise').click(function(){AjaxCall($(this));});
			$('#txnDateWise').click(function(){AjaxCall($(this));});
			$('#bonusDateWise').click(function(){AjaxCall($(this));});
			$('#plrInfoEdit').click(function(){
				AjaxCall($(this));
			});
			$('.resendTicketSmsClass').click(function(){
				AjaxCall($(this));
				alert("Sms Successfully Send")
			});
			function AjaxCall(txt){
					
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
			}
			$('.openFaceBox').facebox({
				closeImage : 'images/closelabel.png'
  	 		});
			
	var activeAccordian = false;
	var $accordions = $("#login").on('click', function() {
		 		$( "#login" ).off( "click" );
				if( $("#login_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_login_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
        			if(response.length>0){
						$('#login_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransaction' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Login Date</th><th>IP Address</th><th>City</th><th>Login Device</th><th>LogOut Date</th><th>Status</th><th>Browser</th><th>OS</th><th>Model</th><th>App Version</th></tr>");
						$.each(response, function(i, value) {
						var login = new Date(value.loginDate);
						var mm = (login.getMonth()+1)<10?"0"+ (login.getMonth()+1): (login.getMonth()+1);
						var dd = login.getDate()<10?"0"+login.getDate():login.getDate();
						var yy = login.getFullYear();
						var logout =typeof(value.logoutDate)=="undefined"?'':(new Date(value.logoutDate));
						var mm1 = logout ==''?'': (logout.getMonth()+1)<10?"0"+ (logout.getMonth()+1): (logout.getMonth()+1);
						var dd1 = logout ==''?'':logout.getDate()<10?"0"+logout.getDate():logout.getDate();
						var yy1 = logout ==''?'':logout.getFullYear();
						var logoutDate  = logout==''?'--':dd1+"/"+mm1+"/"+yy+" "+logout.toTimeString().split('G')[0];
						var count = i+1;
							$("#payTransaction").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+login.toTimeString().split('G')[0]+"</td><td>"+value.ipAddress+"</td><td>"+value.city+"</td><td>"+value.loginDevice+"</td><td>"+logoutDate+"</td><td>"+value.status+"</td><td>"+value.browser+"</td><td>"+value.OS+"</td><td>"+value.device+"</td><td>"+value.appVersion+"</td></tr>");
						});
						 $("#login_details").append("</table>");
					}
				else{
					$('#login_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitLogin").fadeOut();});
				
			}
        	activeAccordian = this;
    		}).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    });
    
    var $accordions = $("#wallet").on('click', function() {
    	$( "#wallet" ).off( "click" );
    if( $("#wallet_details").children().size()<=1){
    		_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_wallet_detail.action","playerId="+$("#detailPlayerId").val()+"&domainId1="+$("#domainId1").val(),function(response){
        			hideLoader(response);
				if(response!=null){
						/*$('#wallet_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionw' align='center' class='payTransaction' style='color: #696969;'><tr><th>Total Balance</th><th>Cash Balance</th><th>Bonus Balance</th><th>Total Deposit</th><th>Total Winning</th><th>Total Wager</th><th>Total WithDrawal</th><th>Total Bonus</th><th>Withdrawable Balance</th><th>Rake Amount</th></tr>");*/
					$('#wallet_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionw' align='center' class='payTransaction' style='color: #696969;'><tr><th>Total Balance</th><th>Cash Balance</th><th>Bonus Balance</th><th>Total Deposit</th><th>Total Winning</th><th>Total Wager</th><th>Total WithDrawal</th><th>Total Bonus</th><th>Withdrawable Balance</th></tr>");
							/*$("#payTransactionw").append("<tr><td>"+(response.totalBal).toFixed(2) +"</td><td>"+(response.cashBal).toFixed(2)+"</td><td>"+(response.bonusBal).toFixed(2)+"</td><td>"+(response.totalDeposit).toFixed(2)+"</td><td>"+(response.totalWinning).toFixed(2)+"</td><td>"+(response.totalWager).toFixed(2)+"</td><td>"+(response.totalWithdrawal).toFixed(2)+"</td><td>"+(response.totalBonus).toFixed(2)+"</td><td>"+(response.withdrawableBal).toFixed(2)+"</td><td><div id='rakeDiv'><a href='#' style='font-weight: 100;' onclick='javascript: return callGetRakeAmt();'>SHOW</a> </div></></td></tr>");*/
							$("#payTransactionw").append("<tr><td>"+(response.totalBal).toFixed(2) +"</td><td>"+(response.cashBal).toFixed(2)+"</td><td>"+(response.bonusBal).toFixed(2)+"</td><td>"+(response.totalDeposit).toFixed(2)+"</td><td>"+(response.totalWinning).toFixed(2)+"</td><td>"+(response.totalWager).toFixed(2)+"</td><td>"+(response.totalWithdrawal).toFixed(2)+"</td><td>"+(response.totalBonus).toFixed(2)+"</td><td>"+(response.withdrawableBal).toFixed(2)+"</td></tr>");
						 $("#wallet_details").append("</table>");
					}
				else{
					$('#wallet_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
    		$("#waitWallet").hide();});
			}
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	 var $accordions = $("#deposit").on('click', function() {
		 $( "#deposit" ).off( "click" );
	 if( $("#deposit_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_deposit_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
				if(response.length>0){
						$('#deposit_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactiond' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Requested Id</th><th>Amount</th><th>Device</th><th>Browser</th><th>OS</th><th>Model</th></tr>");
						$.each(response, function(i, value) {
						var count = i+1;
						var date = new Date(value.transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
							$("#payTransactiond").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+value.transactionId+"</td><td>"+value.requestId+"</td><td>"+value.amount+"</td><td>"+value.depDevice+"</td><td>"+value.browser+"</td><td>"+value.os+"</td><td>"+value.device+"</td></tr>");
						});
						 $("#deposit_details").append("</table>");
					}
				else{
					$('#deposit_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitDeposit").hide();});
			}
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate',false);
    
	});
	 var $accordions = $("#thirdPartyTxn").on('click', function() {
		 $( "#thirdPartyTxn" ).off( "click" );
	 if( $("#thirdPartyTxn_details").children().size()<=1){
				_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_thirdPartyTxn_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
				$("#thirdPartyTxn_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromThirdTrans' name='fromThirdTrans' placeholder='From Date'  readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toThirdTrans' name='toThirdTrans' placeholder='To Date' readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Txn Details' id='thirdPartyTxnDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
				$("#fromThirdTrans").val(response[0]);
				$("#toThirdTrans").val(response[1]);
				$("#fromThirdTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
			$("#toThirdTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
				if(response.length>2){
						$('#thirdPartyTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payThirdtxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Amount</th><th>Game Engine</th><th>Wallet Provider</th><th>Particulars</th></tr>");
	        			for(i=0;i<response[2].length;i++){
						var count = i+1;
						var date = new Date(response[2][i].transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth() + 1):(date.getMonth() + 1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
						var amount = typeof(response[2][i].amount)=="undefined"?'':(response[2][i].amount <0.01 && response[2][i].amount>0)?(response[2][i].amount).toFixed(3):(response[2][i].amount).toFixed(2);
							$("#payThirdtxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+amount+"</td><td>"+response[2][i].vendorName+"</td><td>"+response[2][i].walletProvider+"</td><td>"+response[2][i].particulars+"</td></tr>");
						}
						 $("#thirdPartyTxn_details").append("</table>");
					}
				else{
					$('#thirdPartyTxn_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
					$("#waitThirdPartyTxn").hide();
					});
			}
	 
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});

	$("#thirdPartyTxnDateWise").live('click', function() {
	var flag2 = 0;
	$("#fromThirdTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
			$("#toThirdTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
	if(flag2==0){
	$("#waitThirdPartyTxn").show();
		_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_thirdPartyTxnFull.action","playerId="+$("#detailPlayerId").val()+"&fromDateTxn="+$("#fromThirdTrans").val()+"&toDateTxn="+$("#toThirdTrans").val(),function(response){
        			hideLoader(response);
		flag2=1;
		$("#thirdPartyTxn_details").empty();
		var fromDate = new Date(response[0]);
					var toDate = new Date(response[1]);
					$("#thirdPartyTxn_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromThirdTrans' name='fromThirdTrans' placeholder='From Date'  readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toThirdTrans' name='toThirdTrans' placeholder='To Date'  readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Txn Details' id='thirdPartyTxnDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
					$("#fromThirdTrans").val(response[0]);
					$("#toThirdTrans").val(response[1]);
					 $("#fromThirdTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
						$("#toThirdTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
					 
					if(response.length>2){
						$('#thirdPartyTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payThirdtxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Amount</th><th>Game Engine</th><th>Wallet Provider</th><th>Particulars</th></tr>");
						for(i=0;i<response[2].length;i++){
						var count = i+1;var date = new Date(response[2][i].transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth() + 1):(date.getMonth() + 1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
						var amount = typeof(response[2][i].amount)=="undefined"?'':(response[2][i].amount <0.01 && response[2][i].amount>0)?(response[2][i].amount).toFixed(3):(response[2][i].amount).toFixed(2);
							$("#payThirdtxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+amount+"</td><td>"+response[2][i].vendorName+"</td><td>"+response[2][i].walletProvider+"</td><td>"+response[2][i].particulars+"</td></tr>");
						}
						 $("#thirdPartyTxn_details").append("</table>");
					}
				else{
					$('#thirdPartyTxn_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
					$("#waitThirdPartyTxn").hide();});
			}
	 
	});				
	 var $accordions = $("#lastTxn").on('click', function() {
		 $( "#lastTxn" ).off( "click" );
	 if( $("#lastTxn_details").children().size()<=1){
				_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_lastTxn_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
					hideLoader(response);
				$("#lastTxn_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromLastTrans' name='fromLastTrans' placeholder='From Date'  readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toLastTrans' name='toLastTrans' placeholder='To Date' readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Txn Details' id='txnDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
				$("#fromLastTrans").val(response[0]);
				$("#toLastTrans").val(response[1]);
				$("#fromLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
			$("#toLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
				if(response.length>2){
						/*$('#lastTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactiontxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Particulars</th><th>Credit</th><th>Debit</th><th>Balance</th><th>Withdrawable Balance</th></tr>");*/
						$('#lastTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactiontxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Particulars</th><th>Credit</th><th>Debit</th><th>Balance</th></tr>");
						for(i=0;i<response[2].length;i++){
						var count = i+1;
						var crAmt = typeof(response[2][i].creditAmount)=="undefined"?'':(response[2][i].creditAmount <0.01 && response[2][i].creditAmount > 0)?(response[2][i].creditAmount).toFixed(3):(response[2][i].creditAmount).toFixed(2);
						var dbAmt = typeof(response[2][i].debitAmount)=="undefined"?'':(response[2][i].debitAmount <0.01 && response[2][i].debitAmount > 0) ?(response[2][i].debitAmount).toFixed(3):(response[2][i].debitAmount).toFixed(2);
						var date = new Date(response[2][i].transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth() + 1):(date.getMonth() + 1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
						var withBal = typeof(response[2][i].withdrawableBalance)=="undefined"?'':(response[2][i].withdrawableBalance < 0.01 && response[2][i].withdrawableBalance >0)?(response[2][i].withdrawableBalance).toFixed(3):(response[2][i].withdrawableBalance).toFixed(2);
							/*$("#payTransactiontxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+(response[2][i].particular)+"</td><td>"+crAmt+"</td><td>"+dbAmt+"</td><td>"+(response[2][i].balance).toFixed(2)+"</td><td>"+withBal+"</td></tr>");*/
							$("#payTransactiontxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+(response[2][i].particular)+"</td><td>"+crAmt+"</td><td>"+dbAmt+"</td><td>"+(response[2][i].balance).toFixed(2)+"</td></tr>");
						}
						 $("#lastTxn_details").append("</table>");
					}
				else{
					$('#lastTxn_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
					$("#waitTxn").hide();
					});
			}
	 
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	 var $accordions = $("#withdraw").on('click', function() {
		 $( "#withdraw" ).off( "click" );
	  if( $("#withTxn_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_with_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
				if(response.length>0){
						$('#withTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionwith' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Process Charges</th><th>Withdrawal Mode</th><th>Balance</th><th>Device</th><th>Browser</th><th>OS</th><th>Model</th></tr>");
						$.each(response, function(i, value) {
						var count = i+1;
						var date = new Date(value.transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth() + 1):(date.getMonth() + 1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
						var processCharge =typeof(value.processCharges)=="undefined"?'':(value.processCharges);
						var withDevice =typeof(value.withDevice)=="undefined"?'':(value.withDevice);
							$("#payTransactionwith").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+value.transactionId+"</td><td>"+processCharge+"</td><td>"+value.withdrawalMode+"</td><td>"+(value.amount).toFixed(2)+"</td><td>"+withDevice+"</td><td>"+value.browser+"</td><td>"+value.os+"</td><td>"+value.device+"</td></tr>");
						});
						 $("#withTxn_details").append("</table>");
					}
				else{
					$('#withTxn_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitWith").hide();});
			}
	 
	 
	 
	 
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	 var $accordions = $("#bonus").on('click', function() {
		 $("#bonus").off( "click" );
	 if( $("#bonus_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_bonus_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
					var fromDate = new Date(response[0]);
					var toDate = new Date(response[1]);
					$("#bonus_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromBonusTrans' name='fromBonusTrans' placeholder='From Date'  readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toBonusTrans' name='toBonusTrans' placeholder='To Date'  readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Bonus Details' id='bonusDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
					$("#fromBonusTrans").val((fromDate.getDate() < 10 ? '0' + fromDate.getDate() : fromDate.getDate())+"/"+("0" + (fromDate.getMonth() + 1)).slice(-2)+"/"+fromDate.getFullYear()+" "+fromDate.toTimeString().split('G')[0]);
					$("#toBonusTrans").val((toDate.getDate() < 10 ? '0' + toDate.getDate() : toDate.getDate())+"/"+("0" + (toDate.getMonth() + 1)).slice(-2)+"/"+toDate.getFullYear()+" "+toDate.toTimeString().split('G')[0]);
					
					 $("#fromBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
						$("#toBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
					 
					if(response[2].length>0){
				
							/* 	<input type="text" id="fromBonusTrans" name="fromBonusTrans" placeholder="From Date" value="<s:property value="%{plrDetailBean.plrresponses.get(0)}"/>" readonly="readonly" applyscript="true" />
						<input type="text" id="toBonusTrans" name="toBonusTrans" placeholder="To Date" value="<s:property value="%{plrDetailBean.plrresponses.get(1)}"/>" applyscript="true" readonly="readonly"/>
						<input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerresponse.action" ajaxParamPlr="txnPlayerId,toBonusTrans,fromBonusTrans" target="responseData" class="button" value="View Bonus Details" id="bonusDateWise" checked="true" style="margin: 5px 6px 5px 0 !important;" /> */
							$('#bonus_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionbobnus' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Rec. Date</th><th>Exp. Date</th><th>Bonus Name</th><th>Bonus Criteria</th><th>Target</th><th>Contribution</th><th>Pending</th><th>Bonus Amount</th><th>To Cash</th><th>Status</th></tr>");
							for(i=0;i<response[2].length;i++){
								var count = i+1;
								var recDate = new Date(response[2][i].receivedDate);
								var mm = (recDate.getMonth() + 1)<10?"0"+(recDate.getMonth() + 1):(recDate.getMonth() + 1);
								var dd = recDate.getDate()<10?"0"+recDate.getDate():recDate.getDate();
								var yy = recDate.getFullYear();
								var expDate = new Date(response[2][i].expiredDate);
								var mm1 = (expDate.getMonth() + 1)<10?"0"+(expDate.getMonth() + 1):(expDate.getMonth() + 1);
								var dd1= expDate.getDate()<10?"0"+expDate.getDate():expDate.getDate();
								var yy1 = expDate.getFullYear();
								var wrTarget =  typeof(response[2][i].wrTarget)=="undefined"?0:(response[2][i].wrTarget);
								var pending = wrTarget==0?0:(wrTarget-response[2][i].wrContribution);
								pending = (pending< 0.01 && pending >0)?pending.toFixed(3):pending.toFixed(2);
								var contri = typeof(response[2][i].wrContribution)=="undefined"?0:(response[2][i].wrContribution < 0.01 && response[2][i].wrContribution>0)?(response[2][i].wrContribution).toFixed(3):(response[2][i].wrContribution).toFixed(2);
									$("#payTransactionbobnus").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+recDate.toTimeString().split('G')[0]+"</td><td>"+dd1+"/"+mm1+"/"+yy1+" "+expDate.toTimeString().split('G')[0]+"</td><td>"+(response[2][i].bonusCode)+"</td><td>"+(response[2][i].bonusCriteria)+"</td><td>"+wrTarget.toFixed(2)+"</td><td>"+contri+"</td><td>"+pending+"</td><td>"+((response[2][i].bonusAmt < 0.01 && response[2][i].bonusAmt >0)?(response[2][i].bonusAmt).toFixed(3):(response[2][i].bonusAmt).toFixed(2))+"</td><td>"+((response[2][i].redeemedBonusAmt < 0.01 && response[2][i].redeemedBonusAmt > 0)?(response[2][i].redeemedBonusAmt).toFixed(3):(response[2][i].redeemedBonusAmt).toFixed(2))+"</td><td>"+response[2][i].wrStatus+"</td></tr>");
								}
						 $("#bonus_details").append("</table>");
					}
					
				else{
					$('#bonus_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitBonus").hide();});
			}
	 
	 
	 
	
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	 var $accordions = $("#inbox").on('click', function() {
		 $("#inbox").off( "click" );
	  if( $("#inbox_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_inbox_detail.action","playerId="+$("#detailPlayerId").val()+"&domainId1="+$("#domainId1").val(),function(response){
        			hideLoader(response);
				if(response.length>0){
						$('#inbox_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactioninbox' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Subject</th><th>Template Name</th><th>Sent Date</th><th>Exp. Date</th><th>Status</th></tr>");
						$.each(response, function(i, value) {
						var count = i+1;
						var sendDate = new Date(value.sentDate);
						var mm = (sendDate.getMonth() + 1)<10?"0"+(sendDate.getMonth() + 1):(sendDate.getMonth() + 1);
						var dd = sendDate.getDate()<10?"0"+sendDate.getDate():sendDate.getDate();
						var yy = sendDate.getFullYear();
						var expDate = new Date(value.expiryDate);
						var exp =typeof(value.expiryDate)=="undefined"?'':(new Date(value.expiryDate));
						var expDate  = exp==''?'':expDate.getDate()+"/"+(expDate.getMonth()+1)+"/"+expDate.getFullYear()+" "+exp.toTimeString().split('G')[0];
						
						
							$("#payTransactioninbox").append("<tr><td>"+count+"</td><td>"+value.subject+"</td><td>"+value.templateName+"</td><td>"+dd+"/"+mm+"/"+yy+" "+sendDate.toTimeString().split('G')[0]+"</td><td>"+expDate+"</td><td>"+value.emailStatus+"</td></tr>");
						});
						 $("#inbox_details").append("</table>");
					}
				else{
					$('#inbox_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitInbox").hide();});
			}
	 
	
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	 var $accordions = $("#vip").on('click', function() {
		 $("#vip").off( "click" );
	  if( $("#vip_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_vip_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);
				if(response.length>0){
						$('#vip_details').append("<p style='color: #696969;'>VIP Level "+$("#vipLevelValue").val()+"</p>");
						$('#vip_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionvip' align='center' class='payTransaction' style='color: #696969;'><tr><th>Criteria</th><th>Last Month</th><th>Last Quater</th><th>Last Year</th><th>Since Reg</th></tr>");
												
						$.each(response, function(i, value) {
							var lastMonthFreq = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastMonthFreq);
							var lastQuarterFreq = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastQuarterFreq);
							var lastYearFreq = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastYearFreq);
							var sinceRegiFreq = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.sinceRegiFreq);
							var lastMonthCount = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastMonthCount);
							var lastQuarterCount = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastQuarterCount);
							var lastYearCount =  typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.lastYearCount);
							var sinceRegiCount = typeof(value.plrVipLogin)=="undefined"?'':(value.plrVipLogin.sinceRegiCount);
							var lastMonthFreq1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastMonthFreq);
							var lastQuarterFreq1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastQuarterFreq);
							var lastYearFreq1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastYearFreq);
							var sinceRegiFreq1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.sinceRegiFreq);
							var lastMonthCount1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastMonthCount);
							var lastQuarterCount1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastQuarterCount);
							var lastYearCount1 =  typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastYearCount);
							var sinceRegiCount1 = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.sinceRegiCount);
							var lastMonthValue = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastMonthValue);
							var lastQuarterValue = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastQuarterValue);
							var lastYearValue = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.lastYearValue);
							var sinceRegiValue = typeof(value.plrVipDeposit)=="undefined"?'':(value.plrVipDeposit.sinceRegiValue);
							var lastMonthFreq2 =  typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastMonthFreq);
							var lastQuarterFreq2 =  typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastQuarterFreq);
							var lastYearFreq2 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastYearFreq);
							var sinceRegiFreq2 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.sinceRegiFreq);
							var lastMonthCount2 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastMonthCount);
							var lastQuarterCount2 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastQuarterCount);
							var lastYearCount2 =  typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastYearCount);
							var sinceRegiCount2 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.sinceRegiCount);
							var lastMonthValue1 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastMonthValue);
							var lastQuarterValue1 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastQuarterValue);
							var lastYearValue1 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.lastYearValue);
							var sinceRegiValue1 = typeof(value.plrVipWithdrawal)=="undefined"?'':(value.plrVipWithdrawal.sinceRegiValue);
							var lastMonthFreq3 =  typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastMonthFreq);
							var lastQuarterFreq3 =  typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastQuarterFreq);
							var lastYearFreq3 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastYearFreq);
							var sinceRegiFreq3 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.sinceRegiFreq);
							var lastMonthCount3 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastMonthCount);
							var lastQuarterCount3 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastQuarterCount);
							var lastYearCount3 =  typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastYearCount);
							var sinceRegiCount3 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.sinceRegiCount);
							var lastMonthValue2 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastMonthValue);
							var lastQuarterValue2 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastQuarterValue);
							var lastYearValue2 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.lastYearValue);
							var sinceRegiValue2 = typeof(value.plrVipWagerRummy)=="undefined"?'':(value.plrVipWagerRummy.sinceRegiValue);
							$("#payTransactionvip").append("<tr><td>Login Freq</td><td>"+
									lastMonthFreq+"</td><td>"+lastQuarterFreq+"</td><td>"+lastYearFreq+"</td><td>"+sinceRegiFreq+"</td></tr><tr><td>Login Count</td><td>"+lastMonthCount+"</td><td>"+lastQuarterCount+"</td><td>"+lastYearCount+"</td><td>"+sinceRegiCount+"</td></tr><tr><td>Deposit Freq</td><td>"+lastMonthFreq1+"</td><td>"+lastQuarterFreq1+"</td><td>"+lastYearFreq1+"</td><td>"+sinceRegiFreq1+"</td></tr><tr><td>Deposit Count</td><td>"+lastMonthCount1+"</td><td>"+lastQuarterCount1+"</td><td>"+lastYearCount1+"</td><td>"+sinceRegiCount1+"</td></tr><tr><td>Deposit Value</td><td>"+lastMonthValue1+"</td><td>"+lastQuarterValue1+"</td><td>"+lastYearValue1+"</td><td>"+sinceRegiValue1+"</td></tr><tr><td>Withdrawal Freq</td><td>"+lastMonthFreq2+"</td><td>"+lastQuarterFreq2+"</td><td>"+lastYearFreq2+"</td><td>"+sinceRegiFreq2+"</td></tr><tr><td>Withdrawal Count</td><td>"+lastMonthCount2+"</td><td>"+lastQuarterCount2+"</td><td>"+lastYearCount2+"</td><td>"+sinceRegiCount2+"</td></tr><tr><td>Withdrawal Value</td><td>"+lastMonthValue1+"</td><td>"+lastQuarterValue1+"</td><td>"+lastYearValue1+"</td><td>"+sinceRegiValue1+"</td></tr><tr><td>WagerRummy Freq</td><td>"+lastMonthFreq3+"</td><td>"+lastQuarterFreq3+"</td><td>"+lastYearFreq3+"</td><td>"+sinceRegiFreq3+"</td></tr><tr><td>WagerRummy Count</td><td>"+lastMonthCount3+"</td><td>"+lastQuarterCount3+"</td><td>"+lastYearCount3+"</td><td>"+sinceRegiCount3+"</td></tr><tr><td>WagerRummy Value</td><td>"+lastMonthValue2+"</td><td>"+lastQuarterValue2+"</td><td>"+lastYearValue2+"</td><td>"+sinceRegiValue2+"</td></tr>");
							});
						 $("#vip_details").append("</table>");
					}
				else{
					$('#vip_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitVip").hide();});
			}
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	}); 
	 
	 var $accordions = $("#campaign").on('click', function() {
		 $("#campaign").off( "click" );
	  if( $("#campaign_details").children().size()<=1){
					_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_campaign_detail.action","playerId="+$("#detailPlayerId").val(),function(response){
        			hideLoader(response);        		
				if(response.length>0){					
						$('#campaign_details').append("<table  width='95%' cellspacing='0' cellpadding='0' id='campaignTable' align='center' style='margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px'>");
						$.each(response, function(i, value) {
							var count = i+1;
							var data=value.split("~");
							var param=data[0];
							var paramVal=data[1];	
							$("#campaignTable").append("<tr><td style='width: 215px;'>"+param+"</td><td>"+paramVal+"</td></tr>");
						});
						 $("#campaign_details").append("</table>");
					}
				else{
					$('#campaign_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitcampaign").hide();});
			}
	 
	
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	});
	
	
	 var $accordions = $("#notInUse").on('click', function() {
    activeAccordian = this;
    }).accordion({
			collapsible : true,
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true,
			heightStyle: "content"
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    
	}); 
	 
		var $accordions = $("#ticketDetails").on('click', function() {
	 		$( "#ticketDetails" ).off( "click" );
			if( $("#ticket_details").children().size()<=1){
				_ajaxCallJsonSynch("com/stpl/pms/action/bo/pm/bo_pm_plr_tickets.action","playerId="+$("#detailPlayerId").val()+"&domainId="+$("#domainId1").val()+"&aliasId="+$("#aliasId").val(),function(response){
    			hideLoader(response);
    			if(response.length>0){
					$('#ticket_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransaction' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Transaction Id</th><th>Game Id</th><th>Game Name</th><th>Game Type</th><th>Transaction Date</th><th>Amount</th><th>Status</th><th>Service Code</th><th>Ref Txn No</th><th>Wallet Provider</th></tr>");
					$.each(response, function(i, value) {
					var login = new Date(value.loginDate);
					var mm = (login.getMonth()+1)<10?"0"+ (login.getMonth()+1): (login.getMonth()+1);
					var dd = login.getDate()<10?"0"+login.getDate():login.getDate();
					var yy = login.getFullYear();
					var logout =typeof(value.logoutDate)=="undefined"?'':(new Date(value.logoutDate));
					var mm1 = logout ==''?'': (logout.getMonth()+1)<10?"0"+ (logout.getMonth()+1): (logout.getMonth()+1);
					var dd1 = logout ==''?'':logout.getDate()<10?"0"+logout.getDate():logout.getDate();
					var yy1 = logout ==''?'':logout.getFullYear();
					var logoutDate  = logout==''?'--':dd1+"/"+mm1+"/"+yy+" "+logout.toTimeString().split('G')[0];
					var count = i+1;
						$("#payTransaction").append("<tr><td>"+count+"</td><td>"+value.transactionId+"</td><td>"+value.gameId+"</td><td>"+value.gameName+"</td><td>"+value.gameType+"</td><td>"+value.transactionDate+"</td><td>"+value.amount+"</td><td>"+value.status+"</td><td>"+value.serviceCode+"</td><td>"+value.refTxnNo+"</td><td>"+value.walletProvider+"</td></tr>");
					});
					 $("#ticket_details").append("</table>");
				}
			else{
				$('#ticket_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
			}
			$("#waitTicket").fadeOut();});
			
		}
    	activeAccordian = this;
		}).accordion({
		collapsible : true,
		clearStyle : true,
		icons : {
		header : "plus",
		headerSelected : "minus"
		},
		active : true,
		heightStyle: "content"
		}).on('click', function(event, ui) {
    $accordions.not(activeAccordian).accordion('activate', false);
});
	
	$("#bonusDateWise").live('click', function() {
	var flag1 = 0;
	$("#fromBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
						$("#toBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
	if(flag1==0){
	$("#waitBonus").show();
		_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerBonusDetailFull.action","playerId="+$("#detailPlayerId").val()+"&fromDateBonus="+$("#fromBonusTrans").val()+"&toDateBonus="+$("#toBonusTrans").val(),function(response){
        			hideLoader(response);
		flag1=1;
		
		$("#bonus_details").empty();
					var fromDate = new Date(response[0]);
					var toDate = new Date(response[1]);
					$("#bonus_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromBonusTrans' name='fromBonusTrans' placeholder='From Date' readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toBonusTrans' name='toBonusTrans' placeholder='To Date'  readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Bonus Details' id='bonusDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
					$("#fromBonusTrans").val((fromDate.getDate() < 10 ? '0' + fromDate.getDate() : fromDate.getDate())+"/"+("0" + (fromDate.getMonth() + 1)).slice(-2)+"/"+fromDate.getFullYear()+" "+fromDate.toTimeString().split('G')[0]);
					$("#toBonusTrans").val((toDate.getDate() < 10 ? '0' + toDate.getDate() : toDate.getDate())+"/"+("0" + (toDate.getMonth() + 1)).slice(-2)+"/"+toDate.getFullYear()+" "+toDate.toTimeString().split('G')[0]);
					 $("#fromBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
						$("#toBonusTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
					 
					/*$('#bonus_details').append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromBonusTrans' name='fromBonusTrans' placeholder='From Date' value="+fromDate.toLocaleDateString()+"&nbsp;"+fromDate.toTimeString().split('G')[0]+" readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;' />");
					$('#bonus_details').append("To Date : <input type='text' id='toBonusTrans' name='toBonusTrans' placeholder='From Date' value="+toDate.toLocaleDateString()+"&nbsp;"+toDate.toTimeString().split('G')[0]+" readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'/>");
					$('#bonus_details').append("<input type='button'  class='button' value='View Bonus Details' id='bonusDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
					 */if(response[2].length>0){
				
							/* 	<input type="text" id="fromBonusTrans" name="fromBonusTrans" placeholder="From Date" value="<s:property value="%{plrDetailBean.plrresponses.get(0)}"/>" readonly="readonly" applyscript="true" />
						<input type="text" id="toBonusTrans" name="toBonusTrans" placeholder="To Date" value="<s:property value="%{plrDetailBean.plrresponses.get(1)}"/>" applyscript="true" readonly="readonly"/>
						<input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerresponse.action" ajaxParamPlr="txnPlayerId,toBonusTrans,fromBonusTrans" target="responseData" class="button" value="View Bonus Details" id="bonusDateWise" checked="true" style="margin: 5px 6px 5px 0 !important;" /> */
							$('#bonus_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactionbobnus' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Rec. Date</th><th>Exp. Date</th><th>Bonus Name</th><th>Bonus Criteria</th><th>Target</th><th>Contribution</th><th>Pending</th><th>Bonus Amount</th><th>To Cash</th><th>Status</th></tr>");
						for(i=0;i<response[2].length;i++){
						var count = i+1;
						var recDate = new Date(response[2][i].receivedDate);
						var mm = (recDate.getMonth() + 1)<10?"0"+(recDate.getMonth() + 1):(recDate.getMonth() + 1);
						var dd = recDate.getDate()<10?"0"+recDate.getDate():recDate.getDate();
						var yy = recDate.getFullYear();
						var expDate = new Date(response[2][i].expiredDate);
						var mm1 = (expDate.getMonth() + 1)<10?"0"+(expDate.getMonth() + 1):(expDate.getMonth() + 1);
						var dd1= expDate.getDate()<10?"0"+expDate.getDate():expDate.getDate();
						var yy1 = expDate.getFullYear();
						var wrTarget =  typeof(response[2][i].wrTarget)=="undefined"?0:(response[2][i].wrTarget);
						var pending = wrTarget==0?0:(wrTarget-response[2][i].wrContribution);
						pending = (pending< 0.01 && pending >0)?pending.toFixed(3):pending.toFixed(2);
						var contri = typeof(response[2][i].wrContribution)=="undefined"?0:(response[2][i].wrContribution < 0.01 && response[2][i].wrContribution<0)?(response[2][i].wrContribution).toFixed(3):(response[2][i].wrContribution).toFixed(2);
							$("#payTransactionbobnus").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+recDate.toTimeString().split('G')[0]+"</td><td>"+dd1+"/"+mm1+"/"+yy1+" "+expDate.toTimeString().split('G')[0]+"</td><td>"+(response[2][i].bonusCode)+"</td><td>"+(response[2][i].bonusCriteria)+"</td><td>"+wrTarget.toFixed(2)+"</td><td>"+contri+"</td><td>"+pending+"</td><td>"+((response[2][i].bonusAmt < 0.01 && response[2][i].bonusAmt >0)?(response[2][i].bonusAmt).toFixed(3):(response[2][i].bonusAmt).toFixed(2))+"</td><td>"+((response[2][i].redeemedBonusAmt<0.01 && response[2][i].redeemedBonusAmt >0)?(response[2][i].redeemedBonusAmt).toFixed(3):(response[2][i].redeemedBonusAmt).toFixed(2))+"</td><td>"+response[2][i].wrStatus+"</td></tr>");
						}
						 $("#bonus_details").append("</table>");
					}
					
				else{
					$('#bonus_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
				$("#waitBonus").hide();});
				}
	});
	
	
	
	
	
	$("#txnDateWise").live('click', function() {
	var flag2 = 0;
	$("#fromLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
			$("#toLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				maxDate : serverDateStr,
				maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
			});
	if(flag2==0){
	$("#waitTxn").show();
		_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnDetailFull.action","playerId="+$("#detailPlayerId").val()+"&fromDateTxn="+$("#fromLastTrans").val()+"&toDateTxn="+$("#toLastTrans").val(),function(response){
        			hideLoader(response);
		flag2=1;
		$("#lastTxn_details").empty();
		var fromDate = new Date(response[0]);
					var toDate = new Date(response[1]);
					$("#lastTxn_details").append("<span style='margin-left: 5px;'>From Date :  <input type='text' id='fromLastTrans' name='fromLastTrans' placeholder='From Date'  readonly='readonly' applyscript='true'style='margin: 10px 10px 5px 6px !important;'color: #696969;' />To Date : <input type='text' id='toLastTrans' name='toLastTrans' placeholder='To Date'  readonly='readonly' applyscript='true'  style='margin: 10px 10px 5px 6px !important;'color: #696969;'/><input type='button'  class='button' value='View Txn Details' id='txnDateWise' checked='true' style='margin: 10px 6px 5px 0 !important;'/></span>");
					$("#fromLastTrans").val(response[0]);
					$("#toLastTrans").val(response[1]);
					 $("#fromLastTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
						$("#toLastTrans").datetimepicker( {
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond: true,
							changeMonth : true,
							maxDate : serverDateStr,
							maxDateTime : $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						});
					 
					if(response.length>2){
						/*$('#lastTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactiontxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Particulars</th><th>Credit</th><th>Debit</th><th>Balance</th><th>Withdrawable Balance</th></tr>");*/
						$('#lastTxn_details').append("<table  width='100%' border='0' cellspacing='0' cellpadding='0' id='payTransactiontxn' align='center' class='payTransaction' style='color: #696969;'><tr><th>S.No</th><th>Date</th><th>Transaction Id</th><th>Particulars</th><th>Credit</th><th>Debit</th><th>Balance</th></tr>");
						for(i=0;i<response[2].length;i++){
						var count = i+1;
						var crAmt = typeof(response[2][i].creditAmount)=="undefined"?'':(response[2][i].creditAmount < 0.01 && response[2][i].creditAmount>0)?(response[2][i].creditAmount).toFixed(3):(response[2][i].creditAmount).toFixed(2);
						var dbAmt = typeof(response[2][i].debitAmount)=="undefined"?'':(response[2][i].debitAmount < 0.01 && response[2][i].debitAmount > 0)?(response[2][i].debitAmount).toFixed(3):(response[2][i].debitAmount).toFixed(2);
						var date = new Date(response[2][i].transactionDate);
						var mm = (date.getMonth() + 1)<10?"0"+(date.getMonth() + 1):(date.getMonth() + 1);
						var dd = date.getDate()<10?"0"+date.getDate():date.getDate();
						var yy = date.getFullYear();
						//var withBal = typeof(response[2][i].withdrawableBalance)=="undefined"?'':(response[2][i].withdrawableBalance <0.01 && response[2][i].withdrawableBalance>0)?(response[2][i].withdrawableBalance).toFixed(3):(response[2][i].withdrawableBalance).toFixed(2);
							$("#payTransactiontxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+(response[2][i].particular)+"</td><td>"+crAmt+"</td><td>"+dbAmt+"</td><td>"+(response[2][i].balance).toFixed(2)+"</td></tr>");
							/*$("#payTransactiontxn").append("<tr><td>"+count+"</td><td>"+dd+"/"+mm+"/"+yy+" "+date.toTimeString().split('G')[0]+"</td><td>"+response[2][i].transactionId+"</td><td>"+(response[2][i].particular)+"</td><td>"+crAmt+"</td><td>"+dbAmt+"</td><td>"+(response[2][i].balance).toFixed(2)+"</td><td>"+withBal+"</td></tr>");*/
						}
						 $("#lastTxn_details").append("</table>");
					}
				else{
					$('#lastTxn_details').append("<div class='innerBox'><div class='alert info_msg '><span class='alert_close'></span><strong>Msg: </strong>No Record Found.</div></div>");
				}
					$("#waitTxn").hide();});
			}
	 
	});
	});
	function hideLoader(_resp){$("#waitLogin").hide();
	return _resp;}
	
	function callGetRakeAmt(){
		$("#rakeDiv").append("<img src='images/loading16X16.gif'/>");
		_ajaxCallJsonSynch("com/stpl/pms/action/bo/reports/st_pms_bo_rep_rake_amt.action","playerId="+$("#detailPlayerId").val(),function(response){
		if(response!=null){
			$("#rakeDiv").html(response);
		}
		
		});
		return false;
		
	}
	 $('#inbox').hide();
	 $('#vip').hide();
	