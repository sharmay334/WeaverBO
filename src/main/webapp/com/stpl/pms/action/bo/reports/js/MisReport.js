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
$(document).ready(function() {
// $('#domainId').val($('#byDefaultDomainID').val());
			// Last Transaction start
	
					loadAliasName($("#domainId").val());
					$('#domainId').change(function() {
						if($("#domainId").val()=="0"){
							$('#aliasId').html('');
							$('#aliasId').append(
									$('<option></option>').val("-1").html("---Please Select---"));
							$('#proceName').html('');
							$('#proceName').append(
									$('<option></option>').val("-1").html("---Please Select---"));
							if ($('#proceName').val() == "-1") {
								fetchReportData();
								$('#proceName').focus();
								$("#download").attr("disabled",false);
								$("#download").removeClass("disabledDownld");
							}
								
						}
						else{
								$('#aliasId').removeAttr('disabled');
								$("#aliasId").html("");
								loadAliasName($(this).val());
								$('#proceName').html('');
								$('#proceName').append(
										$('<option></option>').val("-1").html("---Please Select---"));
								if ($('#proceName').val() == "-1") {
									fetchReportData();
									$('#proceName').focus();
									$("#download").attr("disabled",false);
									$("#download").removeClass("disabledDownld");
								}
							}
						
					
					});
					function loadAliasName(domainId){
								var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
								$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
								$.each(aliasMap,function(index, value) {
									$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
							  	});
						}
	

					
				$("#toDateLastDep").datetimepicker(
						{
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							numberOfMonths : 1,
							onClose : function(selectedDate) {
								$("#fromDateLastDep").datetimepicker("option",
										"maxDate", selectedDate);
							}
						});
				$("#fromDateLastDep").datetimepicker(
						{
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							numberOfMonths : 1,
							onClose : function(selectedDate) {
								$("#toDateLastDep").datetimepicker("option",
										"minDate", selectedDate);
							}
						});
				// Bonus Details Calender end

				$("#fromDateFirstDep").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateFirstDep").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateFirstDep").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateFirstDep').datetimepicker("option",
										"maxDateTime", new Date(dateText));
							}

						});

				var d = new Date();
				var year = d.getFullYear() - 18;
				d.setFullYear(year);
				$("#fromDateDob").datetimepicker( {
					
					
					dateFormat : 'dd/mm/yy',
					timeFormat : 'HH:mm:ss',
					showSecond: true,
					changeMonth : true,
					changeYear : true,
					yearRange: '1900:-18',
					 maxDate: new Date(year,d.getMonth(),d.getDate()),
					onClose : function(selectedDate) {
						$("#toDateDob").datetimepicker("option", "minDate",selectedDate);
						
					}
				
					
				});
				
					
				$("#toDateDob").datetimepicker( {
				
					dateFormat : 'dd/mm/yy',
					timeFormat : 'HH:mm:ss',
					showSecond: true,
					changeMonth : true,
					changeYear : true,
					numberOfMonths : 1,
					yearRange: '1900:-18',
					 maxDate: new Date(year,d.getMonth(),d.getDate()),
					onClose : function(selectedDate) {
						$('#fromDateDob').
						// $('#domainId').val($('#byDefaultDomainID').val());
						// Last Transaction start

							$("#toDateLastDep").datetimepicker(
									{
										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										numberOfMonths : 1,
										onClose : function(selectedDate) {
											$("#fromDateLastDep").datetimepicker("option",
													"maxDate", selectedDate);
										}
									});
							$("#fromDateLastDep").datetimepicker(
									{
										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										numberOfMonths : 1,
										onClose : function(selectedDate) {
											$("#toDateLastDep").datetimepicker("option",
													"minDate", selectedDate);
										}
									});
							// Bonus Details Calender end

							$("#fromDateFirstDep").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateFirstDep").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateFirstDep").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateFirstDep').datetimepicker("option",
													"maxDateTime", new Date(dateText));
										}

									});

							var d = new Date();
							var year = d.getFullYear() - 18;
							d.setFullYear(year);
							$("#fromDateDob").datetimepicker( {
								
								
								dateFormat : 'dd/mm/yy',
								timeFormat : 'HH:mm:ss',
								showSecond: true,
								changeMonth : true,
								changeYear : true,
								yearRange: '1900:-18',
								 maxDate: new Date(year,d.getMonth(),d.getDate()),
								onClose : function(selectedDate) {
									$("#toDateDob").datetimepicker("option", "minDate",selectedDate);
									
								}
							
								
							});
							
								
							$("#toDateDob").datetimepicker( {
							
								dateFormat : 'dd/mm/yy',
								timeFormat : 'HH:mm:ss',
								showSecond: true,
								changeMonth : true,
								changeYear : true,
								numberOfMonths : 1,
								yearRange: '1900:-18',
								 maxDate: new Date(year,d.getMonth(),d.getDate()),
								onClose : function(selectedDate) {
									$('#fromDateDob').datetimepicker("option", "maxDate",
											selectedDate);
								}
						
							});
							
							$("#fromDateFirstWith").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateFirstWith").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateFirstWith").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateFirstWith').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});
							$("#fromDateLastWith").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateLastWith").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateLastWith").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateLastWith').datetimepicker("option",
													"maxDateTime", new Date(dateText));
										}

									});
							// player report validation start
							$("#fromDateFirstDepPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateFirstDepPR").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateFirstDepPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateFirstDepPR').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});

							$("#fromDateLastDepPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateLastDepPR").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateLastDepPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateLastDepPR').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});

							$("#fromDateLastWithPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateLastWithPR").datetimepicker("option",
													"minDate", dateText);

										}

									});

							$("#toDateLastWithPR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateLastWithPR').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});

							$("#fromDateLastCashGamePR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#toDateLastCashGamePR").datetimepicker(
													"option", "minDate", dateText);

										}

									});

							$("#toDateLastCashGamePR").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#fromDateLastCashGamePR').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});
							
							// player report validation end
							$("#lastWgrFromDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#lastWgrToDate").datetimepicker(
													"option", "minDate", dateText);

										}

									});

							$("#lastWgrToDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#lastWgrFromDate').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});
							$("#bonusExDateFrom").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#bonusExDateTo").datetimepicker(
													"option", "minDate", dateText);

										}

									});

							$("#bonusExDateTo").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#bonusExDateFrom').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});
							$("#firstDepFromDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#firstDepToDate").datetimepicker(
													"option", "minDate", dateText);

										}

									});

							$("#firstDepToDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#firstDepFromDate').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});
							$("#lastDepFromDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$("#lastDepToDate").datetimepicker(
													"option", "minDate", dateText);

										}

									});

							$("#lastDepToDate").datetimepicker(
									{

										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										numberOfMonths : 1,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											$('#lastDepFromDate').datetimepicker(
													"option", "maxDateTime",
													new Date(dateText));
										}

									});

							$("#fromDateLastLogin,#toDateLastLogin").datetimepicker(
									{
										dateFormat : 'dd/mm/yy',
										timeFormat : 'HH:mm:ss',
										showSecond : true,
										maxDate : new Date(),
										showSecond : true,
										changeMonth : true,
										changeYear : true,
										yearRange : '1950:+0',
										onClose : function(dateText, inst) {
											if ($(this).attr('id').indexOf('fromDate') != -1) {
												$('#toDateLastLogin').datetimepicker("option", "minDate",
														dateText);
												$('#toDateLastLogin').datetimepicker("option", "minDateTime",
														new Date(dateText));
											} else if ($(this).attr('id').indexOf('toDate') != -1) {
												$('#fromDateLastLogin').datetimepicker("option", "maxDate",
														dateText);
												$('#fromDateLastLogin').datetimepicker("option", "maxDateTime",
														new Date(dateText));
											}
										}

									});

							
							$(".txnDate").datetimepicker( {
									dateFormat : 'dd/mm/yy',
									timeFormat : 'HH:mm:ss',
									showSecond : true,
									maxDate : new Date(),
									showSecond : true,
									changeMonth : true,
									changeYear : true,
									yearRange : '1950:+0'
								});
							
							$('form').submit(function() {
								if(validateForm() && $("#redirect").val()!='') {
									if($("#redirect").val()=="Search" ) {
										return ajaxCall(this);
									} else if ($("#redirect").val()=="Excel") {
										return true;
									} 
								} else {
									$("#waitDiv").hide();
									$("#searchButtonMis").show();
									$("#download").attr("disabled",false);
									$("#searchButtonMis").removeAttr("disabled");
									return false;
								}	
							});

							setDefaultDate();
							
					        $("#searchButtonMis").click(function(){
					           $("#startIndex").val("0");
					           $( "#misBusinessSummary_next" ).die( "click" );
					           $( "#misBusinessSummary_previous" ).die( "click" );
					          /* $( "#misReports_next" ).die( "click" );
					           $( "#misReports_previous" ).die( "click" );
					           $( "#misReportsCount_next" ).die( "click" );
					           $( "#misReportsCount_previous" ).die( "click" );*/
					           $("#redirect").val("Search");
					           $("#playerSearchFrm").attr("target","searchResult");
					           $("#searchButtonMis").hide();
					           $("#waitDiv").show();
					           $("#download").attr("disabled",true);
					           $("#download").addClass("disabledDownld");
					           $("#searchButtonMis").attr("disabled",true);
					           $("#playerSearchFrm").submit();
					           return false;
					        });	
						datetimepicker("option", "maxDate",
								selectedDate);
					}
			
				});
				
				$("#fromDateFirstWith").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateFirstWith").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateFirstWith").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateFirstWith').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});
				$("#fromDateLastWith").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateLastWith").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateLastWith").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateLastWith').datetimepicker("option",
										"maxDateTime", new Date(dateText));
							}

						});
				// player report validation start
				$("#fromDateFirstDepPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateFirstDepPR").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateFirstDepPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateFirstDepPR').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});

				$("#fromDateLastDepPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateLastDepPR").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateLastDepPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateLastDepPR').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});

				$("#fromDateLastWithPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateLastWithPR").datetimepicker("option",
										"minDate", dateText);

							}

						});

				$("#toDateLastWithPR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateLastWithPR').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});

				$("#fromDateLastCashGamePR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#toDateLastCashGamePR").datetimepicker(
										"option", "minDate", dateText);

							}

						});

				$("#toDateLastCashGamePR").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#fromDateLastCashGamePR').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});
				
				// player report validation end
				$("#lastWgrFromDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#lastWgrToDate").datetimepicker(
										"option", "minDate", dateText);

							}

						});

				$("#lastWgrToDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#lastWgrFromDate').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});
				$("#bonusExDateFrom").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#bonusExDateTo").datetimepicker(
										"option", "minDate", dateText);

							}

						});

				$("#bonusExDateTo").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#bonusExDateFrom').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});
				$("#firstDepFromDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#firstDepToDate").datetimepicker(
										"option", "minDate", dateText);

							}

						});

				$("#firstDepToDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#firstDepFromDate').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});
				$("#lastDepFromDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$("#lastDepToDate").datetimepicker(
										"option", "minDate", dateText);

							}

						});

				$("#lastDepToDate").datetimepicker(
						{

							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							numberOfMonths : 1,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								$('#lastDepFromDate').datetimepicker(
										"option", "maxDateTime",
										new Date(dateText));
							}

						});

				$("#fromDateLastLogin,#toDateLastLogin").datetimepicker(
						{
							dateFormat : 'dd/mm/yy',
							timeFormat : 'HH:mm:ss',
							showSecond : true,
							maxDate : new Date(),
							showSecond : true,
							changeMonth : true,
							changeYear : true,
							yearRange : '1950:+0',
							onClose : function(dateText, inst) {
								if ($(this).attr('id').indexOf('fromDate') != -1) {
									$('#toDateLastLogin').datetimepicker("option", "minDate",
											dateText);
									$('#toDateLastLogin').datetimepicker("option", "minDateTime",
											new Date(dateText));
								} else if ($(this).attr('id').indexOf('toDate') != -1) {
									$('#fromDateLastLogin').datetimepicker("option", "maxDate",
											dateText);
									$('#fromDateLastLogin').datetimepicker("option", "maxDateTime",
											new Date(dateText));
								}
							}

						});

				
				$(".txnDate").datetimepicker( {
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						maxDate : new Date(),
						showSecond : true,
						changeMonth : true,
						changeYear : true,
						yearRange : '1950:+0'
					});
				
				$('form').submit(function() {
					if(validateForm() && $("#redirect").val()!='') {
						if($("#redirect").val()=="Search" ) {
							return ajaxCall(this);
						} else if ($("#redirect").val()=="Excel") {
							return true;
						} 
					} else {
						$("#waitDiv").hide();
						$("#searchButtonMis").show();
						$("#download").attr("disabled",false);
						$("#searchButtonMis").removeAttr("disabled");
						return false;
					}	
				});

				setDefaultDate();
				
		        $("#searchButtonMis").click(function(){
		           $("#startIndex").val("0");
		           $( "#misBusinessSummary_next" ).die( "click" );
		           $( "#misBusinessSummary_previous" ).die( "click" );
		          /* $( "#misReports_next" ).die( "click" );
		           $( "#misReports_previous" ).die( "click" );
		           $( "#misReportsCount_next" ).die( "click" );
		           $( "#misReportsCount_previous" ).die( "click" );*/
		           $("#redirect").val("Search");
		           $("#playerSearchFrm").attr("target","searchResult");
		           $("#searchButtonMis").hide();
		           $("#waitDiv").show();
		           $("#download").attr("disabled",true);
		           $("#download").addClass("disabledDownld");
		           $("#searchButtonMis").attr("disabled",true);
		           $("#playerSearchFrm").submit();
		           return false;
		        });	
			});

