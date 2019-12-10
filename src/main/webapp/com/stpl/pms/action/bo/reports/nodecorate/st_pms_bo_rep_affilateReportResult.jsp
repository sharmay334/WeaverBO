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
	 			}],
				    });
			    
 				$(document).on("click", "[aria-controls='reportTable'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").text()==""){
	 					$("#reportTable_next").removeClass("disabled");
		 				$("[aria-controls='reportTable'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='reportTable'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='reportTable'][data-dt-idx='1']").text()>1)
 						$("#reportTable_previous").removeClass("disabled");
	 				$("[aria-controls='reportTable'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#reportTable_next").live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#reportTable_next").removeClass("disabled");
								}
								if($("#reportTable_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').attr("data-dt-idx")==4){
										$("[aria-controls='reportTable'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').attr("data-dt-idx")<5){
									$("[aria-controls='reportTable'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').attr("data-dt-idx")==5   && !($("[aria-controls='reportTable'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='reportTable'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='reportTable'][data-dt-idx='5']").hasClass("nextCall")  && !($("#reportTable_next").hasClass("disabled"))) {
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
															.val().slice(0, -1)+',"proceName":"getBonusDetailReport"}'
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
									if($("[aria-controls='reportTable'][data-dt-idx='1']").text()>1){
 										$("#reportTable_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').attr("data-dt-idx")==2){
										$("[aria-controls='reportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').attr("data-dt-idx")>1){
										$("[aria-controls='reportTable'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').attr("data-dt-idx")==1   && !($("[aria-controls='reportTable'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='reportTable'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='reportTable'][data-dt-idx='1']").hasClass("prevCall") && !($("#reportTable_previous").hasClass("disabled"))) {	
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
															.val().slice(0, -1)+',"proceName":"getBonusDetailReport"}'
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
							$(document).on("keyup", "[aria-controls='reportTable']#search", function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#reportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".paginate_button").css("pointer-events","auto");
								}else if($("[aria-controls='reportTable'][data-dt-idx='1']").text()>1){
									$("#reportTable_previous").removeClass("disabled");
									$("[aria-controls='reportTable'][data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
								
	});
	function displayData(response) {
	    debugger;



	var resultList = response;
		$("#rowCountSub1").text(resultList.length);
		if ($("#rowCountSub1").text() < 101){
			$("#subReportTableReg_next").addClass("disabled");}
		//	alert(response.size());
			var nextPage = $("#nextPageStartSub").val();
		jQuery('#subReportTableReg').dataTable().fnDestroy();
		$("#" + 'subReportTableReg')
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
									$("#subReportTableReg_previous").removeClass("disabled");
									$("[aria-controls='subReportTableReg'][data-dt-idx='1']").addClass('prevCall');
									document.getElementById("subReportTableReg_paginate").lastChild.innerHTML = x;
								$($("#subReportTableReg_paginate>span>.paginate_button")).each(function(){
								$(this).text(nextPage);
								nextPage++;
							});
							},
							"fnDrawCallback" : function(oSettings) {
							if($("[aria-controls='subReportTableReg'][id='search']").val()==""){
							flagPage++;
							if(flagPage < 3) {
								return false;
							}
							var currentPageNum = nextPage-$("#subReportTableReg_paginate>span>.paginate_button").length;
							$($("#subReportTableReg_paginate>span>.paginate_button")).each(function(){
								$(this).text(currentPageNum);
								currentPageNum++;
							});
						}else if($('span:last').hasClass("current")){
									$("#subReportTableReg_next").addClass("disabled");
								}
						}
						});
	}
		
		function displayDataPrev(response) {
			if ($("#rowCountSub1").text() < 101)
				$("#subReportTableReg_next").addClass("disabled");
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTableReg').dataTable().fnDestroy();
			$("#" + 'subReportTableReg')
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
									 if($('#startIndexSub1').val()==0){
										$("#subReportTableReg_previous").addClass("disabled");}
									 else
 										$("#subReportTableReg_previous").removeClass("disabled");
 									$("[aria-controls='subReportTableReg'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableReg_paginate").firstChild.innerHTML = y;
									$($("#subReportTableReg_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTableReg').dataTable().fnPageChange( 'last' );
									$("#subReportTableReg_next").removeClass("disabled");
									$("[aria-controls='subReportTableReg'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("[aria-controls='subReportTableReg'][id='search']").val()==""){
								$("#rowCountSub1").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTableReg_paginate>span>.paginate_button").length;
								$($("#subReportTableReg_paginate>span>.paginate_button")).each(function(){
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
					Ad Company Report
					<s:property value="%{domainName}" />
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div class="dataTbl_top"></div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
							<th valign="middle" style="text-align: center;">PlayerID</th>
							<th valign="middle" style="text-align: center;">Registration Date</th>
							<th valign="middle" style="text-align: center;">Total Deposit
							</th>
							<th valign="middle" style="text-align: center;">Total Rake
							</th>
							<th valign="middle" style="text-align: center;">Commission Amt</th>
							<th valign="middle" style="text-align: center;">STATE</th>
							<th valign="middle" style="text-align: center;">Device</th>
						
						</tr>
						
					</thead>
					<tbody></tbody>
				
				</table>
			</div>
			<div class="box_footer"></div>
			<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 	<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		 	<div id="startIndexSub" style="display:none"><s:property value="0" /></div>
		 	<div id="rowCountSub" style="display:none"><s:property value="101" /></div>
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
	<div id="expandIt"></div>
</body>
</html>


