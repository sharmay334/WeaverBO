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
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript">
			$(document).ready(function() {
	var flagPage = 0;
	var x ="";
	var y ="";
		$(document).ready(function() {
 				$(document).on("click", "[data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").val()==""){
	 					$("#misReportsPartial_next").removeClass("disabled");
		 				$("[data-dt-idx='5']").addClass('nextCall');
	 				}
 				});
 				$(document).on("click", "[data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[data-dt-idx='1']").text()>1)
 						$("#misReportsPartial_previous").removeClass("disabled");
	 				$("[data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#misReportsPartial_next").live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#misReportsPartial_next").removeClass("disabled");
								}
								if($("#misReportsPartial_next").hasClass("disabled"))
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
								if($("[data-dt-idx='5']").hasClass("nextCall")  && !($("#misReportsPartial_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.val()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 x = document.getElementById("misReportsPartial_paginate").lastChild.innerHTML;
									document.getElementById("misReportsPartial_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#misReportsPartial_paginate > a:last-child').addClass('waitBtn');
									$('.paginate_button').css("pointer-events","none");
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
							$('#misReportsPartial_previous').live('click', function(e) {
									if($("[data-dt-idx='1']").text()>1){
 										$("#misReportsPartial_previous").removeClass("disabled");
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
										
									if($("[data-dt-idx='1']").hasClass("prevCall") && !($("#misReportsPartial_previous").hasClass("disabled"))) {	
									var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("misReportsPartial_paginate").firstChild.innerHTML;
									document.getElementById("misReportsPartial_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#misReportsPartial_paginate > a:first-child').addClass('waitBtn');
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
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								}else if($("[data-dt-idx='1']").text()>1){
									$("#misReportsPartial_previous").removeClass("disabled");
									$("[data-dt-idx='1']").addClass("prevCall");
								}
							});
							fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 101){
				$("#misReportsPartial_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#misReportsPartial').dataTable().fnDestroy();
			$("#" + 'misReportsPartial')
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
 									$("#misReportsPartial_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misReportsPartial_paginate").lastChild.innerHTML = x;
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
										$("#misReportsPartial_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#misReportsPartial_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#misReportsPartial').dataTable().fnDestroy();
			$("#" + 'misReportsPartial')
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
										$("#misReportsPartial_previous").addClass("disabled");}
									 else
 										$("#misReportsPartial_previous").removeClass("disabled");
 									$("[data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misReportsPartial_paginate").firstChild.innerHTML = y;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#misReportsPartial').dataTable().fnPageChange( 'last' );
									$("#misReportsPartial_next").removeClass("disabled");
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
	
		 
			 $("#misReportsPartial").DataTable({
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
				//"searching" : false,
				"bSort" : false,
		    });  
	 		fromAndToDate(); 
		});
		</SCRIPT>
	</head>

	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Partial Register Players Report : <s:property value="%{domainName}" />
					</h4>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0" align="center"
						class="payTransaction" id="misReportsPartial">
						<thead>
							<tr class="headerRow">
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									First Name
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Last Name
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Email Id
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Mobile No.
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Date
								</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 		<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  		<div id="nextPageStart" style="display:none"></div> 
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
		<br />
		<br />
	</body>
</html>

