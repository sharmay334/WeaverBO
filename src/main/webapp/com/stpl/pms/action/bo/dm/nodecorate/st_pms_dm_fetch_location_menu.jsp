<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Edit Menu</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		createBubble();
		if($("#editForm").length<1){
			$("#display").attr('style','display: block');
			$("#display #cancel").attr('disabled',true);
		}
		else{
			$("#display #cancel").attr('disabled',false);
		}
		$("#lastDomain").val($("#domainId").val());
	});
</script>	
</head>
<body>
		<s:if test="%{locMaster!=null && locMaster.size()>0}">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Device Locations</h4>
			</div>
			<s:form id="editForm"
				action="st_dm_update_location_status.action"
				theme="simple">
			<s:hidden id="lastDomain" name="domainId"></s:hidden>
			<s:token id="editToken" name="editToken"></s:token>	
				<div class="clear2"></div>
				<div class="innerBox" style="margin: 29px auto 0;overflow-x: scroll;">
					<table width="830" cellspacing="0" cellpadding="4" border="1"
						align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="6%" valign="middle" align="left" class="name"></th>
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
								<tr id=locMaster_ <s:property value="%{locationId}" />>
									<td><input type="checkbox" name="locId" id="chkBox_<s:property value='%{locationId}' />"
										value="<s:property value='%{locationId}' />"></td>

									<td class="text"
										id="fullName_<s:property value='%{locationId}'/>"><s:property
											value="%{fullName}" /></td>
									<td class="text"
										id="locationName_<s:property value='%{locationId}'/>"><s:property
											value="%{locationName}" /></td>
									<td class="text"
										id="address_<s:property value='%{locationId}'/>"><s:property
											value="%{address}" /></td>
									<td class="text" id="email_<s:property value='%{locationId}'/>"><s:property
											value="%{email}" /></td>
									<td class="text"
										id="mobileNo_<s:property value='%{locationId}'/>}"><s:property
											value="%{mobileNo}" /></td>
									<td class="text"
										id="landlineNo_<s:property value='%{locationId}'/>"><s:property
											value="%{landlineNo}" /></td>
									<td class="text" id="status_<s:property value='%{locationId}'/>"><s:property value="%{status}" /></td>
									<td><input id="edit_<s:property value='%{locationId}'/>"
										style="margin:0 !important;" type="button" value="edit"></td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
					</div>
					<div class="box_footer" align="right">
						<input type="button" id="addMore" value="ADD MORE">
						<s:submit id="inactive" value="INACTIVE" theme="myTheme"
							name="status" label="INACTIVE ALL" />
						<s:submit id="active" value="ACTIVE" theme="myTheme" name="status"
							label="ACTIVE ALL" />
					</div>
			</s:form>
		</div>	
		</s:if>
	<div id="display" style="display: none">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>ADD / Edit Location</h4>
			</div>
			<s:form id="addLocation"
				action="st_dm_update_location.action"
				theme="simple">
				<s:token id="strutsToken" name="strutsToken"></s:token>
				<s:hidden id="locId" name="locMas.locationId" />
				<s:hidden name="locMas.domainId" value="%{domainId}" id="domainId" />
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Full Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="fullName" name="locMas.fullName" applyscript="true" maxlength="20" errormassage="Please Enter Valid Name"></s:textfield>
						</div>
					</div>

					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Location Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="locationName" name="locMas.locationName" action="st_dm_checkUniqueLocName.action"
								ajaxParam="locId,locationName" applyscript="true" maxlength="50" errormassage="Please Enter Valid Location" ></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Address: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="address" name="locMas.address" applyscript="true" maxlength="200" errormassage="Please Enter Valid Address"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Email: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield id="email" name="locMas.email" applyscript="true"
							pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							maxlength="50" errormassage="Please Enter Valid Email Id" patternOn="blur"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Mobile No: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="mobileNo" name="locMas.mobileNo" applyscript="true" maxlength="15" errormassage="Only Numeric character allowed" pattern="^[0-9]*$"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> LandLine No: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="landlineNo" name="locMas.landlineNo"
								applyscript="true" maxlength="15" errormassage="Only Numeric character allowed" pattern="^[0-9]*$"></s:textfield>
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
					<input type="button" value="cancel" id="cancel" >
				</div>
			</s:form>

		</div>
	</div>
	<br>
	<br>

</body>
</html>
