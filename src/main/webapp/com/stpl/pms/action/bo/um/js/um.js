function chkDefault(objArr) {
	var defChk;
	var count = 0;
	// alert('def'+objArr.length);
	objArr.each(function() {
		if (this.value.indexOf('*') != -1) {
			defChk = this;
		}
		if (this.value.indexOf('*') == -1 && this.checked) {
			count++;
		}
	});
	// alert(defChk+'---'+(defChk!=undefined));
	if (defChk != undefined) {
		if (count > 0) {
			defChk.checked = true;
			defChk.readOnly = true;
		} else {
			// defChk.attr('checked',false);
			// defChk.attr('readonly',false);
			defChk.readOnly = false;
		}
	}

	// return {obj:defChk,c:count};
	// alert(count+'==='+defChk+"==="+defChk.value);
	/*
	 * if(count>0){ defChk.attr('checked',true); defChk.attr('readonly',true);
	 * }else{ //defChk.attr('checked',false); defChk.attr('readonly',false); }
	 * /*if(obj.val().indexOf('*')==-1){
	 * 
	 * /*obj.closest('table').parents('td').find('.chkOne').each(function(){
	 * if($(this).val().indexOf('*')!=-1){ defChk=$(this); }
	 * if($(this).val().indexOf('*')==-1 && this.checked){ count++; } });
	 */
	// alert(count);
	/*
	 * if(count>0){ defChk.attr('checked',true); defChk.attr('readonly',true);
	 * }else{ defChk.attr('checked',false); defChk.attr('readonly',false); } }
	 */
}

function chkPriv(obj) {
	var chk = true;
	obj.closest('table').closest('tr').closest('table').find('.chkGrp').each(
			function() {
				if (!this.checked) {
					chk = false;
				}
			});
	obj.closest('table').closest('tr').closest('table').find('.chkAll').attr(
			'checked', chk);
}
function chksub() {
	var c = false;
	// alert($('.chkOne'));
	$('.chkOne').each(function() {
		if (this.checked) {
			c = true;
		}
	});
	if (c == false) {
		alert("Please Check Atleast One Role Privilege");
		return false;
	} else {
		return true;
	}
}
function getSelectedRoleValue(roleId, roleName) {
	var val = $("#" + roleId + " option:selected").text();
	$("#" + roleName).attr("value", val);
}
/*
 * function getUserPriveledges(userName) { if (userName == -1) {
 * $('#result').html(""); } else { var actionName =
 * 'bo_um_editBoSubUserPriv_FetchPriv.action'; var
 * actionParam='userName='+userName;
 * _ajaxCallDiv(actionName,actionParam,'result'); } return false; }
 */
