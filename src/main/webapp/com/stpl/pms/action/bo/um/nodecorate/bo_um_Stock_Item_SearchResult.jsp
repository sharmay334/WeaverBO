<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		$('#payTransaction').dataTable();
	});
</script>
</head>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Stock Item Result</h4>
		</div>
		<div class="innerBox">


			<%
				String jspName = getServletConfig().getServletContext().getRealPath(request.getServletPath());
				pageContext.setAttribute("jspName", jspName);
			%>
			<s:if test="%{(itemBean.size()>0)}">
				<div class="FormMainBox1">
					<table width="100%" cellspacing="0" align="center"
						id="payTransaction" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Name</th>
								<th style="text-align: center;" nowrap="nowrap">Under Group</th>
								<th style="text-align: center;" nowrap="nowrap">Category</th>
								<th style="text-align: center;" nowrap="nowrap">Units</th>
								<th style="text-align: center;" nowrap="nowrap">Alter Unit</th>
								<th style="text-align: center;" nowrap="nowrap">Maintain
									batches</th>
								<th style="text-align: center;" nowrap="nowrap">Manufacturing</th>
								<th style="text-align: center;" nowrap="nowrap">Expiry</th>
								<th style="text-align: center;" nowrap="nowrap">Standard
									Rates</th>
								<th style="text-align: center;" nowrap="nowrap">Cost Track</th>
								<th style="text-align: center;" nowrap="nowrap">GST
									Applicable</th>
								<th style="text-align: center;" nowrap="nowrap">Supply Type</th>
								<th style="text-align: center;" nowrap="nowrap">Duty Rate</th>
							
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{itemBean}">

								<tr>
									<td><s:a
											href="bo_um_searchStockCatagory_Detail.action?unit_id=%{itemId}"
											theme="simple">
											<s:property value="itemName" />
										</s:a></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="underGroup" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="underCatagory" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="isUnit" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="isAlternate" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="isBatches" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="dom" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="expiry" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="isStandard" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="costTrack" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="gstApplicable" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="supplyType" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="rateDuty" /></td>


								</tr>


							</s:iterator>
						</tbody>
					</table>

				</div>
			</s:if>
			<s:else>
				<s:div id="naviga">
					<div align="center">
						<h3>
							<s:text name="global.searchuser.NoRecordsFound"></s:text>
							<%-- <s:text name="noRecords">No Records Found!</s:text> --%>
						</h3>
					</div>
					<br />

				</s:div>
			</s:else>
		</div>
	</div>
</body>
</html>