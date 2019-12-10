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
					    "sAutoWidth":false,
				      	"aaSorting":[],
						"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
							columnsLength = $("#headerArray").val().split(",").length*2+3;
	            			var api = this.api();
	            			for(var j=1; j<columnsLength;j++){
			            		var sum=0;
				            	for ( var i=iStart ; i<iEnd ; i++ ) 
				            		sum += aaData[aiDisplay[i]][j]*1;
				            	if(j%2==0)
			            			$(api.column(j).footer()).html(parseFloat(sum));
			            		else
			            			$(api.column(j).footer()).html(parseFloat(sum).toFixed(2));
			            	}
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
		<s:hidden id="reportType" name="reportType" value="%{reportType}" />
		<s:hidden id="reportDataAjax" name="reportData" value="%{reportData}" />
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					<s:if test="%{reportType=='getDepositDetail'}">
                           Deposit Detail Report For Domain : <s:property
							value="%{domainName}" />
					</s:if>
					<s:else>
                          Withdrawal Detail Report For Domain : <s:property
							value="%{domainName}" />
					</s:else>
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div class="dataTbl_top">
				<p>
					Report Category:
					<s:radio id="reportCategory" name="reportCategories"
						list="#{'PG':'Payment GateWay','PT':'Payment Type'}"
						value="%{'PG'}" />
				</p>
			</div>
			<div id="ajaxResponse">
				<s:hidden id="headerArray" value="%{headerArray}"></s:hidden>
				<div class="dataTbl_top">
					<p align="center">
						Display Type:
						<s:radio id="typeToDisplay" name="displayType"
							list="#{'amt':'Player','plr':'Amount','both': 'Both'}"
							value="%{'both'}" />
					</p>
				</div>
				<div class="tableScrollbar">
					<div class="innerBox">
						<table cellspacing="0" cellpadding="0" border="0" align="center"
							class="payTransaction" id="reportTable">
							<thead>
								<s:iterator value="%{reportResult}" status="reportResult"
									var="reportResult">
									<s:if test="%{#reportResult.index==0}">
										<tr>
											<th valign="middle" rowspan="2" style="text-align: center;"
												nowrap="nowrap"><s:property value="%{leftTopHeading}" />
											</th>
											<s:iterator value="value" var="reportResultKey"
												status="reportResultKey">
												<th colspan="2" style="text-align: center;" class="header"
													nowrap="nowrap"><s:property value="key" />
												</th>
											</s:iterator>
											<th valign="middle" colspan="2" style="text-align: center;"
												nowrap="nowrap">Total</th>
										</tr>
										<tr>
											<s:iterator value="value" var="reportResultKey"
												status="reportResultKey">
												<th colspan="1" style="text-align: center;" nowrap="nowrap">Amount</th>
												<th colspan="1" style="text-align: center;" nowrap="nowrap">Plr</th>
											</s:iterator>
											<th colspan="1" style="text-align: center;" nowrap="nowrap">Amount</th>
											<th colspan="1" style="text-align: center;" nowrap="nowrap">Plr</th>
										</tr>
									</s:if>
								</s:iterator>
							</thead>
							<tbody></tbody>
							<tfoot>
								<s:iterator value="%{reportResult}" status="reportResult"
									var="reportResult">
									<s:if test="%{#reportResult.index==0}">
										<tr>
											<th valign="middle" style="text-align: center;" rowspan="1">
												Total</th>
											<s:iterator value="value" var="reportResultKey"
												status="reportResultKey">
												<th class="totalAmt" valign="middle"
													style="text-align: center; "></th>
												<th class="totalPlr" valign="middle"
													style="text-align: center; "></th>
											</s:iterator>
											<th valign="middle" style="text-align:center;"></th>
											<th valign="middle" style="text-align:center;"></th>
										</tr>
									</s:if>
								</s:iterator>
							</tfoot>
						</table>
					</div>
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