function ajaxCall(form) {
	var form = $(form);
	var target = form.attr('target');
	var callback = (typeof form.attr('callBack') !== 'undefined') ? form
			.attr('callBack') : '';
	$.ajax( {
		type : "POST",
		url : form.attr('action'),
		data : form.serialize(),
		success : function(result) {
			$('#' + target).html(result);
			eval('createBubble()');
			if (callback != '') {
				eval(callback);
			}
		}
	});
	return false;
}

function validateForm() {
	var vipCriteria = new Array();
	var bonusCriteriaBeanArray = new Array();
	isValid = true;

	if ((isValid
			&& $('#fromDateFirstDep').val() != "" && $(
			'#toDateFirstDep').val() == "")
			|| (isValid
					&& $('#fromDateFirstDep')
							.val() == "" && $(
					'#toDateFirstDep').val() != "")) {
		alert("Fill first deposit from and to date.");
		isValid = false;
		$('#fromDateFirstDep').focus();
	}
	if ((isValid
			&& $('#fromDateDob').val() != "" && $(
			'#toDateDob').val() == "")
			|| (isValid
					&& $('#fromDateDob').val() == "" && $(
					'#toDateDob').val() != "")) {
		alert("Fill DOB from and to date.");
		isValid = false;
		$('#fromDateDob').focus();
	}
	if ((isValid
			&& $('#fromDateLastDep').val() != "" && $(
			'#toDateLastDep').val() == "")
			|| (isValid
					&& $('#fromDateLastDep')
							.val() == "" && $(
					'#toDateLastDep').val() != "")) {
		alert("Fill last deposit  from and to date.");
		isValid = false;
		$('#fromDateLastDep').focus();
	}

	if ((isValid
			&& $('#fromDateFirstWith').val() != "" && $(
			'#toDateFirstWith').val() == "")
			|| (isValid
					&& $('#fromDateFirstWith')
							.val() == "" && $(
					'#toDateFirstWith').val() != "")) {
		alert("Fill first withdrawal from and to date.");
		isValid = false;
		$('#fromDateFirstWith').focus();
	}

	if ((isValid
			&& $('#fromDateLastWith').val() != "" && $(
			'#toDateLastWith').val() == "")
			|| (isValid
					&& $('#fromDateLastWith')
							.val() == "" && $(
					'#toDateLastWith').val() != "")) {
		alert("Fill last withdrawal   from and to date.");
		isValid = false;
		$('#fromDateLastWith').focus();
	}
	// player report validation start
	 
		if ((isValid && $('#fromDateFirstDepPR').val() != "" && $('#toDateFirstDepPR').val() == "")
			|| (isValid && $('#fromDateFirstDepPR').val() == "" && $('#toDateFirstDepPR').val() != "")) {
				alert("Fill first deposit from and to date.");
				isValid = false;
				$('#fromDateFirstDepPR').focus();
			}

			if ((isValid && $('#fromDateLastDepPR').val() != "" && $('#toDateLastDepPR').val() == "")
			|| (isValid && $('#fromDateLastDepPR').val() == "" && $('#toDateLastDepPR').val() != "")) {
				alert("Fill last deposit from and to date.");
				isValid = false;
				$('#fromDateLastDepPR').focus();
			}

			if ((isValid && $('#fromDateLastWithPR').val() != "" && $('#toDateLastWithPR').val() == "")
			|| (isValid && $('#fromDateLastWithPR').val() == "" && $('#toDateLastWithPR').val() != "")) {
				alert("Fill last withdrawal from and to date.");
				isValid = false;
				$('#fromDateLastWithPR').focus();
			}


			if ((isValid && $('#fromDateLastCashGamePR').val() != "" && $('#toDateLastCashGamePR').val() == "")
			|| (isValid && $('#fromDateLastCashGamePR').val() == "" && $('#toDateLastCashGamePR').val() != "")) {
				alert("Fill last cash game played from and to date.");
				isValid = false;
				$('#fromDateLastCashGamePR').focus();
			}

// alias validation 			
			if ($('#aliasId').val() == "-1") {
				alert("Please select the Alias");
				$("#download").attr("disabled",false);
				  $("#download").removeClass("disabledDownld");
				isValid = false;
				$('#aliasId').focus();
				return false;
			}
	// player report validation end

	if ($('#proceName').val() == "-1") {
		alert("Please select the Report Type");
		$("#download").attr("disabled",false);
		  $("#download").removeClass("disabledDownld");
		isValid = false;
		$('#proceName').focus();
	}
	if($('#proceName').val() != "-1" && $('#proceName').val() == "StateWiseReport" && $('#whatToGet').val() == "-1"){
        alert("Please select the StateWise Report Type");
        $("#download").attr("disabled",false);
        $("#download").removeClass("disabledDownld");
        isValid = false;
        $('#whatToGet').focus();
	}
    if($('#proceName').val() != "-1" && $('#proceName').val() == "itPlayerWise" && $('#taxmonthwise').val() == "-1"){
        alert("Please select the Month");
        $("#download").attr("disabled",false);
        $("#download").removeClass("disabledDownld");
        isValid = false;
        $('#taxmonthwise').focus();
    }
    if($('#proceName').val() != "-1" && $('#proceName').val() == "itPlayerWise" && $('#financialyear').val() == "-1"){
        alert("Please select the Financial Year");


        $("#download").attr("disabled",false);
        $("#download").removeClass("disabledDownld");
        isValid = false;
        $('#financialyear').focus();
    }

    if($('#proceName').val() != "-1" && $('#proceName').val() == "itPlayerWise"  &&  document.getElementById("taxreportwiseSTATEWISE").checked==true && $('#taxstatewise').val() == "-1"){
        alert("Please Select the State");

        $("#download").attr("disabled",false);
        $("#download").removeClass("disabledDownld");
        isValid = false;
        $('#taxreportwise').focus();
    }

	if ($('#minimumDepAmt').val() != ''
			|| $('#maximumDepAmt').val() != '') {
		if ($('#minimumDepAmt').val() == '') {
			alert("Please enter minimum deposit amount");
			$('#minimumDepAmt').focus();
			isValid = false;
		} else if ($('#maximumDepAmt').val() == '') {
			alert("Please enter maximum deposit amount");
			$('#maximumDepAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minimumDepAmt')
				.val()) > parseFloat($(
				'#maximumDepAmt').val())) {
			alert("Deposit amount must be in correct order(Min<Max)");
			$('#minimumDepAmt').focus();
			isValid = false;
		}
	}
	if ($('#minimumWithAmt').val() != ''
			|| $('#maximumWithAmt').val() != '') {
		if ($('#minimumWithAmt').val() == '') {
			alert("Please enter minimum withdrawal amount");
			$('#minimumWithAmt').focus();
			isValid = false;
		} else if ($('#maximumWithAmt').val() == '') {
			alert("Please enter maximum withdrawal amount");
			$('#maximumWithAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minimumWithAmt')
				.val()) > parseFloat($(
				'#maximumWithAmt').val())) {
			alert("Withdrawal amount must be in correct order(Min<Max)");
			$('#minimumWithAmt').focus();
			isValid = false;
		}
	}

	if ($('#minimumLastDepAmt').val() != ''
			|| $('#maximumLastDepAmt').val() != '') {
		if ($('#minimumLastDepAmt').val() == '') {
			alert("Please enter minimum last deposit amount");
			$('#minimumLastDepAmt').focus();
			isValid = false;
		} else if ($('#maximumLastDepAmt')
				.val() == '') {
			alert("Please enter maximum last deposit amount");
			$('#maximumLastDepAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minimumLastDepAmt')
				.val()) > parseFloat($(
				'#maximumLastDepAmt').val())) {
			alert("Last deposit amount must be in correct order(Min<Max)");
			$('#minimumLastDepAmt').focus();
			isValid = false;
		}
	}
	if ($('#minimumLastWithAmt').val() != ''
			|| $('#maximumLastWithAmt').val() != '') {
		if ($('#minimumLastWithAmt').val() == '') {
			alert("Please enter minimum last withdrawal amount");
			$('#minimumLastWithAmt').focus();
			isValid = false;
		} else if ($('#maximumLastWithAmt')
				.val() == '') {
			alert("Please enter maximum last withdrawal amount");
			$('#maximumLastWithAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minimumLastWithAmt')
				.val()) > parseFloat($(
				'#maximumLastWithAmt').val())) {
			alert("Last withdrawal amount must be in correct order(Min<Max)");
			$('#minimumLastWithAmt').focus();
			isValid = false;
		}
	}
	
	// player report valid start
	if ($('#minTotalDepAmtPR').val() != ''|| $('#maxTotalDepAmtPR').val() != '') {
		if ($('#minTotalDepAmtPR').val() == '') {
			alert("Please enter minimum  total deposit amount ");
			$('#minTotalDepAmtPR').focus();
			isValid = false;
		} else if ($('#maxTotalDepAmtPR').val() == '') {
			alert("Please enter maximum total deposit amount");
			$('#maxTotalDepAmtPR').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotalDepAmtPR').val()) > parseFloat($('#maxTotalDepAmtPR').val())) {
			alert("Total deposit amount must be in correct order(Min<Max)");
			$('#minTotalDepAmtPR').focus();
			isValid = false;
		}
	}

	if ($('#minTotalWithAmtPR').val() != ''|| $('#maxTotalWithAmtPR').val() != '') {
		if ($('#minTotalWithAmtPR').val() == '') {
			alert("Please enter minimum total withdrawal amount");
			$('#minTotalWithAmtPR').focus();
			isValid = false;
		} else if ($('#maxTotalWithAmtPR').val() == '') {
			alert("Please enter maximum total withdrawal amount");
			$('#maxTotalWithAmtPR').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotalWithAmtPR').val()) > parseFloat($('#maxTotalWithAmtPR').val())) {
			alert("Total withdrawal amount must be in correct order(Min<Max)");
			$('#minTotalWithAmtPR').focus();
			isValid = false;
		}
	}

	if ($('#minCashBalPR').val() != ''|| $('#maxCashBalPR').val() != '') {
		if ($('#minCashBalPR').val() == '') {
			alert("Please enter minimum cash balance");
			$('#minCashBalPR').focus();
			isValid = false;
		} else if ($('#maxCashBalPR').val() == '') {
			alert("Please enter maximum cash balance");
			$('#maxCashBalPR').focus();
			isValid = false;
		}
		if (parseFloat($('#minCashBalPR').val()) > parseFloat($('#maxCashBalPR').val())) {
			alert("cash balance must be in correct order(Min<Max)");
			$('#minCashBalPR').focus();
			isValid = false;
		}
	}


	if ($('#minBonusBalPR').val() != ''|| $('#maxBonusBalPR').val() != '') {
		if ($('#minBonusBalPR').val() == '') {
			alert("Please enter minimum bonus balance");
			$('#minBonusBalPR').focus();
			isValid = false;
		} else if ($('#maxBonusBalPR').val() == '') {
			alert("Please enter maximum bonus balance");
			$('#maxBonusBalPR').focus();
			isValid = false;
		}
		if (parseFloat($('#minBonusBalPR').val()) > parseFloat($('#maxBonusBalPR').val())) {
			alert("Bonus balance must be in correct order(Min<Max)");
			$('#minBonusBalPR').focus();
			isValid = false;
		}
	}

	if ($('#minPromoBalPR').val() != ''|| $('#maxPromoBalPR').val() != '') {
		if ($('#minPromoBalPR').val() == '') {
			alert("Please enter minimum promo chips  balance");
			$('#minPromoBalPR').focus();
			isValid = false;
		} else if ($('#maxPromoBalPR').val() == '') {
			alert("Please enter maximum promo chips  balance");
			$('#maxPromoBalPR').focus();
			isValid = false;
		}
		if (parseFloat($('#minPromoBalPR').val()) > parseFloat($('#maxPromoBalPR').val())) {
			alert("Promo chips  balance must be in correct order(Min<Max)");
			$('#minPromoBalPR').focus();
			isValid = false;
		}
	}


	if ($('#minNoCashGamePR').val() != ''|| $('#maxNoCashGamePR').val() != '') {
		if ($('#minNoCashGamePR').val() == '') {
			alert("Please enter minimum no. of cash game");
			$('#minNoCashGamePR').focus();
			isValid = false;
		} else if ($('#maxNoCashGamePR').val() == '') {
			alert("Please enter maximum no. of cash game ");
			$('#maxNoCashGamePR').focus();
			isValid = false;
		}
		if (parseFloat($('#minNoCashGamePR').val()) > parseFloat($('#maxNoCashGamePR').val())) {
			alert("No of cash game must be in correct order(Min<Max)");
			$('#minNoCashGamePR').focus();
			isValid = false;
		}
	}

	if ($('#minNoFreeGamePR').val() != ''|| $('#maxNoFreeGamePR').val() != '') {
		if ($('#minNoFreeGamePR').val() == '') {
			alert("Please enter minimum no. of free game");
			$('#minNoFreeGamePR').focus();
			isValid = false;
		} else if ($('#maxNoFreeGamePR').val() == '') {
			alert("Please enter maximum no. of free game ");
			$('#maxNoFreeGamePR').focus();
			isValid = false;
		}
		if (parseFloat($('#minNoFreeGamePR').val()) > parseFloat($('#maxNoFreeGamePR').val())) {
			alert("No of free game must be in correct order(Min<Max)");
			$('#minNoFreeGamePR').focus();
			isValid = false;
		}
	}
	// player report valid end
   
     // player balance valid start
     				
	if ($('#minTotDepAmt').val() != ''
		|| $('#maxTotDepAmt').val() != '') {
		if ($('#minTotDepAmt').val() == '') {
			alert("Please enter minimum deposit amount");
			$('#minTotDepAmt').focus();
			isValid = false;
		} else if ($('#maxTotDepAmt').val() == '') {
			alert("Please enter maximum deposit amount");
			$('#maxTotDepAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotDepAmt').val()) > parseFloat($(
				'#maxTotDepAmt').val())) {
			alert("Deposit amount must be in correct order(Min<Max)");
			$('#minTotDepAmt').focus();
			isValid = false;
		}
	}
	
	if ($('#minTotBonus').val() != ''
			|| $('#maxTotBonus').val() != '') {
		if ($('#minTotBonus').val() == '') {
			alert("Please enter minimum bonus amount");
			$('#minTotBonus').focus();
			isValid = false;
		} else if ($('#maxTotBonus').val() == '') {
			alert("Please enter maximum bonus amount");
			$('#maxTotBonus').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotBonus').val()) > parseFloat($(
				'#maxTotBonus').val())) {
			alert("Bonus amount must be in correct order(Min<Max)");
			$('#minTotBonus').focus();
			isValid = false;
		}
	}
 
	if ($('#minTotWin').val() != ''
			|| $('#maxTotWin').val() != '') {
		if ($('#minTotWin').val() == '') {
			alert("Please enter minimum Winning");
			$('#minTotWin').focus();
			isValid = false;
		} else if ($('#maxTotWin').val() == '') {
			alert("Please enter maximum Winning");
			$('#maxTotWin').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotWin').val()) > parseFloat($(
				'#maxTotWin').val())) {
			alert("Winning must be in correct order(Min<Max)");
			$('#minTotWin').focus();
			isValid = false;
		}
	} 

	if ($('#minTotWgr').val() != ''
			|| $('#maxTotWgr').val() != '') {
		if ($('#minTotWgr').val() == '') {
			alert("Please enter minimum Wager");
			$('#minTotWgr').focus();
			isValid = false;
		} else if ($('#maxTotWgr').val() == '') {
			alert("Please enter maximum Wager");
			$('#maxTotWgr').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotWgr').val()) > parseFloat($(
				'#maxTotWgr').val())) {
			alert("Wager must be in correct order(Min<Max)");
			$('#minTotWgr').focus();
			isValid = false;
		}
	}

	if ($('#minAccBal').val() != ''
			|| $('#maxAccBal').val() != '') {
		if ($('#minAccBal').val() == '') {
			alert("Please enter minimum account balance");
			$('#minAccBal').focus();
			isValid = false;
		} else if ($('#maxAccBal').val() == '') {
			alert("Please enter maximum account balance");
			$('#maxAccBal').focus();
			isValid = false;
		}
		if (parseFloat($('#minAccBal').val()) > parseFloat($(
				'#maxAccBal').val())) {
			alert("Account balance must be in correct order(Min<Max)");
			$('#minAccBal').focus();
			isValid = false;
		}
	}

	if ($('#minTourWin').val() != ''
			|| $('#maxTourWin').val() != '') {
		if ($('#minTourWin').val() == '') {
			alert("Please enter minimum Tournament amount");
			$('#minTourWin').focus();
			isValid = false;
		} else if ($('#maxTourWin').val() == '') {
			alert("Please enter maximum Tournament amount");
			$('#maxTourWin').focus();
			isValid = false;
		}
		if (parseFloat($('#minTourWin').val()) > parseFloat($(
				'#maxTourWin').val())) {
			alert("Tournament amount must be in correct order(Min<Max)");
			$('#minTourWin').focus();
			isValid = false;
		}
	}
     // player balance valid end
     
