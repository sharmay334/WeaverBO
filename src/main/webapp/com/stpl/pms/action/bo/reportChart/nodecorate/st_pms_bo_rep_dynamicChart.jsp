<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
	
%>


<script type="text/javascript">
	
	$(function() {		
		var authGraphs=$("#graphList").val().replace("[","").replace("]","").replace(" ","").split(/\s*,\s*/);
		if(authGraphs)
			for(var i=0;i<authGraphs.length;i++){
				if($("#actionPrivFunctionMap").val().indexOf(authGraphs[i])!=-1) 
				 	dashBoardAjaxCall(authGraphs[i]);
				}
	});

</script>
<s:hidden id="domainId" name="domainId"></s:hidden>
<s:hidden id="graphList" name="graphList"></s:hidden>
<s:hidden id="actionPrivFunctionMap" name="actionPrivFunctionMap"></s:hidden>
<style type="text/css">
#getRummyWagerDayWise {
				height: 400px;
				min-width: 310px;
				max-width: 900px;
			}
#getTotalPokerWagerDayWise {
				height: 400px;
				min-width: 50px;
				max-width: 800px;
			}
			
#getTotalRegDayWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}
#getTotalDepAmtDayWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}
#getTotalWithDrawDayWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}		
#getTotalRummyWagerDayWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}												
#getTotalDepRequestStatus {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}	
#getTotalBonusDayWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}	
#getRummyWagerHourWise {
				height: 400px;
				min-width: 100px;
				max-width: 1300px;
			}		
#getTotalNgrIgeDayWise{
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}	
#getTotalNgrSlotDayWise{
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}
#getWagerAndWinningGameWise {
				height: 300px;
				min-width: 50px;
				max-width: 800px;
			}					
#getSBSWagerAndWinning {
	height: 300px;
	min-width: 50px;
	max-width: 800px;
}
#getSLEWagerAndWinning {
	height: 300px;
	min-width: 50px;
	max-width: 800px;
}
#getTotalRummyRakeDayWise {
				height: 400px;
				min-width: 50px;
				max-width: 800px;
			}													
body {
	margin: 0;
}

.highcharts-title {
    text-transform: uppercase;
    font-size: 14px !important;
    font-weight: 600 !important;
    color: #555555 !important;
    fill: #555555 !important;
    letter-spacing: 0.01em !important;
}

.main_wrapper {
	width: 100%;
	margin: auto;
	max-width: 970px;
}

.new-chart-div {
	width: 100%;
	margin: 15px 0px;
}

.col-3-div {
	float: left;
	width: 31%;
	margin: 0 1%;
	border: 1px solid #d4d4d4;
	overflow: auto;
	position: relative;
	margin-bottom: 15px;
}

.clearboth {
	clear: both;
}

.col-2-div {
	float: left;
	width: 64.2%;
	margin: 0 1%;
	border: 1px solid #d4d4d4;
	overflow: auto;
	position: relative;
}

.col-1-div {
	width: 97.4%;
	margin: 0 1%;
	border: 1px solid #d4d4d4;
	position: relative;
}

img.img-res {
	display: block;
	max-width: 100%;
	height: auto;
}

.margin0 {
	margin-right: 0;
}

.new-chart-div .dashBoardLoading{
	float: none;
	position:absolute;
	width:100%;
	margin-top:30px;
	top:0;
	left:0;
	margin-left: 0;
	z-index:1000;
}
@media only screen and (max-width : 767px) {
	.main_wrapper {
		width: 96%;
	}
	.col-3-div {
		float: left;
		width: 98%;
		margin-bottom: 25px;
	}
	.col-2-div {
		width: 98%;
		margin-bottom: 25px;
	}
	.col-1-div {
		width: 98%;
	}
	.new-chart-div {
		margin: 0;
	}
}

</style>


