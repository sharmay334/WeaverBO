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

<title>Player Login Data</title>

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
	$('#startIndexSub').text("0");
	$('#rowCountSub').text("101");
	$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
    	//fromAndToDate();
			 $("#subReportTableRef").DataTable({
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
 				$(document).on("click", "[aria-controls='subReportTableRef'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCountSub").text()==101 && $("[aria-controls='subReportTableRef'][id='search']").val()==""){
	 					$("#subReportTableRef_next").removeClass("disabled");
		 				$("[aria-controls='subReportTableRef'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='subReportTableRef'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='subReportTableRef'][data-dt-idx='1']").text()>1){
 						$("#subReportTableRef_previous").removeClass("disabled");}
	 				$("[aria-controls='subReportTableRef'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$('#subReportTableRef_next').live('click', function(e) {
								if($("#rowCountSub").text()==101 && $("[aria-controls='subReportTableRef'][id='search']").val()==""){
									$("#subReportTableRef_next").removeClass("disabled");
								}
								if($("#subReportTableRef_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').eq(1).attr("data-dt-idx")==4){
										$("[aria-controls='subReportTableRef'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")<5){
									$("[aria-controls='subReportTableRef'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==5   && !($("[aria-controls='subReportTableRef'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='subReportTableRef'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='subReportTableRef'][data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTableRef_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndexSub")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($("[aria-controls='subReportTableRef'][data-dt-idx='5']").text())+1;
											$("#nextPageStartSub").text(nextPageStart);
									$('#startIndexSub').text(start);
									 x = document.getElementById("subReportTableRef_paginate").lastChild.innerHTML;
									document.getElementById("subReportTableRef_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTableRef_paginate > a:last-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									
									_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"campRevReferFrndPlrReport","domainId":'+$("#domainId").val()+',"aliasId":'+$("#aliasId").val()+',"camType":"'+$("#camType").val()+'","startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
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
							$('#subReportTableRef_previous').live('click', function(e) {
									if($("[aria-controls='subReportTableRef'][data-dt-idx='1']").text()>1){
 										$("#subReportTableRef_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').eq(1).attr("data-dt-idx")==2){
										$("[aria-controls='subReportTableRef'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")>1){
										$("[aria-controls='subReportTableRef'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==1   && !($("[data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='subReportTableRef'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='subReportTableRef'][data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTableRef_previous").hasClass("disabled"))) {
									if(parseInt($("#startIndexSub").text())>0)
										var start = parseInt($("#startIndexSub").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())-5;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub').text(start);
									 y = document.getElementById("subReportTableRef_paginate").firstChild.innerHTML;
									document.getElementById("subReportTableRef_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTableRef_paginate > a:first-child').addClass('waitBtn');
									$(".paginate_button").css("pointer-events","none");
									
									
										_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"campRevReferFrndPlrReport","domainId":'+$("#domainId").val()+',"aliasId":'+$("#aliasId").val()+',"camType":"'+$("#camType").val()+'","startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
												,
											"",
									
											function(response) {
												displayDataPrev(response);
											});
								}
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$(document).on("keyup", "[aria-controls='subReportTableRef'][id='search']", function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#subReportTableRef_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".paginate_button").css("pointer-events","auto");
								}else if($("[aria-controls='subReportTableRef'][data-dt-idx='1']").text()>1){
									$("#subReportTableRef_previous").removeClass("disabled");
									$("[aria-controls='subReportTableRef'][data-dt-idx='1']").addClass("prevCall");
								}
							});
		//fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCountSub").text(resultList.length);
			if ($("#rowCountSub").text() < 101){
				$("#subReportTableRef_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStartSub").text();
			jQuery('#subReportTableRef').dataTable().fnDestroy();
			$("#" + 'subReportTableRef')
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
 									$("#subReportTableRef_previous").removeClass("disabled");
 									$("[aria-controls='subReportTableRef'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableRef_paginate").lastChild.innerHTML = x;
									$($("#subReportTableRef_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("[aria-controls='subReportTableRef'][id='search']").val()==""){
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTableRef_paginate>span>.paginate_button").length;
										$($("#subReportTableRef_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#subReportTableRef_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCountSub").text() < 101)
				$("#subReportTableRef_next").addClass("disabled");
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTableRef').dataTable().fnDestroy();
			$("#" + 'subReportTableRef')
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
										$("#subReportTableRef_previous").addClass("disabled");}
									 else
 										$("#subReportTableRef_previous").removeClass("disabled");
 									$("[aria-controls='subReportTableRef'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableRef_paginate").firstChild.innerHTML = y;
									$($("#subReportTableRef_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTableRef').dataTable().fnPageChange( 'last' );
									$("#subReportTableRef_next").removeClass("disabled");
									$("[aria-controls='subReportTableRef'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("[aria-controls='subReportTableRef'][id='search']").val()==""){
								$("#rowCountSub").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTableRef_paginate>span>.paginate_button").length;
								$($("#subReportTableRef_paginate>span>.paginate_button")).each(function(){
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
				<h4 style="float: left">Campaign Revenue Data</h4>
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
					class="payTransaction" id="subReportTableRef">
					<thead>
						<tr class="headerRow">
							<th valign="middle" style="text-align: center;">Source</th>

							<th valign="middle" style="text-align: center;">Sub-Source
							</th>
							<th valign="middle" style="text-align: center;">User Name</th>
							<th valign="middle" style="text-align: center;">Deposit
								Amount</th>
							<th valign="middle" style="text-align: center;">Wager
								Amount</th>
							<th valign="middle" style="text-align: center;">Winning
								Amount</th>
							<th valign="middle" style="text-align: center;">Bonus
								Amount</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer">
			<div id="startIndexSub" style="display:none"><s:property value="0" /></div>
			<div id=recordTofetchSub style="display:none"><s:property value="101" /></div>
		 	<div id="rowCountSub" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		 	<div id="nextPageStartSub" style="display:none"></div> 
			
			
				<%-- <div id="startIndex" style="display:none"><s:property value="0" /></div>
			 	<div id="rowCountSub" style="display:none"><s:property value="%{resultList.size()}"/></div> 
			  	<div id="nextPageStart" style="display:none"></div>  --%>
			  	
			  	<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
				<div class="animated-striped">Wait</div>
				</div>
				<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
				<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div></div>
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