// wager and winning valid start
	if ($('#minWagAmount').val() != ''
		|| $('#maxWagAmount').val() != '') {
		if ($('#minWagAmount').val() == '') {
			alert("Please enter minimum Wager amount");
			$('#minWagAmount').focus();
			isValid = false;
		} else if ($('#maxWagAmount').val() == '') {
			alert("Please enter maximum Wager amount");
			$('#maxWagAmount').focus();
			isValid = false;
		}
		if (parseFloat($('#minWagAmount').val()) > parseFloat($(
				'#maxWagAmount').val())) {
			alert("Wager amount must be in correct order(Min<Max)");
			$('#minWagAmount').focus();
			isValid = false;
		}
	}

	if ($('#minWinAmt').val() != ''
		|| $('#maxWinAmt').val() != '') {
		if ($('#minWinAmt').val() == '') {
			alert("Please enter minimum Winning amount");
			$('#minWinAmt').focus();
			isValid = false;
		} else if ($('#maxWinAmt').val() == '') {
			alert("Please enter maximum Winning amount");
			$('#maxWinAmt').focus();
			isValid = false;
		}
		if (parseFloat($('#minWinAmt').val()) > parseFloat($(
				'#maxWinAmt').val())) {
			alert("Winning amount must be in correct order(Min<Max)");
			$('#minWinAmt').focus();
			isValid = false;
		}
	}

		if ((isValid && $('#lastWgrFromDate').val() != "" && $('#lastWgrToDate').val() == "")
				|| (isValid && $('#lastWgrFromDate').val() == "" && $('#lastWgrToDate').val() != "")) {
			alert("Fill last wager from and to date.");
			isValid = false;
			$('#lastWgrFromDate').focus();
		}
		
		if ((isValid && $('#firstDepFromDate').val() != "" && $('#firstDepToDate').val() == "")
				|| (isValid && $('#firstDepFromDate').val() == "" && $('#firstDepToDate').val() != "")) {
			alert("Fill first deposit from and to date.");
			isValid = false;
			$('#firstDepFromDate').focus();
		}

