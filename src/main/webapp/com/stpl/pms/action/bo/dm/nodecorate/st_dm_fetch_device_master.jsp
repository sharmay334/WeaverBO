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
				if($("#editForm").length<1){
					$("#display").attr('style','display: block');
				}
			});

			$(document).on("click", "[id*='edit_']", function(){
					if($(this).val()=="edit") {
						$("#display").attr('style','display: block');
						$("#devId").val($(this).attr("id").split("_")[1]);
						$(this).parent().parent().find("td").each(function(){
							var className = $(this).attr("class");
							if(className=="text"){
								$("#"+$(this).attr('id').split('_')[0]).val($(this).text().trim());
							} 					
						});
					}
 		});
 		
 		$(document).on("click", "[id='addMore']", function(){
			$("#display").attr('style','display: block');
			$("#devId").val(null);
			$("#reset").click();
		});
		$(document).on("click","[id='reset']", function(){
			$("#locId").val("");
		});
		
		$(document).on("click", "[id='active'],[id='inactive']", function(){
			var isChecked = false;
			$("[id*='chkBox_']:checked").each(function() {
				isChecked = true;
				console.log("abc");
				return false;
 			});	  
 			if(!isChecked)
 				alert ("Please select at least one Checkbox");
 			return isChecked;
		});
	</script>
</head>
<body>
	<s:if test="%{devMaster!=null && devMaster.size()>0}">
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Device List</h4>
		</div>
		<s:form id="editForm"
			action="st_dm_update_device_status.action"
			theme="simple">
			<s:hidden name="domainId"></s:hidden>
			<s:hidden name="aliasId"></s:hidden>
			<div class="clear2"></div>
			<div class="innerBox" style="margin: 29px auto 0;">
				<table width="830" cellspacing="0" cellpadding="4" border="1"
					align="center" class="payTransaction">
					<thead>
						<tr>
							<th width="5%" valign="middle" align="left" ></th>
							<th width="19%" valign="middle" align="left" >
								Device Name</th>
							<th width="19%" valign="middle" align="left" >
								MAC Address</th>	
							<th width="19%" valign="middle" align="left" >
								Device Type</th>
							<th width="19%" valign="middle" align="left" >
								Device OS</th>
							<th width="19%" valign="middle" align="left" >
								Status</th>
							<th width="19%" valign="middle" align="left" >
								Edit</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="%{devMaster}">
							<tr id=devMaster_ <s:property value="%{deviceId}" />>
								<td><input type="checkbox" name="devId" id="chkBox_<s:property value='%{deviceId}' />"
									value="<s:property value='%{deviceId}' />"></td>

								<td class="text"
									id="deviceName_<s:property value='%{deviceId}'/>"><s:property
										value="%{deviceName}" /></td>
								<td class="text"
									id="deviceMacAddress_<s:property value='%{deviceId}'/>"><s:property
										value="%{deviceMacAddress}" /></td>		
								<td class="text"
									id="deviceType_<s:property value='%{deviceId}'/>"><s:property
										value="%{deviceType}" /></td>
								<td class="text"
									id="deviceOs_<s:property value='%{deviceId}'/>"><s:property
										value="%{deviceOs}" /></td>
								<td class="text" id="status_<s:property value='%{deviceId}'/>"><s:property value="%{status}" /></td>
								<td><input id="edit_<s:property value='%{deviceId}'/>"
									style="margin:0 !important" type="button" value="edit"></td>
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
	<div id="display" style="display: none;" >
		<div class="FormSection">
			<div class="greyStrip">
				<h4>ADD / Edit Devices</h4>
			</div>
			<s:form
				action="st_dm_update_devices.action"
				theme="simple">
				<s:hidden id="devId" name="devMas.deviceId" />
				<s:hidden name="aliasId"></s:hidden>
				<s:token id="strutsToken" name="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Device Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="deviceName" name="devMas.deviceName" applyscript="true" maxlength="20" action="st_dm_checkUniqueDevName.action"
							 ajaxparam="deviceName,devId,aliasId" errormassage="Please Enter Valid Name"></s:textfield>
						</div>
					</div>

					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> MAC Address: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield id="deviceMacAddress" name="devMas.deviceMacAddress" applyscript="true" maxlength="200" patternon="both"
							ajaxparam="deviceMacAddress,devId" action="st_dm_checkUniqueMAC.action"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Device Type: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select id="deviceType" name="devMas.deviceType"
								list="#{'MOBILE':'MOBILE','TAB':'TABLET'}"
								theme="myTheme" cssClass="select1"
								applyScript="true"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Device OS: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select id="deviceOs" name="devMas.deviceOs"
								list="#{'ANDROID':'ANDROID','IOS':'IOS'}"
								theme="myTheme" cssClass="select1"
								applyScript="true"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> status: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select id="status" name="devMas.status"
								list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
								theme="myTheme" cssClass="select1"
								applyScript="true"></s:select>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<ss:submit theme="myTheme" id="submitBtn" value="Submit"></ss:submit>
					<input type="reset" value="reset" id="reset" >
				</div>
			</s:form>

		</div>
	</div>
	<br>
	<br>
</body>
</html>
