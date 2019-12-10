
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
	<script>
	var flagPage = 0;
	var x ="";
	var y ="";
		$(document).ready(function() {
				
			  $("#dailyRakeWithRoyalty").DataTable({
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
	 		
 				$(document).on("click", "[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").val()==""){
	 					$("#dailyRakeWithRoyalty_next").removeClass("disabled");
		 				$("[aria-controls='dailyRakeWithRoyalty']-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").text()>1)
 						$("#dailyRakeWithRoyalty_previous").removeClass("disabled");
	 				$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#dailyRakeWithRoyalty_next").live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#dailyRakeWithRoyalty_next").removeClass("disabled");
								}
								if($("#dailyRakeWithRoyalty_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').attr("data-dt-idx")==4){
										$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').attr("data-dt-idx")<5){
									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').attr("data-dt-idx")==5   && !($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").hasClass("nextCall")  && !($("#dailyRakeWithRoyalty_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.val()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 x = document.getElementById("dailyRakeWithRoyalty_paginate").lastChild.innerHTML;
									document.getElementById("dailyRakeWithRoyalty_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#dailyRakeWithRoyalty_paginate > a:last-child').addClass('waitBtn');
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
							$('#dailyRakeWithRoyalty_previous').live('click', function(e) {
									if($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").text()>1){
 										$("#dailyRakeWithRoyalty_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').attr("data-dt-idx")==2){
										$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').attr("data-dt-idx")>1){
										$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').attr("data-dt-idx")==1   && !($("[data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").hasClass("prevCall") && !($("#dailyRakeWithRoyalty_previous").hasClass("disabled"))) {	
									var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("dailyRakeWithRoyalty_paginate").firstChild.innerHTML;
									document.getElementById("dailyRakeWithRoyalty_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#dailyRakeWithRoyalty_paginate > a:first-child').addClass('waitBtn');
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
								}else if($("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").text()>1){
									$("#dailyRakeWithRoyalty_previous").removeClass("disabled");
									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").addClass("prevCall");
								}
							});
							fromAndToDate();
								
	});
		
		 
			 
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 101){
				$("#dailyRakeWithRoyalty_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#dailyRakeWithRoyalty').dataTable().fnDestroy();
			$("#" + 'dailyRakeWithRoyalty')
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
 									$("#dailyRakeWithRoyalty_previous").removeClass("disabled");
 									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("dailyRakeWithRoyalty_paginate").lastChild.innerHTML = x;
 									$($("#dailyRakeWithRoyalty_paginate>span>.paginate_button")).each(function(){
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
								$($("#dailyRakeWithRoyalty_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#dailyRakeWithRoyalty_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#dailyRakeWithRoyalty_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#dailyRakeWithRoyalty').dataTable().fnDestroy();
			$("#" + 'dailyRakeWithRoyalty')
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
										$("#dailyRakeWithRoyalty_previous").addClass("disabled");}
									 else
 										$("#dailyRakeWithRoyalty_previous").removeClass("disabled");
 									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("dailyRakeWithRoyalty_paginate").firstChild.innerHTML = y;
									$($(".dataTables_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#dailyRakeWithRoyalty').dataTable().fnPageChange( 'last' );
									$("#dailyRakeWithRoyalty_next").removeClass("disabled");
									$("[aria-controls='dailyRakeWithRoyalty'][data-dt-idx='5']").addClass('nextCall');
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
						Daily Rake And Royalty Report For Domain :
						<s:property value="%{domainName}" />
					</h4>
					<h4 class="dateData" style="text-align: right; background: none">
					</h4>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0" align="center"
						class="payTransaction" id="dailyRakeWithRoyalty">
						<thead>
							<tr class="headerRow">
								<th style="text-align: center;" valign="middle" nowrap="nowrap">
									Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Product Name
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Gross Rake 
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									 Govt. Royalty
								</th>
								

							</tr>
						</thead>
						<tbody></tbody>

					</table>
				</div>
				<div class="box_footer">

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
		<div id="expandIt">
		</div>
	</body>
</html>

