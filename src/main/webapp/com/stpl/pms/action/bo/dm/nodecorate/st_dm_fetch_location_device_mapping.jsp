<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =(String)request.getAttribute("basePathURL") ;
%>
<head>
<script type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js"></script>
<script type="text/javascript">

		var refreshOptns=function(){
			$(".tempOptn").remove();
					locDevMap=_ajaxCallJson("com/stpl/pms/action/bo/dm/st_dm_fetchActiveDeviceLocation.action","domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val());
					console.log(locDevMap);
					
					$("#deviceName").empty().append($("<option>").val(-1).html("--Please Select--"));
					$.each(locDevMap.devices,function(index,dev){
						$("#deviceName").append($('<option>').val(dev.deviceId).html(dev.deviceName));
					});
					
					$("#locationName").empty().append($("<option>").val(-1).html("--Please Select--"));
					$.each(locDevMap.locations,function(index,loc){
						$("#locationName").append($("<option>").val(loc.locationId).html(loc.locationName));
					});
			};
			
			$(document).ready(function(){
				refreshOptns();
				if($("#editForm").length<1){
					$("#display").attr('style','display: block');
				}
				$("#editForm input[type='checkbox']").click(function(event){
					 var cols= $(this).parent().parent().find("td");
					 cols.each(function(){
					 	var stat=$(this).attr("data-status");
					 	if(stat && stat=="INACTIVE"){
							event.stopPropagation();
							event.preventDefault();
							window.control.modal("This mapping cannot be ACTIVE because linked device or location is inactive!");
							return false;
						}
					 });
				 });
				 
				 $("#editForm input.deleteBtn").click(function(){
				 	var mappingId=$(this).attr("data-id");
				 	if("SUCCESS"==_ajaxCallText("com/stpl/pms/action/bo/dm/st_dm_deleteMapping.action", "devMapId="+mappingId)){
				 		$(this).parent().parent().remove();
				 		window.control.modal("Successfully deleted!");
				 	}else
						window.control.modal("Deletion failed!");
				 });
			});

		
			$(document).on("click", "[id*='edit_']", function(){
					if($(this).val()=="edit") {
						refreshOptns();
						$("#display").attr('style','display: block');
						$("#mapId").val($(this).attr("id").split("_")[1]);
						$(this).parent().parent().find("td").each(function(){
							var className = $(this).attr("class");
							if(className=="select"){
								var attr = $(this).attr('id').split('_');
								if(attr[0]!="locationName" && $(this).attr("data-status")=="ACTIVE" ){
									$("#"+attr[0]).append($('<option>', {
									    value: attr[1],
									    text: $(this).text(),
									    class:"tempOptn"
									}));
								}
								$("#"+attr[0]).val(attr[1].trim());
								
							} else if(className=="text"){
								$("#"+$(this).attr('id').split('_')[0]).val($(this).text().trim());
							}					
						});
					}
 		});
 		
 		$(document).on("click", "[id='addMore']", function(){
 			refreshOptns();
 			$("#display").attr('style','display: block');
			$("#mapId").val(null);
			$("#reset").click();
		});
		$(document).on("click","[id='reset']", function(){
			//console.log("RESET");
			$("#locId").val("");
		});
		
		$(document).on("click", "[id='active'],[id='inactive']", function(){
			var isChecked = false;
			$("[id*='chkBox_']:checked").each(function() {
				isChecked = true;
				//console.log("abc");
				return false;
 			});	  
 			if(!isChecked)
 				alert ("Please select at least one Checkbox");
 			return isChecked;
		});
	</script>
</head>
<body>
	<s:if test="%{devMapping!=null && devMapping.size()>0}">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Location Device Mapping</h4>
			</div>
			<s:form id="editForm"
				action="com/stpl/pms/action/bo/dm/st_dm_update_device_mapping_status.action"
				theme="simple">
				<s:token id="editToken" value="editToken"></s:token>
				<s:hidden id="lastAlias" name="aliasId"></s:hidden>
				<s:hidden id="lastDomain" name="domainId"></s:hidden>
				<div class="clear2"></div>
				<div class="innerBox" style="margin: 29px auto 0;">
					<table width="830" cellspacing="0" cellpadding="4" border="1"
						align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="6%" valign="middle" align="left"></th>
								<th width="24%" valign="middle" align="left">Location Name</th>
								<th width="23%" valign="middle" align="left">Device Name</th>
								<th width="24%" valign="middle" align="left">Status</th>
								<th width="7%" valign="middle" align="left">Edit</th>
								<th width="7%" valign="middle" align="left">Delete</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{devMapping}">
								<tr>
									<td><input type="checkbox" name="devMapId"
										id="chkBox_<s:property value='%{mappingId}' />"
										value="<s:property value='%{mappingId}' />">
									</td>
									<td class="select" data-status="<s:property value='%{locMaster.status}'/>"
										id="locationName_<s:property value='%{locMaster.locationId}'/>"><s:property
											value="%{locMaster.locationName}" />
									</td>
									<td class="select" data-status="<s:property value='%{locDevices.status}'/>"
										id="deviceName_<s:property value='%{locDevices.deviceId}'/>"><s:property
											value="%{locDevices.deviceName}" />
									</td>
									<td class="text" id="status_<s:property value='%{mappingId}'/>"><s:property
											value="%{status}" />
									</td>
									<td><input id="edit_<s:property value='%{mappingId}'/>"
										style="margin:0 !important;" type="button" value="edit">
									</td>
									<td><input class="deleteBtn" data-id="<s:property value='%{mappingId}'/>"  id="deleteBtn_<s:property value='%{mappingId}'/>"
										style="margin:0 !important;" type="button" value="delete">
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
				<div class="box_footer" align="right">
					<input type="button" id="addMore" value="ADD MORE" >
					<!-- <button id="delete" value="DELETED" name="status">DELETE </button> -->
					<s:submit id="inactive" value="INACTIVE" theme="myTheme" name="status"/>
					<s:submit id="active" value="ACTIVE" theme="myTheme" name="status"/>
				</div>
			</s:form>
		</div>
	</s:if>
	<div id="display" style="display: none;">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>ADD / Edit Devices</h4>
			</div>
			<s:form
				action="com/stpl/pms/action/bo/dm/st_dm_save_update_device_mapping.action"
				theme="simple">
				<s:hidden id="mapId" name="locDevMap.mappingId" />
				<s:hidden id="alid" name="locDevMap.aliasId" value="%{aliasId}" />
				<s:token id="strutsToken" value="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Location Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">

							<ss:select list="%{}" headerKey="-1"
								headerValue="--Please Select--" cssClass="select1"
								name="locDevMap.locMaster.locationId" id="locationName"
								theme="myTheme" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Device Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select list="%{}" headerKey="-1" 
								headerValue="--Please Select--" cssClass="select1"
								name="locDevMap.locDevices.deviceId" id="deviceName"
								theme="myTheme" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Status: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select id="status" name="locDevMap.status"
								list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
								theme="myTheme" cssClass="select1" applyScript="true"></s:select>
						</div>
					</div>
					<div class="box_footer" align="right">
						<ss:submit theme="myTheme" id="submitBtn" value="Submit"></ss:submit>
						<input type="reset" value="reset" id="reset">
					</div>
				</div>

			</s:form>
		</div>
	</div>
	<br>
	<br>
</body>
