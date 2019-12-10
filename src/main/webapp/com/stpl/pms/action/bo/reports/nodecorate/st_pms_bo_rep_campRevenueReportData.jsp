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
<title>Search Data</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<script>
	/* $(document).ready(function(){
		$('#waitDiv').hide();
  		$('#search').show();
  		$('#search').attr("disabled",false);
		$("#reportTable").dataTable({
			"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
			"sAjaxDataProp":"resultList",
			"sServerMethod": "POST",
			"deferRender": true,
			"scrollX": "100%",
			"aoColumnDefs": [ {
				"aTargets": [4],
				"mRender": function (data, type, full) {
								return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=CampWiseRevenuReport&reportData={"domainId":'+$("#domainId").val()+',"camType":"'+$("#camType").val()+'","camName":"'+full[0].replace(/\%/g, '%25').replace(/\s/g,'%20')+'","subCamName":"'+full[1].replace(/\s/g,'%20')+'"} target="expandIt" >'+data+'</a>';
							}
					}],
		});
	});	  */
	
	var flagPage = 0;
	var x ="";
	var y ="";
	$(document).ready(function(){
	$('#waitDiv').hide();
  		$('#waitDiv').hide();
  		$('#search').show();
  		$('#search').attr("disabled",false);
    	//fromAndToDate();
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
					 "aoColumnDefs": [{
				"aTargets": [0],
				"bVisible": true, 
 			},{"aTargets": [4],
				"mRender": function (data, type, full) {
							var aliasVal1= $("#domainId").val()==0?-1: $("#aliasId").val();
								return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=CampWiseRevenuReport&reportData={"domainId":"'+$("#domainId").val()+'","aliasId":"'+aliasVal1+'","camType":"'+$("#camType").val()+'","camName":"'+full[0].replace(/\%/g, '%25').replace(/\s/g,'%20')+'","subCamName":"'+full[1].replace(/\s/g,'%20')+'","startIndex":"'+$("#startIndex").val()+'","recordTofetch":"101"}  target="expandIt" >'+data+'</a>';
							}
							}]
		});  
 				$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").val()==101 && $("#search").text()==""){
	 					$("#reportTable_next").removeClass("disabled");
		 				$("[data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[data-dt-idx='1']").val()>1)
 						$("#reportTable_previous").removeClass("disabled");
	 				$("[data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#reportTable_next").live('click', function(e) {
								if($("#rowCount").val()==101 && $("#search").val()==""){
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
											var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())+1;
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
															.val().slice(0, -1)+',"proceName":"CampRevenueReport"}'
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
												displayData1(response);
											});
								}else
									return false;	
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$('#reportTable_previous').live('click', function(e) {
									if($("[data-dt-idx='1']").val()>1){
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
									if(parseInt($("#startIndex").val())>0)
										var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())-5;
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
															.val().slice(0, -1)+',"proceName":"CampRevenueReport"}'
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
												displayDataPrev1(response);
											});
								}
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$(document).on('keyup', '#search', function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#reportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".paginate_button").css("pointer-events","auto");
								}else if($("[data-dt-idx='1']").val()>1){
									$("#reportTable_previous").removeClass("disabled");
									$("[data-dt-idx='1']").addClass("prevCall");
								}
							});
		//fromAndToDate();
								
	});
		function displayData1(response) {
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
								"aoColumnDefs": [{
				"aTargets": [0],
				"bVisible": true, 
 			},{"aTargets": [4],
				"mRender": function (data, type, full) {
								return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=CampWiseRevenuReport&reportData={"domainId":'+$("#domainId").val()+'","aliasId":"'+$("#aliasId").val()+'","camType":"'+$("#camType").val()+'","camName":"'+full[0].replace(/\%/g, '%25').replace(/\s/g,'%20')+'","subCamName":"'+full[1].replace(/\s/g,'%20')+'","'+'startIndex":"'+$("#startIndex").text()+'","'+'recordTofetch":"'+$("#rowCount").text()+'"}  target="expandIt" >'+data+'</a>';
							}
							}],
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
		
		function displayDataPrev1(response) {
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
								"aoColumnDefs": [{
				"aTargets": [0],
				"bVisible": true, 
 			},{"aTargets": [4],
				"mRender": function (data, type, full) {
								return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=CampWiseRevenuReport&reportData={"domainId":'+$("#domainId").val()+'","aliasId":"'+$("#aliasId").val()+'","camType":"'+$("#camType").val()+'","camName":"'+full[0].replace(/\%/g, '%25').replace(/\s/g,'%20')+'","subCamName":"'+full[1].replace(/\s/g,'%20')+'","'+'startIndex":"'+$("#startIndex").text()+'","'+'recordTofetch":"'+$("#rowCount").text()+'"}  target="expandIt" >'+data+'</a>';
							}
							}],
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
				<h4 style="float: left">
					Campaign Revenue Report For Domain :
					<s:property value="%{domainName}" />
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
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
							<th valign="middle" style="text-align: center;">Source</th>
							<th valign="middle" style="text-align: center;">Sub-Source
							</th>
							<th valign="middle" style="text-align: center;">Start Date</th>
							<th valign="middle" style="text-align: center;">End Date</th>
							<th valign="middle" style="text-align: center;">Total
								Registration</th>
							<th valign="middle" style="text-align: center;">Total
								Deposit</th>
							<th valign="middle" style="text-align: center;">Total Wager
							</th>
							<th valign="middle" style="text-align: center;">Total
								Winning</th>
							<th valign="middle" style="text-align: center;">Total Bonus
							</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer">
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
			 	<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/></div> 
			  	<div id="nextPageStart" style="display:none"></div> 
			  	<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
				<div class="animated-striped">Wait</div>
				</div>
				<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
				<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
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
	<div id="expandIt"></div>
</body>
</html>

