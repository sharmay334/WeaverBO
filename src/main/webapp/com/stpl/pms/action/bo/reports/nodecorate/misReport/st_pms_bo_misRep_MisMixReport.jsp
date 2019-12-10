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
		<link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
			type="text/css" />
		<script src="js/facebox.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
	      fromAndToDate();
		});
	
	</script>
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						  Mixed Report For Domain : <s:property value="%{domainName}"/>
					</h4>
					 <h4 class="dateData" style="text-align: right;background: none">
					</h4>
				</div>
				<div class="dataTbl_top">
					<p>
				    Total Count:<s:property value="%{resultList.size}"/>
				     </p>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction">
						  <tr class="headerRow">
						        <th width="5%" valign="middle" align="left" class="allCheckBox">
								</th>
						        <th id="th_1"   style="text-align: center;">
											Player ID
								</th>
								 <th  valign="middle" style="text-align: center;" id="th_2" >
											Player Alias
								</th>
								<th  valign="middle" style="text-align: center;" id="th_3" >
											Email ID
								</th>
								<th " valign="middle" style="text-align: center;" id="th_4" >
											Mobile Number
								</th>
							 
								<th  valign="middle" width="10%" style="text-align: center;" id="th_5" >
											Registration Date
								</th>
								<th  valign="middle" style="text-align: center;" id="th_6" >
											Email Verified
								</th>
								<th  valign="middle" style="text-align: center;" id="th_7" >
											Mobile Verified
								</th>
								<th  valign="middle" style="text-align: center;" id="th_8" >
											Cash Game Count
								</th>
								<th  valign="middle" style="text-align: center;" id="th_9" >
											Free Game Count
								</th>
								<th  valign="middle" style="text-align: center;" id="th_10" >
											Total Deposit
								</th>
								
								
								
							 </tr>
						<s:iterator value="%{resultList}" status="resultList"
							var="resultListVar">
							<tr class="<s:property value="#resultListVar[#resultListVar.length-1] "/>">
							<td>
									<s:checkbox id="checkBoxId_%{#resultListVar[0]}" name="checkBoxId_"
										theme="simple" fieldValue="%{#resultListVar[0]}" cssClass="%{#resultListVar[1]}"></s:checkbox>
										<s:hidden id="playerDomainId_%{#resultListVar[0]}" value="%{domainId}"></s:hidden>
								</td>
								<s:iterator value="%{#resultListVar}" status="indexvalue" var="varValue">	
										<td width="5%" valign="middle" style="text-align: center;" class='tdclass td_<s:property value="%{#indexvalue.index}"/>' >
											<s:property />
										</td>
								</s:iterator>
							</tr>
						</s:iterator>
						
					</table>
				</div>
				<div class="box_footer">
					<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
				</div>
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 		<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  		<div id="nextPageStart" style="display:none"></div> 
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
   <div id="expandIt">
   </div>
	</body>
</html>

