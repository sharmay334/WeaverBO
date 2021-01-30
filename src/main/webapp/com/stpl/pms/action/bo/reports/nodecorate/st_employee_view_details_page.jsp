<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		bonusTable = $('#payTransactionStockItem').dataTable({
			"scrollX" : true,
			"sPaginationType" : "full_numbers"
			
		});
		
	});
</script>
</head>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Employee  Result</h4>
		</div>
		<div class="innerBox">


			<%
				String jspName = getServletConfig().getServletContext().getRealPath(request.getServletPath());
				pageContext.setAttribute("jspName", jspName);
			%>
			<s:if test="%{(userList.size()>0)}">
				<div class="FormMainBox1">
					<table width="100%" cellspacing="0" align="center"
						id="payTransactionStockItem" class="transactionTable">
						<thead>
								<tr>
									<th style="text-align: center;" nowrap="nowrap">
										Name
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Gender	
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Email
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Phone Number
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Branch
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Role
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Department
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Manager Name
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Joining Date
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										Salary
									</th>
								</tr>
							</thead>
						<tbody>
							<s:iterator value="%{userList}">
									<tr>
										<td style="text-align: center;" nowrap="nowrap">
											<s:a
												href="/WeaverBO/com/stpl/pms/action/bo/um/bo_um_edit_employee_page.action?user_id=%{userId}"
												theme="simple">
												<s:property value="firstName" />

											</s:a>
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="gender" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="emailId" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="phoneNum" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="branch" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="role" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="department" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="approver" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="doj" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="salary" />
										</td>

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