// wager and winning valid end

// player Bonus valid start

	if ($('#minPlrBonus').val() != ''
		|| $('#maxPlrBonus').val() != '') {
		if ($('#minPlrBonus').val() == '') {
			alert("Please enter minimum Total Bonus");
			$('#minPlrBonus').focus();
			isValid = false;
		} else if ($('#maxPlrBonus').val() == '') {
			alert("Please enter maximum Total Bonus");
			$('#maxPlrBonus').focus();
			isValid = false;
		}
		if (parseFloat($('#minPlrBonus').val()) > parseFloat($(
				'#maxPlrBonus').val())) {
			alert("Total Bonus must be in correct order(Min<Max)");
			$('#minPlrBonus').focus();
			isValid = false;
		}
	}

	if ($('#minReleaseBonus').val() != ''
		|| $('#maxReleaseBonus').val() != '') {
		if ($('#minReleaseBonus').val() == '') {
			alert("Please enter minimum Release Bonus");
			$('#minReleaseBonus').focus();
			isValid = false;
		} else if ($('#maxReleaseBonus').val() == '') {
			alert("Please enter maximum Release Bonus");
			$('#maxReleaseBonus').focus();
			isValid = false;
		}
		if (parseFloat($('#minReleaseBonus').val()) > parseFloat($(
				'#maxReleaseBonus').val())) {
			alert("Release Bonus must be in correct order(Min<Max)");
			$('#minReleaseBonus').focus();
			isValid = false;
		}
	}

	if ($('#minPendingBonus').val() != ''
		|| $('#maxPendingBonus').val() != '') {
		if ($('#minPendingBonus').val() == '') {
			alert("Please enter minimum Pending Bonus");
			$('#minPendingBonus').focus();
			isValid = false;
		} else if ($('#maxPendingBonus').val() == '') {
			alert("Please enter maximum Pending Bonus");
			$('#maxPendingBonus').focus();
			isValid = false;
		}
		if (parseFloat($('#minPendingBonus').val()) > parseFloat($(
				'#maxPendingBonus').val())) {
			alert("Pending Bonus must be in correct order(Min<Max)");
			$('#minPendingBonus').focus();
			isValid = false;
		}
	}

	if ($('#minNoBonus').val() != ''
		|| $('#maxNoBonus').val() != '') {
		if ($('#minNoBonus').val() == '') {
			alert("Please enter minimum No of Bonus");
			$('#minNoBonus').focus();
			isValid = false;
		} else if ($('#maxNoBonus').val() == '') {
			alert("Please enter maximum No of Bonus");
			$('#maxNoBonus').focus();
			isValid = false;
		}
		if (parseFloat($('#minNoBonus').val()) > parseFloat($(
				'#maxNoBonus').val())) {
			alert("No of Bonus must be in correct order(Min<Max)");
			$('#minNoBonus').focus();
			isValid = false;
		}
	}

	if ((isValid && $('#bonusExDateFrom').val() != "" && $('#bonusExDateTo').val() == "")
		|| (isValid && $('#bonusExDateFrom').val() == "" && $('#bonusExDateTo').val() != "")) {
			alert("Fill last bonus Expiry from and to date.");
			isValid = false;
			$('#bonusExDateFrom').focus();
	}
