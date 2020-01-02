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
			<s:if test="%{(companies.size()>0)}">
				<div class="FormMainBox1">
					<table width="100%" cellpadding="3" cellspacing="0" align="center"
						id="payTransaction" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Company
									Name</th>
								<th style="text-align: center;" nowrap="nowrap">Company
									Email</th>
								<th style="text-align: center;" nowrap="nowrap">Address</th>
								<th style="text-align: center;" nowrap="nowrap">Country</th>
								<th style="text-align: center;" nowrap="nowrap">State</th>
								<th style="text-align: center;" nowrap="nowrap">pincode</th>
								<th style="text-align: center;" nowrap="nowrap">Contact</th>
								<th style="text-align: center;" nowrap="nowrap">GST No</th>
								<th style="text-align: center;" nowrap="nowrap">PAN No</th>
								<th style="text-align: center;" nowrap="nowrap">License</th>
								<th style="text-align: center;" nowrap="nowrap">Seeds
									License No</th>
								<th style="text-align: center;" nowrap="nowrap">Pesticide
									License No</th>
								<th style="text-align: center;" nowrap="nowrap">Fertilizer
									License No</th>
								<th style="text-align: center;" nowrap="nowrap">CIN REG No</th>
								<th style="text-align: center;" nowrap="nowrap">Bank Name</th>
								<th style="text-align: center;" nowrap="nowrap">Acc No</th>
								<th style="text-align: center;" nowrap="nowrap">Acc Holder
								</th>
								<th style="text-align: center;" nowrap="nowrap">Bank IFSC</th>

								<!--<th align="left">
					Report Mailing
				</th>
				-->

							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{companies}">

								<tr>
									<td><s:a
											href="bo_um_searchCompany_Detail.action?company_id=%{companyId}"
											theme="simple">
											<s:property value="name" />

										</s:a></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="email" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="currentAddress" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="country" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="state" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="pincode" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="contactNo" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="gstNo" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="panNo" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="license" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="csln" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="cpln" /></td>

									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="cfln" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="cinRegNo" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="bankName" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="accountNo" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="accHolderName" /></td>
									<td style="text-align: center;" nowrap="nowrap"><s:property
											value="ifsc" /></td>
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