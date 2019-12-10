<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
/*	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; */
	String basePath =  (String)request.getAttribute("basePathURL") ;
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	long time=Calendar.getInstance().getTimeInMillis();
%>
<html>
<head>
<style type="text/css">
.dashBoardLoading {
	float: left;
	margin-left: 20px;
	margin-top: 20px;
	width: 300px;
	height: 170px;
	text-align: center;
	padding-top: 76px;
}
</style>
<script src="<%=path %>/com/stpl/pms/action/bo/lm/drawHighCharts.js"></script>
<SCRIPT type="text/javascript">
		$(document).ready(function() {	
				var domainId = $("#graphDomainId").val();
				if(domainId!=-1 && domainId){
					_ajaxCallDiv("../reports/st_pms_bo_rep_dynChart.action","domainId="+domainId,"chartContainer");
				}
			
			$('#graphDomainId').change(function() {
				_ajaxCallDiv("../reports/st_pms_bo_rep_dynChart.action","domainId="+this.value,"chartContainer");
			});		
		});
	
		

	function dashBoardAjaxCall(chartId) {
		 var chartLoaderId=chartId+"Load";
		 $("#" + chartLoaderId).show();
		var domainId=$("#graphDomainId").val();
		var domainName = "All";
			if ('<s:property value="%{userInfoBean.userType}" />' == 'BO' || '<s:property value="%{userInfoBean.userType}" />' == 'ADMIN') {
				if (domainId != '-1' ) {
					domainName = $('#graphDomainId option:selected').text();
				}
			} else {
				domainName = '<s:property value="%{domainName}" />';
				$("#" + chartLoaderId).hide();
			}   
			
			$.ajax({
				type : "POST",
				url : "../reports/newChartabc.action?chartName="+chartId+"&graphDomainId="+domainId,
				success : function(result, arguments, text) {
					if (arguments == 'success') {
						var data = text.responseText;
						if(data){
							data =JSON.parse(data);
							switch(chartId){
									case "getTotalRegDayWise" :
										getTotalRegDayWise(data);
										break;
									case "getTotalDepAmtDayWise" :
										getTotalDepAmtDayWise(data);
										break;
									case "getTotalWithDrawDayWise" :
										getTotalWithDrawDayWise(data);
										break;
									case "getTotalRummyWagerDayWise" :
										getTotalRummyWagerDayWise(data);
										break;
									case "getTotalDepRequestStatus" :
										getTotalDepRequestStatus(data);
										break;
									case "getTotalBonusDayWise" :
										getTotalBonusDayWise(data);
										break;
									case "getTotalPokerWagerDayWise" :
										getTotalPokerWagerDayWise(data);
										break;
									case "getRummyWagerDayWise" :
										getRummyWagerDayWise(data);
										break;
									case "getRummyWagerHourWise" :
										getRummyWagerHourWise(data);
										break;
									case "getTotalNgrSlotDayWise" :
										getTotalNgrSlotDayWise(data);
										break;
									case "getTotalNgrIgeDayWise" :	
										getTotalNgrIgeDayWise(data);
										break;	
									case "getWagerAndWinningGameWise":
										getWagerAndWinningGameWise(data);
										break;
									case "getSBSWagerAndWinning" :
										getSBSWagerAndWinning(data);
										break;
									case "getSLEWagerAndWinning" :
										getSLEWagerAndWinning(data);
										break;
									case "getTotalRummyRakeDayWise" :
										getTotalRummyRakeDayWise(data);
										break;
							}
							
								$("#" + chartLoaderId).hide();
								$("#" + chartId).show();
						}
				}
			}
		});
	}
	

	//return "fdefdsfsdf";
</SCRIPT>
</head>
<body class="chartPage">
	<s:hidden id="contentPath" value="%{contentPath}"></s:hidden>
	<div class="clear2"></div>
	<div class="FormSection">
		<div class="greyStrip">
				<h4>
					Statistics
				</h4>
		</div>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Domain Name</label>
				</div>
				<div class="InputDiv">
					<s:if test="%{domainId>1}">
						<s:hidden value="%{domainId}" id="graphDomainId"
							name="graphDomainId"></s:hidden>
						<s:property value="%{domainName}" />
					</s:if>
					<s:else>
						<s:select theme="myTheme" cssClass="select1"
							list="%{domainMap}" name="graphDomainId" id="graphDomainId"
							headerKey="-1" headerValue="--Please Select--" value="%{bydefaultSelectedDomain}"
							listKey="%{key}" listValue="%{value}" applyscript="true"></s:select>
					</s:else>
				</div>
			</div>
		</div>
	</div>
	<div id="chartContainer"></div>
</body>
</html>