// player bonus valid end
// Mixed Report valid start
	if ($('#minTotDepAmount').val() != ''
		|| $('#maxTotDepAmount').val() != '') {
		if ($('#minTotDepAmount').val() == '') {
			alert("Please enter minimum No Deposit Amount");
			$('#minTotDepAmount').focus();
			isValid = false;
		} else if ($('#maxTotDepAmount').val() == '') {
			alert("Please enter maximum Deposit Amount");
			$('#maxTotDepAmount').focus();
			isValid = false;
		}
		if (parseFloat($('#minTotDepAmount').val()) > parseFloat($(
				'#maxTotDepAmount').val())) {
			alert("Deposit Amount must be in correct order(Min<Max)");
			$('#minTotDepAmount').focus();
			isValid = false;
		}
	}
	if ($('#minFreeGame').val() != ''
		|| $('#maxFreeGame').val() != '') {
		if ($('#minFreeGame').val() == '') {
			alert("Please enter minimum No of Free Games");
			$('#minFreeGame').focus();
			isValid = false;
		} else if ($('#maxFreeGame').val() == '') {
			alert("Please enter maximum no of Free Games");
			$('#maxFreeGame').focus();
			isValid = false;
		}
		if (parseFloat($('#minFreeGame').val()) > parseFloat($(
				'#maxFreeGame').val())) {
			alert("Free Games must be in correct order(Min<Max)");
			$('#minFreeGame').focus();
			isValid = false;
		}
	}
	if ($('#minCashGame').val() != ''
		|| $('#maxCashGame').val() != '') {
		if ($('#minCashGame').val() == '') {
			alert("Please enter minimum No of Cash Games");
			$('#minCashGame').focus();
			isValid = false;
		} else if ($('#maxCashGame').val() == '') {
			alert("Please enter maximum no of Cash Games");
			$('#maxCashGame').focus();
			isValid = false;
		}
		if (parseFloat($('#minCashGame').val()) > parseFloat($(
				'#maxCashGame').val())) {
			alert("Cash Games must be in correct order(Min<Max)");
			$('#minCashGame').focus();
			isValid = false;
		}
	}
	if ((isValid && $('#firstDepFromDate').val() != "" && $('#firstDepToDate').val() == "")
			|| (isValid && $('#firstDepFromDate').val() == "" && $('#firstDepToDate').val() != "")) {
		alert("Fill First Deposit from and to date.");
		isValid = false;
		$('#firstDepFromDate').focus();
	}
	if ((isValid && $('#lastDepFromDate').val() != "" && $('#lastDepToDate').val() == "")
			|| (isValid && $('#lastDepFromDate').val() == "" && $('#lastDepToDate').val() != "")) {
		alert("Fill last Deposit from and to date.");
		isValid = false;
		$('#lastDepFromDate').focus();
	}
	if(isValid==true) {
		$('[id="searchResult"]').show();
	}
	return isValid;
}

