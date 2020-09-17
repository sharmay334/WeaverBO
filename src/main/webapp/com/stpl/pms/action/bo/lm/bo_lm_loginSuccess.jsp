<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");

	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
	
</script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
<style>
.grid-container {
  display: grid;
  grid-template-columns: auto auto auto;
  padding: 10px;
}
.grid-item {
  padding: 2px;
  text-align: center;
  width:580px;
  height:400px;
}
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin-top: 50px;
    border: 1px solid rgba(0, 0, 0, 0.8);
}

#container_chart {
    height: 400px;
}
#container_chart1 {
    height: 400px;
}
#container_chart2 {
    height: 400px;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


</style>
<script>
var parsedSeries;
$(document).ready(function() {
	var myBasrUrl = "<%=basePath%>";
	var myurl = myBasrUrl+"/com/stpl/pms/action/bo/um/bo_um_tm_get_transaction_monthly_report_charts.action";
	
	
	var myurl1 = myBasrUrl+"/com/stpl/pms/action/bo/um/bo_um_tm_get_pending_bills_monthly_report_charts.action";
	
	var myurl2 = myBasrUrl+"/com/stpl/pms/action/bo/um/bo_um_tm_get_sale_receipt_report_charts.action";
	
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			parsedSeries = eval(itr);
			Highcharts.chart('container_chart', {
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: 'Monthly Transaction'
			    },
			    subtitle: {
			        text: '(Sale, Purchase, Credit Note, Debit Note)'
			    },
			    xAxis: {
			        categories: [
			            'Jan',
			            'Feb',
			            'Mar',
			            'Apr',
			            'May',
			            'Jun',
			            'Jul',
			            'Aug',
			            'Sep',
			            'Oct',
			            'Nov',
			            'Dec'
			        ],
			        crosshair: true
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Transactions (in numbers)'
			        }
			    },
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: true
			    },
			    plotOptions: {
			        column: {
			            pointPadding: 0.2,
			            borderWidth: 0
			        }
			    },
			    series: parsedSeries
			});
			
			
			
			
		},

		error : function(itr) {

		}
	});
	
	$.ajax({
		type : "GET",
		url : myurl1,
		success : function(itr) {
			parsedSeries = eval(itr);
			Highcharts.chart('container_chart1', {
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: 'Monthly Pending Sale Bills'
			    },
			    subtitle: {
			        text: '(Only Agst Ref Bills)'
			    },
			    xAxis: {
			        categories: [
			            'Jan',
			            'Feb',
			            'Mar',
			            'Apr',
			            'May',
			            'Jun',
			            'Jul',
			            'Aug',
			            'Sep',
			            'Oct',
			            'Nov',
			            'Dec'
			        ],
			        crosshair: true
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Bills (in numbers)'
			        }
			    },
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: true
			    },
			    plotOptions: {
			        column: {
			            pointPadding: 0.2,
			            borderWidth: 0
			        }
			    },
			    series: parsedSeries
			});
			
			
			
		},

		error : function(itr) {

		}
	});
	
	
	$.ajax({
		type : "GET",
		url : myurl2,
		success : function(itr) {
			parsedSeries = eval(itr);
			// Build the chart
			Highcharts.chart('container_chart2', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie'
			    },
			    title: {
			        text: 'Sale vs Receipt vs Credit Note Graph'
			    },
			    tooltip: {
			        pointFormat: '{series.name}: <b>{point.y:.2f} ₹</b>'
			    },
			    accessibility: {
			        point: {
			            valueSuffix: '₹'
			        }
			    },
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true
			            },
			            showInLegend: true
			        }
			    },
			    series: parsedSeries
			});
			
			
		},

		error : function(itr) {

		}
	});
	
	
	
});
</script>
<title>WelCome</title>
</head>
<body>
<s:if test="%{userInfoBean.getUserName().equalsIgnoreCase('bomaster')}">
<div class="grid-container">
  <div class="grid-item">
  <figure class="highcharts-figure" >
    <div id="container_chart"></div>
</figure>
  </div>
  <div class="grid-item">
  <figure class="highcharts-figure" >
    <div id="container_chart1"></div>
</figure>
  </div>
  <div class="grid-item">
  <figure class="highcharts-figure" >
    <div id="container_chart2"></div>
</figure>
  </div>  
  
</div>



</s:if>

</body>
</html>