function enableStockCatBoxesGroup(){
	var continue_button = document.getElementById('submitButton');
	var edit_button = document.getElementById('editButton');
	// alert(document.getElementById('submitButton'));
	continue_button.style.display = 'block';
	edit_button.style.display = 'none';
	document.getElementById('stockName').readOnly = false;
	
	document.getElementById('stockName').style.backgroundColor = "#F9FCCD";
}
function enableStockBoxesGroup(){
	
	var continue_button = document.getElementById('submitButton');
	var edit_button = document.getElementById('editButton');
	// alert(document.getElementById('submitButton'));
	continue_button.style.display = 'block';
	edit_button.style.display = 'none';
	document.getElementById('stockName').readOnly = false;
	document.getElementById('qtyCheck').readOnly = false;
	document.getElementById('gstDetCheck').readOnly = false;
	
	document.getElementById('qtyCheck').style.backgroundColor = "#F9FCCD";
	document.getElementById('stockName').style.backgroundColor = "#F9FCCD";
	document.getElementById('gstDetCheck').style.backgroundColor = "#F9FCCD";
}
function enableBoxesGroup(){
	var continue_button = document.getElementById('submitButton');
	var edit_button = document.getElementById('editButton');
	// alert(document.getElementById('submitButton'));
	continue_button.style.display = 'block';
	edit_button.style.display = 'none';
	document.getElementById('subLedger').readOnly = false;
	document.getElementById('blncForRep').readOnly = false;
	document.getElementById('forCalc').readOnly = false;
	document.getElementById('purInvoice').readOnly = false;
	
	document.getElementById('subLedger').style.backgroundColor = "#F9FCCD";
	document.getElementById('blncForRep').style.backgroundColor = "#F9FCCD";
	document.getElementById('forCalc').style.backgroundColor = "#F9FCCD";
	document.getElementById('purInvoice').style.backgroundColor = "#F9FCCD";
	
}
function enableBoxesCompany() {
	var continue_button = document.getElementById('submitButton');
	var edit_button = document.getElementById('editButton');
	// alert(document.getElementById('submitButton'));
	continue_button.style.display = 'block';
	edit_button.style.display = 'none';
	document.getElementById('email').readOnly = false;
	document.getElementById('currentAddress').readOnly = false;
	document.getElementById('country').readOnly = false;
	document.getElementById('contactNo').readOnly = false;
	document.getElementById('state').readOnly = false;
	document.getElementById('name').readOnly = false;
	document.getElementById('pincode').readOnly = false;
	document.getElementById('ifsc').readOnly = false;
	document.getElementById('accHolderName').readOnly = false;
	document.getElementById('accountNo').readOnly = false;
	document.getElementById('bankName').readOnly = false;
	document.getElementById('cinRegNo').readOnly = false;
	document.getElementById('cfln').readOnly = false;
	document.getElementById('cpln').readOnly = false;
	document.getElementById('csln').readOnly = false;
	document.getElementById('license').readOnly = false;
	document.getElementById('panNo').readOnly = false;
	document.getElementById('gstNo').readOnly = false;
	
	document.getElementById('email').style.backgroundColor = "#F9FCCD";
	document.getElementById('currentAddress').style.backgroundColor = "#F9FCCD";
	document.getElementById('country').style.backgroundColor = "#F9FCCD";
	document.getElementById('state').style.backgroundColor = "#F9FCCD";
	document.getElementById('contactNo').style.backgroundColor = "#F9FCCD";
	document.getElementById('name').style.backgroundColor = "#F9FCCD";
	document.getElementById('pincode').style.backgroundColor = "#F9FCCD";
	document.getElementById('ifsc').style.backgroundColor = "#F9FCCD";
	document.getElementById('accHolderName').style.backgroundColor = "#F9FCCD";
	document.getElementById('accountNo').style.backgroundColor = "#F9FCCD";
	document.getElementById('bankName').style.backgroundColor = "#F9FCCD";
	document.getElementById('cinRegNo').style.backgroundColor = "#F9FCCD";
	document.getElementById('cfln').style.backgroundColor = "#F9FCCD";
	document.getElementById('cpln').style.backgroundColor = "#F9FCCD";
	document.getElementById('csln').style.backgroundColor = "#F9FCCD";
	document.getElementById('license').style.backgroundColor = "#F9FCCD";
	document.getElementById('panNo').style.backgroundColor = "#F9FCCD";
	document.getElementById('gstNo').style.backgroundColor = "#F9FCCD";
}

function enableBoxes() {

	var continue_button = document.getElementById('submitButton');
	var edit_button = document.getElementById('editButton');
	// alert(document.getElementById('submitButton'));
	continue_button.style.display = 'block';
	edit_button.style.display = 'none';
	document.getElementById('email').disabled = false;
	document.getElementById('phoneNbr').readOnly = false;
	document.getElementById('lastnameedit').readOnly = false;

	// document.getElementById('submitButton').style.display='block';
	// continue_button.style.visibility = 'visible';
	// change the background color
	document.getElementById('statId').disabled = false;
	document.getElementById('phoneNbr').style.backgroundColor = "#F9FCCD";
	document.getElementById('email').style.backgroundColor = "#F9FCCD";
	document.getElementById('lastnameedit').style.backgroundColor = "#F9FCCD";

}
function resetPasswordBO(url, email) {
	alert("hi");
	alert("hello");
	var _resp = _ajaxCallText(url, '');
	if (_resp == 'true') {
		document.getElementById('errorDiv').innerHTML = "<br><font color = '#000000; size=12px'><h4>Password reset Successful!! Password has been sent to the registered mail id.</h4></font>";
	} else {
		alert("Problem: ");
	}
}

