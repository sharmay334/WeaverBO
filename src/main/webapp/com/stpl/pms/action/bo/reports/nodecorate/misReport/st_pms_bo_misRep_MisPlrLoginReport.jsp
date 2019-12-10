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

<title>Player Login Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=path %>/css/facebox_bigsize.css" media="screen"
	rel="stylesheet" type="text/css" />

<script>
	$(document).ready(function() { 
		
	var loginDevice='';
	$("#playerSearchFrm").find("[Id*='loginDevice']:checked").each( function(index, value) {
			loginDevice += ',"' + value.value+ '":Y';
	});
	var flagPage = 0;
	var x ="";
	var y ="";
		$(document).ready(function() {
 				$(document).on("click", "[aria-controls='misPlrLoginReport'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCount").text()==101 && $("#search").text()==""){
	 					$("#misPlrLoginReport_next").removeClass("disabled");
		 				$("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='misPlrLoginReport'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").text()>1)
 						$("#misPlrLoginReport_previous").removeClass("disabled");
	 				$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$('#misPlrLoginReport_next').live('click', function(e) {
								if($("#rowCount").text()==101 && $("#search").val()==""){
									$("#misPlrLoginReport_next").removeClass("disabled");
								}
								if($("#misPlrLoginReport_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').attr("data-dt-idx")==4){
										$("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').attr("data-dt-idx")<5){
									$("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
									
									else if($('.paginate_button.current').attr("data-dt-idx")==5   && !($("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								
								if($("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").hasClass("nextCall")  && !($("#misPlrLoginReport_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndex")
											.val()) + 100;
											flagPage = 0;
												var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())+1;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 x = document.getElementById("misPlrLoginReport_paginate").lastChild.innerHTML;
									document.getElementById("misPlrLoginReport_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#misPlrLoginReport_paginate > a:last-child').addClass('waitBtn');
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
							$('#misPlrLoginReport_previous').live('click', function(e) {
									if($("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").text()>1){
 										$("#misPlrLoginReport_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').attr("data-dt-idx")==2){
										$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').attr("data-dt-idx")>1){
										$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').attr("data-dt-idx")==1   && !($("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").hasClass("prevCall") && !($("#misPlrLoginReport_previous").hasClass("disabled"))) {	
									var start = parseInt($("#startIndex").val()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())-5;
											$("#nextPageStart").val(nextPageStart);
									$('#startIndex').val(start);
									 y = document.getElementById("misPlrLoginReport_paginate").firstChild.innerHTML;
									document.getElementById("misPlrLoginReport_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#misPlrLoginReport_paginate > a:first-child').addClass('waitBtn');
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
												displayDataPrev(response);
											});
											e.stopImmediatePropagation();
											e.preventDefault();
								}
							});
								$(document).on("keyup", "[aria-controls='misPlrLoginReport']#search", function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#misPlrLoginReport_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".paginate_button").css("pointer-events","auto");
								}else if($("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").text()>1){
									$("#misPlrLoginReport_previous").removeClass("disabled");
									$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").addClass("prevCall");
								}
							});
							
							fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCount").text(resultList.length);
			if ($("#rowCount").text() < 101){
				$("#misPlrLoginReport_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStart").val();
				
			jQuery('#misPlrLoginReport').dataTable().fnDestroy();
			$("#" + 'misPlrLoginReport')
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
								} , {
					       		"aTargets": [4],
					       		"mRender": function (data, type, full) {
									return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReport.action?procName=MisPlrLoginData&reportData={"startIndex":"0","recordTofetch":"'+data+'","domainId":'
							+$("#domainId").val()+',"fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', 
							$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker
							.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate")
							.val().split(' ')[1]+'","'+'playerId":"'+full[0]+'"'+loginDevice+'}&redirect='+'"Search"  target='+'"expandIt">'+data+'</a>';
					       		    }
					       		}],
								 "fnInitComplete": function( oSettings) {
 									$("#misPlrLoginReport_previous").removeClass("disabled");
 									$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misPlrLoginReport_paginate").lastChild.innerHTML = x;
									$($("#misPlrLoginReport_paginate>span>.paginate_button")).each(function(){
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
								
								
								var currentPageNum = nextPage-$("#misPlrLoginReport_paginate>span>.paginate_button").length;
								$($("#misPlrLoginReport_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#misPlrLoginReport_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCount").text() < 101)
				$("#misPlrLoginReport_next").addClass("disabled");
				var nextPage = $("#nextPageStart").val();
			jQuery('#misPlrLoginReport').dataTable().fnDestroy();
			$("#" + 'misPlrLoginReport')
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
								} ,  {
					       		"aTargets": [4],
					       		"mRender": function (data, type, full) {
									return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReport.action?procName=MisPlrLoginData&reportData={"startIndex":"0","recordTofetch":"'+data+'","domainId":'
							+$("#domainId").val()+',"fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', 
							$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker
							.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate")
							.val().split(' ')[1]+'","'+'playerId":"'+full[0]+'"'+loginDevice+'}&redirect='+'"Search"  target='+'"expandIt">'+data+'</a>';
					       		    }
					       		}],
								 "fnInitComplete": function( oSettings) {
									 if($('#startIndex').val()==0){
										$("#misPlrLoginReport_previous").addClass("disabled");}
									 else
 										$("#misPlrLoginReport_previous").removeClass("disabled");
 									$("[aria-controls='misPlrLoginReport'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("misPlrLoginReport_paginate").firstChild.innerHTML = y;
									$($("#misPlrLoginReport_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#misPlrLoginReport').dataTable().fnPageChange( 'last' );
									$("#misPlrLoginReport_next").removeClass("disabled");
									$("[aria-controls='misPlrLoginReport'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
								$("#rowCount").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								
								var currentPageNum = nextPage-$("#misPlrLoginReport_paginate>span>.paginate_button").length;
								$($("#misPlrLoginReport_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}
							}
							});
		}
		$("#misPlrLoginReport").DataTable({
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
	       "aoColumnDefs": [{
	       		"aTargets": [0],
		       	"mRender": function (data, type, full) {
					return '<input type="checkbox" id="checkBoxId_'+data+'" value ="'+data+'" class ="'+full[1]
						+'">&nbsp;'+data+'</input>';
	       			}
	       		},{
	       		"aTargets": [4],
	       		"mRender": function (data, type, full) {
					return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReport.action?procName=MisPlrLoginData&reportData={"startIndex":"0","recordTofetch":"'+data+'","domainId":'
							+$("#domainId").val()+',"fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', 
							$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker
							.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate")
							.val().split(' ')[1]+'","'+'playerId":"'+full[0]+'"'+loginDevice+'}&redirect='+'"Search"  target='+'"expandIt">'+data+'</a>';
	       		    }
	       		}
	       ],
		}); 
		fromAndToDate();
	});
</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					Player Login Report For Domain :
					<s:property value="%{domainName}" />
				</h4>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="misPlrLoginReport">
					<thead>
						<tr class="headerRow">
							<th valign="middle" style="text-align: center;" nowrap="nowrap">Player
								Id</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">User
								Name</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">Email
								Id</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">Mobile
								No.</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">Login
								Count</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">Last
								Login Date</th>

							<th valign="middle" style="text-align: center;" nowrap="nowrap">First
								Login Date</th>
							
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Subscribed Promo Mail</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Version</th>	
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer">
				<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
				<a rel="facebox" id="freeBonus" class="button">Free Bonus</a>
			</div>
			<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 	<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  	<div id="nextPageStart" style="display:none"></div> 
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
