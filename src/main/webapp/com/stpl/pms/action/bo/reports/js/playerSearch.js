var count = 6;
var bCount = 2;
var criteriaList;
var criSelectList;
var limit = 5;
var activityData;
var criteriaData;
var activityValueType;
var newId = 1;
var isValid = false;
var globalCheckList=new Array();
$(document)
		.ready(
				function() {
					
					var vipCriteriaMap = $.parseJSON($('#vipCriteriaListJson')
							.val());
					
					if ($('#currentUserType').val()!='DOMAIN') {
						$('#domainId').val($('#byDefaultDomainID').val());
					}
					
					$('#referSourceType').change(function(){
						if($('#domainId').val()!=-1)
							getReferSource($(this).val());
						
					});
					loadCountries($('#domainId').val());
					loadAliasName($('#domainId').val());
					$('#countryId').change(function(){
						getStates($('#countryId').val(),$('#domainId').val());
					});
					$('.more_filter').hide();
					$('#advanceSearch').click(function(){
						if($('.more_filter').css('display')=="block"){
						$('.more_filter').hide();
						$('a').each(function(){
							var classId = $(this).attr('class'); 
							var divId = $(this).closest('div').siblings('.'+classId);
							 $("."+classId+" div").each(function() {
						  			$("."+classId+" div input[type=text]").val("");
						  			$("."+classId+" div select").val("-1");
						  			if(classId=="plrVipCriteria"){
					  					$('.search-choice').remove();
					  					$('[id^=vipLevel_chzn_o_]').attr('class','active-result');
					  			}
									});
										$(divId).hide();
						});
						$(this).val("Show Filters");
						}else{
							$('.more_filter').show();
							$(this).val("Hide Filters");
						}
					});
					$('a').each(function(){
				var classId = $(this).attr('class'); 
				var divId = $(this).closest('div').siblings('.'+classId);
							$(divId).hide();
			});
			
			
			$("a").click(function() {
				var href = $(this).attr('href');
				if(href!='#'){
					return ;
				}
			var classId = $(this).attr('class'); 
			var id = $(this).attr('id');
			var divId = $(this).closest('div').siblings('.'+classId);
			 if($('.'+classId).css('display') == 'none') {
			 	$(divId).show('slow');
			 }else{
				 $("."+classId+" div").each(function() {
	  			$("."+classId+" div input[type=text]").val("");
	  			$("."+classId+" div select").val("-1");
	  			if(classId=="plrVipCriteria"){
	  					$('.search-choice').remove();
	  					$('[id^=vipLevel_chzn_o_]').attr('class','active-result');
	  			}
				});
			 	 $(divId).hide();
			 }
			 return false;
	 });
			
			$('#resetButton').click(function(){
				$('.search-choice').remove();
				$('.search-field').find('input').attr('class','default');
				$('.result-selected').attr('class','active-result');
				$("#plrSearchFrm").get(0).reset();
				$("#referSource").empty().append($(
				'<option></option>').val("-1").html(
						"----Please Select----"));
				$("#referSource").prop('selectedIndex', 0);
				$("#searchResult").hide();
				$("#disableFileds").show();
			});
			
			
	 $("#fromDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(dateText, inst) {
				$("#toDate").datetimepicker("option", "minDate", dateText);
			}
		});
		$("#toDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		//Last Transaction start
		
		
		$("#fromWagerDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toWagerDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toWagerDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromWagerDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		
		$("#fromWinDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toWinDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toWinDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromWinDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		
		$("#fromDepDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toDepDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toDepDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromDepDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		
		$("#fromWitDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toWitDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toWitDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromWitDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		$("#fromLoginDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			changeYear : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toLoginDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toLoginDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			changeYear : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromLoginDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		//Last transaction end
		
		// Bonus Details Calender start
		
		$("#toBonRecDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromBonRecDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		
		$("#fromBonRecDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toBonRecDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toBonExpDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromBonExpDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		$("#fromBonExpDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toBonExpDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		// Bonus Details Calender end
		
		
		var d = new Date();
		var year = d.getFullYear() - 18;
		d.setFullYear(year);
		$("#fromDob").datepicker( {
			dateFormat : 'dd/mm/yy',
			changeMonth : true,
			changeYear:true,
			yearRange:'1900:-18',
			 maxDate: new Date(year,d.getMonth(),d.getDate()),
			onClose : function(selectedDate) {
				$("#toDob").datetimepicker("option", "minDate",selectedDate);
			},
		});
		
		$("#toDob").datepicker( {
			dateFormat : 'dd/mm/yy',
			changeMonth : true,
			changeYear:true,
			yearRange:'1900:-18',
			 maxDate: new Date(year,d.getMonth(),d.getDate()),
			onClose : function(selectedDate) {
				$('#fromDob').datetimepicker("option", "maxDate",selectedDate);
			}
	
		});
		$("#loginFromDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#loginToDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#loginToDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#loginFromDate").datetimepicker("option", "maxDate", selectedDate);
			}
		});
		
		 $("#fromRegDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#toRegDate").datetimepicker("option", "minDate", selectedDate);
			}
		});
		$("#toRegDate").datetimepicker( {
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			changeMonth : true,
			numberOfMonths : 1,
			hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
			onClose : function(selectedDate) {
				$("#fromRegDate").datetimepicker("option", "maxDate", selectedDate);
			}
				});
		 $("#fromFirstDepositDate").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				maxDate : new Date(),
				onClose : function(selectedDate) {
					$("#toFirstDepositDate").datetimepicker("option", "minDate", selectedDate);
				}
			});
			$("#toFirstDepositDate").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				hour: 23,
				minute: 59,
				second: 59,
				maxDate : new Date(),
				onClose : function(selectedDate) {
					$("#fromFirstDepositDate").datetimepicker("option", "maxDate", selectedDate);
				}
					});
			
					
		$('#formSubmit').click(function(){
			 $('#paginationPage').val(0);
			 $('#recordPerPage').val(100);
			 $('#redirect').val("Search");
			 $("#searchResult").show();
			 globalCheckList=["playerId","fname","userName","pokerNickName","rummyNickName","email","mobile","regStatus","plrStatus","cashBalance","referSource","regDevice","depositReferSource","isPlay2x"];
		});
		
		$('#uploadedDoc').change(function(){
			
			var obj = $(this);
			if(obj.val()!='-1'){
				$('#uniqueNo').removeAttr('disabled');
			}else{
				$('#uniqueNo').attr('disabled','true');
				$('#uniqueNo').val("");
			}
			
		});		
		$('#playerIdList').click(function(){
				$("#disableFileds").hide();
		});
		 /*$('#regIp2').bind("paste", function(e) {$("domainId").val
			 e.preventDefault();
		});
		$('#regIp3').bind("paste", function(e) {
			e.preventDefault();
		});
		$('#regIp4').bind("paste", function(e) {
			e.preventDefault();
		});*/
		var intRegex = new RegExp("^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$");
		var intRegex1 = new RegExp("^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$");
		var intRegex2 = new RegExp("^(\\d{1,3})\\.(\\d{1,3})$");
		var intRegex3 = new RegExp("^(\\d{1,3})$");
		
					$('#regIp1').on(
							"paste",
							function() {
								var $this = $(this);
								var originalValue = $this.val();
								$this.val("");

								$this.one("input.fromPaste", function() {
									$currentInputBox = $(this);
									var pastedValue = $currentInputBox.val();
									if (pastedValue.length <= 15
											&& (intRegex.test(pastedValue) || intRegex1.test(pastedValue) || intRegex2.test(pastedValue) || intRegex3.test(pastedValue))
										) {
										pasteValues(pastedValue);
									} else {
										$this.val(originalValue);
									    alert("Enter valid Ip Address.");
									    $('#regIp1').focus();
									}

									$('#regIp1').attr("maxlength", 3);
								});
								$('#regIp1').attr("maxlength", 15);

							});
					function pasteValues(element) {
						$("#regIp1").val("");
						$("#regIp2").val("");
						$("#regIp3").val("");
						$("#regIp4").val("");
						var values = element.split(".");

						$(values).each(
								function(index) {
									var $inputBox = $('[id*="regIp'
											+ (index + 1) + '"]');
									$inputBox.val(values[index]);
								});
					};	
		
		
						
					
					$('#plrSearchFrm')
							.submit(
									function() {
										
										var vipCriteria = new Array();
										var bonusCriteriaBeanArray = new Array();
										 isValid = true;
										 var dob=true;
										 var emailPattren =new RegExp("^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$");
										 var ipPattern = new RegExp("^([01]?\\d\\d?|2[0-4]\\d|25[0-5])$");
										 if(isValid && $('#email').val()!="" && !emailPattren.test($('#email').val())){
											 alert("Enter valid Email Id.");
												isValid=false;
												$('#email').focus();
										 }
										 if(isValid && ($('#regIp1').val()!="" && !ipPattern.test($('#regIp1').val())) || ($('#regIp2').val()!="" && !ipPattern.test($('#regIp2').val() )) || ($('#regIp3').val()!="" && !ipPattern.test($('#regIp3').val() )) || ($('#regIp4').val()!="" && !ipPattern.test($('#regIp4').val()) )){
											 alert("Enter valid Ip Address.");
												isValid=false;
												$('#regIp1').focus();
										 }
										 if(isValid && ((parseFloat($('#minCashBal').val())>=0 && isNaN(parseFloat($('#maxCashBal').val()))) || (isNaN(parseFloat($('#minCashBal').val())) && parseFloat($('#maxCashBal').val())>=0) || (parseFloat($('#minCashBal').val())>parseFloat($('#maxCashBal').val())))){
												alert("Cash Balance must be in correct order(Min<Max)");
												isValid=false;
												$('#minCashBal').focus();
											}
										if(isValid && ((parseFloat($('#minPraBal').val())>=0 && isNaN(parseFloat($('#maxPraBal').val()))) || (isNaN(parseFloat($('#minPraBal').val())) && parseFloat($('#maxPraBal').val())>=0) || ( parseFloat($('#minPraBal').val())>parseFloat($('#maxPraBal').val())))){
											alert("Practice balance must be in correct order(Min<Max)");
											isValid=false;
											$('#minPraBal').focus();
											
										}
										if(isValid && ((parseFloat($('#minBonBal').val())>=0 && isNaN(parseFloat($('#maxBonBal').val()))) || (isNaN(parseFloat($('#minBonBal').val())) && parseFloat($('#maxBonBal').val())>=0) || (parseFloat($('#minBonBal').val())>parseFloat($('#maxBonBal').val())))){
											alert("Bonus balance must be in correct order(Min<Max)");
											isValid=false;
											$('#minBonBal').focus();
										}
										if(isValid && ((parseFloat($('#minTotBal').val())>=0 && isNaN(parseFloat($('#maxTotBal').val()))) || (isNaN(parseFloat($('#minTotBal').val())) && parseFloat($('#maxTotBal').val())>=0) || (parseFloat($('#minTotBal').val())>parseFloat($('#maxTotBal').val())))){
											alert("Total balance must be in correct order(Min<Max)");
											isValid=false;
											$('#minTotBal').focus();
										}
										if(isValid && ((parseFloat($('#minBonRecAmount').val())>=0 && isNaN(parseFloat($('#maxBonRecAmount').val()))) || (isNaN(parseFloat($('#minBonRecAmount').val())) && parseFloat($('#maxBonRecAmount').val())>=0) || (parseFloat($('#minBonRecAmount').val())>parseFloat($('#maxBonRecAmount').val())))){
											alert("Bonus Received Amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minBonRecAmount').focus();
										}
										if(isValid && ((parseFloat($('#minBonExpAmount').val())>=0 && isNaN(parseFloat($('#maxBonExpAmount').val()))) || (isNaN(parseFloat($('#minBonExpAmount').val())) && parseFloat($('#maxBonExpAmount').val())>=0) || ( parseFloat($('#minBonExpAmount').val())>parseFloat($('#maxBonExpAmount').val())))){
											alert("Bonus Expire must be in correct order(Min<Max)");
											isValid=false;
											$('#minBonExpAmount').focus();
										}
										if(isValid && ((parseFloat($('#bonFromCash').val())>=0 && isNaN(parseFloat($('#bonToCash').val()))) || (isNaN(parseFloat($('#bonFromCash').val())) && parseFloat($('#bonToCash').val())>=0) || ( parseFloat($('#bonFromCash').val())>parseFloat($('#bonToCash').val())))){
											alert("To cash must be in correct order(Min<Max)");
											isValid=false;
											$('#bonFromCash').focus();
										}
										if(isValid && ((parseFloat($('#minPenAmount').val())>=0 && isNaN(parseFloat($('#maxPenAmount').val()))) || (isNaN(parseFloat($('#minPenAmount').val())) && parseFloat($('#maxPenAmount').val())>=0) || (parseFloat($('#minPenAmount').val())>parseFloat($('#maxPenAmount').val())))){
											alert("Pending Amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minPenAmount').focus();
										}
										if((isValid && $('#fromDepositDate').val()!="" && $('#toDepositDate').val()=="") || (isValid && $('#fromDepositDate').val()=="" && $('#toDepositDate').val()!="") ){
											alert("Fill First Deposit from and to date.");
											isValid=false;
											$('#fromDob').focus();
										}
										if((isValid && $('#fromDob').val()!="" && $('#toDob').val()=="") || (isValid && $('#fromDob').val()=="" && $('#toDob').val()!="") ){
											alert("Fill DOB from and to date.");
											isValid=false;
											dob = false;
											$('#fromDob').focus();
										}
										if((isValid && $('#fromRegDate').val()!="" && $('#toRegDate').val()=="") || (isValid && $('#fromRegDate').val()=="" && $('#toRegDate').val()!="") ){
											alert("Fill Reg. from and to date.");
											isValid=false;
											$('#fromRegDate').focus();
										}
										if((isValid && $('#fromWagerDate').val()!="" && $('#toWagerDate').val()=="") || (isValid && $('#fromWagerDate').val()=="" && $('#toWagerDate').val()!="") ){
											alert("Fill Wager from and to date.");
											isValid=false;
											$('#fromWagerDate').focus();
										}
										if((isValid && $('#fromWinDate').val()!="" && $('#toWinDate').val()=="") || (isValid && $('#fromWinDate').val()=="" && $('#toWinDate').val()!="") ){
											alert("Fill Winning from and to date.");
											isValid=false;
											$('#fromWinDate').focus();
										}
										if((isValid && $('#fromDepDate').val()!="" && $('#toDepDate').val()=="") || (isValid && $('#fromDepDate').val()=="" && $('#toDepDate').val()!="") ){
											alert("Fill Deposit from and to date.");
											isValid=false;
											$('#fromDepDate').focus();
										}
										if((isValid && $('#fromWitDate').val()!="" && $('#toWitDate').val()=="") || (isValid && $('#fromWitDate').val()=="" && $('#toWitDate').val()!="") ){
											alert("Fill Withdrawal from and to date.");
											isValid=false;
											$('#fromWitDate').focus();
										}
										if((isValid && $('#fromLoginDate').val()!="" && $('#toLoginDate').val()=="") || (isValid && $('#fromLoginDate').val()=="" && $('#toLoginDate').val()!="") ){
											alert("Fill Last Login from and to date.");
											isValid=false;
											$('#fromLoginDate').focus();
										}
										if(isValid && ((parseFloat($('#minWithdrawalAmount').val())>=0 && isNaN(parseFloat($('#maxWithdrawalAmount').val()))) || (isNaN(parseFloat($('#minWithdrawalAmount').val())) && parseFloat($('#maxWithdrawalAmount').val())>=0) || (parseFloat($('#minWithdrawalAmount').val())>parseFloat($('#maxWithdrawalAmount').val())))){
											alert("Withdrawal Amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minWithdrawalAmount').focus();
										}
										if(isValid && ((parseFloat($('#minWinningAmount').val())>=0 && isNaN(parseFloat($('#maxWinningAmount').val()))) || (isNaN(parseFloat($('#minWinningAmount').val())) && parseFloat($('#maxWinningAmount').val())>=0) || (parseFloat($('#minWinningAmount').val())>parseFloat($('#maxWinningAmount').val())))){
											alert("Winning amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minWinningAmount').focus();
										}
										if(isValid && ((parseFloat($('#minBonusAmount').val())>=0 && isNaN(parseFloat($('#maxBonusAmount').val()))) || (isNaN(parseFloat($('#minBonusAmount').val())) && parseFloat($('#maxBonusAmount').val())>=0) || (parseFloat($('#minBonusAmount').val())>parseFloat($('#maxBonusAmount').val())))){
											alert("Bonus must be in correct order(Min<Max)");
											isValid=false;
											$('#minBonusAmount').focus();
										}
										if(isValid && ((parseFloat($('#minDepositAmount').val())>=0 && isNaN(parseFloat($('#maxDepositAmount').val()))) || (isNaN(parseFloat($('#minDepositAmount').val())) && parseFloat($('#maxDepositAmount').val())>=0) || (parseFloat($('#minDepositAmount').val())>parseFloat($('#maxDepositAmount').val())))){
											alert("Deposit Amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minDepositAmount').focus();
										}
										if(isValid && ((parseFloat($('#minWagerAmount').val())>=0 && isNaN(parseFloat($('#maxWagerAmount').val()))) || (isNaN(parseFloat($('#minWagerAmount').val())) && parseFloat($('#maxWagerAmount').val())>=0) || (parseFloat($('#minWagerAmount').val())>parseFloat($('#maxWagerAmount').val())))){
											alert("Wager Amount must be in correct order(Min<Max)");
											isValid=false;
											$('#minWagerAmount').focus();
										}
										$('#vipCriteriaTbl > tbody > tr')
												.each(
														function(index) {
															var $row = $(this);
															var vipSelCriteria = $row
																	.find(
																			'[id*=criteria_]')
																	.html();
														
															var viplastMonthMinCriteria = $row
																	.find(
																			'[id*=lastMonth_min_]')
																	.val();
															var viplastMonthMaxCriteria = $row
															.find(
																	'[id*=lastMonth_max_]')
															.val();
															
															
															var vipLastQuarterMinCriteria = $row
																	.find(
																			'[id*=lastQuarter_min_]')
																	.val();
															var vipLastQuarterMaxCriteria = $row
															.find(
																	'[id*=lastQuarter_max_]')
															.val();
															var vipLastYearMinCriteria = $row
															.find(
																	'[id*=lastYear_min_]')
															.val();
															var vipLastYearMaxCriteria = $row
															.find(
																	'[id*=lastYear_max_]')
															.val();
															var vipSinceRegiMinCriteria = $row
															.find(
																	'[id*=sinceRegi_min_]')
															.val();
															var vipSinceRegiMaxCriteria = $row
															.find(
																	'[id*=sinceRegi_max_]')
															.val();
															if(viplastMonthMinCriteria==""){
																viplastMonthMinCriteria=0.00;
															}
															if(vipLastQuarterMinCriteria==""){
																vipLastQuarterMinCriteria=0.00;
															}
															if(vipLastYearMinCriteria==""){
																vipLastYearMinCriteria=0.00;
															}
															if(vipSinceRegiMinCriteria==""){
																vipSinceRegiMinCriteria=0.00;
															}
															if(viplastMonthMaxCriteria==""){
																viplastMonthMaxCriteria=0.00;
															}
															if(vipLastQuarterMaxCriteria==""){
																vipLastQuarterMaxCriteria=0.00;
															}
															if(vipLastYearMaxCriteria==""){
																vipLastYearMaxCriteria=0.00;
															}
															if(vipSinceRegiMaxCriteria==""){
																vipSinceRegiMaxCriteria=0.00;
															}
															if((viplastMonthMinCriteria>viplastMonthMaxCriteria) || (vipLastQuarterMinCriteria>vipLastQuarterMaxCriteria) || (vipLastYearMinCriteria>vipLastYearMaxCriteria) || (vipSinceRegiMinCriteria>vipSinceRegiMaxCriteria)){
																alert("Vip Criteria Value must be in correct order(Min<Max).");
																isValid=false;
															}
															
															vipCriteria
																	.push(new vipCriteriaListBean(
																			vipSelCriteria,	viplastMonthMinCriteria,
																			vipLastQuarterMinCriteria,vipLastYearMinCriteria,vipSinceRegiMinCriteria,viplastMonthMaxCriteria,
																			vipLastQuarterMaxCriteria,vipLastYearMaxCriteria,vipSinceRegiMaxCriteria));
														});
										
										if (isValid) {
											$('#vipCriteriaBean')
													.val(
															JSON
																	.stringify(vipCriteria));
										}
										// Bonus End
										if(dob && $('#fromDob').val()!=""){
										$('#fromDob').val($('#fromDob').val()+" 00:00:00");
										}
										if(dob && $('#toDob').val()!=""){
										$('#toDob').val($('#toDob').val()+" 00:00:00");
										}
										if($('#redirect').val()!="Excel"){
										if(isValid){
											$('#waitDiv').show();
											$('#formSubmit').hide();
											
											var form = $(this).closest("form");
											$.ajax( {
												type : "POST",
												url : form.attr('action'),
												data : form.serialize(),
												async : true,
												success : function(result) {
													$('#searchResult' ).html(result);
													$('#formSubmit').show();
													$('#waitDiv').hide();
												}
											});
											$('#fromDob').val($('#fromDob').val().split(" ")[0]);
											$('#toDob').val($('#toDob').val().split(" ")[0]);
											
											return false;
										}
										}
										/*else
										{
											var form = $(this).closest("form");
											$.ajax( {
												type : "POST",
												url : 'com/stpl/pms/action/bo/reports/st_pms_bo_rep_downloadplayerSearchRep.action',
												data : form.serialize(),
												async : true,
												success : function(result) {
													$('#searchResult' ).html(result);
													$('#Image_loading').css("display","none");
												}
											});
										}*/
										return isValid;
										
									});
					
					
					
					function vipCriteriaListBean(
							vipSelCriteria,
							viplastMonthMinCriteria,
							vipLastQuarterMinCriteria,vipLastYearMinCriteria,vipSinceRegiMinCriteria,viplastMonthMaxCriteria,
							vipLastQuarterMaxCriteria,vipLastYearMaxCriteria,vipSinceRegiMaxCriteria) {
						this.vipSelCriteria = vipSelCriteria;
						this.viplastMonthMinCriteria = viplastMonthMinCriteria;
						this.vipLastQuarterMinCriteria = vipLastQuarterMinCriteria;
						this.vipLastYearMinCriteria = vipLastYearMinCriteria;
						this.vipSinceRegiMinCriteria = vipSinceRegiMinCriteria;
						this.viplastMonthMaxCriteria = viplastMonthMaxCriteria;
						this.vipLastQuarterMaxCriteria = vipLastQuarterMaxCriteria;
						this.vipLastYearMaxCriteria = vipLastYearMaxCriteria;
						this.vipSinceRegiMaxCriteria = vipSinceRegiMaxCriteria;
					}
					
					
					$('#regStatus').chosen('{}');
					$('#varStatus').chosen('{}');
					
					
					$('#domainId')
							.change(
									function() {
										if($("#domainId").val()=="-1"){
											loadAliasName($(this).val());
											$('#aliasId').attr('disabled','true');
										}
										else{
											$('#aliasId').removeAttr('disabled');
											$("#aliasId").html("");
											loadAliasName($(this).val());
										}
										$("#referSourceType").prop('selectedIndex', 0);
										$("#referSource").html("");
										$("#referSource").append($(
										'<option></option>').val("-1").html(
												"----Please Select----"));
										$("#referSource").prop('selectedIndex', 0);
										
										
										var jsonList = '["referSourceList"]';
										var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_referSourceList.action?domainId="
												+ $('#domainId').val() + "&alias="+$("#aliasId").val()+"&jsonList=" + jsonList,"");
										//var referSourceMap =  JSON.parse(jsonmap["referSourceList"]);
										
										
										
										
										$('#referSourceMap').val(jsonmap["referSourceList"]);
										
										
										
										$('#searchResult').html("");
										$('#vipLevel_chzn').remove();
										$('#countryId_chzn').remove();
										$('#countryId').empty().removeClass('chzn-done').show();
										$('#vipLevel').empty().removeClass('chzn-done').show();
										loadCountries($(this).val());
										
									});
					
					$('#aliasId')
					.change(
							function() {
								$("#referSourceType").prop('selectedIndex', 0);
								$("#referSource").html("");
								$("#referSource").append($(
								'<option></option>').val("-1").html(
										"----Please Select----"));
								$("#referSource").prop('selectedIndex', 0);
								
								
								var jsonList = '["referSourceList"]';
								var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_referSourceList.action?domainId="
										+ $('#domainId').val() + "&alias="+$("#aliasId").val()+"&jsonList=" + jsonList,"");
								//var referSourceMap =  JSON.parse(jsonmap["referSourceList"]);
								
								
								
								
								$('#referSourceMap').val(jsonmap["referSourceList"]);
							});
					
					$("#addCriteria")
							.click(
									function() {
										vipCriteriaMap = $.parseJSON($(
												'#vipCriteriaListJson').val());
										criSelectList = $('<select><option value="-1">--Please Select--</option></select>');
										$.each(vipCriteriaMap,function(code, crit) {criSelectList
																	.append($('<option></option>').val(
																					crit.relatedTo+ '_'+ crit.relatedColumn).html(crit.criteriaName));
										});

										var criTblBody = $('#vipCriteriaTbl tbody');
										criTblBody
												.append($('<tr>'
														+ ' <td><select id="vipCriteria_'
														+ count
														+ '" class="select1" ></select></td>'
														+ '<td><input type="text" maxlength="5" style="height: 20px;"  pattern="^[0-9]*$" errorMassage="Please enter Numeric value." id="criMinVal_'
														+ count
														+ '" '
														+ '">  </td> <td><input type="text" maxlength="5" style="height: 20px;" pattern="^[0-9]*$" errorMassage="Please enter Numeric value." id="criMaxVal_'
														+ count + '" '
														+ '">  </td>'
														+ ' </tr>'));

										$('#vipCriteria_' + count).append(
												criSelectList.html());
										count++;
									});
					
					function loadAliasName(domainId){
						var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
						$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						$.each(aliasMap,function(index, value) {
							$('#aliasId').append($('<option></option>').val(index).html(value));
					  	});
					}
					function loadCountries(domainId){
						
						var selectedDomain=domainId; 							
						
						if (domainId == '-1') {
							$('#countryId').empty().append($(
													'<option></option>').val("-1").html(
															"----Please Select----"));
							$('#currencyList').empty().append($(
													'<option></option>').val("-1").html(
															"----Please Select----"));
							$('#vipLevel').empty().append($(
													'<option></option>').val("-1").html(
															"----Please Select----"));
							$('#state').empty().append($(
											'<option></option>').val("-1").html(
													"----Please Select----"));
							
						} else {
							var jsonList = '["countryList","currencyList","vipList"]';
							var jsonMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
							$('#countryId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
							
							$.each(jsonMap["countryList"],function(index,
													value) {$('#countryId').append($(
																		'<option></option>').val(value.countryId).html(value.name));
							$('#state').empty().append($(
											'<option></option>').val("-1").html(
													"----Please Select----"));
							});
							$.each(jsonMap["currencyList"],function(index,value) {$('#currencyList')
														.append($('<option></option>').val(
																				value.currencyId).html(value.currName));
							});
							
							$.each(jsonMap["vipList"],function(index,value) {$('#vipLevel')
														.append($('<option></option>').val(
																				value.vipLevel).html(value.vipCode));
							});
							$('#vipLevel').chosen('{}');
							}
							$('#vipLevel').chosen('{}');
					
				 }
					
					function getStates(countryId, domainId) {
						if(countryId=='-1'){
						 $('#state').html('');
							$('#state').append($('<option></option>').val(
															"-1").html("---Please Select---"));
															return;
						}
						var jsonList = '["stateList"]';
						var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList+"&countryId="+countryId,"");

						 $('#state').html('');
						 $('#state').append($('<option></option>').val(
													"-1").html("---Please Select---"));
						$.each(jsonmap["stateList"], function(index, value) {
							$('#state').append(
									$('<option></option>').val(
											value.stateId).html(value.name));
						});

						return;
					}
					
					function getReferSource(referSourceType){
						
						
						if(referSourceType=="OLA"){
							$('#referSource').html('');
							 $('#referSource').append($('<option></option>').val(
														"-1").html("---Please Select---"));
							 $('#referSource').append($('<option></option>').val(
								"1").html("OLA"));
						}else if(referSourceType=="REFER_FRIEND"){
							$('#referSource').html('');
							 $('#referSource').append($('<option></option>').val(
														"-1").html("---Please Select---"));
							 $('#referSource').append($('<option></option>').val(
								"-1").html("Friend"));
						}else if(referSourceType=="AFFILIATE"){
							$('#referSource').html('');
							 $('#referSource').append($('<option></option>').val(
														"-1").html("---Please Select---"));
							 $('#referSource').append($('<option></option>').val(
								"1").html("ZAPAK"));
						}else if(referSourceType=="PPC"){
						
						var referSourceMap =  $.parseJSON($('#referSourceMap').val());
						if(referSourceType!="-1"){
							$('#referSource').html('');
							$('#referSource').append($('<option></option>').val(
							"-1").html("---Please Select---"));
						$.each(referSourceMap, function(index1, value1) {
							if (index1 == referSourceType) {
								 
								 $.each(value1, function(index2, value2) {
									 $('#referSource').append($('<option></option>').val(
											 index2).html(value2));
								 });
								
							}
						});
						}
						}else{
							$('#referSource').html('');
							 $('#referSource').append($('<option></option>').val(
														"-1").html("---No Option---"));
						}
					}
					$('#reportToExcel').click(function(){
							$('#redirect').val('Excel');
							$('#plrSearchFrm').submit();
					});
					
				});

 
