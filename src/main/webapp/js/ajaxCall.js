
function _ajaxCallText(actionName, param) {
	var _resp;
	$.ajax( {
		type : "POST",
		url : actionName,
		data : param,
		async : false,
		success : function(result, arguments, text) {
			if (arguments == 'success') {
				_resp = text.responseText;
			} else {
				_resp = 'error';
			}

		}
	});
	return _resp;
}

function _ajaxCallDiv(actionName,param,divId) {
	$.ajax( {
		type : "POST",
		url : actionName,
		data : param,
		async : false,
		success : function(result) {
			if((/Session Time Out/i).test(result)){
				window.open(projectName+"/com/stpl/pms/common/execption/nodecorate/sessionTimeOut.jsp", target="_top");
			}else{
				$("#"+divId).html(result);
			}
		}
	});
}

function _ajaxCallph(actionName,param,divId) {
	$.ajax( {
		type : "POST",
		url : actionName,
		data : param,
		async : false,
		success : function(result) {
			if((/Session Time Out/i).test(result)){
				window.open(projectName+"/com/stpl/pms/common/execption/nodecorate/sessionTimeOut.jsp", target="_top");
			}else{
				$("#"+divId).html(result);
			}
		}
	});
}

function _ajaxCallJson(actionName,param) {
	var _resp;
	$.ajax( {
		type : "POST",
		url : actionName,
		data : param,
		async : false,
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
	return _resp;
}
function _ajaxCallJsonSynch(actionName,param,callback) {
	var _resp;
	$.ajax({
		type : "POST",
		url : actionName,
		data : param,
		success : function(result, arguments, text) { 
			if (arguments == 'success') {
			_resp = text.responseText;
				if (_resp != 'error')
					_resp = $.parseJSON(_resp);
			if(typeof(callback) !== 'undefined' && jQuery.isFunction(callback)){
					callback(_resp);}
				else
					console.log('----no response---'+_resp);
	
				
			} else {
				_resp = 'error';
			}
		}
	});
	
	
}

function _ajaxCallph(actionName,param,divId) {
	$.ajax( {
		type : "POST",
		url : actionName,
		data : param,
		async : false,
		success : function(result) {
			if((/Session Time Out/i).test(result)){
				window.open(projectName+"/com/stpl/pms/common/execption/nodecorate/sessionTimeOut.jsp", target="_top");
			}else{
				$("#"+divId).html(result);
			}
		}
	});
}