function setParam(){
	var reportType = $("#playerSearchFrm").find('#proceName').val();
    var getId=$('#download').val();

	if(reportType=="StateWiseReport" && getId=="Download Excel"){
        $("#playerSearchFrm").attr("action", "com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action");
        $("#reportTypeName").val(reportType);
        $("#redirect").val("Excel");
        $("#playerSearchFrm").removeAttr("target");
        $("#playerSearchFrm").submit();
	}else {
        $("#reportTypeName").val(reportType);
        $("#redirect").val("Excel");
        $("#playerSearchFrm").removeAttr("target");
        $("#playerSearchFrm").submit();
    }
}
$(document).on("change", 'select[name="proceName"]', fetchReportData);

function fetchReportData(){
	$('[class="reportFilter"]').hide();
	$('[id="searchResult"]').html("");
	$('[id=' + $(this).val() + ']').show();
  if($("#proceName").val()=="MisPlayerReport"){
     $("#fromDateField").html("From Date<br/>(registration)");
     $("#toDateField").html("To Date<br/>(registration)");
  }
  if($("#proceName").val()=="MisDepositAndWithdrawal"){
     $("#fromDateField").html("From Date<br/>(transaction)");
     $("#toDateField").html("To Date<br/>(transaction)");
  }
  if($("#proceName").val()=="MisPlayerBonus"){
     $("#fromDateField").html("From Date<br/>(recevied)");
     $("#toDateField").html("To Date<br/>(recevied)");
  }
  if($("#proceName").val()=="MisPlayerBalance"){
     $("#fromDateField").html("From Date<br/>(registration)");
     $("#toDateField").html("To Date<br/>(registration)");
  }
  
  if($("#proceName").val()=="MisMixReport"){
     $("#fromDateField").html("From Date<br/>(registration)");
     $("#toDateField").html("To Date<br/>(registration)");
  }
  if($("#proceName").val()=="MisBusinessSummary"){
     $("#fromDateField").html("From Date");
     $("#toDateField").html("To Date");
  }
  if($("#proceName").val()=="MisPlayerBalanceDayWise"){
    $("#fromDateField").html("From Date<br/>(Registration)");
    $("#toDateField").html("To Date<br/>(Registration)");
  }
  
  if($("#proceName").val()=="MisWagerAndWinning"){
    $("#fromDateField").html("From Date<br/>(wagering)");
    $("#toDateField").html("To Date<br/>(wagering)");
    $('#vipLevel').empty().append(
            $('<option></option>').val("0").html("----Please Select----"));
  	domainId = $("#domainId").val();
  	if(domainId=="0"){
           $("#vipLevel").empty().append(
            $('<option></option>').val("0").html("----Please Select----"));
       return;
     }
    var jsonList = '["vipList"]';
	var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
    $.each(jsonmap["vipList"], function(
            index, value) {
        $('#vipLevel').append($('<option></option>').val(value.vipLevel).html(value.vipCode));
    });
  }
  
  if($("#proceName").val()=="MisRegsitrationReport"){
    $("#fromDateField").html("From Date<br/>(registration)");
    $("#toDateField").html("To Date<br/>(registration)");
    $('#state').empty().append(
            $('<option></option>').val("-1").html("----Please Select----"));
  	domainId = $("#domainId").val();
  	if(domainId=="0"){
           $("#stateList").empty().append(
            $('<option></option>').val("0").html("----Please Select----"));
       return;
     }
    var jsonList = '["stateList"]';
	var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList+"&countryId=105","");
    $.each(jsonmap["stateList"], function(
            index, value) {
        $('#stateList').append($('<option></option>').val(value.stateCode).html(value.name));
    });
  }
  if($("#proceName").val()=="MisDailyPlayReport"){
    $("#fromDateField").html("From Date<br/>(wagering)");
     $("#toDateField").html("To Date<br/>(wagering)");
  }
  if($("#proceName").val()=="MisPlrLoginReport"){
	    $("#fromDateField").html("From Date<br/>(Login)");
	     $("#toDateField").html("To Date<br/>(Login)");
	  }
  if($("#proceName").val()=="PlayerRegIpCountReport"){
	     $("#fromDateField").html("From Date<br/>(registration)");
	     $("#toDateField").html("To Date<br/>(registration)");
	  }
  $("#waitDiv").hide();
  $("#searchButtonMis").show();
  $("#download").attr("disabled",false);
  $("#download").removeClass("disabledDownld");
  $("#searchButtonMis").removeAttr("disabled");
}

