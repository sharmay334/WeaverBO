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

        var jsonData=JSON.parse($("#reportdata").text());
		var emailcondition=jsonData.emailVerified;
		console.log(emailcondition);
		if(emailcondition==="undefined") {
            $("#download_excel").attr("href", $('#download_excel').attr('href')+$('#sumofregvalue').text());
            $('#sumofregvalue1').text($('#sumofregvalue').text());

        }else {
            $("#download_excel").attr("href", $('#download_excel').attr('href')+$('#sumofemailregvalue').text());

            $('#sumofregvalue1').text($('#sumofemailregvalue').text());
        }


	$('#startIndexSub1').text("0");
	$('#rowCountSub1').text("101");
	debugger;
	if($('#sumofregvalue1').text()<=100)
		$('#rowCountSub1').text($('#sumofregvalue1').text());

	$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
    	fromAndToDate();
			 $("#subReportTableReg").DataTable({
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
 				$(document).on("click", "[aria-controls='subReportTableReg'][data-dt-idx='5']:not(.next,.previous)", function(){
 					if($("#rowCountSub1").text()==101 && $("[aria-controls='subReportTableReg'][id='search']").val()==""){
	 					$("#subReportTableReg_next").removeClass("disabled");
		 				$("[aria-controls='subReportTableReg'][data-dt-idx='5']").addClass('nextCall');
		 			}
 				});
 				$(document).on("click", "[aria-controls='subReportTableReg'][data-dt-idx='1']:not(.next,.previous)", function(){
 					if($("[aria-controls='subReportTableReg'][data-dt-idx='1']").text()>1){
 						$("#subReportTableReg_previous").removeClass("disabled");}
	 				$("[aria-controls='subReportTableReg'][data-dt-idx='1']").addClass('prevCall');
 				});
 				$("#subReportTableReg_next").live('click', function(e) {
								if($("#rowCountSub1").text()==101 && $("[aria-controls='subReportTableReg'][id='search']").val()==""){
									$("#subReportTableReg_next").removeClass("disabled");
								}
								if($("#subReportTableReg_next").hasClass("disabled"))
									return false;
								if($('.paginate_button.current').eq(1).attr("data-dt-idx")==4){
										$("[aria-controls='subReportTableReg'][data-dt-idx='5']").removeClass('nextCall');
										return false;
									}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")<5){
									$("[aria-controls='subReportTableReg'][data-dt-idx='5']").removeClass('nextCall');
									return false;
								}
								else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==5   && !($("[aria-controls='subReportTableReg'][data-dt-idx='5']").hasClass("nextCall") )){
									$("[aria-controls='subReportTableReg'][data-dt-idx='5']").addClass('nextCall');
									e.stopImmediatePropagation();
									e.preventDefault();
									return false;
								}
								if($("[aria-controls='subReportTableReg'][data-dt-idx='5']").hasClass("nextCall")  && !($("#subReportTableReg_next").hasClass("disabled"))) {
									var start = parseInt($(
											"#startIndexSub1")
											.text()) + 100;
											flagPage = 0;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())+1;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub1').text(start);
									 x = document.getElementById("subReportTableReg_paginate").lastChild.innerHTML;
									document.getElementById("subReportTableReg_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
									$('#subReportTableReg_paginate > a:last-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");

                                    $('#sumofregvalue1').text(parseInt($('#sumofregvalue1').text())-100);
                                    if($('#sumofregvalue1').text()<=100)
                                        $('#recordTofetchSub').text($('#sumofregvalue1').text());
									
									
									_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampPlayerRegReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","emailVerified":"'+'undefined'+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub1").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
												,
											"",
											function(response) {
												displayData(response);
                                                $('#recordTofetchSub').text("101");
											});
								}else
									return false;	
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							$('#subReportTableReg_previous').live('click', function(e) {
									if($("[aria-controls='subReportTableReg'][data-dt-idx='1']").text()>1){
 										$("#subReportTableReg_previous").removeClass("disabled");
 									}
 									
 									if($('.paginate_button.current').eq(1).attr("data-dt-idx")==2){
										$("[aria-controls='subReportTableReg'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									}
									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")>1){
										$("[aria-controls='subReportTableReg'][data-dt-idx='1']").removeClass('prevCall');
										return false;
									} 
 									else if($('.paginate_button.current').eq(1).attr("data-dt-idx")==1   && !($("[aria-controls='subReportTableReg'][data-dt-idx='1']").hasClass("prevCall") )){
										$("[aria-controls='subReportTableReg'][data-dt-idx='1']").addClass('prevCall');
										e.stopImmediatePropagation();
										e.preventDefault();
										return false;
									}
										
									if($("[aria-controls='subReportTableReg'][data-dt-idx='1']").hasClass("prevCall") && !($("#subReportTableReg_previous").hasClass("disabled"))) {
									if(parseInt($("#startIndexSub1").text())>0)
										var start = parseInt($("#startIndexSub1").text()) - 100;
											var nextPageStart = parseInt($('.paginate_button.current').eq(1).text())-5;
											$("#nextPageStartSub").val(nextPageStart);
									$('#startIndexSub1').text(start);
									 y = document.getElementById("subReportTableReg_paginate").firstChild.innerHTML;
									document.getElementById("subReportTableReg_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
									$('#subReportTableReg_paginate > a:first-child').addClass('waitBtn');
									$(".dataTables_paginate").eq(1).css("pointer-events","none");
									debugger;
                                        $('#sumofregvalue1').text(parseInt($('#sumofregvalue1').text())+100);
									
										_ajaxCallJsonSynch(
											'com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData={"proceName":"stCmsCampPlayerRegReport","domainId":'+$("#domainId").val()+',"campId":"'+$("#campId").text()+'","subCampId":"'+$("#subCampId").text() +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","emailVerified":"'+'undefined'+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub1").text()+'","'+'recordTofetch":"'+$("#recordTofetchSub").text()+'"}'
												,
											"",
									
											function(response) {
												displayDataPrev(response);
											});
								}
								e.stopImmediatePropagation();
								e.preventDefault();
							});
							
							$(document).on("keyup", "[aria-controls='subReportTableReg'][id='search']", function(){
								if($(this).val()!=""){
									var currentPageNum = 1;
								$($("#subReportTableReg_paginate>span>.paginate_button")).each(function(){
									$(this).text(currentPageNum);
									$(this).addClass('search');
									currentPageNum++;
								});
								$(".dataTables_paginate").eq(1).css("pointer-events","auto");
								}else if($("[aria-controls='subReportTableReg'][data-dt-idx='1']").text()>1){
									$("#subReportTableReg_previous").removeClass("disabled");
									$("[aria-controls='subReportTableReg'][data-dt-idx='1']").addClass("prevCall");
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
				<h4 style="float: left">Registered Player Data</h4>
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
					class="payTransaction" id="subReportTableReg">
					<thead>
						<tr class="headerRow">
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
							<th valign="middle" style="text-align: center;">Reg. Device</th>	
							<th valign="middle" style="text-align: center;">
								Registration IP</th>
							<th valign="middle" style="text-align: center;">State</th>
							<th valign="middle" style="text-align: center;">
								Registration Date</th>
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
				<div id="startIndexSub1" style="display:none"><s:property value="0" /></div>
			<div id=recordTofetchSub style="display:none"><s:property value="101" /></div>
		 	<div id="rowCountSub1" style="display:none"><s:property value="%{resultList.size()}"/></div>
		 	<div id="nextPageStartSub" style="display:none"></div> 
		 	<div id="campId" style="display:none"><s:property value="%{campId}" /></div>
		 	<div id="subCampId" style="display:none"><s:property value="%{subCampId}" /></div>
			<div id="sumofregvalue1" style="display:none"><s:property value="0" /></div>
			<div id="reportdata" style="display:none"><s:property value="%{reportData}"/></div>
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

