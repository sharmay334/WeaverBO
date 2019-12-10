<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Loyalty Program Dashboard</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/grid_assets/css/gridstack.css" />
<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/grid_assets/css/gridstack-extra.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" />
<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/grid_assets/css/custom.css" />
<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/css/overview.css" />	



<script src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/jquery.min.js"></script>
<script src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/jquery-ui.js"></script>
<script
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/bootstrap.min.js"></script>
<script src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/lodash.min.js"></script>
<script
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/grid_assets/js/gridstack.js"></script>

<script type="text/javascript">
	$(function() {
		$('#active_special').hide();
	});
</script>


</head>

<body>
	<header></header>

	<div class="container-fluid" style="margin-bottom:20px">
		<div class="grid-stack">
			<div id="exposure_expiry" class="grid-stack-item hi" data-gs-x="0"
				data-gs-y="3" data-gs-width="12" data-gs-height="8">
				<div class="grid-stack-item-content">
					<div class="header">
						<div class="dragPoint iconMenu hide">Drag Cursor</div>
						<div class="title">Exposure <!-- and Expiry --></div>
						<div class="refreshBTN iconMenu">Refresh</div>
						<div class="closeBTN iconMenu hide">Close</div>
					</div>
					<div class="content">
						<div class="dataValuelistWrap">
							<div class="custem-table-data">
								<table cellpadding="0" cellspacing="0" width="100%">
									<tbody>
										<tr id="current_redemption_liberties">
											<td class="key">current redemption liberties</td>
											<td class="value"></td>
										</tr>
										
										<tr>
											<td>Point exposure</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td colspan="2">
												<table cellpadding="0" cellspacing="0" width="100%" id="table_point">
												</table>
											</td>
										</tr>
										
										<tr>
											<td>Credit Value</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td colspan="2">
												<table cellpadding="0" cellspacing="0" width="100%" id="table_credit">
												</table>
											</td>
										</tr>

									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="footer"></div>
				</div>
			</div>
			<!-- <div id="active_special" class="grid-stack-item hide" data-gs-x="4"
				data-gs-y="3" data-gs-width="8" data-gs-height="3">
				<div class="grid-stack-item-content">
					<div class="header">
						<div class="dragPoint iconMenu">Drag Cursor</div>
						<div class="title">Active Special</div>
						<div class="refreshBTN iconMenu">Refresh</div>
						<div class="closeBTN iconMenu">Close</div>
					</div>
					<div class="content">
						<div class="active-special-table">
							<table class="table">
								<thead>
									<tr>
										<th>Special Name</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th>Additional</th>
										<th>Current Point Earned</th>
										<th>Update</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>Velonic Admin v1</td>
										<td>01/01/2015</td>
										<td>26/04/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Velonic Frontend v1</td>
										<td>01/01/2015</td>
										<td>26/04/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>
									<tr>
										<td>3</td>
										<td>Velonic Admin v1.1</td>
										<td>01/05/2015</td>
										<td>10/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>
									<tr>
										<td>4</td>
										<td>Velonic Frontend v1.1</td>
										<td>01/01/2015</td>
										<td>31/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>
									<tr>
										<td>5</td>
										<td>Velonic Admin v1.3</td>
										<td>01/01/2015</td>
										<td>31/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>

									<tr>
										<td>6</td>
										<td>Velonic Admin v1.3</td>
										<td>01/01/2015</td>
										<td>31/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>

									<tr>
										<td>7</td>
										<td>Velonic Admin v1.3</td>
										<td>01/01/2015</td>
										<td>31/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>

									<tr>
										<td>8</td>
										<td>Velonic Admin v1.3</td>
										<td>01/01/2015</td>
										<td>31/05/2015</td>
										<td>Released</td>
										<td>Coderthemes</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
					<div class="footer"></div>
				</div>
			</div> -->
			<div id="tier_stats" class="grid-stack-item" data-gs-x="0"
				data-gs-y="0" data-gs-width="12" data-gs-height="2">
				<div class="grid-stack-item-content">
					<div class="header">
						<div class="dragPoint iconMenu hide">Drag Cursor</div>
						<div class="title">Tiers</div>
						<div class="refreshBTN iconMenu">Refresh</div>
						<div class="closeBTN iconMenu hide">Close</div>
					</div>
					<div class="content">
						<div class="custom-tiers">
							<!--row-->
							<div class="tier-row">
								<h5>Players in tiers</h5>
								<div class="tier-step" id="tier_stats_step_container"></div>
							</div>
						</div>
					</div>
					<div class="footer"></div>
				</div>
			</div>
			<!-- <div id="tier_graph" class="grid-stack-item hide" data-gs-x="0"
				data-gs-y="4" data-gs-width="4" data-gs-height="4">
				<div class="grid-stack-item-content">
					<div class="header">
						<div class="dragPoint iconMenu">Drag Cursor</div>
						<div class="title">Tiers</div>
						<div class="refreshBTN iconMenu">Refresh</div>
						<div class="closeBTN iconMenu hide">Close</div>
					</div>
					<div class="content">Graph and other items</div>
					<div class="footer"></div>
				</div>
			</div> -->
			<!-- <div id="redemption_stats" class="grid-stack-item hide" data-gs-x="4"
				data-gs-y="7" data-gs-width="8" data-gs-height="4">
				<div class="grid-stack-item-content">
					<div class="header">
						<div class="dragPoint iconMenu">Drag Cursor</div>
						<div class="title">Redemption</div>
						<div class="refreshBTN iconMenu">Refresh</div>
						<div class="closeBTN iconMenu hide">Close</div>
					</div>
					<div class="content">Graph and other items</div>
					<div class="footer"></div>
				</div>
			</div> -->
		</div>
	</div>
	<div class="clearFRM"></div>
	<div class="clearFRM"></div>
	<script type="text/javascript">
		var grid;
		$(function() {
			var options = {
				animate : true,
				handle : '.dragPoint'
			};
			$('.grid-stack').gridstack(options);
			grid = $('.grid-stack').data("gridstack");
			//grid.removeWidget('.hi');

		});
	</script>
	<script src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/overview.js"></script>
</body>

</html>
