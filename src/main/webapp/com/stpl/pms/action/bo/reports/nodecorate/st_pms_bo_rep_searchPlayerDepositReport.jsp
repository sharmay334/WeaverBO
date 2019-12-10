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
	$(document).ready(function() {
		$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
		var columnsLength;
		fromAndToDate();
		var table = $("#reportTable").DataTable({
				    	"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
				      	"sAjaxDataProp":"resultList",
					  	"sServerMethod": "POST",
					  	"deferRender": true,
					    "scrollX": "100%",
				      	"aaSorting":[],
				   		"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
				    		columnsLength = $("#headerArray").val().split(",").length*2+3;
	            			var api = this.api();
	            			for(var j=1; j<columnsLength;j++){
			            		var sum=0;
				            	for ( var i=iStart ; i<iEnd ; i++ )
				            		sum += aaData[aiDisplay[i]][j]*1;
				            	if(j%2==0)
			            			$( api.column(j).footer() ).html(parseFloat(sum));
			            		else
			            			$( api.column(j).footer() ).html(parseFloat(sum).toFixed(2));
			            	}
			            	if($("#reportType").val()!="getWithDrawalTxnReport")
			            		$( api.column(columnsLength).footer() ).html($("#avgTotalSucc").val());
	        			}
					}); 
		$('input:radio[name=displayType]').change(function(){
			if($('input:radio[name=displayType]:checked').val()=="amt"){
				for(var i=1;i<columnsLength;i++)
					(i%2==0)?table.column(i).visible(true):table.column(i).visible(false);
			} else if($('input:radio[name=displayType]:checked').val()=="plr") {
	  			for(var i=1;i<columnsLength;i++)
					(i%2==0)?table.column(i).visible(false):table.column(i).visible(true);
			} else {
				for(var i=1;i<columnsLength;i++)
					table.column(i).visible(true);
			 }
		});
	});
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<s:hidden id="reportType" value="%{reportType}"></s:hidden>
			<s:hidden id="headerArray" value="%{headerArray}"></s:hidden>
			<s:hidden id="avgTotalSucc" value="%{avgTotalSucc}"></s:hidden>
			<div class="greyStrip">
				<h4 style="float: left">
					<s:if test="reportType!= 'getWithDrawalTxnReport'">
                         Deposit Status  Report For Domain : <s:property
							value="%{domainName}" />
					</s:if>
					<s:else>
                          Withdrawal Status  Report For Domain : <s:property
							value="%{domainName}" />
					</s:else>
				</h4>

				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div id="ajaxResponse">
				<div class="dataTbl_top">
					<p align="center">
						Display Type:
						<s:radio id="typeToDisplay" name="displayType"
							list="#{'amt':'No.of Request','plr':'Requested Amount','both': 'Both'}"
							value="%{'both'}" />
					</p>
				</div>
				<div class="dataTbl_top">
					<p>
						<s:if test="reportType!= 'getWithDrawalTxnReport'">
							<a
								href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=depTnxReports">Download
								Excel</a>
						</s:if>
						<s:else>
							<a
								href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=withDrawTnxReports">Download
								Excel</a>
						</s:else>
					</p>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="0" border="0" align="center"
						class="payTransaction" id="reportTable">

						<s:iterator value="%{reportResult}" status="reportResult"
							var="reportResult">
							<s:if test="%{#reportResult.index==0}">
								<thead>
									<tr>
										<th valign="middle" rowspan="2" style="text-align: center;"
											nowrap="nowrap">Payment GateWay</th>
										<s:iterator value="value" var="reportResultKey"
											status="reportResultKey">
											<s:if test="%{key.replaceAll('_',' ')=='CANCEL ON FALIURE'}">
												<th colspan="2" style="text-align: center;" class="header"
												nowrap="nowrap">CANCEL ON FAILURE</th>
											</s:if>
											<s:else>
												<th colspan="2" style="text-align: center;" class="header"
												nowrap="nowrap"><s:property
													value="%{key.replaceAll('_',' ')}" /></th>
											</s:else>
										</s:iterator>
										<th valign="middle" colspan="2" nowrap="nowrap"
											style="text-align: center;" class="header">Total</th>
										<s:if test="reportType!= 'getWithDrawalTxnReport'">
											<th rowspan="2" style="text-align: center;" nowrap="nowrap">S
												Rate</th>
											<th rowspan="2" style="text-align: center;" nowrap="nowrap">Avg
												Resp Time (Min)</th>
										</s:if>
									</tr>
									<tr>
										<s:iterator value="value" var="reportResultKey"
											status="reportResultKey">
											<th style="text-align: center;" nowrap="nowrap">
												Amount</th>
											<th style="text-align: center;" nowrap="nowrap">
												Req</th>
										</s:iterator>
										<th style="text-align: center;" nowrap="nowrap">Amount</th>
										<th style="text-align: center;" nowrap="nowrap">Req</th>
									</tr>
								</thead>
							</s:if>
							<tbody></tbody>
						</s:iterator>
						<s:iterator value="%{reportResult}" status="reportResult"
							var="reportResult">
							<tfoot>
								<tr class="totalResult">
									<s:if test="%{#reportResult.index==0}">
										<th valign="middle" rowspan="1" nowrap="nowrap"
											style="text-align: center;">Total</th>
										<s:iterator value="value" var="reportResultKey">
											<th valign="middle" style="text-align:center;"
												nowrap="nowrap" class="totalAmt"></th>
											<th valign="middle" style="text-align:center;"
												nowrap="nowrap" class="totalPlr"></th>
										</s:iterator>
										<th valign="middle" style="text-align:center;" nowrap="nowrap"></th>
										<th valign="middle" style="text-align:center;" nowrap="nowrap"></th>
										<s:if test="reportType!= 'getWithDrawalTxnReport'">
											<th valign="middle" style="text-align:center;"
												nowrap="nowrap"></th>
											<th valign="middle" style="text-align:center;"
												nowrap="nowrap"></th>
										</s:if>
									</s:if>
								</tr>
							</tfoot>
						</s:iterator>
					</table>
				</div>
				<div class="box_footer"></div>
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
</body>
</html>