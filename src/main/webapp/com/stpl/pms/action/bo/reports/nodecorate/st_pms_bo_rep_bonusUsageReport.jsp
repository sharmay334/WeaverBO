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
 			}, {
				"aTargets": [1],
				"mRender": function (data, type, full) {
								var bonusName=''; 
								var a = full[1].split(' ');
								if(a.length>0)
								{
									for(var b=0;b<a.length;b++)
									{
										if((a.length)-1 == b)
										{
											bonusName+=a[b];
										}
										else
										{
											var d = a[b]+'%20'; 
											bonusName=bonusName+d;
										}
									}
								}
								return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getBonusPlrDetailReport&reportData={"domainId":'+$("#domainId").val()+',"aliasId":"'+$("#aliasId").val() +'","bonusCode":"'+bonusName +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy',$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'reportCurrency":"'+$("#reportCurrency").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"}  target='+'"expandIt">'+data+'</a>';
							}																																																																																																																																																																  
			}],
			"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
	        	var api = this.api();
	            for(var j=2; j<8;j++){
			    	var sum=0;
				    for ( var i=iStart ; i<iEnd ; i++ ) 
				    	sum += aaData[aiDisplay[i]][j]*1;
				    if( j==2 || j==3)
				    	$(api.column(j).footer()).html(parseFloat(sum));
				    else 	
			      		$(api.column(j).footer()).html(parseFloat(sum).toFixed(2));
			    } 
	        }
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
												displayData1(response);
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
												displayDataPrev1(response);
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
								},	 "aoColumnDefs": [{
									"aTargets": [0],
									"bVisible": true, 
					 			}, {
									"aTargets": [1],
									"mRender": function (data, type, full) {
													var bonusName=''; 
													var a = full[1].split(' ');
													if(a.length>0)
													{
														for(var b=0;b<a.length;b++)
														{
															if((a.length)-1 == b)
															{
																bonusName+=a[b];
															}
															else
															{
																var d = a[b]+'%20'; 
																bonusName=bonusName+d;
															}
														}
													}
													return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getBonusPlrDetailReport&reportData={"domainId":'+$("#domainId").val()+',"bonusCode":"'+bonusName +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy',$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'reportCurrency":"'+$("#reportCurrency").val()+'","startIndex":0,"recordTofetch":101}  target='+'"expandIt">'+data+'</a>';
												}
								}],
								"columnDefs" : [ {
									"targets" : 'no-sort',
									"orderable" : false,
								} ],
								"fnInitComplete": function( oSettings) {
 									$("#reportTable_previous").removeClass("disabled");
 									$("[aria-controls='reportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("reportTable_paginate").lastChild.innerHTML = x;
									$($("#reportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
								});
								},"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
						        	var api = this.api();
						            for(var j=2; j<8;j++){
								    	var sum=0;
									    for ( var i=iStart ; i<iEnd ; i++ ) 
									    	sum += aaData[aiDisplay[i]][j]*1;
									    if( j==2 || j==3)
									    	$(api.column(j).footer()).html(parseFloat(sum));
									    else 	
								      		$(api.column(j).footer()).html(parseFloat(sum).toFixed(2));
								    } 
						        },"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#reportTable_paginate>span>.paginate_button").length;
								$($("#reportTable_paginate>span>.paginate_button")).each(function(){
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
								},	 "aoColumnDefs": [{
									"aTargets": [0],
									"bVisible": true, 
					 			}, {
									"aTargets": [1],
									"mRender": function (data, type, full) {
													var bonusName=''; 
													var a = full[1].split(' ');
													if(a.length>0)
													{
														for(var b=0;b<a.length;b++)
														{
															if((a.length)-1 == b)
															{
																bonusName+=a[b];
															}
															else
															{
																var d = a[b]+'%20'; 
																bonusName=bonusName+d;
															}
														}
													}
													return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getBonusPlrDetailReport&reportData={"domainId":'+$("#domainId").val()+',"bonusCode":"'+bonusName +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy',$("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'reportCurrency":"'+$("#reportCurrency").val()+'","startIndex":0,"recordTofetch":101}  target='+'"expandIt">'+data+'</a>';
												}
								}],
								"columnDefs" : [ {
									"targets" : 'no-sort',
									"orderable" : false,
								} ],
								"fnInitComplete": function( oSettings) {
									 if($('#startIndex').val()==0){
										$("#reportTable_previous").addClass("disabled");}
									 else
 										$("#reportTable_previous").removeClass("disabled");
 									$("[aria-controls='reportTable'][data-dt-idx='1']").addClass('prevCall');
 									document.getElementById("reportTable_paginate").firstChild.innerHTML = y;
									$($("#reportTable_paginate>span>.paginate_button")).each(function(){
									$(this).text(nextPage);
									nextPage++;
									$('#reportTable').dataTable().fnPageChange( 'last' );
									$("#reportTable_next").removeClass("disabled");
									$("[aria-controls='reportTable'][data-dt-idx='5']").addClass('nextCall');
								});
								},"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
						        	var api = this.api();
						            for(var j=2; j<8;j++){
								    	var sum=0;
									    for ( var i=iStart ; i<iEnd ; i++ ) 
									    	sum += aaData[aiDisplay[i]][j]*1;
									    if( j==2 || j==3)
									    	$(api.column(j).footer()).html(parseFloat(sum));
									    else 	
								      		$(api.column(j).footer()).html(parseFloat(sum).toFixed(2));
								    } 
						        },
								"fnDrawCallback" : function(oSettings) {
								if($("#search").val()==""){
								$("#rowCount").text("101");
								flagPage++;
								if(flagPage < 3) {
									return false;
								}
								var currentPageNum = nextPage-$("#reportTable_paginate>span>.paginate_button").length;
								$($("#reportTable_paginate>span>.paginate_button")).each(function(){
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
					Bonus Detail Report For Domain :
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

							<th valign="middle" style="text-align: center;" rowspan="2">
								Domain Name</th>
							<th style="text-align: center;" rowspan="2">Active Bonus</th>
							<th valign="middle" style="text-align: center;" colspan="2">
								No. of Plr Received</th>
							<th valign="middle" style="text-align: center;" rowspan="2">
								Bonus Distributed Amt</th>
							<th valign="middle" style="text-align: center;" rowspan="2">
								Redeemed Amt</th>
							<th valign="middle" style="text-align: center;" rowspan="2">
								Pending Amt</th>
							<th valign="middle" style="text-align: center;" rowspan="2">
								Expired Amt</th>
						</tr>
						<tr>
							<th valign="middle" style="text-align: center;">Total Plr</th>
							<th valign="middle" style="text-align: center;">Unique Plr
							</th>
						</tr>
					</thead>
					<tbody></tbody>
					<tfoot>
						<tr>
							<th></th>
							<th valign="middle" style="text-align: center;">Total</th>
							<th valign="middle" style="text-align: center;"></th>
							<th valign="middle" style="text-align: center; "></th>
							<th valign="middle" style="text-align: center; "></th>
							<th valign="middle" style="text-align: center; "></th>
							<th valign="middle" style="text-align: center; "></th>
							<th valign="middle" style="text-align: center; "></th>
						</tr>
					</tfoot>
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