function sendMail(){
	$('#sendPlrMail').click(function(){
		var plrList = new Object();
		$('[id*=checkBoxId_]:checked').each(function(index,value){
			plrList[$(this).val()] = $(this).attr('class');
		});
		plrList = JSON.stringify(plrList);
		if($("#procedure").length>0 && $("#procedure").val()!=null && $("#procedure").val()!='' && $("#repData").length>0 && $("#repData").val()!=null && $("#repData").val()!='' )
			$('#sendPlrMail').attr('href','com/stpl/pms/action/bo/pm/st_pm_plr_emailDispatch.action?plrIdList='+plrList+'&domainId='+$('#domainId').val()+'&reportDataType='+$("#procedure").val()+"&reportData="+$('#repData').val());
		else
			$('#sendPlrMail').attr('href','com/stpl/pms/action/bo/pm/st_pm_plr_emailDispatch.action?plrIdList='+plrList+'&domainId='+$('#domainId').val()+'&reportDataType='+$('#proceName').val()+"&reportData="+$('#reportData').val());
	});
}

function distributeBonus(){
	$('#freeBonus').click(function(){
		var isValid = false;
		var plrList = new Object();
		$('[id*=checkBoxId_]:checked').each(function(index,value){
			plrList[$(this).val()] = $(this).attr('class');
			isValid = true;
		});
		if(isValid){
			plrList = JSON.stringify(plrList);
			$('#freeBonus').attr('href','com/stpl/pms/action/bo/bonus/bo_promo_freeCashBonus.action?plrList='+plrList+'&domainId='+$('#domainId').val());
		}
		else{
			$('#freeBonus').attr('href','com/stpl/pms/action/bo/bonus/bo_promo_freeCashBonus.action');
		}
		return isValid;
	});
}

