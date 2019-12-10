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
	    fromAndToDate();
	    $('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
	});
	</script>
	</head>

	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Player Transaction Report
					</h4>
					 <h4 class="dateData" style="text-align: right">
					</h4>
				</div>
				<div class="dataTbl_top">
					<p>
						<a href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=allTnxReports">Download Excel</a>
					</p>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction">
						  <tr>
						        <th id="th_0" is_link="false" is_hidden="true" style="display: none;">
											DomainId
								</th>
							  	<th width="5%" valign="middle" style="text-align: center;" id="th_1" is_link="false">
											Domain Name
								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_2" data_column="sum" is_link="true" json_param="domainId,aliasId,fromDate,toDate,reportCurrency">
											<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getDepositDetailPG&reportData=.td_0,.td_6,#fromDate,#toDate,#reportCurrency'  target="expandIt" callBack="attachEvent('expandIt')"></a>
											Total Deposit								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_3" data_column="sum" is_link="false">
											Depositing Players
								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_4" data_column="sum" is_link="true" json_param="domainId,aliasId,fromDate,toDate,reportCurrency">
											<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getWithdrawalDetailPG&reportData=.td_0,.td_6,#fromDate,#toDate,#reportCurrency'  target="expandIt" callBack="attachEvent('expandIt')"></a>
											Total Withdrawal 
								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_5" data_column="sum" is_link="false">
											Withdrawal Players
								</th>
								<th id="th_6" is_link="false" is_hidden="true" style="display: none;">
											AliasId
								</th>
							 </tr>
						<s:iterator value="%{resultList}" status="resultList"
							var="resultListVar">
							<tr>
								<s:iterator value="%{#resultListVar}" status="indexvalue">
								       <s:if test="#indexvalue.index==1">
										<td width="5%" valign="middle" style="text-align: center;" class='tdclass td_<s:property value="%{#indexvalue.index}"/>' >
											<s:property />
										</td>
								       </s:if>
								       <s:else>
										<td width="5%" valign="middle" style="text-align: right;" class='tdclass td_<s:property value="%{#indexvalue.index}"/>' >
											<s:property />
										</td>
									</s:else>	
								</s:iterator>
							</tr>
						</s:iterator>
						<tr>
						   <th width="5%" valign="middle" align="left" class="td_0">
									Total
						   </th>
						   <th width="5%" valign="middle" style="text-align: center;">
											Total
							</th>
							<th width="5%" valign="middle" align="left" id="sum_2" style="text-align: right; padding-right: 5px;">
							</th>
							 <th width="5%" valign="middle" align="left" id="sum_3" style="text-align: right; padding-right: 5px;">
							</th>
							<th width="5%" valign="middle" align="left" id="sum_4" style="text-align: right; padding-right: 5px;">
							</th>	
                            <th width="5%" valign="middle" align="left" id="sum_5" style="text-align: right; padding-right: 5px;"> 
							</th>	
							<th width="5%" valign="middle" align="left" class="td_6">
									Total
						   </th>
						</tr>
					</table>
				</div>
				<div class="box_footer">
				</div>
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