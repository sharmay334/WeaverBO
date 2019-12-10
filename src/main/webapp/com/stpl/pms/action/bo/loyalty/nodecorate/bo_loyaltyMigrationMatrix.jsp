<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Loyalty Migration Summary Matrix</title>
<script type="text/javascript">	
	$(document).ready(function(){
		disableZeroExcel();
	});
	function disableZeroExcel(){
		$.each($("#LMatrix a"),function(index,val){
			if(parseInt($(val).text().trim())<=0){
				$(val).attr("disabled","disabled");
				$(val).attr("href","");
				$(val).click( function(){
					return false;
				});
			}	
		});
	}
</script>
<style type="text/css">
#LMatrix td {
	text-align: center;
}

#LMatrix td {
	padding: 5px;
	width: 100px;
	border-left: 1px;
}

#LMatrix .bolder {
	font-weight: bolder;
	color: black;
	background-color: #eaeaea;
}
#LMatrix a{
	color: #777;
	font-size: 15px;
}

.totalStat {
	font-weight: bolder;
}
</style>
</head>

<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Loyalty Migration Summary Matrix</h4>
		</div>
		<div align="center" style="margin: 20px ;color: black;    font-size: medium;"><s:property value="%{migrationSummaryRequest.toDate}" /></div>
		<div class="innerBox" align="center" style="margin: 30px;margin-top:0;margin-left:0;text-transform: uppercase;">
		<div align="center" style="    margin: 20px;color: black;position: absolute;    font-size: medium;transform: rotate(270deg);top: 110px;left: -35px;"><s:property value="%{migrationSummaryRequest.fromDate}" /></div>
			<table id="LMatrix" border="1px" >
				<tr>
					<td class="bolder"></td>
					<td class="bolder">total</td>
					<td class="bolder">Bronze</td>
					<td class="bolder">Silver</td>
					<td class="bolder">Gold</td>
					<td class="bolder">Diamond</td>
					<td class="bolder">Platinum</td>
				</tr>
				<tr>
					<td class="bolder">total</td>
					<td ></td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&destTier=1"}' > <s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getFinalTotal(1l)}"/></s:a></td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getFinalTotal(2l)}"/></s:a></td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getFinalTotal(3l)}"/></s:a></td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getFinalTotal(4l)}"/></s:a></td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getFinalTotal(5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">Bronze</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=1&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(1l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=1&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(1l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=1&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(1l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=1&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(1l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=1&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(1l,5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">Silver</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=2&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(2l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=2&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(2l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=2&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(2l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=2&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(2l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=2&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(2l,5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">Gold</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=3&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(3l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=3&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(3l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=3&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(3l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=3&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(3l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=3&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(3l,5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">Diamond</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=4&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(4l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=4&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(4l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=4&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(4l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=4&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(4l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=4&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(4l,5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">Platinum</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(5l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=5&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(5l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=5&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(5l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=5&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(5l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=5&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(5l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=5&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(5l,5l)}"/></s:a></td>
				</tr>
				<tr>
					<td class="bolder">New</td>
					<td class="totalStat"><s:a href='%{getExcelBaseLink()+"&sourceTier=-1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getInitialTotal(-1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=-1&destTier=1"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(-1l,1l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=-1&destTier=2"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(-1l,2l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=-1&destTier=3"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(-1l,3l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=-1&destTier=4"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(-1l,4l)}"/></s:a></td>
					<td><s:a href='%{getExcelBaseLink()+"&sourceTier=-1&destTier=5"}' ><s:property value="%{migrationSummaryResponse==null?0:migrationSummaryResponse.getMigrationCount(-1l,5l)}"/></s:a></td>
				</tr>
			</table>
		</div>
	</div>
	<div style="margin-bottom: 100px"></div>
</body>
</html>
