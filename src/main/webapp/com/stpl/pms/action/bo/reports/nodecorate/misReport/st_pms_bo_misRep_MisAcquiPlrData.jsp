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
	<script>
		$(document).ready(function (){
			$("#misReportsAcqui").DataTable({
		      "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
		      "sAjaxDataProp":"resultList",
			  "sServerMethod": "POST",
		      "scrollX": true,
		      "aaSorting" : [],
								"pageLength" : 20,
								"bLengthChange" : false,
								
								"oLanguage" : {
									"sInfo" : '',
								},
								"columnDefs" : [ {
									"targets" : 'no-sort',
									"orderable" : false,
								} ],
								//"searching" : false,
								"bSort" : false,
								"aoColumnDefs": [{
							    	  'bSortable': false,
								       "aTargets": [0],
								       "mRender": function (data, type, full) {
											return '<input type="checkbox" id="checkBoxId_'+data+'" value ="'+data+'" class ="'+full[1]+'">&nbsp;'+data+'</input>';
							       		}
							      }],
			});
			sendMail();
			distributeBonus();
			$('a[rel*="facebox"]').facebox({
				closeImage : 'images/closelabel.png',
			}); 
		});
	</script>
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
			<s:hidden id="procedure" value="%{procName}" />
			<s:hidden id="repData" value="%{reportData}"/>
				<div class="greyStrip">
					<h4 style="float: left">
						New Depositors Player Data : <s:property value="%{domainName}" />
					</h4>

				</div>

				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0" align="center"
						class="payTransaction" id="misReportsAcqui">
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
									Date Of Registration
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									First Deposit Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									First Deposit Amount
								</th>

							</tr>
					</table>
				</div>
				<div class="box_footer">
					<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
					<a rel="facebox" id="freeBonus" class="button">Free Bonus</a>
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

