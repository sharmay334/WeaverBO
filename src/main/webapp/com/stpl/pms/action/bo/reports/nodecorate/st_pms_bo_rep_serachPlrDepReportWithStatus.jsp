<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Search Data</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
		var flagPage = 0;
		var x ="";
		var y ="";
		$(document).ready(function(){
		$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
    	fromAndToDate();
			var table = $("#reportTable").DataTable({
						"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
						"sAjaxDataProp":"resultList",
						"sServerMethod": "POST",
						"scrollX": true,
						"aaSorting":[],
						"pageLength" : 75,
						"bLengthChange" : false,
						"oLanguage" : {
										"sInfo" : '',
									},
						"aoColumnDefs": [{
							"aTargets": [0],
							"bVisible": false, 
 						},{
							"aTargets": [4],
							"bVisible": false, 
 						}, {
							"aTargets": [5],
							"bVisible": false, 
 						}, 
 						 {
							"aTargets": [3],
							"mRender": function (data, type, full) {
								return '<a  style="cursor: pointer;"'+'onclick="window.open('+"'com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action?openDeco=true&playerId="+full[0]+"','_blank'"+")"+'">'+data+'</a>';
							}
						}/* ,{
						"aTargets": [15],
						"mRender": function (data, type, full) {
					 if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && (full[9]=="EBS"))
					 	return '<a  id=requery_'+full[1]+' class="info_link" style="cursor:pointer" >Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="ATOM")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="CASHFREE")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else
							return '<a   style="pointer-events: none; cursor: default;color:#D7DBDE">--</a>';
						} 
					} */],
					"createdRow": function ( row, data, index ) {
						if(data[7]!=data[6] && "--"!=data[7]){
							$("td:eq(4)",row).css('color', 'red');
							$("td:eq(4)",row).css('font-weight', 'bold');
						}	            
			        },
					"fnDrawCallback" : function(oSettings){
						$(".info_link").click(function(){
							var selectedBtn=this;
						 	var alreadyClicked = $(this).data("clicked");
						    if (alreadyClicked) {
						      	return false;
						   }
						   	$(this).data('clicked', true);
							var rowData = table.row($(this).parent().parent()).data();
							var reqId = rowData[1];
									   	if(rowData[9]=='ATOM'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryATOM.action";
									   	}
									   	else if(rowData[9]=='EBS'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryEBS.action";
									   	}
									   	else if(rowData[9]=='CASHFREE'){
									 	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryCASHFREE.action";
									   	}
 									  _ajaxCallJsonSynch(urlVal+"?requestId=" + rowData[1], "", function(response) {
 									  				$("#expandIt").show();
													if(response == "success"){	
													 		$(selectedBtn).text("--");
															$(selectedBtn).css("pointer-events","none");
													 		$(selectedBtn).css("cursor","default");
													   		$(selectedBtn).css("color","#D7DBDE");
													 $("#resp").text("Requery done and system has been updated according to the payment gateway response for request id "+reqId+".");
													}else if(response=="Exceeded 90 days from the date of transaction."){
														 $("#resp").text("The transaction date of request id "+reqId+" is more than 90 days old.");
														 $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
														else if(response=="No Record Found"){
														 $("#resp").text("No Record Found.");
														  $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
													  else
													  		$("#resp").text("Response from payment gateway for request id "+reqId+" is Fail.");
														 
													
												
											}); 
										
							});
							}
					}); 
 				$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==376 && $("#search").val()==""){
	 					$("#reportTable_next").removeClass("disabled");
		 				$("[data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[data-dt-idx='1']").text()>1)
 						$("#reportTable_previous").removeClass("disabled");
	 				$("[data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#reportTable_next").live('click', function(e) {
								if($("#rowCount").text()==376 && $("#search").val()==""){
									$("#reportTable_next").removeClass("disabled");
								}
								if($("#reportTable_next").hasClass("disabled"))
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
								if($("[data-dt-idx='5']").hasClass("nextCall")  && !($("#reportTable_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.val()) + 375;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 x = document.getElementById("reportTable_paginate").lastChild.innerHTML;
									document.getElementById("reportTable_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#reportTable_paginate > a:last-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+ $(
															"#reportData")
															.val().slice(0, -1)+',"proceName":"getPlrDepReportWithStatus"}'
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
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$('#reportTable_previous').live('click', function(e) {
									if($("[data-dt-idx='1']").text()>1){
 										$("#reportTable_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').attr("data-dt-idx")==2){
										$("[data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').attr("data-dt-idx")>1){
										$("[data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').attr("data-dt-idx")==1   && !($("[data-dt-idx='1']").hasClass("prevCall") )){
										$("[data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[data-dt-idx='1']").hasClass("prevCall") && !($("#reportTable_previous").hasClass("disabled"))) {	
									if( parseInt($("#startIndex").val())>0)
									var start = parseInt($("#startIndex").val()) - 375;
											var nextPageStart = parseInt($('.paginate_button.current').text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("reportTable_paginate").firstChild.innerHTML;
									document.getElementById("reportTable_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#reportTable_paginate > a:first-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+$(
															"#reportData")
															.val().slice(0, -1)+',"proceName":"getPlrDepReportWithStatus"}'
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
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$(document).on('keyup', '#search', function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".paginate_button").css("pointer-events","auto");
								}else if($("[data-dt-idx='1']").text()>1){
									$("#reportTable_previous").removeClass("disabled");
									$("[data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 376){
				$("#reportTable_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#reportTable').dataTable().fnDestroy();
			var table = $("#" + 'reportTable')
					.DataTable(
							{
								"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
								"sAjaxDataProp":"resultList",
								"sServerMethod": "POST",
								"scrollX": true,
								"aaSorting":[],
								"pageLength" : 75,
								"bLengthChange" : false,
								"oLanguage" : {
												"sInfo" : '',
											},
								"aoColumnDefs": [{
							"aTargets": [0],
							"bVisible": false, 
 						},{
							"aTargets": [4],
							"bVisible": false, 
 						}, {
							"aTargets": [5],
							"bVisible": false, 
 						}, 
 						 {
							"aTargets": [3],
							"mRender": function (data, type, full) {
								return '<a  style="cursor: pointer;"'+'onclick="window.open('+"'com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action?openDeco=true&playerId="+full[0]+"','_blank'"+")"+'">'+data+'</a>';
							}
						}/* ,{
						"aTargets": [15],
						"mRender": function (data, type, full) {
					 if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && (full[9]=="EBS"))
					 	return '<a  id=requery_'+full[1]+' class="info_link" style="cursor:pointer" >Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="ATOM")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="CASHFREE")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else
							return '<a   style="pointer-events: none; cursor: default;color:#D7DBDE">--</a>';
						} 
					} */],
					"createdRow": function ( row, data, index ) {
						if(data[7]!=data[6] && "--"!=data[7]){
							$("td:eq(4)",row).css('color', 'red');	
							$("td:eq(4)",row).css('font-weight', 'bold');
						}	            
			        },
					
								 "fnInitComplete": function( oSettings) {
 									$("#reportTable_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("reportTable_paginate").lastChild.innerHTML = x;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
								});
								},
								"fnDrawCallback" : function(oSettings) {
								
								
								$(".info_link").click(function(){
							var selectedBtn=this;
						 	var alreadyClicked = $(this).data("clicked");
						    if (alreadyClicked) {
						      	return false;
						   }
						   	$(this).data('clicked', true);
							var rowData = table.row($(this).parent().parent()).data();
							var reqId = rowData[1];
									   	if(rowData[9]=='ATOM'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryATOM.action";
									   	}
									   	else if(rowData[9]=='EBS'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryEBS.action";
									   	}
									   	else if(rowData[9]=='CASHFREE'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryCASHFREE.action";
									   	}
 									  _ajaxCallJsonSynch(urlVal+"?requestId=" + rowData[1], "", function(response) {
 									  				$("#expandIt").show();
													if(response == "success"){	
													 		$(selectedBtn).text("--");
															$(selectedBtn).css("pointer-events","none");
													 		$(selectedBtn).css("cursor","default");
													   		$(selectedBtn).css("color","#D7DBDE");
													 $("#resp").text("Requery done and system has been updated according to the payment gateway response for request id "+reqId+".");
													}else if(response=="Exceeded 90 days from the date of transaction."){
														 $("#resp").text("The transaction date of request id "+reqId+" is more than 90 days old.");
														 $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
														else if(response=="No Record Found"){
														 $("#resp").text("No Record Found.");
														  $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
													  else
													  		$("#resp").text("Response from payment gateway for request id "+reqId+" is Fail.");
														 
													
												
											}); 
										
							});
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
										$("#reportTable_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 376)
				$("#reportTable_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#reportTable').dataTable().fnDestroy();
		var table = 	$("#" + 'reportTable')
					.DataTable(
							{
								"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
								"sAjaxDataProp":"resultList",
								"sServerMethod": "POST",
								"scrollX": true,
								"aaSorting":[],
								"pageLength" : 75,
								"bLengthChange" : false,
								"oLanguage" : {
												"sInfo" : '',
											},
								"aoColumnDefs": [{
							"aTargets": [0],
							"bVisible": false, 
 						},{
							"aTargets": [4],
							"bVisible": false, 
 						}, {
							"aTargets": [5],
							"bVisible": false, 
 						}, 
 						 {
							"aTargets": [3],
							"mRender": function (data, type, full) {
								return '<a  style="cursor: pointer;"'+'onclick="window.open('+"'com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action?openDeco=true&playerId="+full[0]+"','_blank'"+")"+'">'+data+'</a>';
							}
						}/* ,{
						"aTargets": [15],
						"mRender": function (data, type, full) {
					 if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && (full[9]=="EBS"))
					 	return '<a  id=requery_'+full[1]+' class="info_link" style="cursor:pointer" >Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="ATOM")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else if((full[10]=="FAILED"  ||  full[10]=="INITIATED") && full[9]=="CASHFREE")
						return '<a  id=requery_'+full[1]+' class="info_link" style="cursor: pointer;">Requery</a>';
						else
							return '<a   style="pointer-events: none; cursor: default;color:#D7DBDE">--</a>';
						} 
					} */],
					"createdRow": function ( row, data, index ) {
						if(data[7]!=data[6] && "--"!=data[7]){
							$("td:eq(4)",row).css('color', 'red');	
							$("td:eq(4)",row).css('font-weight', 'bold');
						}	            
			        },
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndex').val()==0){
										$("#reportTable_previous").addClass("disabled");}
									 else
 										$("#reportTable_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("reportTable_paginate").firstChild.innerHTML = y;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#reportTable').dataTable().fnPageChange( 'last' );
									$("#reportTable_next").removeClass("disabled");
									$("[data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								
								$(".info_link").click(function(){
							var selectedBtn=this;
						 	var alreadyClicked = $(this).data("clicked");
						    if (alreadyClicked) {
						      	return false;
						   }
						   	$(this).data('clicked', true);
							var rowData = table.row($(this).parent().parent()).data();
							var reqId = rowData[1];
									   	if(rowData[9]=='ATOM'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryATOM.action";
									   	}
									   	else if(rowData[9]=='EBS'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryEBS.action";
									   	}
									   	else if(rowData[9]=='CASHFREE'){
									   	var urlVal="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_reQueryCASHFREE.action";
									   	}
 									  _ajaxCallJsonSynch(urlVal+"?requestId=" + rowData[1], "", function(response) {
 									  				$("#expandIt").show();
													if(response == "success"){	
													 		$(selectedBtn).text("--");
															$(selectedBtn).css("pointer-events","none");
													 		$(selectedBtn).css("cursor","default");
													   		$(selectedBtn).css("color","#D7DBDE");
													 $("#resp").text("Requery done and system has been updated according to the payment gateway response for request id "+reqId+".");
													}else if(response=="Exceeded 90 days from the date of transaction."){
														 $("#resp").text("The transaction date of request id "+reqId+" is more than 90 days old.");
														 $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
														else if(response=="No Record Found"){
														 $("#resp").text("No Record Found.");
														  $(selectedBtn).text("--");
														 $(selectedBtn).css("pointer-events","none");
														 $(selectedBtn).css("cursor","default");
														  $(selectedBtn).css("color","#D7DBDE");
														}
													  else
													  		$("#resp").text("Response from payment gateway for request id "+reqId+" is Fail.");
														 
													
												
											}); 
										
							});
								if($("#search").val()==""){
								$("#rowCount").text("376");
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
					
					
					
		/* $('input[name="txnStatus"]').click(function(){
			txnType=[];
			$("input:checkbox[name=txnStatus]:checked").each(function() {
				txnType.push($(this).val());
			});
			table.draw();	
		});	 */
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					<s:if test="procName!= 'getPlrWithDrawalReportWithStatus'">
						  Player Deposit Reports For Domain : <s:property
							value="%{domainName}" />
					</s:if>
					<s:else>
						  Player WithDrawal Reports For Domain : <s:property
							value="%{domainName}" />
					</s:else>
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>		
			<s:if test="procName!= 'getPlrWithDrawalReportWithStatus'">
				<div class="dataTbl_top">
					<p>
						<a
							href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=plrDepRepWithSatuts">Download
							Excel</a>
					</p>
				</div>
			</s:if>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
							<th nowrap="nowrap">Player ID</th>
							<th style="text-align: center;">Request ID</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Date & Time</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Player UserName</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Domain Name</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Alias Name</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Initiated Amount</th>
						   <th valign="middle" style="text-align: center;" nowrap="nowrap">
							    Txn Amount
							</th>  
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Payment Type</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Payment Sub Type</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Payment GateWay Provider</th>
							<s:if test="procName == 'getPlrWithDrawalReportWithStatus'">
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Ref Txn No</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Ref Txn Date</th>
							</s:if>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Txn Status</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Device</th>	
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
							   Browser
							   </th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
							   OS
							   </th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
							   Model
							   </th>  
							 <!-- <th valign="middle" style="text-align: center;" nowrap="nowrap">
								Re-Query</th>  -->   	
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer" ></div>
			<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 	<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  	<div id="nextPageStart" style="display:none"></div> 
		  	<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
			<div class="animated-striped">Wait</div>
			</div>
			<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
			<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
			</div>
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</s:else>
	</div>
	<div id="expandIt" style="display:none">
			<div class="alert info_msg " style="width: auto" id="resp">
				<span class="alert_close"></span>
			</div>
	
	</div>
</body>
</html>