function convertDataTable(){
	if ('misReports'==$('table').attr('id') || ($('table').get(2).id!="" && $('table').get(2).id=="misReports")){
		$("#"+'misReports').DataTable({
		      "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
		      "sAjaxDataProp":"resultList",
			  "sServerMethod": "POST",
		      "scrollX": true,
		      "deferRender": true,
		      "aaSorting":[],
		      "pageLength": 20,
		      "bLengthChange": false,
				"oLanguage" : {
					"sInfo" : '',
				},
				"columnDefs" : [ {
					"targets" : 'no-sort',
					"orderable" : false,
				} ],
				//"searching" : false,
				"bSort" : false,
		      "aoColumnDefs": [{
		    	  'bSortable': false,
			       "aTargets": [0],
			       "mRender": function (data, type, full) {
						return '<input type="checkbox" id="checkBoxId_'+data+'" value ="'+data+'" class ="'+full[1]+'">&nbsp;'+data+'</input>';
		       		}
		      }],
		}); 
	}
	sendMail();
	distributeBonus();
	$('a[rel*="facebox"]').facebox({
		closeImage : 'images/closelabel.png',
	});
	 $("#waitDiv").hide();
     $("#searchButtonMis").show();
     $("#download").attr("disabled",false);
     $("#download").removeClass("disabledDownld");
     $("#searchButtonMis").removeAttr("disabled");
}

$(document).on('click','[id*=checkBoxId_]',function(){
	if(($(this).attr('checked')!='checked') || (typeof $(this).attr('checked')=='undefined')) {
		$(this).removeAttr('checked');
	}else{
		$(this).attr('checked','true');
	}
});
function getMisReportType(){
	if ($('#domainId').val() == '0') {
		$('#proceName').html('');
		$('#proceName').append(
				$('<option></option>').val("-1").html("---Please Select---"));
	}else{
	var jsonList = '["misReportList"]';
	var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_misReportType.action?domainId="
			+ $('#domainId').val() +"&alias="+$('#aliasId').val()+ "&jsonList=" + jsonList,"");

	$('#proceName').html('');
	$('#proceName').append(
			$('<option></option>').val("-1").html("---Please Select---"));
	$.each(jsonmap["misReportList"], function(index, value) {
		$('#proceName').append(
				$('<option></option>').val(value.ReportProcedureName).html(value.ReportName));
	});
	}
	if ($('#proceName').val() == "-1") {
		fetchReportData();
		$('#proceName').focus();
		$("#download").attr("disabled",false);
		$("#download").removeClass("disabledDownld");
	}
	return;

}

function getMisReportTypeAliasWise(){
	var jsonList = '["misReportList"]';
	var aliasId = $('#aliasId').val();
	if(aliasId==2 || aliasId==4){
		$('#gType1').show();
		$('#gType2').hide();
	}else{
		$('#gType1').hide();
		$('#gType2').show();
	}
	if ($('#aliasId').val() != '-1' && $('#domainId').val() != '-1') {
	/*	var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_misReportType.action?domainId="
				+ $('#domainId').val() +"&alias="+$('#aliasId').val()+ "&jsonList=" + jsonList,"");
	}else{*/
		var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_misReportType.action?domainId="
				+ $('#domainId').val() +"&alias="+$('#aliasId').val()+ "&jsonList=" + jsonList,"");
		
		$('#proceName').html('');
		$('#proceName').append(
				$('<option></option>').val("-1").html("---Please Select---"));
		$.each(jsonmap["misReportList"], function(index, value) {
			$('#proceName').append(
					$('<option></option>').val(value.ReportProcedureName).html(value.ReportName));
		});
	}else{
		$('#proceName').html('');
		$('#proceName').append(
				$('<option></option>').val("-1").html("---Please Select---"));
	}
		
	if ($('#proceName').val() == "-1" || $('#aliasId').val() == '-1' ) {
		fetchReportData();
		$('#proceName').focus();
		$("#download").attr("disabled",false);
		$("#download").removeClass("disabledDownld");
	}
	return;
}
function getStateTaxReport(){
    var proceName = $('#proceName').val();

        var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_taxReportState.action");
        $('#taxstatewise').html('');
        $('#taxstatewise').append(
            $('<option></option>').val("-1").html("---Please Select---"));
        $.each(jsonmap["stateList"], function(index, value) {
            $('#taxstatewise').append(
                $('<option></option>').val(value.stateCode).html(value.name));
        });
    $('#taxstatewise').append($('<option></option>').val("Others").html("Others"));

    return;
}
function getAccountReportTypeAliasWise(){
    var jsonList = '["misReportList"]';
    var aliasId = $('#aliasId').val();
    if(aliasId==2 || aliasId==4){
        $('#gType1').show();
        $('#gType2').hide();
    }else{
        $('#gType1').hide();
        $('#gType2').show();
    }
    if ($('#aliasId').val() != '-1' && $('#domainId').val() != '-1') {
		/*	var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_misReportType.action?domainId="
		 + $('#domainId').val() +"&alias="+$('#aliasId').val()+ "&jsonList=" + jsonList,"");
		 }else{*/
        var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/reports/st_pms_bo_rep_accountReportType.action?domainId="
            + $('#domainId').val() +"&alias="+$('#aliasId').val()+ "&jsonList=" + jsonList,"");

        $('#proceName').html('');
        $('#proceName').append(
            $('<option></option>').val("-1").html("---Please Select---"));
        $.each(jsonmap["misReportList"], function(index, value) {
            $('#proceName').append(
                $('<option></option>').val(value.ReportProcedureName).html(value.ReportName));
        });
    }else{
        $('#proceName').html('');
        $('#proceName').append(
            $('<option></option>').val("-1").html("---Please Select---"));
    }

    if ($('#proceName').val() == "-1" || $('#aliasId').val() == '-1' ) {
        fetchReportData();
        $('#proceName').focus();
        $("#download").attr("disabled",false);
        $("#download").removeClass("disabledDownld");
    }
    return;
}