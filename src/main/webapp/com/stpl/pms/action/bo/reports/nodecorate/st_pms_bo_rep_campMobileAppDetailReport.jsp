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

<title>Mobile app Download Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	
	/* 	var flagPage = 0;
	var x ="";
	var y ="";
	$(document).ready(function(){
	$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
    	fromAndToDate();
			 $("#subReportTable").DataTable({
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
				"bVisible": true, 
 			}],
			    });  
 				$(document).on("click", "[aria-controls='subReportTable'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCountSub").text()==101 && $("#search").val()==""){
	 					$("#subReportTable_next").removeClass("disabled");
		 				$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='subReportTable'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
 						$("#subReportTable_previous").removeClass("disabled");}
	 				$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#subReportTable_next").live('click', function(e) {
								if($("#rowCountSub").text()==101 && $("#search").val()==""){
									$("#subReportTable_next").removeClass("disabled");
								}
								if($("#subReportTable_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').eq(1).attr("data-dt-idx")==4){
										$("[aria-controls='subReportTable'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")<5){
									$("[aria-controls='subReportTable'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==5   && !($("[aria-controls='subReportTable'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='subReportTable'][data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTable_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndexSub")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())+1;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub').text(start);
									 x = document.getElementById("subReportTable_paginate").lastChild.innerHTML;
									document.getElementById("subReportTable_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTable_paginate > a:last-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");
									
									
									_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampAppDownReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
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
							$('#subReportTable_previous').live('click', function(e) {
									if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
 										$("#subReportTable_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').eq(1).attr("data-dt-idx")==2){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")>1){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==1   && !($("[aria-controls='subReportTable'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='subReportTable'][data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTable_previous").hasClass("disabled"))) {
									var start = parseInt($("#startIndexSub").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())-5;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub').text(start);
									 y = document.getElementById("subReportTable_paginate").firstChild.innerHTML;
									document.getElementById("subReportTable_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTable_paginate > a:first-child').addClass('waitBtn');
									
									
									
										_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampAppDownReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
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
								$($(".dataTables_paginate.eq(1)>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								}else if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
									$("#subReportTable_previous").removeClass("disabled");
									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCountSub").text(resultList.length);
			if ($("#rowCountSub").text() < 101){
				$("#subReportTable_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTable').dataTable().fnDestroy();
			$("#" + 'subReportTable')
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
								 "fnInitComplete": function( oSettings) {
 									$("#subReportTable_previous").removeClass("disabled");
 									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTable_paginate").lastChild.innerHTML = x;
									$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
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
								var currentPageNum = nextPage-$("#subReportTable_paginate>span>.paginate_button").length;
								$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#subReportTable_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCountSub").text() < 101)
				$("#subReportTable_next").addClass("disabled");
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTable').dataTable().fnDestroy();
			$("#" + 'subReportTable')
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
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndexSub').val()==0){
										$("#subReportTable_previous").addClass("disabled");}
									 else
 										$("#subReportTable_previous").removeClass("disabled");
 									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTable_paginate").firstChild.innerHTML = y;
									$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTable').dataTable().fnPageChange( 'last' );
									$("#subReportTable_next").removeClass("disabled");
									$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
								$("#rowCountSub").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTable_paginate>span>.paginate_button").length;
								$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}
							}
							});
		} */
			$(document).ready(function() {
			$('#waitDiv').hide();
	  		$('#searchButtons').show();
	  		$('#searchButtons').attr("disabled",false);
			$("#subReportTable").dataTable({
			"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
			"sAjaxDataProp":"resultList",
			"sServerMethod": "POST",
			"deferRender": true,
			"scrollX": "100%",
			"pageLength" : 20,
			"bLengthChange" : false,
			"oLanguage" : {
			"sInfo" : '',
			}
		});
		$(document).on("click", "[aria-controls='subReportTable'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCountSub").text()==101 && $("#search").val()==""){
	 					$("#subReportTable_next").removeClass("disabled");
		 				$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='subReportTable'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
 						$("#subReportTable_previous").removeClass("disabled");}
	 				$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#subReportTable_next").live('click', function(e) {
								if($("#rowCountSub").text()==101 && $("#search").val()==""){
									$("#subReportTable_next").removeClass("disabled");
								}
								if($("#subReportTable_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').eq(1).attr("data-dt-idx")==4){
										$("[aria-controls='subReportTable'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")<5){
									$("[aria-controls='subReportTable'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==5   && !($("[aria-controls='subReportTable'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='subReportTable'][data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTable_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndexSub")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())+1;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub').text(start);
									 x = document.getElementById("subReportTable_paginate").lastChild.innerHTML;
									document.getElementById("subReportTable_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTable_paginate > a:last-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");
									
									
									_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampAppDownReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
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
							$('#subReportTable_previous').live('click', function(e) {
									if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
 										$("#subReportTable_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').eq(1).attr("data-dt-idx")==2){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")>1){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==1   && !($("[aria-controls='subReportTable'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='subReportTable'][data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTable_previous").hasClass("disabled"))) {
									if( parseInt($("#startIndexSub").text())>0)
									var start = parseInt($("#startIndexSub").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())-5;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub').text(start);
									 y = document.getElementById("subReportTable_paginate").firstChild.innerHTML;
									document.getElementById("subReportTable_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTable_paginate > a:first-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");
									
									
										_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampAppDownReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
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
								$($(".dataTables_paginate.eq(1)>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".dataTables_paginate").eq(1).css("pointer-events","auto");
								}else if($("[aria-controls='subReportTable'][data-dt-idx='1']").text()>1){
									$("#subReportTable_previous").removeClass("disabled");
									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
	
	});
	function displayData(response) {
		var resultList = response;
			$("#rowCountSub").text(resultList.length);
			if ($("#rowCountSub").text() < 101){
				$("#subReportTable_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTable').dataTable().fnDestroy();
			$("#" + 'subReportTable')
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
								 "fnInitComplete": function( oSettings) {
 									$("#subReportTable_previous").removeClass("disabled");
 									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTable_paginate").lastChild.innerHTML = x;
									$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
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
								var currentPageNum = nextPage-$("#subReportTable_paginate>span>.paginate_button").length;
								$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#subReportTable_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCountSub").text() < 101)
				$("#subReportTable_next").addClass("disabled");
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTable').dataTable().fnDestroy();
			$("#" + 'subReportTable')
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
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndexSub').val()==0){
										$("#subReportTable_previous").addClass("disabled");}
									 else
 										$("#subReportTable_previous").removeClass("disabled");
 									$("[aria-controls='subReportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTable_paginate").firstChild.innerHTML = y;
									$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTable').dataTable().fnPageChange( 'last' );
									$("#subReportTable_next").removeClass("disabled");
									$("[aria-controls='subReportTable'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
								$("#rowCountSub").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTable_paginate>span>.paginate_button").length;
								$($("#subReportTable_paginate>span>.paginate_button")).each(function(){
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
				<h4 style="float: left">Mobile app Download Report</h4>
			</div>
			<div class="dataTbl_top">
				<p>
					<a
						href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=<s:property value="%{procName}"/> ">Download
						Excel</a>
				</p>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="subReportTable">
					<thead>
						<tr class="headerRow">
								<th valign="middle" style="text-align: center;">Domain ID</th>

								<th valign="middle" style="text-align: center;">Link Visit
									Time</th>
								<th valign="middle" style="text-align: center;">IP Address</th>
								<th valign="middle" style="text-align: center;">Browser</th>
								<th valign="middle" style="text-align: center;">OS</th>
								<th valign="middle" style="text-align: center;">Device</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer"></div>
				<div id="startIndexSub" style="display:none"><s:property value="0" /></div>
			<div id=recordTofetchSub style="display:none"><s:property value="101" /></div>
		 	<div id="rowCountSub" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		 	<div id="nextPageStartSub" style="display:none"></div> 
		 	<div id="campId" style="display:none"><s:property value="%{campId}" /></div>
		 	<div id="subCampId" style="display:none"><s:property value="%{subCampId}" /></div>
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
</body>
</html>