<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
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
var flagPage = 0;
	var x ="";
	var y ="";
	$(document).ready(function(){
			 $("#reportTable").DataTable({
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
					"columnDefs" : [ {
										"targets" : 'no-sort',
										"orderable" : false,
									} ],
					//"searching" : true,
					"bSort" : false,
			    });  
			    $('#waitDiv').hide();
  				$('#searchBtn').show();
  				$('#searchBtn').attr("disabled",false);
 				$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").val()==""){
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
 								if($("#rowCount").text()==101 && $("#search").val()==""){
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
											.val()) + 100;
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
									var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("reportTable_paginate").firstChild.innerHTML;
									document.getElementById("reportTable_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#reportTable_paginate > a:first-child').addClass('waitBtn');
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
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							
							$(document).on('keyup', '#search', function(){
								if($("#search").val()!=""){
									var currentPageNum = 1;
								$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
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
			if ($("#rowCount").text() < 101){
				$("#reportTable_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#reportTable').dataTable().fnDestroy();
			$("#" + 'reportTable')
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
 									$("#reportTable_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("reportTable_paginate").lastChild.innerHTML = x;
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
								$("#reportTable_next").addClass("disabled");
							}
								}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#reportTable_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#reportTable').dataTable().fnDestroy();
			$("#" + 'reportTable')
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
		
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">AppsFlyer IOS Data Report</h4>
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
					class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
								<th valign="middle" style="text-align: center;">Serial No</th>
								<th valign="middle" style="text-align: center;">App Id</th>
								<th valign="middle" style="text-align: center;">Platform</th>
								<th valign="middle" style="text-align: center;">Click Time</th>
								<th valign="middle" style="text-align: center;">Install Time</th>
								<th valign="middle" style="text-align: center;">Agency</th>
								<th valign="middle" style="text-align: center;">Media Source</th>
								<th valign="middle" style="text-align: center;">Campaign</th>
								<th valign="middle" style="text-align: center;">FB Campaign Name</th>
								<th valign="middle" style="text-align: center;">FB Campaign Id</th>
								<th valign="middle" style="text-align: center;">FB Adset Name</th>
								<th valign="middle" style="text-align: center;">FB Adset Id</th>
								<th valign="middle" style="text-align: center;">FB Adgroup Name</th>
								<th valign="middle" style="text-align: center;">FB Adgroup Id</th>
								<th valign="middle" style="text-align: center;">AF Site ID</th>
								<th valign="middle" style="text-align: center;">Cost Per Install</th>
								<th valign="middle" style="text-align: center;">Country Code</th>
								<th valign="middle" style="text-align: center;">City</th>
								<th valign="middle" style="text-align: center;">IP</th>
								<th valign="middle" style="text-align: center;">Wifi</th>
								<th valign="middle" style="text-align: center;">Language</th>
								<th valign="middle" style="text-align: center;">AppsFlyer Device Id</th>
								<th valign="middle" style="text-align: center;">Customer User Id</th>
								<th valign="middle" style="text-align: center;">IDFA</th>
								<th valign="middle" style="text-align: center;">MAC</th>
								<th valign="middle" style="text-align: center;">Device Name</th>
								<th valign="middle" style="text-align: center;">Device Type</th>
								<th valign="middle" style="text-align: center;">OS Version</th>
								<th valign="middle" style="text-align: center;">SDK Version</th>
								<th valign="middle" style="text-align: center;">App Version</th>
								<th valign="middle" style="text-align: center;">Event Type</th>
								<th valign="middle" style="text-align: center;">Event Name</th>
								<th valign="middle" style="text-align: center;">Event Value</th>
								<th valign="middle" style="text-align: center;">Currency</th>
								<th valign="middle" style="text-align: center;">Event Time</th>
								<th valign="middle" style="text-align: center;">AF Sub1</th>
								<th valign="middle" style="text-align: center;">AF Sub2</th>
								<th valign="middle" style="text-align: center;">AF Sub3</th>
								<th valign="middle" style="text-align: center;">AF Sub4</th>
								<th valign="middle" style="text-align: center;">AF Sub5</th>
								<th valign="middle" style="text-align: center;">Click Url</th>
								<th valign="middle" style="text-align: center;">Attribution Type</th>
								<th valign="middle" style="text-align: center;">Operator</th>
								<th valign="middle" style="text-align: center;">Is Retargeting</th>
								<th valign="middle" style="text-align: center;">Retargeting Conversion Type</th>
								<th valign="middle" style="text-align: center;">Carrier</th>
								
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer"></div>
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
</body>
</html>