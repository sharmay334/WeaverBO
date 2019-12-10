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
	var dtable;
	$(document).ready(function() {
	var crow = 0;
	
		dtable=$("#reportTable").DataTable({ 
			"sAjaxSource" : 'com/stpl/pms/action/bo/ajax/dataTablesAction.action',
			"sAjaxDataProp":"dataList",
			"sServerMethod": "POST",
			"deferRender": true,
			"scrollX": "100%",
			"bLengthChange" : false,
			"pageLength" : 30,
			"oLanguage" : {
									"sInfo" : '',
						 },
			 "aoColumnDefs" : [{
							 "fnCreatedCell" :function (nTd, sData, oData, iRow, iCol) {
								crow = iRow;
							 }
							 },{
							"aTargets" : [7],
							"mRender" : function(
									data, type,
									full) {
											return '<a  style="cursor: pointer; margin: 4px 0px 4px 0px;padding: 2px 14px;" class ="view-btn row-trgt" ' + '"> CLOSE </a>';
											}
							},{
				       		"aTargets": [8],
				       		"mRender": function (data, type, full) {
				       						//return '<input type="text" id ="reasonId'+crow+'" name ="reason" maxlength="95"/>';	
											 divData =  '<input type="text" id ="reasonId'+crow+'" name ="reason" maxlength="95"/>';
											crow++;
											return divData;    
				       		    }
		       				} ], 
								"fnDrawCallback": function ( oSettings ) {									
									
									
									
									$("[data-dt-idx='1']").hide();
									$(".view-btn").off('click').click(function(){
										var selectedBtn=this;
										var rowData = dtable.row($(this).parent().parent()).data();
										var reason = encodeURIComponent($(this).parent().siblings().children('[id*=reason]').val());
										if(typeof(reason) == undefined || reason == ""){
											alert("Please Enter Reason For Payment Correction");
											return false;
										}
										 var alreadyClicked = $(this).data("clicked");
										   if (alreadyClicked) {
										      	return false;
										   }
									   	$(this).data('clicked', true);
										var domainId = $("#domainId").val();
 									  _ajaxCallJsonSynch(
											"com/stpl/pms/action/bo/cashier/st_pms_bo_csh_subwalletRec_save.action?playerId="
													+ rowData[0]
													+ "&tableId="
													+ rowData[3]
													+ "&subWalletTime="
													+ rowData[6]
													+ "&amt="
													+ rowData[4]
													+ "&reason="
													+ reason
													+ "&domainId="
													+ domainId
													+ "&aliasId="
													+ rowData[2], "", function(response) {
													if(response == "success"){	
														dtable.row($(selectedBtn).parent().parent()).remove().draw();
													}else{
														alert("Some Internal Error");
													}
												
											}); 
										
									});
								}
		});
		
	
		
		
		$("#reportTable_paginate").hide();
	});
	
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					SubWallet Reconcilation Report
					<s:property value="%{domainName}" />
				</h4>			
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
							<th style="text-align: center;">Player Id</th>
							<th valign="middle" style="text-align: center;">User Name</th>
							<th valign="middle" style="text-align: center;">Alias Id</th>
							<th valign="middle" style="text-align: center;">Table Id</th>
							<th valign="middle" style="text-align: center;">Amount</th>
							<th valign="middle" style="text-align: center;">Last Update
								Time</th>
							<!-- <th valign="middle" style="text-align: center;">Status</th>-->
							<th valign="middle" style="text-align: center;">Unique Time</th>
							<th valign="middle" style="text-align: center;">Active Subwallet</th> 
							<th valign="middle" style="text-align: center;"> Reason</th>
								<!-- <div id="subWalletActive" class="animated-button-div" style="margin:13px 0px 14px 0px; display: none;">
									<div class="animated-striped" style="padding:3px 21px 2px 20px;">Wait...</div>
								</div> -->
								
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div style="margin-left: 890px;">	
				<%--  <s:if test="%{startSubwalletId>0}">
				 	<a href="#" onclick="javascript:  $('#previousFlag').val('true'); $('#subwalletRecFrm').submit();  return false;"> < Previous Data > </a>				 	
					<a href="#" onclick="javascript: $('#previousFlag').val('false');$('#subwalletRecFrm').submit();  return false;"> < More Data > </a>
				</s:if> --%>
			</div>	
			</div>
			<div class="box_footer"></div>
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

