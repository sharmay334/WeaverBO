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
	<title>Active Reports List</title>
	<head>
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{activeReportsList!=null && activeReportsList.size()>0}">
				<s:hidden name="newActiveReportList" id="newActiveReportList"
					value=""></s:hidden>
				<div class="innerBox" style="margin: 29px auto 0;">

					<table width="830" cellspacing="0" cellpadding="4" border="1"
						align="center" class="payTransaction" id="activeMisReport">
						<thead>
							<tr>
								<th width="25%" valign="middle" align="left" class="name">
									Name
								</th>
								<th width="25%" valign="middle" align="left" class="status">
									Status
								</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{activeReportsList}">
								<tr>
									<td id="misName">
										<s:property value="%{key}" />
									</td>
									<td id="misStatus">
										<ss:select id="status" value="%{value}"
											list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
											theme="myTheme" cssClass="select1" />
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
					<br />
				</div>
				<div class="box_footer" align="right">
					<s:submit id="submit" value="submit" cssClass="button"
						theme="simple"></s:submit>
				</div>
			</s:if>
			<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
		</div>
	</body>
</html>