function checkUploadFrm() {
	var frm = document.bannerUploadFrm;
	var pattern = "!@#$%^&*()+=-[]\';,/{}|:<>?";
	var pattern1 = "!@#$%^&*()+=[]';,{}|<>";
	if (frm.bannerName.value == "") {
		alert("Banner Name cannot be blank");
		frm.bannerName.focus();
		return false;
	} else if (frm.bannerName.value.length < 3
			|| frm.bannerName.value.length > 30) {
		alert("Banner Name should be between 3 to 30");
		frm.bannerName.focus();
		return false;
	}

	else {
		for (var i = 0; i < frm.bannerName.value.length; i++) {
			if (pattern.indexOf(frm.bannerName.value.charAt(i)) != -1) {
				alert("Banner name should be alphanumeric");
				frm.bannerName.focus();
				return false;
			}
		}
	}

	if (frm.bannerURL.value == "") {
		alert("Banner URL cannot be blank");
		frm.bannerURL.focus();
		return false;
	} else if (frm.bannerURL.value.indexOf("http:") != -1
			|| frm.bannerURL.value.indexOf("ftp:") != -1
			|| frm.bannerURL.value.indexOf("https:") != -1) {
		alert("Banner URL should not contain protocol prefix");
		frm.bannerURL.focus();
		return false;
	} else if (frm.bannerURL.value.lastIndexOf("/") == frm.bannerURL.value.length - 1) {
		alert("Banner URL should not contain / as suffix");
		frm.bannerURL.focus();
		return false;
	} else if (frm.bannerURL.value != '') {
		for (var i = 0; i < frm.bannerURL.value.length; i++) {
			if (pattern1.indexOf(frm.bannerURL.value.charAt(i)) != -1) {
				alert("Banner URL is not valid");
				frm.bannerURL.focus();
				return false;
			}
		}
	}

	var txtElm = document.getElementById("text");
	var flashElm1 = document.getElementById("flash_1");
	var flashElm2 = document.getElementById("flash_2");

	var imageElm = document.getElementById("image");

	if (txtElm.className == "show" || txtElm.className == "") {
		if (frm.bannerText.value == "") {
			alert("Banner Text cannot be blank");
			frm.bannerText.focus();
			return false;
		}
	}
	if (flashElm1.className == "" && flashElm2.className == "") {
		var frmBannerDim = document.getElementById("bannerDimension").value;

		if (frmBannerDim == null || frmBannerDim == "") {
			alert("Banner Dimension cannot be blank");
			// frm.bannerDimension.focus();
			return false;
		} else {
			if (frmBannerDim.indexOf("X") == -1
					|| frmBannerDim.indexOf("X") == 0
					|| frmBannerDim.indexOf("X") == frmBannerDim.length - 1) {
				alert("Banner Dimension should be separated by X i.e height X width");
				// frm.bannerDimension.focus();
				return false;
			} else {
				var dimArr = frmBannerDim.split("X");
				var re = /^[a-zA-Z]$/;
				if (isNaN(dimArr[0]) && isNaN(dimArr[1])) {
					alert("Height & Width dimensions should be numeric");
					return false;
				}
				if (isNaN(dimArr[0])) {
					alert("Height dimension should be numeric");
					return false;
				}
				if (isNaN(dimArr[1])) {
					alert("Width dimension should be numeric");
					return false;
				}

			}
		}
		var bPath = document.getElementById("bannerfPath").value;
		if (bPath == "undefined" || bPath == null || bPath == "") {
			alert("Banner source path should be specified");
			return false;
		}

	}
	if (imageElm.className == "" || imageElm.className == "show") {

		var imgAlt = document.getElementById("imageAltText").value;
		if (imgAlt == "undefined" || imgAlt == null || imgAlt == "") {
			alert("Image alt text should be specified");
			return false;
		}
	}

	return true;

}
function checkUserRegfrm(formname) {
	var hideBubble = new Array();
	var hideBubble = document.getElementsByTagName('*');
	for (var i = 0; i < hideBubble.length; i++) {
		if (hideBubble[i].className == "bubbletip") {
			hideBubble[i].style.display = 'none';
		}
	}
}
