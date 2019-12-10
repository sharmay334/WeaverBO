<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
	
%>


<script type="text/javascript">
	
	$(function() {		
		var authGraphs=$("#gameList").val().replace("[","").replace("]","").replace(" ","").split(/\s*,\s*/);
		if(authGraphs)
			for(var i=0;i<authGraphs.length;i++){
				if($("#actionPrivFunctionMap").val().indexOf(authGraphs[i])!=-1) 
				 	dashBoardAjaxCall(authGraphs[i]);
				}
	});

</script>
<s:hidden id="domainId" name="domainId"></s:hidden>
<s:hidden id="gameList" name="gameList"></s:hidden>
<s:hidden id="actionPrivFunctionMap" name="actionPrivFunctionMap"></s:hidden>
<style type="text/css">

#getSLEWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getSLEWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getSGEWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getSGEWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getDGEWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}

#getDGEWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getRUMMYWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getRUMMYWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getPOKERWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getPOKERWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getSBSWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getSBSWagerAndWinning {
	height: 400px;
	min-width: 50px;
	max-width: 800px;
}

#getIGEWagerDayWise {
	height: 400px;
	min-width: 310px;
	max-width: 900px;
}
#getIGEWagerAndWinning {
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

.new-chart-div .dashBoardLoading {
	float: none;
	position: absolute;
	width: 100%;
	margin-top: 30px;
	top: 0;
	left: 0;
	margin-left: 0;
	z-index: 1000;
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
		<s:if
			test='%{gameList.contains("getSLEWagerAndWinning") && actionPrivFunctionMap.containsKey("getSLEWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getSLEWagerAndWinning"></div>
				<div id="getSLEWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getSLEWagerDayWise") && actionPrivFunctionMap.containsKey("getSLEWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getSLEWagerDayWise"></div>
				<div id="getSLEWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getSGEWagerAndWinning") && actionPrivFunctionMap.containsKey("getSGEWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getSGEWagerAndWinning"></div>
				<div id="getSGEWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getSGEWagerDayWise") && actionPrivFunctionMap.containsKey("getSGEWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getSGEWagerDayWise"></div>
				<div id="getSGEWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getIGEWagerAndWinning") && actionPrivFunctionMap.containsKey("getIGEWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getIGEWagerAndWinning"></div>
				<div id="getIGEWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getIGEWagerDayWise") && actionPrivFunctionMap.containsKey("getIGEWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getIGEWagerDayWise"></div>
				<div id="getIGEWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getDGEWagerAndWinning") && actionPrivFunctionMap.containsKey("getDGEWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getDGEWagerAndWinning"></div>
				<div id="getDGEWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getDGEWagerDayWise") && actionPrivFunctionMap.containsKey("getDGEWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getDGEWagerDayWise"></div>
				<div id="getDGEWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		
		
		<s:if
			test='%{gameList.contains("getRUMMYWagerAndWinning") && actionPrivFunctionMap.containsKey("getRUMMYWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getRUMMYWagerAndWinning"></div>
				<div id="getRUMMYWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getRUMMYWagerDayWise") && actionPrivFunctionMap.containsKey("getRUMMYWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getRUMMYWagerDayWise"></div>
				<div id="getRUMMYWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		
		
		<s:if
			test='%{gameList.contains("getPOKERWagerAndWinning") && actionPrivFunctionMap.containsKey("getPOKERWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getPOKERWagerAndWinning"></div>
				<div id="getPOKERWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getPOKERWagerDayWise") && actionPrivFunctionMap.containsKey("getPOKERWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getPOKERWagerDayWise"></div>
				<div id="getPOKERWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		
		
		<s:if
			test='%{gameList.contains("getSBSWagerAndWinning") && actionPrivFunctionMap.containsKey("getSBSWagerAndWinning")}'>
			<div class="col-3-div">
				<div id="getSBSWagerAndWinning"></div>
				<div id="getSBSWagerAndWinningLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
		<s:if
			test='%{gameList.contains("getSBSWagerDayWise") && actionPrivFunctionMap.containsKey("getSBSWagerDayWise")}'>
			<div class="col-2-div">
				<div id="getSBSWagerDayWise"></div>
				<div id="getSBSWagerDayWiseLoad" class="dashBoardLoading"
					style="display: none">
					<img id="loadingImage" src="<%=path%>/images/loadingImage.gif" />
				</div>
			</div>
		</s:if>
				<div class="clearboth"></div>
	</div>
</div>
