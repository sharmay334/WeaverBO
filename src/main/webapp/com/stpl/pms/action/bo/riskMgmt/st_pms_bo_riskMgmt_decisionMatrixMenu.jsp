<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Decision Matrix</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/riskMgmt/js/decisionMatrixMenu.js" ></SCRIPT>
	</head>

	<body>
		<h2>
			Decision Matrix
		</h2>
		<div id="resultDiv">
		<s:form theme="simple" id="submitFrm" action="st_pms_bo_riskMgmt_decisionMatrixSave">
			<div id="accordion" class="UIaccordian">
				<s:iterator value="%{decisionMap}" status="activity">
					<div class="accordianHeader">
						<h3 class="headerBlock">
							<s:property value="%{key}" />
						</h3>
					</div>
					<div class="accordian_content">
						<s:iterator value="%{value}" status="valueOn">
							<table
								id="tlb_<s:property value="%{#activity.index+1}"/>_<s:property value="%{#valueOn.index+1}"/>"
								width="830" cellspacing="0" cellpadding="4" border="0"
								align="center" class="payTransaction">
								<tr class="nodrop nodrag">
									<th>

									</th>
									<th>
										Doer Name
									</th>
									<th>
										Value On
									</th>
									<th>
										Priority Order
									</th>
									<th>
										Status
									</th>
								</tr>
								<s:iterator value="%{value}" status="bean">
									<tr
										id="tr_<s:property value="%{#activity.index+1}"/>_<s:property value="%{#valueOn.index+1}"/>_<s:property value="%{#bean.index+1}"/>">
										<td class="dragHandle">
											<s:hidden
												id="mappingId_%{#activity.index+1}_%{#valueOn.index+1}_%{#bean.index+1}"
												value="%{mappingId}"></s:hidden>
										</td>
										<td>
											<s:property value="%{doerName}" />
										</td>
										<td>
											<s:property value="%{valueOn}" />
										</td>
										<td>
											<s:property value="%{priorityOrder}" />
										</td>
										<td>
											<s:select
												id="status_%{#activity.index+1}_%{#valueOn.index+1}_%{#bean.index+1}"
												list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
												theme="simple" value="%{status}"></s:select>
										</td>
									</tr>
								</s:iterator>
							</table>
						</s:iterator>

					</div>
				</s:iterator>
				
				<div class="box_footer">
			<s:submit value="Submit" />
			</div>
			
				</div>
			</s:form>
			</div>
	</body>
</html>
