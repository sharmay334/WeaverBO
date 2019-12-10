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
	$('#startIndexSub2').text("0");
	$('#rowCountSub2').text("101");
	$("#download_excel").attr("href", $('#download_excel').attr('href')+$('#sumofdepvalue').text());
	$('#sumofdepvalue1').text($('#sumofdepvalue').text());


	if($('#sumofdepvalue1').text()<=100)
		$('#rowCountSub2').text($('#sumofdepvalue1').text());
	$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
    	fromAndToDate();
			 $("#subReportTableDep").DataTable({
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
 				$(document).on("click", "[aria-controls='subReportTableDep'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCountSub2").text()==101 && $("[aria-controls='subReportTableDep'][id='search']").val()==""){
	 					$("#subReportTableDep_next").removeClass("disabled");
		 				$("[aria-controls='subReportTableDep'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='subReportTableDep'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='subReportTableDep'][data-dt-idx='1']").text()>1){
 						$("#subReportTableDep_previous").removeClass("disabled");}
	 				$("[aria-controls='subReportTableDep'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#subReportTableDep_next").live('click', function(e) {
								if($("#rowCountSub2").text()==101 && $("[aria-controls='subReportTableDep'][id='search']").val()==""){
									$("#subReportTableDep_next").removeClass("disabled");
								}
								if($("#subReportTableDep_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').eq(1).attr("data-dt-idx")==4){
										$("[aria-controls='subReportTableDep'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")<5){
									$("[aria-controls='subReportTableDep'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==5   && !($("[aria-controls='subReportTableDep'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='subReportTableDep'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='subReportTableDep'][data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTableDep_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndexSub2")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())+1;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub2').text(start);
									 x = document.getElementById("subReportTableDep_paginate").lastChild.innerHTML;
									document.getElementById("subReportTableDep_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTableDep_paginate > a:last-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");

                                    $('#sumofdepvalue1').text(parseInt($('#sumofdepvalue1').text())-100);
                                    if($('#sumofdepvalue1').text()<=100)
                                        $('#recordTofetchSub1').text($('#sumofdepvalue1').text());


                                    _ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampPlayerDepReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub2").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub1").text()+'"}'
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
							$('#subReportTableDep_previous').live('click', function(e) {
									if($("[aria-controls='subReportTableDep'][data-dt-idx='1']").text()>1){
 										$("#subReportTableDep_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').eq(1).attr("data-dt-idx")==2){
										$("[aria-controls='subReportTableDep'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")>1){
										$("[aria-controls='subReportTableDep'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==1   && !($("[aria-controls='subReportTableDep'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='subReportTableDep'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='subReportTableDep'][data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTableDep_previous").hasClass("disabled"))) {
									if(parseInt($("#startIndexSub2").text())>0)
										var start = parseInt($("#startIndexSub2").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())-5;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub2').text(start);
									 y = document.getElementById("subReportTableDep_paginate").firstChild.innerHTML;
									document.getElementById("subReportTableDep_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTableDep_paginate > a:first-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");

                                        $('#sumofdepvalue1').text(parseInt($('#sumofdepvalue1').text())+100);
										_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampPlayerDepReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub2").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub1").text()+'"}'
												,
											"",
									
											function(response) {
												displayDataPrev(response);
											});
								}
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$(document).on("keyup", "[aria-controls='subReportTableDep'][id='search']", function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#subReportTableDep_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".dataTables_paginate").eq(1).css("pointer-events","auto");
								}else if($("[aria-controls='subReportTableDep'][data-dt-idx='1']").text()>1){
									$("#subReportTableDep_previous").removeClass("disabled");
									$("[aria-controls='subReportTableDep'][data-dt-idx='1']").addClass("prevCall");
								}
							});
		fromAndToDate();
								
	});
		function displayData(response) {
		var resultList = response;
			$("#rowCountSub2").text(resultList.length);
			if ($("#rowCountSub2").text() < 101){
				$("#subReportTableDep_next").addClass("disabled");}
			//	alert(response.size());
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTableDep').dataTable().fnDestroy();
			$("#" + 'subReportTableDep')
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
 									$("#subReportTableDep_previous").removeClass("disabled");
 									$("[aria-controls='subReportTableDep'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableDep_paginate").lastChild.innerHTML = x;
									$($("#subReportTableDep_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("[aria-controls='subReportTableDep'][id='search']").val()==""){
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTableDep_paginate>span>.paginate_button").length;
								$($("#subReportTableDep_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									currentPageNum++;
								});
							}else if($('span:last').hasClass("current")){
										$("#subReportTableDep_next").addClass("disabled");
									}
							}
							});
		}
		
		function displayDataPrev(response) {
			if ($("#rowCountSub2").text() < 101)
				$("#subReportTableDep_next").addClass("disabled");
				var nextPage = $("#nextPageStartSub").val();
			jQuery('#subReportTableDep').dataTable().fnDestroy();
			$("#" + 'subReportTableDep')
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
									 if($('#startIndexSub2').val()==0){
										$("#subReportTableDep_previous").addClass("disabled");}
									 else
 										$("#subReportTableDep_previous").removeClass("disabled");
 									$("[aria-controls='subReportTableDep'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("subReportTableDep_paginate").firstChild.innerHTML = y;
									$($("#subReportTableDep_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#subReportTableDep').dataTable().fnPageChange( 'last' );
									$("#subReportTableDep_next").removeClass("disabled");
									$("[aria-controls='subReportTableDep'][data-dt-idx='5']").addClass('nextCall');
								});
								},
								"fnDrawCallback" : function(oSettings) {
								if($("[aria-controls='subReportTableDep'][id='search']").val()==""){
								$("#rowCountSub2").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#subReportTableDep_paginate>span>.paginate_button").length;
								$($("#subReportTableDep_paginate>span>.paginate_button")).each(function(){
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
				<h4 style="float: left">Deposited Player Data</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div class="dataTbl_top">
				<p>
					<s:a id="download_excel"
						href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=%{reportData}&reportTypeName=%{procName}&recordTofetch="> Download Excel</s:a>
				</p>
			</div>
			<s:hidden id="paramlen" value="%{paramList.size()}"></s:hidden>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="subReportTableDep">
					<thead>
						<tr class="headerRow">
							<th valign="middle" style="text-align: center;">Player Id</th>
							<th valign="middle" style="text-align: center;">User Name</th>
							<th valign="middle" style="text-align: center;">Email Id</th>
							<th valign="middle" style="text-align: center;">Mobile No.
							</th>
							<th valign="middle" style="text-align: center;">Total Wager
							</th>
							<th valign="middle" style="text-align: center;">Total
								Winning</th>
							<th valign="middle" style="text-align: center;">Total
								Withdrawal</th>
							<th valign="middle" style="text-align: center;">Total
								Deposit</th>
							<th valign="middle" style="text-align: center;">First
								Deposit Date</th>
							<th valign="middle" style="text-align: center;">
								Registration IP</th>
							<th valign="middle" style="text-align: center;">State</th>
							<th valign="middle" style="text-align: center;">
								Registration Date</th>
							<th valign="middle" style="text-align: center;">
								First Deposit Refer Source</th>
							<th valign="middle" style="text-align: center;">
                                                                Deposit Device</th>	
	                        <th valign="middle" style="text-align: center;">
                                                                Registration Device</th>	
							<s:iterator value="%{paramList}">
								<th valign="middle" style="text-align: center;"><s:property />
								</th>
							</s:iterator>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer"></div>
				<div id="startIndexSub2" style="display:none"><s:property value="0" /></div>
			<div id=recordTofetchSub1 style="display:none"><s:property value="101" /></div>
		 	<div id="rowCountSub2" style="display:none"><s:property value="%{resultList.size()}"/> </div>
		 	<div id="nextPageStartSub" style="display:none"></div> 
		 	<div id="campId" style="display:none"><s:property value="%{campId}" /></div>
		 	<div id="subCampId" style="display:none"><s:property value="%{subCampId}" /></div>
			<div id="sumofdepvalue1" style="display:none"><s:property value="0" /></div>
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
	<div id="expandResult"></div>
</body>
</html>

