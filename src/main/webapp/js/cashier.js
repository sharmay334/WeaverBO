function validateAmount(amt_id, errorDiv) {
	var amt = amt_id.val();
	$('#'+errorDiv).css('font-size', '12px');
	$('#'+errorDiv).css('color', 'red');
	$('#'+errorDiv).css('font-weight', 'bold');
	var paymentType = amt_id.attr("id").split("amount_");
	var chk = true;
	if (isNaN(amt)) {
		$('#' + errorDiv).html('Please enter a valid amount.');
		chk = false;
	} else if (amt < 25) {
		$('#' + errorDiv).html("Minimum amount required : 25");
		chk = false;
	} else if (amt > 10000) {
		$('#' + errorDiv).html("Maximum amount allowed :10000");
		chk = false;
	} else {
		$('#' + errorDiv).html("");
		$('#' + errorDiv).css('color', 'green');
	}
	return chk;
}
function chkAmountOnkeyPressed(event,errorDiv) {
	// alert($(this).attr('type')+'--'+event);
	var regex = new RegExp("^[0-9.]+$");
	var key = event.charCode ? event.charCode : event.which ? event.which
			: event.keyCode;
	var keyPressed = String.fromCharCode(key);
	if (key == 8 || key == 27 || key == 46 || key == 37 || key == 39
			|| key == 9) {
		return true;
	} else if (!regex.test(keyPressed)) {
		event.preventDefault();
		$('#'+errorDiv).css('font-size', '12px');
		$('#'+errorDiv).css('color', 'red');
		$('#'+errorDiv).css('font-weight', 'bold');
		$('#'+errorDiv).html('Please Enter only Amount');
		return false;
	}
}

function depositValidate(frmObj,errorDiv) {
	var id = frmObj.attr("id").replace('depFrm', '');
	var txtAmt = frmObj.find('#amount_' + id);
	var providerBankCode = frmObj.find('#subTypeCode_' + id);
	var currency =  frmObj.find('#currency_' + id);
	var isChk = true;
	
	if (id != 'CASH_PAYMENT' && id != 'CASH_ON_DELIVERY' && id != 'PENDING_WITHDRAWAL') {
		if (!validateAmount(txtAmt, errorDiv)) {
			isChk = false;
		}
	}
	if (id == 'CASH_CARD') {
		var serialNo = $('#serialNo_' + id).val();
		if (serialNo == 'Serial No' || serialNo == '' || isNaN(serialNo)) {
			alert("Please fill valid serial no.");
			isChk = false;
		}
		var pinNo = $('#pinNo_' + id).val();
		if (pinNo == 'PIN No' || pinNo == '' || isNaN(pinNo)) {
			alert("Please fill valid pin no.");
			isChk = false;
		}
	}
	if (id != 'CASH_PAYMENT' && id != 'PENDING_WITHDRAWAL') {
		 if (providerBankCode.val() == -1) {
			 $('#'+errorDiv).css('font-size', '12px');
			 $('#'+errorDiv).css('color', 'red');
			 $('#'+errorDiv).css('font-weight', 'bold');
			 $('#'+errorDiv).html('Please Select Card/Bank Type');
			isChk = false;
		}
	}
	if (id != 'CASH_PAYMENT' && id != 'PENDING_WITHDRAWAL') {
		 if (currency.val() == -1) {
			 $('#'+errorDiv).css('font-size', '12px');
			 $('#'+errorDiv).css('color', 'red');
			 $('#'+errorDiv).css('font-weight', 'bold');
			 $('#'+errorDiv).html('Please select currency');
			isChk = false;
		}
	}
	if(isChk){
		$('#'+errorDiv).html('');
	}
	return isChk;
}
