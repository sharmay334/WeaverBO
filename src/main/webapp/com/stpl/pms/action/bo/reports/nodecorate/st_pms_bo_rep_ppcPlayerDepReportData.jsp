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
	$(document).ready(function(){
		$('#waitDiv').hide();
  		$('#search').show();
  		$('#search').attr("disabled",false);
		$("#reportTable").dataTable({
    		"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
      		"sAjaxDataProp":"resultList",
	  		"sServerMethod": "POST",
	  		"deferRender": true,
	    	"scrollX": "100%",
			"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
        		var api = this.api();
         		for(var j=1; j<6;j++){
           			var sum=0;
            		for ( var i=iStart ; i<iEnd ; i++ ) 
            			sum += aaData[aiDisplay[i]][j]*1;
           			$( api.column(j).footer() ).html(parseFloat(sum).toFixed(2));
           		}
			}
		}); 
	});	
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					India Bet Player Wager Report For Domain :
					<s:property value="%{domainName}" />
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div class="dataTbl_top">
				<p>
					<a
						href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=<s:property value="%{procName}"/> ">Download
						Excel</a>
				</p>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
							<th style="text-align: center;">India Bet User Id</th>
							<th valign="middle" style="text-align: center;">Wager Amount
							</th>
							<th valign="middle" style="text-align: center;">Gross Rake</th>

							<th valign="middle" style="text-align: center;">Bonus To
								Cash</th>
							<th valign="middle" style="text-align: center;">Gateway
								Charges</th>
							<th valign="middle" style="text-align: center;">40% rake for
								India Bet</th>
						</tr>
					</thead>
					<tbody></tbody>
					<tfoot>
						<tr>
							<th valign="middle" style="text-align: center;">Total</th>
							<th valign="middle" style="text-align: center;"></th>
							<th valign="middle" style="text-align: center;"></th>
							<th valign="middle" style="text-align: center;"></th>
							<th valign="middle" style="text-align: center;"></th>
							<th valign="middle" style="text-align: center;"></th>
						</tr>
					</tfoot>
				</table>
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
	<div id="expandIt"></div>
</body>
</html>

