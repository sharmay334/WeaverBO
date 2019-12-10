<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script type="text/javascript">
	$(function() {
		$('#playerIdArr').chosen('{}');
		
		$('.checkAppOs').click(function() {
			$('#verSelect' + this.value).toggle();
			$('#verSelect' + this.value + " select").prop('disabled',function(i, v) {return !v;});
		});
		
		$('#pushAppFrm').submit(function() {
			if ($('#playerIdArr').val() == null && !($("#selectAll").is(':checked'))) {
				alert("Please select atleast one player.");
				return false;
			}		
			var verArr=$("input.checkAppOs:checked");
			if(verArr.length==0){
				alert("Please select atleast one app version.");
				return false;
			}
			for (i = 0; i < verArr.length; i++) {
				if($("#verSelect"+verArr[i].value+ " select").val()==-1) {
					alert("Please select "+$(verArr[i]).attr("data")+ " Version");
					return false;
				}
			}		
			if ($("#selectAll").is(':checked')){ 
				prepareCriFieldValue($(this));
			}
		});
	});

	function prepareCriFieldValue(obj) {
		var location = obj.parents('div[id*="facebox"]').siblings(
				'div[id*=container]').children('div[id*=decoBody]');
		var isAffiliated = new Array();
		var depositer = new Array();
		var regIp = new Array();
		var isVerified = new Array();
		var status = new Array();
		var vipCriteria = new Array();
		var vipLevel = new Array();
		var gender = new Array();
		var pendBonus = new Array();
		var fromDob, toDob, fromRegDate, toRegDate, fromDepositDate, toDepositDate, fromWagerDate, toWagerDate, fromWinDate, toWinDate, fromDepDate, toDepDate, fromWitDate, toWitDate, fromLoginDate, toLoginDate, toFirstDepositDate, fromFirstDepositDate;
		location.find('[id*=isAffiliated]:checked').each(function(index) {
			isAffiliated.push($(this).val());
		});
		location.find('[id*=depositer]:checked').each(function(index) {
			depositer.push($(this).val());
		});
		location.find('[id*=isVerified]:checked').each(function(index) {
			isVerified.push($(this).val());
		});
		location.find('[id*=status]:checked').each(function(index) {
			status.push($(this).val());
		});
		location.find('[id*=gender]:checked').each(function(index) {
			gender.push($(this).val());
		});
		location.find('[id*=pendBonus]:checked').each(function(index) {
			pendBonus.push($(this).val());
		});
		location.find('[id*=vipLevel].search-choice').find(
				".search-choice-close").each(function(index) {
			var index1 = $(this).attr('rel');
			location.find('#vipLevel > option').each(function(index) {
				if (parseInt(index) == (parseInt(index1))) {
					vipLevel.push($(this).val());
				}
			});

		});
		location.find('[id*=regIp]').each(function(index) {
			regIp.push($(this).val());
		});
		location.find('#vipCriteriaTbl > tbody > tr').each(
				function(index) {
					var $row = $(this);
					var vipSelCriteria = $row.find('[id*=criteria_]').html();

					var viplastMonthMinCriteria = $row.find(
							'[id*=lastMonth_min_]').val();
					var viplastMonthMaxCriteria = $row.find(
							'[id*=lastMonth_max_]').val();

					var vipLastQuarterMinCriteria = $row.find(
							'[id*=lastQuarter_min_]').val();
					var vipLastQuarterMaxCriteria = $row.find(
							'[id*=lastQuarter_max_]').val();
					var vipLastYearMinCriteria = $row.find(
							'[id*=lastYear_min_]').val();
					var vipLastYearMaxCriteria = $row.find(
							'[id*=lastYear_max_]').val();
					var vipSinceRegiMinCriteria = $row.find(
							'[id*=sinceRegi_min_]').val();
					var vipSinceRegiMaxCriteria = $row.find(
							'[id*=sinceRegi_max_]').val();
					if (viplastMonthMinCriteria == "") {
						viplastMonthMinCriteria = 0.00;
					}
					if (vipLastQuarterMinCriteria == "") {
						vipLastQuarterMinCriteria = 0.00;
					}
					if (vipLastYearMinCriteria == "") {
						vipLastYearMinCriteria = 0.00;
					}
					if (vipSinceRegiMinCriteria == "") {
						vipSinceRegiMinCriteria = 0.00;
					}
					if (viplastMonthMaxCriteria == "") {
						viplastMonthMaxCriteria = 0.00;
					}
					if (vipLastQuarterMaxCriteria == "") {
						vipLastQuarterMaxCriteria = 0.00;
					}
					if (vipLastYearMaxCriteria == "") {
						vipLastYearMaxCriteria = 0.00;
					}
					if (vipSinceRegiMaxCriteria == "") {
						vipSinceRegiMaxCriteria = 0.00;
					}
					vipCriteria.push(new vipCriteriaListBean(vipSelCriteria,
							viplastMonthMinCriteria, vipLastQuarterMinCriteria,
							vipLastYearMinCriteria, vipSinceRegiMinCriteria,
							viplastMonthMaxCriteria, vipLastQuarterMaxCriteria,
							vipLastYearMaxCriteria, vipSinceRegiMaxCriteria));
				});
		if (location.find('#fromDob').val() == "") {
			fromDob = null;
		} else {
			fromDob = location.find('#fromDob').val();
		}
		if (location.find('#toDob').val() == "") {
			toDob = null;
		} else {
			toDob = location.find('#toDob').val();
		}
		if (location.find('#fromRegDate').val() == "") {
			fromRegDate = null;
		} else {
			fromRegDate = location.find('#fromRegDate').val();
		}
		if (location.find('#toRegDate').val() == "") {
			toRegDate = null;
		} else {
			toRegDate = location.find('#toRegDate').val();
		}
		if (location.find('#fromWagerDate').val() == "") {
			fromWagerDate = null;
		} else {
			fromWagerDate = location.find('#fromWagerDate').val();
		}
		if (location.find('#toWagerDate').val() == "") {
			toWagerDate = null;
		} else {
			toWagerDate = location.find('#toWagerDate').val();
		}
		if (location.find('#fromWinDate').val() == "") {
			fromWinDate = null;
		} else {
			fromWinDate = location.find('#fromWinDate').val();
		}
		if (location.find('#toWinDate').val() == "") {
			toWinDate = null;
		} else {
			toWinDate = location.find('#toWinDate').val();
		}
		if (location.find('#fromDepDate').val() == "") {
			fromDepDate = null;
		} else {
			fromDepDate = location.find('#fromDepDate').val();
		}
		if (location.find('#toDepDate').val() == "") {
			toDepDate = null;
		} else {
			toDepDate = location.find('#toDepDate').val();
		}
		if (location.find('#fromWitDate').val() == "") {
			fromWitDate = null;
		} else {
			fromWitDate = location.find('#fromWitDate').val();
		}
		if (location.find('#toWitDate').val() == "") {
			toWitDate = null;
		} else {
			toWitDate = location.find('#toWitDate').val();
		}
		if (location.find('#fromLoginDate').val() == "") {
			fromLoginDate = null;
		} else {
			fromLoginDate = location.find('#fromLoginDate').val();
		}
		if (location.find('#toLoginDate').val() == "") {
			toLoginDate = null;
		} else {
			toLoginDate = location.find('#toLoginDate').val();
		}
		if (location.find('#fromFirstDepositDate').val() == "") {
			fromFirstDepositDate = null;
		} else {
			fromFirstDepositDate = location.find('#fromFirstDepositDate').val();
		}
		if (location.find('#toFirstDepositDate').val() == "") {
			toFirstDepositDate = null;
		} else {
			toFirstDepositDate = location.find('#toFirstDepositDate').val();
		}
		$('#searchedCriteria').val(
				JSON
						.stringify(new PlrSearchOptionBean(parseInt(location
								.find('select[id*=domainId]').val()),
								parseInt(location.find('select[id*=aliasId]')
										.val()), location.find('#playerIdList')
										.val(), location.find('#fname').val(),
								location.find('#lname').val(), location.find(
										'#userName').val(), location.find(
										'#email').val(), location.find(
										'#mobile').val(), location.find(
										'#plrTaxId').val(), gender,
								isAffiliated, depositer, fromDob, toDob,
								new Boolean(location.find(
										'[id^=yearCheck]:checked').val()),
								regIp, fromRegDate, toRegDate, location.find(
										'#countryId').val(), location.find(
										'#state').val(), location.find('#city')
										.val(), isVerified, status,
								fromWagerDate, toWagerDate, fromWinDate,
								toWinDate, fromDepDate, toDepDate, fromWitDate,
								toWitDate, fromLoginDate, toLoginDate,
								parseFloat(location.find('#minCashBal').val()),
								parseFloat(location.find('#maxCashBal').val()),
								location.find('#minBonBal').val(), location
										.find('#maxBonBal').val(), location
										.find('#minPraBal').val(), location
										.find('#maxPraBal').val(), location
										.find('#minTotBal').val(), location
										.find('#maxTotBal').val(), pendBonus,
								vipCriteria, location.find('#minBonRecAmount')
										.val(), location.find(
										'#maxBonRecAmount').val(), location
										.find('#minBonExpAmount').val(),
								location.find('#maxBonExpAmount').val(),
								location.find('#bonFromCash').val(), location
										.find('#bonToCash').val(), location
										.find('#minPenAmount').val(), location
										.find('#maxPenAmount').val(),
								parseFloat(location
										.find('#minWithdrawalAmount').val()),
								parseFloat(location
										.find('#maxWithdrawalAmount').val()),
								parseFloat(location.find('#minDepositAmount')
										.val()), parseFloat(location.find(
										'#maxDepositAmount').val()),
								parseFloat(location.find('#minWinningAmount')
										.val()), parseFloat(location.find(
										'#maxWinningAmount').val()),
								parseFloat(location.find('#minWagerAmount')
										.val()), parseFloat(location.find(
										'#maxWagerAmount').val()),
								parseFloat(location.find('#minBonusAmount')
										.val()), parseFloat(location.find(
										'#maxBonusAmount').val()), vipLevel,
								fromFirstDepositDate, toFirstDepositDate,
								location.find('#uploadedDoc').val(), location
										.find('#uniqueNo').val(), location
										.find('#referSourceType').val(),
								location.find('#referSource').val())));
	}

	function PlrSearchOptionBean(domainId, aliasId, playerIdList, fname, lname,
			userName, email, mobile, plrTaxId, gender, isAffiliated, depositer,
			fromDob, toDob, yearCheck, regIp, fromRegDate, toRegDate,
			countryId, state, city, isVerified, status, fromWagerDate,
			toWagerDate, fromWinDate, toWinDate, fromDepDate, toDepDate,
			fromWitDate, toWitDate, fromLoginDate, toLoginDate, minCashBal,
			maxCashBal, minBonBal, maxBonBal, minPraBal, maxPraBal, minTotBal,
			maxTotBal, pendBonus, vipCriteriaBean, minBonRecAmount,
			maxBonRecAmount, minBonExpAmount, maxBonExpAmount, bonFromCash,
			bonToCash, minPenAmount, maxPenAmount, minWithdrawalAmount,
			maxWithdrawalAmount, minDepositAmount, maxDepositAmount,
			minWinningAmount, maxWinningAmount, minWagerAmount, maxWagerAmount,
			minBonusAmount, maxBonusAmount, vipLevel, fromFirstDepositDate,
			toFirstDepositDate, uploadedDoc, uniqueNo, referSourceType,
			referSource) {
		this.domainId = domainId;
		this.aliasId = aliasId;
		this.playerIdList = playerIdList;
		this.fname = fname;
		this.lname = lname;
		this.userName = userName;
		this.isVerified = isVerified;
		this.vipLevel = vipLevel;
		this.countryId = countryId;
		this.city = city;
		this.stateId = state;
		this.email = email;
		this.mobile = mobile;
		this.fromDob = fromDob;
		this.toDob = toDob;
		this.fromRegDate = fromRegDate;
		this.toRegDate = toRegDate;
		this.isAffiliated = isAffiliated;
		this.vipCriteriaBean = vipCriteriaBean;
		this.plrTaxId = plrTaxId;
		this.gender = gender;
		this.fromWagerDate = fromWagerDate;
		this.toWagerDate = toWagerDate;
		this.fromWinDate = fromWinDate;
		this.toWinDate = toWinDate;
		this.fromDepDate = fromDepDate;
		this.toDepDate = toDepDate;
		this.fromWitDate = fromWitDate;
		this.toWitDate = toWitDate;
		this.minPraBal = minPraBal;
		this.maxPraBal = maxPraBal;
		this.minBonBal = minBonBal;
		this.maxBonBal = maxBonBal;
		this.minTotBal = minTotBal;
		this.maxTotBal = maxTotBal;
		this.bonFromCash = bonFromCash;
		this.bonToCash = bonToCash;
		this.pendBonus = pendBonus;
		this.minBonRecAmount = minBonRecAmount;
		this.maxBonRecAmount = maxBonRecAmount;
		this.minBonExpAmount = minBonExpAmount;
		this.maxBonExpAmount = maxBonExpAmount;
		this.minPenAmount = minPenAmount;
		this.maxPenAmount = maxPenAmount;
		this.fromLoginDate = fromLoginDate;
		this.toLoginDate = toLoginDate;
		this.status = status;
		this.minBonusAmount = minBonusAmount;
		this.maxBonusAmount = maxBonusAmount;
		this.minDepositAmount = minDepositAmount;
		this.maxDepositAmount = maxDepositAmount;
		this.minWagerAmount = minWagerAmount;
		this.maxWagerAmount = maxWagerAmount
		this.minWithdrawalAmount = minWithdrawalAmount;
		this.maxWithdrawalAmount = maxWithdrawalAmount;
		this.minWinningAmount = minWinningAmount;
		this.maxWinningAmount = maxWinningAmount;
		this.minCashBal = minCashBal;
		this.maxCashBal = maxCashBal;
		this.fromFirstDepositDate = fromFirstDepositDate;
		this.toFirstDepositDate = toFirstDepositDate;
		this.regIp = regIp;
		this.depositer = depositer;
		this.yearCheck = yearCheck;
		this.uniqueNo = uniqueNo;
		this.uploadedDoc = uploadedDoc;
		this.referSourceType = referSourceType;
		this.referSource = referSource;

	}

	function vipCriteriaListBean(vipSelCriteria, viplastMonthMinCriteria,
			vipLastQuarterMinCriteria, vipLastYearMinCriteria,
			vipSinceRegiMinCriteria, viplastMonthMaxCriteria,
			vipLastQuarterMaxCriteria, vipLastYearMaxCriteria,
			vipSinceRegiMaxCriteria) {
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
</script>
</head>
<body>
	<s:form id="pushAppFrm"
		action="com/stpl/pms/action/bo/pm/st_pms_pushAppUpdate.action"
		theme="simple" style="text-transform: capitalize;">
		<s:token theme="simple"></s:token>
		<s:hidden id="searchedCriteria" name="searchedCriteria"></s:hidden>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Push App Version</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Player </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv" style="height:auto">
						<s:select theme="myTheme" cssClass="select1" list="%{playerMap}"
							multiple="true" name="playerIdArr" id="playerIdArr"
							cssStyle="height:auto"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<%--<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select All: </label>
					</div>
					<div class="InputDiv">
						<s:checkbox name="appPushBean.selectAll" id="selectAll" ></s:checkbox>
						<label for="selectAll"> All
							Players</label>
					</div>
				</div>--%>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Target App: </label><em class="Req">*</em>
					</div>
					<div class="InputDiv" >
					
						<s:iterator value="%{appVersionMap}">
							<input type="checkbox"  class="checkAppOs" data="<s:property value='%{key}'/>"
								value='<s:property value='%{key.replace(" ","")}'/>'  />
							<label><s:property value="%{key}" /> </label>
						</s:iterator> 
					</div>
				</div>
				<s:iterator value="appVersionMap">
					<div id="verSelect<s:property value='%{key.replace(" ","")}' />"
						style="display:none;">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv" style="width:30%">
								<label><s:property value="key.toLowerCase()" />
									version: </label><em class="Req">*</em>
							</div>

							<div class="InputDiv" style="width:68%">
								<s:select theme="myTheme" disabled="true" headerKey="-1" 
									headerValue="--Please Select--" cssClass="select1"
									list="%{value}" listValue="appTag" listKey="id"
									name="appPushBean.verIdArr">
								</s:select>
							</div>
						</div>
					</div>
				</s:iterator>
			</div>
			<div class="box_footer" align="right">
				<s:submit theme="simple" id="submitBtn" value="Push"></s:submit>
			</div>
		</div>
	</s:form>
</body>
</html>