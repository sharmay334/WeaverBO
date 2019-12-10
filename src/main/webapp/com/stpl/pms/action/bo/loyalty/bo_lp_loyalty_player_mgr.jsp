<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Search loyal player</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script type="text/javascript">
	$(function() {
		/*save original width*/
		var searchDivWidth = $('#searchDiv').width(); 
		$("#minBtn").click(function() {
			$('#minBtn').hide();
			$('#maxBtn').show();
			$('#searchForm').hide();
			$('#searchDiv').width(113);
		});
		$("#maxBtn").click(function() {
			$('#maxBtn').hide();
			$('#minBtn').show();
			$('#searchForm').show();
			$('#searchDiv').width(searchDivWidth);
		});
		
		var playerId =$('#default_player_id');
		var val = playerId.val();
		console.log(playerId.val());
		
	});
</script>
<style type="text/css">
.btn-group img {
	width: 16px;
	float: right;
	position: relative;
	top: 10px;
	right: 3px;
}

.header2{
	color: #333333;
	font-size: 13px;
	font-family: Arial, Helvetica, sans-serif;
}
</style>

</head>

<body>

	<!-- <div class="clear2"></div> -->
	<!-- <h2 class="header2" style="color: #333333;font-size: 20px;font-family: Arial, Helvetica, sans-serif;">Player dashboard</h2> -->
<s:hidden id="default_player_id" value='<s:property	value="%{playerId}" />'/>
	<div class="FormSection" id="searchDiv" style="float: right">
		<div class="greyStrip" id="searchHeader">
			<div class="greyStrip">
					<h4>
						Search
					</h4>
				</div>
			<!-- <div style="float: right;margin: 8px 20px 0 0;"><b>_</b></div> -->
			<%-- <div class="btn-group pull-right">
				<a id="minBtn" title="minimize"><img
					src="<%=request.getContextPath()%>/images/min.png" alt="minimize">
				</a><a id="maxBtn" style="display:none" title="maximize"><img
					src="<%=request.getContextPath()%>/images/max.png" alt="maximize">
				</a>
				src="<%=request.getContextPath()%>/images/logout.png" alt="logout" />
			</div> --%>
		</div>
		<div id="searchForm">
			<s:form action="bo_lp_loyalty_player_mgr_search" theme="simple"
				target="resultDiv" id="FormSearch">
				<div class="innerBox">
					
					<div class="FormMainBox height60">
						<div class="labelDiv">
							<label> Player Id </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div class="small-text-box-div">
								<s:textfield name="playerSearchForm.playerId" theme="myTheme" requiredLabel="true"
									id="playerId" pattern="^[0-9,]*$"
									errorMassage="Enter numeric character and comma only"
									cssClass="text-field-small" value="" maxlength="10"></s:textfield>
							</div>
						</div>
						<%-- <s:textfield name="playerSearchForm.masterId" theme="myTheme"
									id="masterId" pattern="^[0-9,]*$"
									errorMassage="Enter numeric character and comma only"
									cssClass="text-field-small" style="display:none" value="1"></s:textfield> --%>
					</div>
				</div>
				<%-- <input type="hidden" value="${sessionScope.token}" name="token"/> --%>
				<div class="box_footer" align="right" style="height: 40px">
					<s:submit value="Search"></s:submit>
				</div>
			</s:form>
		</div>
	</div>


	<div class="clear2"></div>
	<div id="resultDiv"></div>
</body>
</html>


