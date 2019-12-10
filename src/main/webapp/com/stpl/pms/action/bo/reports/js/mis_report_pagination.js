	var flagPage = 0;
	var x ="";
	var y ="";
		$(document).ready(function() {
			$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
				if($("#rowCount").text()==101 && $("#search").val()==""){
 					$("#misReports_next").removeClass("disabled");
	 				$("[data-dt-idx='5']").addClass('nextCall');
				}
 				});
 				$(document).on("click", "[data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[data-dt-idx='1']").text()>1)
 						$("#misReports_previous").removeClass("disabled");
	 				$("[data-dt-idx='1']").addClass('prevCall');
 				});
 				$('#misReports_next').live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#misReports_next").removeClass("disabled");
								}
								if($("#misReports_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').attr("data-dt-idx")==4){
										$("[data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').attr("data-dt-idx")<5){
									$("[data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').attr("data-dt-idx")==5   && !($("[data-dt-idx='5']").hasClass("nextCall") )){
									$("[data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[data-dt-idx='5']").hasClass("nextCall")  && !($("#misReports_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.val()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 x = document.getElementById("misReports_paginate").lastChild.innerHTML;
									document.getElementById("misReports_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('.paginate_button ').css("pointer-events","none");
									$('#misReports_paginate > a:last-child').addClass('waitBtn');
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+ $(
															"#reportData")
															.val()
													+ "&startIndex="
													+ $(
															'#startIndex')
															.val()
													+ "&recordTofetch="
													+ $(
															"#recordTofetch")
															.val(),
											"",
											function(response) {
												displayData(response);
											});
								}else
									return false;	
								
							});
							$('#misReports_previous').live('click', function(e) {
									if($("[data-dt-idx='1']").text()>1){
 										$("#misReports_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').attr("data-dt-idx")==2){
										$("[data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').attr("data-dt-idx")>1){
										$("[data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').attr("data-dt-idx")==1   && !($("[data-dt-idx='1']").hasClass("prevCall"))){
										$("[data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[data-dt-idx='1']").hasClass("prevCall") && !($("#misReports_previous").hasClass("disabled"))) {	
									var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("misReports_paginate").firstChild.innerHTML;
									document.getElementById("misReports_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#misReports_paginate > a:first-child').addClass('waitBtn');
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+ $(
															"#reportData")
															.val()
													+ "&startIndex="
													+ $(
															'#startIndex')
															.val()
													+ "&recordTofetch="
													+ $(
															"#recordTofetch")
															.val(),
											"",
											function(response) {
												displayDataPrev(response);
											});
								}
							});
							$(document).on('keyup', '#search', function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								}else if($("[data-dt-idx='1']").text()>1){
									$("#misReports_previous").removeClass("disabled");
									$("[data-dt-idx='1']").addClass("prevCall");
								}
							});
							
							fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 101)
				$("#misReports_next").addClass("disabled");
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#misReports').dataTable().fnDestroy();
			$("#" + 'misReports')
					.DataTable(
							{
								"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
								"sAjaxDataProp" : "resultList",
								"sServerMethod" : "POST",
								"scrollX" : true,
								"deferRender" : true,
								"aaSorting" : [],
								"pageLength" : 20,
								"bLengthChange" : false,
								"oLanguage" : {
									"sInfo" : '',
								},
								"columnDefs" : [ {
									"targets" : 'no-sort',
									"orderable" : false,
								} ],
								//"searching" : false,
								"bSort" : false,
								"aoColumnDefs" : [ {
									'bSortable' : false,
									"aTargets" : [ 0 ],
									"mRender" : function(data, type, full) {
										return '<input type="checkbox" id="checkBoxId_'+data+'" value ="'+data+'" class ="'+full[1]+'">&nbsp;'
												+ data + '</input>';
									}
								} ],
								 "fnInitComplete": function( oSettings) {
 									$("#misReports_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misReports_paginate").lastChild.innerHTML = x;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
								});
								},
								"fnDrawCallback" : function(oSettings) {
									if($("#search").val()==""){
										flagPage++;
										if(flagPage < 3) {
											return false;
										}
										var currentPageNum = nextPage-$(".dataTables_paginate>span>.paginate_button").length;
										$($(".dataTables_paginate>span>.paginate_button")).each(function(){
											$(this).text(currentPageNum);
											currentPageNum++;
										});
									}else if($('span:last').hasClass("current")){
										$("#misReports_next").addClass("disabled");
									}
								}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#misReports_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#misReports').dataTable().fnDestroy();
			$("#" + 'misReports')
					.DataTable(
							{
								"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
								"sAjaxDataProp" : "resultList",
								"sServerMethod" : "POST",
								"scrollX" : true,
								"deferRender" : true,
								"aaSorting" : [],
								"pageLength" : 20,
								"bLengthChange" : false,
								
								"oLanguage" : {
									"sInfo" : '',
								},
								"columnDefs" : [ {
									"targets" : 'no-sort',
									"orderable" : false,
								} ],
								//"searching" : false,
								"bSort" : false,
								"aoColumnDefs" : [ {
									'bSortable' : false,
									"aTargets" : [ 0 ],
									"mRender" : function(data, type, full) {
										return '<input type="checkbox" id="checkBoxId_'+data+'" value ="'+data+'" class ="'+full[1]+'">&nbsp;'
												+ data + '</input>';
									}
								} ],
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndex').val()==0){
										$("#misReports_previous").addClass("disabled");}
									 else
 										$("#misReports_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misReports_paginate").firstChild.innerHTML = y;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#misReports').dataTable().fnPageChange( 'last' );
									$("#misReports_next").removeClass("disabled");
									$("[data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
									$("#rowCount").text("101");
										flagPage++;
										if(flagPage < 3) {
											return false;
										}
										var currentPageNum = nextPage-$(".dataTables_paginate>span>.paginate_button").length;
										$($(".dataTables_paginate>span>.paginate_button")).each(function(){
											$(this).text(currentPageNum);
											currentPageNum++;
										});
									}
								}
							});
		}
	