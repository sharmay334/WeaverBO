var editor;
	$(document).ready(function() {
	$('#imgBtn').hide();
	var languageList = $.parseJSON($('#languageListJson').val());
	$('#domainVal').val($('#domainId').val());
       $('#playerIdArr').chosen('{}');
	//	var tempList = $.parseJSON($('#tempList').val());
		$('#emailTypemanually').attr("checked","true");
		$('#tempAvailable').attr("disabled", "true");
		$('[id*="int_ext_mailexternal"]').attr("disabled","true");
		$('[id*="int_ext_mailboth"]').attr("disabled","true");
		$('.emailType').click(function() {
				var value = $(this).val();
				if(value=="temp"){
					$('#contentDiv').hide();
					$('#contentDiv').val("");
					$('#tempAvailable').removeAttr("disabled");
					$('#subject').attr("disabled", "true");	
					$('#subject').val("");
					$('[id*="int_ext_mailexternal"]').removeAttr("disabled");
					$('[id*="int_ext_mailboth"]').removeAttr("disabled");
					$('#subject').attr('readonly', 'readonly');
				}else{
				$('#contentDiv').show();
				$('#tempAvailable').val('-1');
				$('#imgBtn').hide();
				//$('#templateType').val("");
					$('#tempAvailable').attr("disabled", "true");
					$('#imgBtn').hide();
					$('#subject').removeAttr("disabled");
					$('#subject').val("");
					$('[id*="int_ext_mailexternal"]').attr("disabled","true");
					$('[id*="int_ext_mailboth"]').attr("disabled","true");
					$('#subject').removeAttr('readonly');
				}
		});
		$('#tempAvailable').change(function(){
		$('#subject').val("");
			if($('#tempAvailable').val()!='-1'){
				//var tempType = $('#templateTypeList').val().split('#');
					//$('#templateType').val(tempType[0]);
	    		$('#subject').val($( "#tempAvailable option:selected" ).text());
				$('#subject').removeAttr("disabled");
				$('#imgBtn').show();
			}else{
				//$('#templateType').val("");
				$('#subject').attr("disabled", "true");	
				$('#subject').val("");
				$('#imgBtn').hide();
			}
		
		});
		$('#regalias').change(function(){
			if($('#regalias').val()!="-1"){
				var tempMap = _ajaxCallJson("com/stpl/pms/action/bo/pm/st_pms_bo_rep_fetchTemplateListOnAliasChange.action?domainId="+$('#domainId').val()+"&aliasId="+$('#regalias').val()+"&sentOn=BOTH","");
				$("#contentType").val(tempMap["contentType"]);
			}
			$('[id*="int_ext_mailexternal"]').prop("checked",false);
			$('[id*="int_ext_mailboth"]').prop("checked",false);
			$('[id*="int_ext_mailinternal"]').prop("checked",false);
			
			if($('#regalias').val()=="3"){
				$('#emailTypemanually').attr("disabled", true);
				$('#emailTypemanually').attr("checked",false);
			}else{
				$('#emailTypemanually').attr("disabled", false);				
			}
			
			if($("#contentType").val()!="PORTALCONTENT"){
				$('#contentDiv').hide();
				$('#contentDiv').val("");
				$('#tempAvailable').removeAttr("disabled");
				$('#subject').attr("disabled", "true");	
				$('#subject').val("");
				$('[id*="int_ext_mailexternal"]').removeAttr("disabled");
				$('[id*="int_ext_mailboth"]').removeAttr("disabled");
				$('#subject').attr('readonly', 'readonly');
				//$('#emailTypemanually').attr("disabled", true);
				//$('#emailTypemanually').attr("checked",false);
				$('#emailTypetemp').attr("checked",true);
			}
			else{
				$('#contentDiv').show();
				$('#tempAvailable').val('-1');
				$('#tempAvailable').attr("disabled", "true");
				$('#subject').removeAttr("disabled");
				$('#subject').val("");
				$('[id*="int_ext_mailexternal"]').attr("disabled","true");
				$('[id*="int_ext_mailboth"]').attr("disabled","true");
				$('#subject').removeAttr('readonly');
				$('#emailTypemanually').attr("disabled", false);
				$('#emailTypemanually').attr("checked",true);
				$('#emailTypetemp').attr("checked",false);
				$('#tempAvailable').attr("disabled", true);
				$('#imgBtn').hide();
			}
			if(tempMap["respMsg"]!=undefined){
				$('#tempAvailable').hide();
				$('#imgBtn').hide();
				$("#notemplate").text(tempMap["respMsg"]);
				$("#notemplate").show();
    	 	}else{
    	 		$("#notemplate").hide();
				$('#tempAvailable').show();
				$('#imgBtn').hide();
				$('#tempAvailable').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				if($("#contentType").val()=="PORTALCONTENT"){
					$.each(tempMap["tempList"],function(index, value) {
						$('#tempAvailable').append($('<option></option>').val(value.templateSubject).html(value.templateSubject));
				  	});
				}
			}
			});
		
		$('input:radio[name="plrEmailBean.int_ext_mail"]').change(
			    function(){
			    	if($('#regalias').val()=="-1"){
			    		alert("Please Select Alias First.");
			    		$("#int_ext_mailexternal").prop('checked', false);
			    		$("#int_ext_mailinternal").prop('checked', false);
			    		$("#int_ext_mailboth").prop('checked', false);
			    		$("#regalias").focus();
			    		return false;
			    	}else if($("#contentType").val()=="PORTALCONTENT")
			    		return false;
			        if ($(this).is(':checked') && $(this).val() == 'internal') {
					$('#imgBtn').hide();
			        	$('#tempAvailable').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			        	 var tempMap = _ajaxCallJson("com/stpl/pms/action/bo/pm/st_pms_bo_rep_fetchTemplateList.action?domainId="+$('#domainId').val()+"&aliasId="+$('#regalias').val()+"&sentOn=INTERNAL","");
			        	 	if(tempMap["respMsg"]!=undefined){
			        	 		$('#tempAvailable').hide();
							$('#imgBtn').hide();
								$("#notemplate").text(tempMap["respMsg"]);
								$("#notemplate").show();
			        	 	}else{
			        	 		$("#notemplate").hide();
								$('#tempAvailable').show();
								$('#imgBtn').hide();
			        	 		$.each(tempMap["tempList"],function(index, value) {
								//$('#tempAvailable').append($('<option></option>').val(value.id).html(value.subject));
								$('#tempAvailable').append($('<option></option>').val(value.url[0]+"#"+value.id).html(value.subject));
			        	 		});
			        	 	}
			        }
			        else  if ($(this).is(':checked') && $(this).val() == 'external') {
					$('#imgBtn').hide();
			        	$('#tempAvailable').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			        	var tempMap = _ajaxCallJson("com/stpl/pms/action/bo/pm/st_pms_bo_rep_fetchTemplateList.action?domainId="+$('#domainId').val()+"&aliasId="+$('#regalias').val()+"&sentOn=EXTERNAL","");
			        	if(tempMap["respMsg"]!=undefined){
		        	 		$('#tempAvailable').hide();
						$('#imgBtn').hide();
							$("#notemplate").text(tempMap["respMsg"]);
							$("#notemplate").show();
		        	 	}else{
		        	 		$("#notemplate").hide();
							$('#tempAvailable').show();
							$('#imgBtn').hide();
							$.each(tempMap["tempList"],function(index, value) {
								$('#tempAvailable').append($('<option></option>').val(value.url[0]+"#"+value.id+"#"+value.from).html(value.subject));
						  	});
		        	 	}
			        }
			        else  if ($(this).is(':checked') && $(this).val() == 'both') {
			        	$('#tempAvailable').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			        	var tempMap = _ajaxCallJson("com/stpl/pms/action/bo/pm/st_pms_bo_rep_fetchTemplateList.action?domainId="+$('#domainId').val()+"&aliasId="+$('#regalias').val()+"&sentOn=BOTH","");
			        	if(tempMap["respMsg"]!=undefined){
		        	 		$('#tempAvailable').hide();
						$('#imgBtn').hide();
							$("#notemplate").text(tempMap["respMsg"]);
							$("#notemplate").show();
		        	 	}else{
		        	 		$("#notemplate").hide();
							$('#tempAvailable').show();
							$('#imgBtn').hide();
							$.each(tempMap["tempList"],function(index, value) {
								$('#tempAvailable').append($('<option></option>').val(value.url[0]+"#"+value.id+"#"+value.from).html(value.subject));
						  	});
		        	 	}
			        }
			    });
		$('#submitBtn').click(function(){
			var check = true;
			if($('#playerIdArr').val()==null && !($("#sentToAll").is(':checked'))){
					alert("Please select atleast one player or send Mail checkbox.");
					check = false;
				}
			if(check && $('#regalias').val()=="-1"){
				alert("Please Select Alias.");
				check = false;
			}
			if(check && $("[id*=int_ext_mail]:checked").length == 0){
					alert("Please select one sent Type.");
					check = false;
			}
			if(check && $('#language').val()=="-1"){
				alert("Please Select Language.");
				check = false;
			}
			if(check && $('#subject').val().trim()==""){
				$('#subject').val("");
				alert("Please enter some subject.");
				check = false;
			}
			if(check && $("#sentToAll").is(':checked') &&  $('#reportDataType').val()==''){
				prepareCriFieldValue($(this));
			}
			if($("#contentType").val()=="JOOMLA"){
				$("#tempFrm").attr("action","/WeaverBO/com/stpl/pms/action/bo/pm/st_pms_inbox_saveTemplateContentJoomla.action");
			}else{
				$("#tempFrm").attr("action","/WeaverBO/com/stpl/pms/action/bo/pm/st_pms_inbox_saveTemplateContent.action");
			}
			return check;
	
		});
		
		$('#language').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					for ( var i = 0; i < languageList.length; i++) {
						$('#language').append($('<option></option>').val(languageList[i].languageBaseCode).html(languageList[i].languageName));
		}
       function prepareCriFieldValue(obj){
      					 var location=obj.parents('div[id*="facebox"]').siblings('div[id*=container]').children('div[id*=decoBody]');
						var isAffiliated =new Array();
						var depositer =new Array();
						var regIp = new Array();
						var isVerified = new Array();
						var status = new Array();
						var vipCriteria = new Array();
						var vipLevel = new Array();
						var gender = new Array();
						var pendBonus = new Array();
						var fromDob,toDob,fromRegDate,toRegDate,fromDepositDate,toDepositDate,fromWagerDate,toWagerDate,fromWinDate,toWinDate,fromDepDate,toDepDate,fromWitDate,toWitDate,fromLoginDate,toLoginDate,toFirstDepositDate,fromFirstDepositDate;
						location.find('[id*=isAffiliated]:checked').each(function(index){
							isAffiliated.push($(this).val());
						});
						location.find('[id*=depositer]:checked').each(function(index){
							depositer.push($(this).val());
						});
						location.find('[id*=isVerified]:checked').each(function(index){
							isVerified.push($(this).val());
						});
						location.find('[id*=status]:checked').each(function(index){
							status.push($(this).val());
						});
						location.find('[id*=gender]:checked').each(function(index){
							gender.push($(this).val());
						});
						location.find('[id*=pendBonus]:checked').each(function(index){
							pendBonus.push($(this).val());
						});
						location.find('[id*=vipLevel].search-choice').find(".search-choice-close").each(function(index){
							var index1 = $(this).attr('rel');
							location.find('#vipLevel > option').each(function(index){
								if(parseInt(index)==(parseInt(index1))){
									vipLevel.push($(this).val());
								}
							});
							
						});
						location.find('[id*=regIp]').each(function(index){
							regIp.push($(this).val());
						});
						location.find('#vipCriteriaTbl > tbody > tr')
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
									vipCriteria
											.push(new vipCriteriaListBean(
													vipSelCriteria,	viplastMonthMinCriteria,
													vipLastQuarterMinCriteria,vipLastYearMinCriteria,vipSinceRegiMinCriteria,viplastMonthMaxCriteria,
													vipLastQuarterMaxCriteria,vipLastYearMaxCriteria,vipSinceRegiMaxCriteria));
								});
								if(location.find('#fromDob').val()==""){
									 fromDob=null;
								}else{
									fromDob= location.find('#fromDob').val();
								}
								if(location.find('#toDob').val()==""){
									 toDob=null;
								}else{
									toDob= location.find('#toDob').val();
								}
								if(location.find('#fromRegDate').val()==""){
									 fromRegDate=null;
								}else{
									fromRegDate= location.find('#fromRegDate').val();
								}
								if(location.find('#toRegDate').val()==""){
									 toRegDate=null;
								}else{
									toRegDate= location.find('#toRegDate').val();
								}
								if(location.find('#fromWagerDate').val()==""){
									 fromWagerDate=null;
								}else{
									fromWagerDate= location.find('#fromWagerDate').val();
								}
								if(location.find('#toWagerDate').val()==""){
									 toWagerDate=null;
								}else{
									toWagerDate= location.find('#toWagerDate').val();
								}
								if(location.find('#fromWinDate').val()==""){
									 fromWinDate=null;
								}else{
									fromWinDate= location.find('#fromWinDate').val();
								}
								if(location.find('#toWinDate').val()==""){
									 toWinDate=null;
								}else{
									toWinDate= location.find('#toWinDate').val();
								}
								if(location.find('#fromDepDate').val()==""){
									 fromDepDate=null;
								}else{
									fromDepDate= location.find('#fromDepDate').val();
								}
								if(location.find('#toDepDate').val()==""){
									 toDepDate=null;
								}else{
									toDepDate= location.find('#toDepDate').val();
								}
								if(location.find('#fromWitDate').val()==""){
									 fromWitDate=null;
								}else{
									fromWitDate= location.find('#fromWitDate').val();
								}
								if(location.find('#toWitDate').val()==""){
									 toWitDate=null;
								}else{
									toWitDate= location.find('#toWitDate').val();
								}
								if(location.find('#fromLoginDate').val()==""){
									 fromLoginDate=null;
								}else{
									fromLoginDate= location.find('#fromLoginDate').val();
								}
								if(location.find('#toLoginDate').val()==""){
									 toLoginDate=null;
								}else{
									toLoginDate= location.find('#toLoginDate').val();
								}
								if(location.find('#fromFirstDepositDate').val()==""){
									 fromFirstDepositDate=null;
								}else{
									fromFirstDepositDate= location.find('#fromFirstDepositDate').val();
								}
								if(location.find('#toFirstDepositDate').val()==""){
									 toFirstDepositDate=null;
								}else{
									toFirstDepositDate= location.find('#toFirstDepositDate').val();
								}
								$('#searchedCriteria').val(JSON.stringify(new PlrSearchOptionBean(parseInt(location.find('select[id*=domainId]').val()),parseInt(location.find('select[id*=aliasId]').val()),location.find('#playerIdList').val(),location.find('#fname').val(),location.find('#lname').val(),location.find('#userName').val(),location.find('#email').val(),location.find('#mobile').val(),location.find('#plrTaxId').val(),gender,isAffiliated,depositer,fromDob,toDob,new Boolean(location.find('[id^=yearCheck]:checked').val()),
								regIp,fromRegDate,toRegDate,location.find('#countryId').val(),location.find('#state').val(),location.find('#city').val(),isVerified,status,fromWagerDate,toWagerDate,
										fromWinDate,toWinDate,fromDepDate,toDepDate,fromWitDate,toWitDate,fromLoginDate,toLoginDate,parseFloat(location.find('#minCashBal').val()),parseFloat(location.find('#maxCashBal').val()),location.find('#minBonBal').val(),location.find('#maxBonBal').val(),location.find('#minPraBal').val(),location.find('#maxPraBal').val(),location.find('#minTotBal').val(),location.find('#maxTotBal').val(),pendBonus,vipCriteria,
										location.find('#minBonRecAmount').val(),location.find('#maxBonRecAmount').val(),location.find('#minBonExpAmount').val(),location.find('#maxBonExpAmount').val(),location.find('#bonFromCash').val(),location.find('#bonToCash').val(),location.find('#minPenAmount').val(),
										location.find('#maxPenAmount').val(),parseFloat(location.find('#minWithdrawalAmount').val()),parseFloat(location.find('#maxWithdrawalAmount').val()),parseFloat(location.find('#minDepositAmount').val()),parseFloat(location.find('#maxDepositAmount').val()),parseFloat(location.find('#minWinningAmount').val()),
										parseFloat(location.find('#maxWinningAmount').val()),parseFloat(location.find('#minWagerAmount').val()),parseFloat(location.find('#maxWagerAmount').val()),parseFloat(location.find('#minBonusAmount').val()),parseFloat(location.find('#maxBonusAmount').val()),vipLevel,fromFirstDepositDate,toFirstDepositDate,location.find('#uploadedDoc').val(),location.find('#uniqueNo').val(),location.find('#referSourceType').val(),location.find('#referSource').val())));
					}
					
		function PlrSearchOptionBean(domainId,aliasId,playerIdList,fname,lname,userName,email,mobile,plrTaxId,gender,isAffiliated,depositer,fromDob,toDob,yearCheck,
				regIp,fromRegDate,toRegDate,countryId,state,city,isVerified,status,fromWagerDate,toWagerDate,
				fromWinDate,toWinDate,fromDepDate,toDepDate,fromWitDate,toWitDate,fromLoginDate,toLoginDate,minCashBal,maxCashBal,minBonBal,maxBonBal,minPraBal,maxPraBal,minTotBal,maxTotBal,pendBonus,vipCriteriaBean,minBonRecAmount,maxBonRecAmount,minBonExpAmount,maxBonExpAmount,bonFromCash,bonToCash,minPenAmount,maxPenAmount,minWithdrawalAmount,maxWithdrawalAmount,minDepositAmount,maxDepositAmount,minWinningAmount,maxWinningAmount,minWagerAmount,maxWagerAmount,minBonusAmount,maxBonusAmount,vipLevel,
				fromFirstDepositDate,toFirstDepositDate,uploadedDoc,uniqueNo,referSourceType,referSource){
			this.domainId =domainId;
			this.aliasId=aliasId;
			this.playerIdList=playerIdList;
			this.fname =fname;
			this.lname =lname;	
			this.userName =userName;
			this.isVerified =isVerified;
			this.vipLevel=vipLevel;
			this.countryId =countryId;
			this.city =city;
			this.stateId =state;
			this.email =email;
			this.mobile =mobile;
			this.fromDob =fromDob;
			this.toDob =toDob;
			this.fromRegDate =fromRegDate;
			this.toRegDate =toRegDate;
			this.isAffiliated =isAffiliated;
			this.vipCriteriaBean =vipCriteriaBean;
			this.plrTaxId =plrTaxId;
			this.gender =gender;
			this.fromWagerDate =fromWagerDate;
			this.toWagerDate =toWagerDate;
			this.fromWinDate =fromWinDate;
			this.toWinDate =toWinDate;
			this.fromDepDate =fromDepDate;
			this.toDepDate =toDepDate;
			this.fromWitDate =fromWitDate;
			this.toWitDate =toWitDate;
			this.minPraBal =minPraBal;
			this.maxPraBal =maxPraBal;
			this.minBonBal =minBonBal;
			this.maxBonBal =maxBonBal;
			this.minTotBal =minTotBal;
			this.maxTotBal =maxTotBal;
			this.bonFromCash=bonFromCash;
			this.bonToCash=bonToCash;
			this.pendBonus =pendBonus;
			this.minBonRecAmount =minBonRecAmount;
			this.maxBonRecAmount=maxBonRecAmount;
			this.minBonExpAmount = minBonExpAmount;
			this.maxBonExpAmount=maxBonExpAmount;
			this.minPenAmount=minPenAmount;
			this.maxPenAmount=maxPenAmount;
			this.fromLoginDate =fromLoginDate;
			this.toLoginDate =toLoginDate;
			this.status =status;
			this.minBonusAmount=minBonusAmount;
			this.maxBonusAmount=maxBonusAmount;
			this.minDepositAmount=minDepositAmount;
			this.maxDepositAmount=maxDepositAmount;
			this.minWagerAmount=minWagerAmount;
			this.maxWagerAmount=maxWagerAmount
			this.minWithdrawalAmount=minWithdrawalAmount;
			this.maxWithdrawalAmount=maxWithdrawalAmount;
			this.minWinningAmount=minWinningAmount;
			this.maxWinningAmount=maxWinningAmount;
			this.minCashBal =minCashBal;
			this.maxCashBal =maxCashBal;
			this.fromFirstDepositDate=fromFirstDepositDate;
			this.toFirstDepositDate=toFirstDepositDate;
			this.regIp =regIp;
			this.depositer =depositer;
			this.yearCheck =yearCheck;
			this.uniqueNo=uniqueNo;
			this.uploadedDoc=uploadedDoc;
			this.referSourceType=referSourceType;
			this.referSource=referSource;
			
		}
		
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
});
	
function openWindow(){
	
	window.open("http://"+$("#regalias option:selected").text()+$("#tempAvailable option:selected").val().split("#")[0]);
	return false;
	
} 	
	