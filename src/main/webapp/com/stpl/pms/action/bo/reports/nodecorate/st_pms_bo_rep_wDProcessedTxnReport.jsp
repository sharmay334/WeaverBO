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
		var disType = 'both';
		var columnsLength = 13;
		var table = $("#reportTable").DataTable({
				    	"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
				      	"sAjaxDataProp":"resultList",
					  	"sServerMethod": "POST",
					  	"deferRender": true,
					    "scrollX": "100%",
				      	"aaSorting":[],
				      	"aoColumnDefs": [ 
				     		<%for(int i=1;i<13;i++){ %>
				      			{
						       		"sDefaultContent": '--',						      
						        	"aTargets": [<%=i%>]
						      	}, 
      						<%}%>
      						 						],
      					"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
	            			for(var j=1; j<columnsLength;j++){
	            				var totalAmt, totalReq, sum=0;
				            	for ( var i=iStart ; i<iEnd ; i++ )
				            		sum += aaData[aiDisplay[i]][j]*1;
				            	if(j==1)
				            		totalAmt=sum;
				            	if(j==2)	
				            		totalReq=sum;		
				            	if(j%2==0 && (disType=='req' || disType=='both')){
					            	$($(nRow).find('th')[j]).html(sum);
					            	var perAmt = (parseFloat(sum/totalReq*100).toFixed(2));
					            	$($($(nRow).next()[0]).find('th')[j]).html((isNaN(perAmt)?'0.00':perAmt)+"%"); 
				         		} else if(j%2!=0 && (disType=='amt' || disType=='both')){
					            	$($(nRow).find('th')[j]).html(parseFloat(sum).toFixed(2));
					            	var perReq = (parseFloat(sum/totalAmt*100).toFixed(2));
	   								$($($(nRow).next()[0]).find('th')[j]).html((isNaN(perReq)?'0.00':perReq)+"%"); 
   								}
			            	}
	        			}
				   });
		$('input:radio[name=displayType]').change(function(){
			if($('input:radio[name=displayType]:checked').val()=="amt") {
				disType = 'req';
				for(var i=1;i<columnsLength;i++)
					(i%2==0)?table.column(i).visible(true):table.column(i).visible(false);
	  	  	} else if ($('input:radio[name=displayType]:checked').val()=="plr") {
	  	  		disType = 'amt';
	  			for(var i=1;i<columnsLength;i++)
					(i%2==0)?table.column(i).visible(false):table.column(i).visible(true);
		   	} else {
		   		disType = 'both';
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
					Withdrawal Processed Detail Report For Domain :
					<s:property value="%{domainName}" />
				</h4>
				<h4 class="dateData" style="text-align: right; background: none">
				</h4>
			</div>
			<div id="ajaxResponse">
				<div class="dataTbl_top">
					<p align="center">
						Display Type:
						<s:radio id="typeToDisplay" name="displayType"
							list="#{'amt':'No.Request','plr':'Amount','both': 'Both'}"
							value="%{'both'}" />
					</p>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="0" border="0" align="center"
						class="payTransaction" id="reportTable">
						<thead>
							<tr>
								<th valign="middle" rowspan="2" style="text-align: center;">
									Date</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									Total Done</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									DoneDay Req</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									DoneDay-1 Req</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									DoneDay-2 Req</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									DoneDay-3 Req</th>
								<th valign="middle" colspan="2" style="text-align: center;">
									DoneDay > 4 Req</th>
							</tr>
							<tr>
								<s:iterator begin="0" end="5" var="indexVar">
									<th style="text-align: center;">Amount</th>
									<th style="text-align: center;">Req</th>
								</s:iterator>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<th valign="middle" rowspan="1" style="text-align: center;">
									Total</th>
								<s:iterator begin="0" end="5" var="indexVar">
									<th valign="middle" style="text-align: center;"></th>
									<th valign="middle" style="text-align: center;"></th>
								</s:iterator>
							</tr>
							<tr>
								<th valign="middle" rowspan="1" style="text-align: center;">
									Percentage</th>
								<s:iterator begin="0" end="5" var="indexVar">
									<th valign="middle" style="text-align: center; "></th>
									<th valign="middle" style="text-align: center;"></th>
								</s:iterator>
							</tr>
						</tfoot>
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