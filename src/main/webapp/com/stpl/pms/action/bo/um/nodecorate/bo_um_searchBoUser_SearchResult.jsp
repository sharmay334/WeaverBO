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


				<% String jspName =  getServletConfig().getServletContext().getRealPath(request.getServletPath());
	pageContext.setAttribute("jspName",jspName);
	%>
				<s:if test="%{(userList.size()>0)}">
					<div class="FormMainBox1">
						<table width="100%" cellpadding="3" cellspacing="0" align="center"
							id="payTransaction" class="transactionTable">
							<thead>
								<tr>
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.searchuser.firstname"></s:text>
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.subuserregistration.LastName"></s:text>
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.subuserregistration.UserName"></s:text>
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.scratchWeaver.info"></s:text>
									</th>
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.searchuser.department"></s:text>
									</th>
									<!--<th align="left">
					Report Mailing
				</th>
				-->
									<th style="text-align: center;" nowrap="nowrap">
										<s:text name="global.searchuser.Status"></s:text>
									</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{userList}">

									<tr>
										<td style="text-align: center;" nowrap="nowrap">
											<s:a
												href="bo_um_searchBoUser_Detail.action?domain_id=%{domainId}&user_id=%{userId}&type=%{boUserType}&userName={userName}"
												theme="simple">
												<s:property value="firstName" />

											</s:a>
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="lastName" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="userName" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="boUserType" />
										</td>
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="department" />
										</td>
										<!--<td align="left">
							<s:property value="mailingStatus" />
						</td>
						-->
										<td style="text-align: center;" nowrap="nowrap">
											<s:property value="status" />
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