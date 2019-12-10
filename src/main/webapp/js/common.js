/*
 * @author: Nitish Bansal
 * @date : 2/03/2013
 * @Desc: It is object oriented java script file and it is common file for common js function in the build
 */

var validate = {
	isAjaxReq : true,
	keyPressFn : function(e) {

		var keyval = window.event ? e.keyCode : e.which;
		if (keyval == 8 || keyval == 9 || keyval == 13 || keyval == 16
				|| keyval == 17 || keyval == 18 || keyval == 20 || keyval == 27
				|| keyval == 0) { // for backspace
			return true;
		}
		var txt = $(this);
		var isChk = true;
		var idValue = txt.attr('id');
		var showClass = txt.attr('class');
		var divId = txt.attr('id') + '_errorDiv';
		var txtVal = txt.val() + String.fromCharCode(keyval);
		var patternOn = txt.attr('patternOn');
		if (patternOn.indexOf('blur') != -1) {
			return true;
		}
		$('#' + divId).html('<ul></ul>');
		return chkPattern(txt.attr('pattern'), txtVal,
				txt.attr('errormassage'), divId, showClass, idValue);
	},
	blurFn : function() {
		return validate.blurFnObj($(this));
	},
	blurFnObj : function(obj) {
		var txt = obj;
		var isChk = true;
		var idValue = txt.attr('id');
		var divId = txt.attr('id') + '_errorDiv';
		var txtVal = txt.val();
		var showClass = txt.attr('class');
		var param = "";
		var ajaxParam = new Array();
		var ajaxParamVal = "";
		$('#' + divId).html('<ul></ul>');
		if ((txtVal == null||txtVal.trim() == "") && obj.attr('applyscript')=="true" ) {
			$('#' + divId).html('<p>Field cannot be blank</p>');
			_Show($('#' + divId), $('#' + idValue));
			isChk = false;
		}
		if (typeof obj.attr('pattern') !== 'undefined') {
			var patternOn = txt.attr('patternOn');
			if (patternOn.indexOf('keypress') == -1) {
				isChk = isChk
						& chkPattern(txt.attr('pattern'), txtVal, txt
								.attr('errormassage'), divId, showClass,
								idValue,obj);
			}
		}
		
		if (typeof obj.attr('minLength') !== 'undefined')
			isChk = isChk
					& chkMinLength(txt.attr('minLength'), txtVal, divId,
							idValue);
		if (typeof obj.attr('min') !== 'undefined'
				&& typeof obj.attr('max') !== 'undefined') {
			isChk = isChk
					& chkMinMax(txt.attr('min'), txt.attr('max'), txtVal,
							divId, idValue);
		} else {
			if (typeof obj.attr('min') !== 'undefined')
				isChk = isChk & chkMin(txt.attr('min'), txtVal, divId, idValue);
			if (typeof obj.attr('max') !== 'undefined')
				isChk = isChk & chkMax(txt.attr('max'), txtVal, divId, idValue);
		}
		if (txt.val() == "-1" && txt.prop("tagName").toLowerCase()=='select') {
			$('#' + divId + ' ul').append('<p>Please select one option.</p>');
			_Show($('#' + divId), $('#' + idValue));
			isChk = false;
		} else {
			_Show($('#' + divId), $('#' + idValue));

		}
		if (isChk) {
			if (typeof obj.attr('action') !== 'undefined') {
				if (typeof txt.attr('ajaxParam') !== 'undefined') {
					var ajaxParamLen = txt.attr('ajaxParam').split(',').length;
					if (ajaxParamLen > 0) {
						ajaxParam = txt.attr('ajaxParam').split(',');
						$.each(ajaxParam, function(index, value) {
							ajaxParamVal = $('#' + value).val();
							if($("#"+value).prop("tagName")=="SELECT" && ajaxParamVal == "-1"){
								$('#' + divId + ' ul').append('<p>Please select one option for '+value+'.</p>');
								_Show($('#' + divId), $('#' + idValue));
								isChk = false;
							}
							param = param + $('#' + value).attr('name') + "=" + ajaxParamVal + '&';
						});
						// param.replaceLast('&','');
					} else {
						param = txt.attr('name') + "=" + txt.val();
					}
				} else {
					param = txt.attr('name') + "=" + txt.val();
				}
				if(isChk)
				$
						.ajax( {
							type : "POST",
							url : txt.attr('action'),
							data : param,
							async : false,
							success : function(result, arguments, text) {
								$('#' + divId).html(text.responseText);
								if ((text.responseText).toLowerCase().indexOf('no') == -1) {
									$('#' + divId).find('p').removeClass().addClass(
											"bubble_msg");
								} else {
									$('#' + divId).find('p').removeClass().addClass(
											"fieldError");
									isChk=false;
								}
								_Show($('#' + divId), $('#' + idValue));
							}
						});
			}
		}
		if (isChk)
			_Show($('#' + divId), $('#' + idValue));
		return isChk;
	},
	ajaxFrmFn : function() {
		var form = $(this);
		var target = form.attr('target');
		var callback = (typeof form.attr('callBack') !== 'undefined') ? form
				.attr('callBack') : '';
		$.ajax( {
			type : "POST",
			url : form.attr('action'),
			data : form.serialize(),
			async : false,
			success : function(result) {
				$('#' + target).html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
		return false;
	},
	ajaxLink : function() {
		var anchor = $(this);
		var linkArr = $(this).attr('href').split('?');
		var target = $(this).attr('target');
		var callback = (typeof anchor.attr('callBack') !== 'undefined') ? anchor
				.attr('callBack')
				: '';
		$.ajax( {
			type : "POST",
			url : linkArr[0],
			data : linkArr[1],
			async : false,
			success : function(result) {
				$('#' + target).html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
		return false;
	},
	ajaxDivFn : function() {
		if (!validate.isAjaxReq) {
			return;
		}
		var txt = $(this);
		var divId = txt.attr('target');
		var param = "";
		var ajaxParam = new Array();
		var ajaxParamVal = "";
		var isChk = true;
		var callback = (typeof txt.attr('callBack') !== 'undefined') ? txt
				.attr('callBack') : '';
		if ($(this).prop('tagName') == 'SELECT') {
			if ($(this).val() == -1) {
				$("#" + divId).html("");
				isChk = false;
				return;
			}
		}
		if (typeof $(this).attr('ajaxParam') !== 'undefined') {
			var ajaxParamLen = $(this).attr('ajaxParam').split(',').length;
			if (ajaxParamLen > 0) {
				ajaxParam = txt.attr('ajaxParam').split(',');
				$.each(ajaxParam, function(index, value) {
					ajaxParamVal = $('#' + value).val();
//					if($("#"+value).prop("tagName")=="SELECT" && ajaxParamVal == "-1")
//						return;
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
			url : txt.attr('ajaxAction'),
			data : param,
			async : false,
			success : function(result) {
				$("#" + divId).html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
		return false;
	},
	checkFormFn : function() {
		var txt = $(this);
		var idValue = txt.attr('id');
		var divId = txt.attr('id') + '_errorDiv';
		var formId = $(this).closest("form").attr("id");
		var isChk = true;
		var isFirstElement = true;
		var frmZIndex = $('#'+formId).zIndex();
		$('#' + formId + ' :input')
				.not(
						':input[type=button], :input[type=submit], :input[type=reset],:input[type=hidden],:input[type=file]')
				.each(function() {
					if (typeof $(this).attr('applyscript') != 'undefined') {
						isChk = isChk & validate.blurFnObj($(this));
						// isChk = isChk & validate.acceptExtFn($(this));
						if (isFirstElement && !isChk) {
							isFirstElement = false;
							$(this).focus();

						}
					} /*else {
						if (formId != (idValue + "_status")) {
							var _wrapperObj = map[$(this).attr('id')];
							var _wrapper = _wrapperObj.wrapper;
							_wrapper.hide();
						}

					}*/

				});
		$('#' + formId + ' :input[type=file]')
				.not(
						':input[type=button], :input[type=submit], :input[type=reset],:input[type=hidden]')
				.each(function() {
					if (typeof $(this).attr('applyscript') != 'undefined') {
						// isChk = isChk & validate.blurFnObj($(this));
						isChk = isChk & validate.acceptExtFn($(this));
						if (isFirstElement && !isChk) {
							isFirstElement = false;
							$(this).focus();

						}
					} else {
						if (formId != (idValue + "_status")) {
							var _wrapperObj = map[$(this).attr('id')];
							var _wrapper = _wrapperObj.wrapper;
							_wrapper.hide();
						}

					}

				});
		$('#' + formId + ' \\:select')
				.not(
						':input[type=button], :input[type=submit], :input[type=reset],:input[type=hidden]')
				.each(function() {

					if (typeof $(this).attr('applyscript') != 'undefined') {
						isChk = isChk & validate.blurSelectFn($(this));
						if (isFirstElement && !isChk) {
							isFirstElement = false;
							$(this).focus();

						}
					}
				});
		if (isChk == 0) {
			isChk = false;
		}
		validate.isAjaxReq = isChk;
		if(frmZIndex!=0){
			$('#'+formId+' :input,textarea,select').not('input[type=button], input[type=submit], input[type=reset],input[type=hidden]').each(function(){
				var id=$(this).attr('id');
				var eleBubbletip = '#'+id+"_bubbleTable";
				$(eleBubbletip).css("zIndex", frmZIndex);
			});
		}
		return isChk;
	},
	blurSelectFn : function() {

		var txt = $(this);
		var divId = txt.attr('id') + "_errorDiv";
		var idValue = txt.attr('id');
		var isChk = true;
		$('#' + divId).html('<ul></ul>');
		if ((txt.val() == "-1" || txt.val() == "") & typeof txt.attr('applyscript') != 'undefined') {
			$('#' + divId + ' ul').append('<p>Please select one option.</p>');
			_Show($('#' + divId), $('#' + idValue));
			isChk = false;
		} else {
			_Show($('#' + divId), $('#' + idValue));
		}
		return isChk;
	},
	acceptFormatFn : function() {
		return validate.acceptExtFn($(this));
	},
	acceptExtFn : function(file) {
		// get filepath from fileupload control on the page
	var isChk = true;
	// var file = $(this);
	idValue = file.attr('id');
	divId = idValue + "_errorDiv";
	var fileUpload = file.val();
	// extracting part of the filename from dot
	var extension = fileUpload.substring(fileUpload.lastIndexOf('.'));
	// valid file type - static
	
	$('#' + divId).html('<ul></ul>');
	if (typeof file.attr('accept') !== 'undefined') {
		var ValidFileType = file.attr('accept').split(",");
		var fileTypeLen = file.attr('accept').split(",").length;
		// check file is of valid type or not
		$.each(ValidFileType, function(index, value) {
			if (value.toLowerCase() != extension.toLowerCase()) {
				isChk = false;
			} else {
				isChk = true;
				return false;
			}
		});
	}
	var msg="";
	if(typeof file.attr('applyscript') !== 'undefined'){
		if(fileUpload==""){
			msg="Please select the file.";
			isChk = false;
		}else{
			if(!isChk){
				msg="Please select valid file extension.";
			}
				
		}
		
	}
	if (!isChk) {
		$('#' + divId + ' ul').append(
				'<p>'+msg +'</p>');
		file.val('');
		_Show($('#' + divId), $('#' + idValue));
	} else {
		_Show($('#' + divId), $('#' + idValue));
	}
	return isChk;
},
hideBubbleFn : function(){
	var _this = $(this).attr('id');
	var _tip = _this+"_errorDiv";
	
	$('table.bubbletip #' + _tip.attr('id')).closest('table.bubbletip').hide();
}

};
if (typeof $('#validateOptOut').get(0) == 'undefined') {
	$(document).on("keypress", "input[pattern],textarea[pattern]", validate.keyPressFn);
	$(document).on("blur", "input[type='text'],textarea", validate.blurFn);
	$(document).on("blur", "select", validate.blurSelectFn);
	$(document).on("click", "a[target]", validate.ajaxLink);
	$(document).on("click", "input[type='submit'],input[type=button][checked]",
			validate.checkFormFn);
	$(document).on("submit", "form[target]", validate.ajaxFrmFn);
	$(document).on("click", "input[ajaxAction]", validate.ajaxDivFn);
	$(document).on("change", "select[ajaxAction]", validate.ajaxDivFn);
	$(document).on("change", "input[type=file]", validate.acceptFormatFn);
	$(document).on("click", "table.bubbletip", function() {$(this).hide()});
	$(createBubble);
}

(function($){
	$.fn.applyScript = function(){
		$(this).attr('applyscript','true');
	},
	$.fn.removeScript = function(){
		$(this).removeAttr('applyscript');
		$(this).each(function(){
			$('#'+$(this).attr('id')+'_bubbleTable').hide();
		});
	}
	$.fn.applyScriptWithBubble = function(){
			var id=$(this).attr('id');
			var divId = id+"_errorDiv";
			$(this).bubbletip($('#'+divId),{
				deltaDirection: 'up',
				bindShow: 'keypress'
			});
	};
	

})(jQuery);


/* if you wants to Opt Out this validations use <s:hidden id="validateOptOut" value="false"></s:hidden> on your page*/