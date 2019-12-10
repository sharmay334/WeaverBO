<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Search Data</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<s:hidden name="reportData" id="reportData" value="%{reportData}"></s:hidden>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Daily Play Report : <s:property value="%{domainName}" />
					</h4>

				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction" id="misReports">
						<thead>
							<tr class="headerRow">
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Player Id
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									User Name
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Email Id
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Mobile No.
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									State
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Registration Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Registration Source
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Last Login Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									First Deposit Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Last Deposit Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Last Cash Game Play Date
								</th>
								<th valign="middle" style="text-align: center;" id="th_11"
									nowrap="nowrap">
									Last Free Game Play Date
								</th>
								<th valign="middle" style="text-align: center;" id="th_16"
									nowrap="nowrap">
									Total Deposit
								</th>
								<th valign="middle" style="text-align: center;" id="th_14"
									nowrap="nowrap">
									Total Withdrawal
								</th>
								<th valign="middle" style="text-align: center;" id="th_16"
									nowrap="nowrap">
									Total Bonus to Cash
								</th>
								<th valign="middle" style="text-align: center;" id="th_12"
									nowrap="nowrap">
									Total Cash Wager
								</th>
								<th valign="middle" style="text-align: center;" id="th_13"
									nowrap="nowrap">
									Total Cash Winning
								</th>
								<th valign="middle" style="text-align: center;" id="th_15"
									nowrap="nowrap">
									Total Free Wager
								</th>
								<th valign="middle" style="text-align: center;" id="th_16"
									nowrap="nowrap">
									Total Free Winning
								</th>
								<th valign="middle" style="text-align: center;" id="th_16"
									nowrap="nowrap">
									Subscribed Promo Mail
								</th>

							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div class="box_footer">
					<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
					<a rel="facebox" id="freeBonus" class="button">Free Bonus</a>
				</div>
			</s:if>
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 		<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  		<div id="nextPageStart" style="display:none"></div> 
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
		<div id="expandIt">
		</div>
	</body>
</html>

