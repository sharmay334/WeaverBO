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
			<h4>
				<s:text name="global.searchuser.searchresult"></s:text>
			</h4>
		</div>
		<div class="innerBox">


			<%
				String jspName = getServletConfig().getServletContext().getRealPath(request.getServletPath());
				pageContext.setAttribute("jspName", jspName);
			%>
			<s:if test="%{(accountLedgerMaster.size()>0)}">
				<div class="FormMainBox1">
					<table width="100%" cellpadding="3" cellspacing="0" align="center"
						id="payTransaction" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Ledger Name</th>
								<th style="text-align: center;" nowrap="nowrap">Ledger
									Under</th>
								<th style="text-align: center;" nowrap="nowrap">Name</th>
								<th style="text-align: center;" nowrap="nowrap">Address</th>
								<th style="text-align: center;" nowrap="nowrap">country</th>
								<th style="text-align: center;" nowrap="nowrap">State</th>
								<th style="text-align: center;" nowrap="nowrap">pincode</th>
								<!--<th align="left">
					Report Mailing
				</th>
				-->

							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{accountLedgerMaster}">

								<tr>
									<td><s:a
											href="bo_um_searchLedger_Detail.action?ledger_id=%{LedgerId}"
											theme="simple">
											<s:property value="LedgerName" />

										</s:a></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="groupUnder" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="name" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="address" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="country" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="state" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="pincode" /></td>
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