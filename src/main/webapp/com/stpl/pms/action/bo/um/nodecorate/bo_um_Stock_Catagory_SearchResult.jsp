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
			<h4>Stock Category Result</h4>
		</div>
		<div class="innerBox">


			<%
				String jspName = getServletConfig().getServletContext().getRealPath(request.getServletPath());
				pageContext.setAttribute("jspName", jspName);
			%>
			<s:if test="%{(stockCatagoryBeanList.size()>0)}">
				<div class="FormMainBox1">
					<table width="100%" cellpadding="3" cellspacing="0" align="center"
						id="payTransaction" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Stock Catagory
									Name</th>
								<th style="text-align: center;" nowrap="nowrap">Under</th>
								

								<!--<th align="left">
					Report Mailing
				</th>
				-->

							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{stockCatagoryBeanList}">

								<tr>
									<td><s:a
											href="bo_um_searchStockCatagory_Detail.action?st_ct_id=%{stCtId}"
											theme="simple">
											<s:property value="stockName" />

										</s:a></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="stock_under" /></td>
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