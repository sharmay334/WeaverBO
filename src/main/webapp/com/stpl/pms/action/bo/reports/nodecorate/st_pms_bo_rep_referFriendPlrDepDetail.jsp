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
	var flagStart = 0;
	var x ="";
	var y ="";
	$(document).ready(function(){
	if(flagPage==0){
		$("#startIndex").text("0");
		flagStart = 1;
		}
	$('#waitDiv').hide();
  		$('#waitDiv').hide();
  		$('#submitBtn').show();
  		$('#submitBtn').attr("disabled",false);
    	fromAndToDate();
			 $("#subReportTableRDep").DataTable({
			       "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
			       "sAjaxDataProp":"resultList",
				   "sServerMethod": "POST",
			       "scrollX": true,
			       "aaSorting": [],
			       "pageLength" : 20,
					"bLengthChange" : false,
					"oLanguage" : {
										"sInfo" : '',
									},
					"aoColumnDefs": [{
				"aTargets": [0],
				"mRender": function (data, type, full) {
					if(data!="--")
						return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerWiseDepReport&reportData={"domainId":'+$("#domainId").val()+',"playerId":"'+full[0]+'"}  target='+'"expandResult">'+data+'</a>';
      				else
      					return data;	
      			}
			}],
		});  
 				$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").val()==""){
	 					$("#subReportTableRDep_next").removeClass("disabled");
		 				$("[data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[data-dt-idx='1']").text()>1)
 						$("#subReportTableRDep_previous").removeClass("disabled");
	 				$("[data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#subReportTableRDep_next").live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#subReportTableRDep_next").removeClass("disabled");
								}
								if($("#subReportTableRDep_next").hasClass("disabled"))
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
								if($("[data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTableRDep_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').text(start);
									 x = document.getElementById("subReportTableRDep_paginate").lastChild.innerHTML;
									document.getElementById("subReportTableRDep_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTableRDep_paginate > a:last-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+ $(
															"#reportData")
															.val().slice(0, -1)+',"proceName":"stCmsReferFriendPlrDepReport","startIndex":"'+$(
															'#startIndex')
															.text()+'","recordTofetch":"'+$(
															"#recordTofetch")
															.val()+'","campId":"'+$(
															"#campId")
															.text()+'","subCampId":"'+$(
															"#subCampId")
															.text()+'"}'
													,
											"",
											function(response) {
												displayData(response);
											});
								}else
									return false;	
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$('#subReportTableRDep_previous').live('click', function(e) {
									if($("[data-dt-idx='1']").text()>1){
 										$("#subReportTableRDep_previous").removeClass("disabled");
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
										
									if($("[data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTableRDep_previous").hasClass("disabled"))) {	
									var start = parseInt($("#startIndex").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').text(start);
									 y = document.getElementById("subReportTableRDep_paginate").firstChild.innerHTML;
									document.getElementById("subReportTableRDep_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTableRDep_paginate > a:first-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									_ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
													+ $(
															"#reportData")
															.val().slice(0, -1)+',"proceName":"stCmsReferFriendPlrDepReport","startIndex":"'+$(
															'#startIndex')
															.val()+'","recordTofetch":"'+$(
															"#recordTofetch")
															.val()+'","campId":"'+$(
															"#campId")
															.text()+'","subCampId":"'+$(
															"#subCampId")
															.text()+'"}'
													,
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
									$("#subReportTableRDep_previous").removeClass("disabled");
									$("[data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 101){
				$("#subReportTableRDep_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#subReportTableRDep').dataTable().fnDestroy();
			$("#" + 'subReportTableRDep')
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
								"aoColumnDefs": [{
				"aTargets": [0],
				"mRender": function (data, type, full) {
					if(data!="--")
						return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerWiseDepReport&reportData={"domainId":'+$("#domainId").val()+',"playerId":"'+full[0]+'"}  target='+'"expandResult">'+data+'</a>';
      				else
      					return data;	
      			}
			}],
								//"searching" : false,
								"bSort" : false,
								 "fnInitComplete": function( oSettings) {
 									$("#subReportTableRDep_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableRDep_paginate").lastChild.innerHTML = x;
									$($("#subReportTableRDep_paginate>span>.paginate_button")).each(function(){
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
								var currentPageNum = nextPage-$("#subReportTableRDep_paginate>span>.paginate_button").length;
								$($("#subReportTableRDep_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#subReportTableRDep_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#subReportTableRDep_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#subReportTableRDep').dataTable().fnDestroy();
			$("#" + 'subReportTableRDep')
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
								"aoColumnDefs": [{
				"aTargets": [0],
				"mRender": function (data, type, full) {
					if(data!="--")
						return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerWiseDepReport&reportData={"domainId":'+$("#domainId").val()+',"playerId":"'+full[0]+'"}  target='+'"expandResult">'+data+'</a>';
      				else
      					return data;	
      			}
			}],
								//"searching" : false,
								"bSort" : false,
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndex').val()==0){
										$("#subReportTableRDep_previous").addClass("disabled");}
									 else
 										$("#subReportTableRDep_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableRDep_paginate").firstChild.innerHTML = y;
									$($("#dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTableRDep').dataTable().fnPageChange( 'last' );
									$("#subReportTableRDep_next").removeClass("disabled");
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
								var currentPageNum = nextPage-$("#subReportTableRDep_paginate>span>.paginate_button").length;
								$($("#dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}
							}
							});
						}
	
	
	
	</script>
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Deposited Player Data
					</h4>
					 <h4 class="dateData" style="text-align: right;background: none">
					</h4>
				</div>
				<div class="dataTbl_top">
				<p>
					<s:a href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=%{reportData}&reportTypeName=%{procName}"> Download Excel</s:a>
					</p>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction" id="subReportTableRDep">
						<thead>
						  <tr class="headerRow">
						  		<th  valign="middle" style="text-align: center;">
											Player Id
								</th>
								<th  valign="middle" style="text-align: center;">
											User Name
								</th>
								<th  valign="middle" style="text-align: center;">
											Email Id
								</th>
							 
								<th  valign="middle" style="text-align: center;">
											Mobile No.
								</th>
								<th  valign="middle" style="text-align: center;">
											Total Wager
								</th>
								<th  valign="middle" style="text-align: center;">
											Total Winning
								</th>
								<th  valign="middle" style="text-align: center;">
											Total Withdrawal
								</th>
								<th  valign="middle" style="text-align: center;">
											Total Deposit
								</th>
								<th  valign="middle" style="text-align: center;">
											First Deposit Date
								</th>
								<th  valign="middle" style="text-align: center;">
											Registration IP
								</th>
								<th  valign="middle" style="text-align: center;">
											Registration Date
								</th>
									<th  valign="middle" style="text-align: center;">
												Referd By
								</th>
								<th  valign="middle" style="text-align: center;">
												Deposit Device
								</th>
								<th  valign="middle" style="text-align: center;">
												Registration Device
								</th>
							 </tr>
						</thead>
						<tbody></tbody>
						
					</table>
				</div>
				<div class="box_footer">
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
			 	<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
			  	<div id="nextPageStart" style="display:none"></div> 
			  	<div id="campId" style="display:none"><s:property value="%{campId}" /></div>
			  	<div id="subCampId" style="display:none"><s:property value="%{subCampId}" /></div>
			  	<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
				<div class="animated-striped">Wait</div>
				</div>
				<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
				<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				</div>
				</div>
			</s:if>
			<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>

		</div>
 <div id="expandResult"></div>
	</body>
</html>

