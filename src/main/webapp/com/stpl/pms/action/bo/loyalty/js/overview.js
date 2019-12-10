var pointSymbol = "Lp";
var ruppee = "&#8377";

$(function(){

	initTierStat();
	initExposure();


});

function initTierStat(){
	var $tierStatDiv = $('#tier_stats');
	var $tierStatDivRefreshBtn = $tierStatDiv.find('.refreshBTN');
	$tierStatDivRefreshBtn.click(function(){
		tierStats();
	});

	$tierStatDivRefreshBtn.trigger('click');
}

function initExposure(){
	var $exposureDiv = $('#exposure_expiry');
	var $exposureDivRefreashBtn = $exposureDiv.find('.refreshBTN');
	$exposureDivRefreashBtn.click(function(){
		exposure();
	});

	$exposureDivRefreashBtn.trigger('click');
}

function tierStats(){

	var $tierStatDiv = $('#tier_stats');
//	var $spinner = $tierStatDiv.find('#spinner');

	console.log("tierstats init");
	var _resp;
	var actionName = "com/stpl/pms/action/bo/loyalty/bo_ajax_call_tier_stats.action";
	$.ajax( {
		type : "POST",
		url : actionName,
		data : "",
		async : false,
		beforeSend: function() { 
			console.log('before send');
		},
		success : function(result, arguments, text) {
			if (arguments == 'success') {
				_resp = text.responseText;
				if(_resp!='error')
					_resp = $.parseJSON(_resp);
			} else {
				_resp = 'error';
			}
		}
	});


	if(_resp.result==0){
		var $tierStatsStepContainer = $tierStatDiv.find('#tier_stats_step_container');
		$tierStatsStepContainer.empty();
		$.each(_resp.list,function(index,value){
			//console.log(index+":"+value);

			/*create step*/
			var $step = $('<div>');
			$step.addClass('col-tiers');
			/*create player count*/
			var $tierPlayerCountDiv = $('<div>');
			$tierPlayerCountDiv.addClass('tier-amt');
			$tierPlayerCountDiv.addClass(value[1]+'-color');
			$tierPlayerCountDiv.text(value[2]);
			/*create tier name*/
			var $tierNameSpan = $('<span>');
			$tierNameSpan.text(value[1]);
			/*append them in steps*/
			$step.append($tierPlayerCountDiv);
			$step.append($tierNameSpan);

			/*finally append step in step container*/
			$tierStatsStepContainer.append($step);

		});
	}
}

function exposure(){
	var $exposureDiv = $('#exposure_expiry');

	console.log("exposure init");
	var _resp;
	var actionName = "com/stpl/pms/action/bo/loyalty/bo_ajax_call_exposure.action";
	$.ajax( {
		type : "POST",
		url : actionName,
		data : "",
		async : false,
		beforeSend: function() { 
			console.log('before send');
		},
		success : function(result, arguments, text) {
			if (arguments == 'success') {
				_resp = text.responseText;
				if(_resp!='error')
					_resp = $.parseJSON(_resp);
			} else {
				_resp = 'error';
			}
		}
	});

	if(_resp.result==0){
		var report = _resp.report;

		var $pointTable = $exposureDiv.find("#table_point");
		$pointTable.empty();
		var $creditTable = $exposureDiv.find("#table_credit");
		$creditTable.empty();

		/*set total details*/
		if(report.total){
			var totalreport = report.total;
			/*create total point row*/
			$totalPointValuetd = $exposureDiv.find('#current_redemption_liberties > .value');
			$totalPointValuetd.text(pointSymbol+" "+totalreport.TotalPts);
			/*create point table*/
			$totalPointTr = $('<tr><td>- Total Points</td><td>'+pointSymbol+" "+totalreport.TotalPts+'</td></tr>');
			$pointTable.append($totalPointTr);
			/*create credit table*/
			$totalCashTr = $('<tr><td>- Total Cash</td><td>'+ruppee+" "+totalreport.Totalcash+'</td></tr>');
			$creditTable.append($totalCashTr);
		}
		
		$.each(report,function(key, value){
			console.log(key,value);
			if(key != 'total'){
				/*add in point table*/
				$pointTable.append($('<tr><td>- '+key+'</td><td>'+pointSymbol+" "+value.TotalPts+'</td></tr>'));
				
				/*create credit table*/
				$creditTable.append($('<tr><td>- '+key+'</td><td>'+ruppee+" "+value.Totalcash+'</td></tr>'));
			}
			
		});
	}
}