</head>
  
    <div class="main_wrapper">
		<div class="new-chart-div">
			<s:if test='%{graphList.contains("getTotalRegDayWise") && actionPrivFunctionMap.containsKey("getTotalRegDayWise")}'>
			<div class="col-3-div">
					<div id="getTotalRegDayWise"></div>
					<div id="getTotalRegDayWiseLoad" class="dashBoardLoading" style=" display:none">
						<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
					</div>
				</div>
				</s:if>
				<s:if test='%{graphList.contains("getTotalDepAmtDayWise") && actionPrivFunctionMap.containsKey("getTotalDepAmtDayWise")}'>
				<div class="col-3-div">
					<div id="getTotalDepAmtDayWise"></div>
						<div id="getTotalDepAmtDayWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
				</div>
				</s:if>
				<s:if test='%{graphList.contains("getTotalWithDrawDayWise") && actionPrivFunctionMap.containsKey("getTotalWithDrawDayWise")}'>
				<div class="col-3-div margin0">
					<div id="getTotalWithDrawDayWise" ></div>
					<div id="getTotalWithDrawDayWiseLoad" class="dashBoardLoading" style=" display:none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
				</div>
				</s:if>
				<s:if test='%{graphList.contains("getTotalRummyWagerDayWise") && actionPrivFunctionMap.containsKey("getTotalRummyWagerDayWise")}'>
			<div class="col-3-div">
					<div id="getTotalRummyWagerDayWise"></div>
						<div id="getTotalRummyWagerDayWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
				</div>
				</s:if>
				<s:if test='%{graphList.contains("getTotalDepRequestStatus")  && actionPrivFunctionMap.containsKey("getTotalDepRequestStatus")}'>
				<div class="col-3-div">
					<div id="getTotalDepRequestStatus" ></div>
						<div id="getTotalDepRequestStatusLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
				</div>
				</s:if>
				<s:if test='%{graphList.contains("getTotalBonusDayWise") && actionPrivFunctionMap.containsKey("getTotalBonusDayWise")}'>
				<div class="col-3-div">
					<div id="getTotalBonusDayWise" ></div>
						<div id="getTotalBonusDayWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
					</div>
				</s:if>
					<s:if test='%{graphList.contains("getWagerAndWinningGameWise") }'>
				<div class="col-3-div">
					<div id="getWagerAndWinningGameWise" ></div>
						<div id="getWagerAndWinningGameWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
					</div>
				</s:if>
			<s:if test='%{graphList.contains("getSBSWagerAndWinning")}'>
				<div class="col-3-div">
					<div id="getSBSWagerAndWinning" ></div>
						<div id="getSBSWagerAndWinningLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
					</div>
				</s:if>
				<s:if test='%{graphList.contains("getSLEWagerAndWinning")}'>
				<div class="col-3-div">
					<div id="getSLEWagerAndWinning" ></div>
						<div id="getSLEWagerAndWinningLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
					</div>
				</s:if>
							
			<s:if test='%{graphList.contains("getTotalNgrIgeDayWise")  && actionPrivFunctionMap.containsKey("getTotalNgrIgeDayWise")}'>
				<div class="col-3-div" >
				<div id="getTotalNgrIgeDayWise" ></div>
					<div id="getTotalNgrIgeDayWiseLoad" class="dashBoardLoading" style=" display:none"> 
						<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
					</div>
				</div>
				</s:if>

			<s:if test='%{graphList.contains("getTotalNgrSlotDayWise") && actionPrivFunctionMap.containsKey("getTotalNgrSlotDayWise")}'>
				<div class="col-3-div margin0">
				<div id="getTotalNgrSlotDayWise" ></div>
					<div id="getTotalNgrSlotDayWiseLoad" class="dashBoardLoading" style=" display:none"> 
						<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
					</div>
				</div>
				</s:if>
				
		
				<div class="clearboth"></div>
			</div>
			
			<div class="new-chart-div">
			<s:if test='%{graphList.contains("getTotalPokerWagerDayWise") && actionPrivFunctionMap.containsKey("getTotalPokerWagerDayWise")}'>
				<div class="col-3-div">
					<div id="getTotalPokerWagerDayWise"></div>
						<div id="getTotalPokerWagerDayWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" /> 
						</div>
					</div> 
				</s:if>
				<s:if test='%{graphList.contains("getRummyWagerDayWise") && actionPrivFunctionMap.containsKey("getRummyWagerDayWise")}'>
				<div class="col-2-div margin0">
					<div id="getRummyWagerDayWise"></div>
						<div id="getRummyWagerDayWiseLoad" class="dashBoardLoading" style=" display:none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
				</div>
				</s:if>
				<div class="clearboth"></div>
			</div>
			<div class="new-chart-div">
			<s:if test='%{graphList.contains("getRummyWagerHourWise") && actionPrivFunctionMap.containsKey("getRummyWagerHourWise")}'>
				<div class="col-1-div margin0">
				<div id="getRummyWagerHourWise" ></div>
					<div id="getRummyWagerHourWiseLoad" class="dashBoardLoading" style=" display:none"> 
						<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
					</div>
				</div>
				</s:if>
				<div class="clearboth"></div>
			</div>
			<div class="new-chart-div">
				<s:if test='%{graphList.contains("getTotalRummyRakeDayWise") && actionPrivFunctionMap.containsKey("getTotalRummyRakeDayWise")}'>
					<div class="col-3-div">
						<div id="getTotalRummyRakeDayWise"></div>
						<div id="getTotalRummyRakeDayWiseLoad" class="dashBoardLoading"
							style="display: none">
							<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
						</div>
					</div>
				</s:if>
				<div class="clearboth"></div>
			</div>

	<s:if test='%{graphList.contains("getTotalRegDayWise")}'>

</s:if>
</div>
