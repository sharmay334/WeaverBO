$(document).ready(function() {
		var domainMap = $.parseJSON($('#plrDomainMap').val());
		var isReason = false;
		var countryMap = $.parseJSON($('#countryMapJson').val());

		loadCountries($('#domainId1').val());
		$('#plrCountry').val($('#plrCountryHidden').val());
		getStates($('#plrCountry').val());
		$('#plrState').val($('#plrStateHidden').val());
		$('#plrCountry').change(function() {
			getStates($('#plrCountry').val());
		});
		$('#regStatusInActive').change(function() {
			if ($(this).val() != "-1") {
				$('#reason').removeAttr('readonly');
				isReason = true;
			} else {
				$('#reason').attr('readonly', 'true');
				isReason = false;
			}
		});
		$("#saveEditData").click(
						function() {
							var isValid = true;
							var emailPattren = new RegExp(
									"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$");
							var firstLastPattern = new RegExp(
									"^[a-zA-Z]{1,50}$");
							var houseNo = new RegExp(
									"^[0-9A-Za-z ,-/]{1,}/{0,1}[0-9A-Za-z]{1,}$");
							/*var address12 = new RegExp(
									"^[a-zA-Z0-9-_ ,;:/`()&]{2,200}[0-9A-Za-z)]{1}$");*/
							var emailValue = $("#emailId").val()
									.trim();
							
							var phoneNo = new RegExp(
									"^[0-9]{9,10}$");
							if (isValid
									&& $('#fName').val() != ""
									&& !firstLastPattern.test($(
											'#fName').val())) {
								isValid = false;
								alert("Enter Valid First Name.");
								$('#fName').focus();
							}
							if (isValid
									&& $('#lName').val() != ""
									&& !firstLastPattern.test($(
											'#lName').val())) {
								isValid = false;
								alert("Enter Valid Last Name.");
								$('#lName').focus();
							}
							if (isValid
									&& $('#emailId').val() != ""
									&& !emailPattren
											.test(emailValue)) {
								isValid = false;
								alert("Enter Valid Email.");
								$('#emailId').focus();
							}
							if (isValid
									&& $('#houseNum').val() != ""
									&& !houseNo.test($('#houseNum')
											.val())) {
								isValid = false;
								alert("Enter Valid House Name.");
								$('#houseNum').focus();
							}
							/*if (isValid
									&& $('#add1').val() != ""
									&& !address12.test($('#add1')
											.val())) {
								isValid = false;
								alert("Enter Valid Address Line1.");
								$('#add1').focus();
							}
							if (isValid
									&& $('#add2').val() != ""
									&& !address12.test($('#add2')
											.val())) {
								isValid = false;
								alert("Enter Valid Address Line2.");
								$('#add2').focus();
							}*/
							if(isValid && $('#add1').val().split(/\n/g).length>4){
								isValid = false;
								alert("Only four lines address allowed.");
								$('#add1').focus();
							} 
							if (isValid &&  $('#add1').val().split(/\n/g).length>4){
								isValid = false;
								alert("Only four lines address allowed.");
								$('#add2').focus();
							}
							if (isValid
									&& $('#mobileNo').val() != ""
									&& !phoneNo.test($('#mobileNo')
											.val())) {
								isValid = false;
								alert("Enter Valid Mobile No.");
								$('#mobileNo').focus();
							}
							if (isReason) {
								if ($('#reason').val() == ""
										|| $('#reason').val() == null) {
									alert("Please enter reason field. ");
									$("#reason").focus();
									isValid = false;
								} else {
									isValid = isValid & true;
								}
							} else {
								isValid = isValid & true;
							}
							if (isValid) {
								var formId = $(this)
										.closest("form").attr("id");
								$("#emailId").val(emailValue);
								$.ajax({
											type : "POST",
											url : $("#" + formId)
													.attr('action'),
											data : $('#' + formId)
													.serialize(),
											async : false,
											success : function(
													result,
													arguments, text) {
												if ((text.responseText)
														.toLowerCase() == "success") {
													$(
															"#plrPersonalInfo")
															.html(
																	" <div class=\"alert saved_msg\"><span class=\"alert_close\"></span><strong>Saved: </strong>Player personal Information were saved..</div>");
													alert("Player Personal info saved.");
												} else if ((text.responseText)
														.toLowerCase() == "error") {
													alert("Server encounter an problem.");
												} else if ((text.responseText)
														.toLowerCase() == "email") {
													alert("Email Already exists.");
													$('#emailId')
															.focus();
												} else if ((text.responseText)
														.toLowerCase() == "mobileno") {
													alert("Mobile No. Already exists.");
													$('#mobileNo')
															.focus();
												}
											}
										});
							}
						});

		$("#dob").datepicker( {
			dateFormat : 'dd/mm/yy',
			changeMonth : true,
			changeYear : true,
			maxDate : $("#dobToDate").val(),
			minDate : '01/01/1900',
			yearRange: "1900:-0"
		});

		$('#editPlayerDetails').click(function() {
			var anchor = $(this);
			var linkArr = $(this).attr('href').split('?');
			var target = $(this).attr('targetPlr');
			$.ajax({
				type : "POST",
				url : linkArr[0],
				data : linkArr[1],
				async : false,
				success : function(result) {
					$('#' + target).html(result);
				}
			});
			return false;
		});
		if($("#ageVerified").val()=="VERIFIED")
			$("#dob").attr('disabled', 'true');
		else
			$("#dob").removeAttr('disabled');
});

function loadCountries(domainId) {
	var jsonList = '["countryList"]';
	var jsonmap = _ajaxCallJson(
			"com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="
					+ domainId + "&jsonList=" + jsonList,
			"");
	$.each(jsonmap["countryList"], function(index, value) {
		$('#plrCountry')
				.append(
						$('<option></option>').val(
								value.countryId).html(
								value.name));
	});

}

function getStates(countryId) {
	var domainId = $("#domainId1").val();
	if (countryId == '-1') {
		$('#plrState').html('');
		$('#plrState').append(
				$('<option></option>').val("-1").html(
						"---Please Select---"));
		return;
	}
	var jsonList = '["stateList"]';
	var jsonmap = _ajaxCallJson(
			"com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="
					+ domainId + "&jsonList=" + jsonList
					+ "&countryId=" + countryId, "");
	$('#plrState').html('');
	$('#plrState').append(
			$('<option></option>').val("-1").html(
					"---Please Select---"));
	$.each(jsonmap["stateList"], function(index, value) {
		$('#plrState').append(
				$('<option selected ></option>').val(
						value.stateId).html(value.name));

	});

}