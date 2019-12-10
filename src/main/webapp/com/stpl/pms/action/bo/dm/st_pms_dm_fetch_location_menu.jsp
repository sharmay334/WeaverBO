<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Edit Menu</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js"></script>
<script type="text/javascript">
	
		$(document).on("click", "[id*='edit_']", function(){
					if($(this).val()=="edit") {
						$("#display").attr('style','display: block');
						$("#locId").val($(this).attr("id").split("_")[1]);
						$(this).parent().parent().find("td").each(function(){
							var className = $(this).attr("class");
							if(className=="text"){
								$("#"+$(this).attr('id').split('_')[0]).val($(this).text());
							} else if(className=="select"){
								$("#status").val($("#status_"+$("#locId").val()).val());
							}						
						});
					}
 		});
		
		$(document).on("click", "[id='addMore']", function(){
			$("#display").attr('style','display: block');
		});
		$(document).on("click","[id='reset']", function(){
			$("#locId").val("");
		});
		
		/* $(document).on("click", "[id='inactive']", function(){
			var locId = [] ;
			$("[id*='chkBox_']:checked").each(function() {
				locId.push($(this).attr('id').split("_")[1]);
 			});	  
 			var actionName = "com/stpl/pms/action/bo/dm/st_dm_update_location_status.action";
 			var param = "locId="+locId+"&status=INACTIVE";
 			var resp =  _ajaxCallText(actionName, param);
 			location.href = "com/stpl/pms/action/bo/dm/st_dm_fetch_location_menu.action";
		});
		
		$(document).on("click", "[id='active']", function(){
			var locId = new Array();
			$("[id*='chkBox_']:checked").each(function() {
				locId.push($(this).attr('id').split("_")[1]);
 			});	  
 			var actionName = "com/stpl/pms/action/bo/dm/st_dm_update_location_status.action";
 			var param = "locId="+locId+"&status=ACTIVE";
 			var resp =  _ajaxCallText(actionName, param);
 			location.href = "com/stpl/pms/action/bo/dm/st_dm_fetch_location_menu.action";
		});
 */
		$(document).on("change","[id*='status_']", function(){
		 			var id = $(this).attr('id');
		 			var divId = id+"_errorDiv";
		 			var actionName = "com/stpl/pms/action/bo/dm/st_dm_update_location_status.action?locId="+id.split("_")[1]+"&status="+$(this).val();
		 			var resp =  _ajaxCallText(actionName, "");
		 			$('#' + divId).html(resp);
		 			if (resp.toLowerCase().indexOf('no') == -1) {
									$('#' + divId).find('p').removeClass().addClass(
											"bubble_msg");
								} else {
									$('#' + divId).find('p').removeClass().addClass(
											"fieldError");
								}
								_Show($('#' + divId), $('#' + id));
		 		});
	</script>
</head>
<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>Device Locations</h4>
			</div>
	
			<s:if test="%{locMaster!=null && locMaster.size()>0}">
			<s:form id="editForm" action="com/stpl/pms/action/bo/dm/st_dm_update_location_status.action" theme="simple" >
				<div class="clear2"></div>
				<div class="innerBox" style="margin: 29px auto 0;">
					<table width="830" cellspacing="0" cellpadding="4" border="1"
						align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="6%" valign="middle" align="left" class="name">
									</th>
								<th width="11%" valign="middle" align="left" class="name">
									Full Name</th>
								<th width="11%" valign="middle" align="left" class="status">
									Location Name</th>
								<th width="11%" valign="middle" align="left" class="status">
									Address</th>
								<th width="11%" valign="middle" align="left" class="status">
									Email</th>
								<th width="11%" valign="middle" align="left" class="status">
									Mobile No</th>
								<th width="11%" valign="middle" align="left" class="status">
									Landline No</th>
								<th width="11%" valign="middle" align="left" class="status">
									Status</th>
								<th width="11%" valign="middle" align="left" class="status">
									Edit</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{locMaster}">
								<tr id=locMaster_<s:property value="%{locationId}" />>
									<td >
										 <input type="checkbox" name="locId" value="<s:property value='%{locationId}' />">
									</td>
								
									<td class="text"
										id="fullName_<s:property value='%{locationId}'/>"><s:property
											value="%{fullName}" />
									</td>
									<td class="text"
										id="locationName_<s:property value='%{locationId}'/>"><s:property
											value="%{locationName}" />
									</td>
									<td class="text"
										id="address_<s:property value='%{locationId}'/>"><s:property
											value="%{address}" />
									</td>
									<td class="text" id="email_<s:property value='%{locationId}'/>"><s:property
											value="%{email}" />
									</td>
									<td class="text"
										id="mobileNo_<s:property value='%{locationId}'/>}"><s:property
											value="%{mobileNo}" />
									</td>
									<td class="text"
										id="landlineNo_<s:property value='%{locationId}'/>"><s:property
											value="%{landlineNo}" />
									</td>
									<td class="select"><s:select id="status_%{locationId}"
											list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
											value="%{status}" cssClass="select1" theme="simple"
											style="width:100px;" applyScript="true"></s:select></td>
									<td><input id="edit_<s:property value='%{locationId}'/>"
										type="button" value="edit">
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
					<div class="box_footer" align="right">
						<input type="button" id="addMore" value="ADD MORE"> 
						<s:submit id="inactive" value="INACTIVE" theme="myTheme" name="status" label="INACTIVE ALL" />
						<s:submit id="active" value="ACTIVE" theme="myTheme" name="status" label="ACTIVE ALL" />
					</div>
				</div> 
				</s:form>
			</s:if>
		</div>
		<div id="display" style="display: none">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>ADD / Edit Location</h4>
				</div>
				<s:form
					action="com/stpl/pms/action/bo/dm/st_dm_update_location.action"
					theme="simple">
					<s:hidden id="locId" name="locMas.locationId" />
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Full Name: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="fullName" name="locMas.fullName"
									applyscript="true"></s:textfield>
							</div>
						</div>

						<div class="clearFRM"></div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Location Name: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="locationName" name="locMas.locationName"
									applyscript="true"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Address: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="address" name="locMas.address" applyscript="true"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Email: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="email" name="locMas.email" applyscript="true"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Mobile No: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="mobileNo" name="locMas.mobileNo"
									applyscript="true"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> LandLine No: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield id="landlineNo" name="locMas.landlineNo"
									applyscript="true"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> status: </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select id="status" name="locMas.status"
									list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
									value="%{status}" theme="myTheme" cssClass="select1"
									applyScript="true"></s:select>
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
						<ss:submit theme="myTheme" id="submitBtn" value="Submit"></ss:submit>
						<s:reset value="reset" id="reset"></s:reset>
					</div>
				</s:form>

			</div>
		</div>
		<br> <br>

</body>
</html>
