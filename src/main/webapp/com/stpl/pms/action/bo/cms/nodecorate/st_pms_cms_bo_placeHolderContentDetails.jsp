<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String	basePath =  (String)request.getAttribute("basePathURL") ;
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>PlaceHolder-Content Mapping</title>
<base href="<%=basePath%>">

<title></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	$("document").ready(function() {

		$(".dateField").datetimepicker(
				{
					dateFormat : 'dd/mm/yy',
					timeFormat : 'HH:mm:ss',
					showSecond : true,
					minDate: serverDateStr,
					minDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
					onClose : function(dateText, inst) {
						if ($(this).attr('id').indexOf('startDate_') != -1) {
							$('#endDate_'+$(this).attr('id').split("_")[1]).datetimepicker("option", "minDate",
									dateText);
							$('#endDate_'+$(this).attr('id').split("_")[1]).datetimepicker("option", "minDateTime",
									$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
						} else if ($(this).attr('id').indexOf('endDate_') != -1) {
							$('#startDate_'+$(this).attr('id').split("_")[1]).datetimepicker("option", "maxDate",
									dateText);
							$('#startDate_'+$(this).attr('id').split("_")[1]).datetimepicker("option", "maxDateTime",
									$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
						}
					}
				}).bind("change",function(){
					
						var type= $(this).attr("id").split("_")[0];
						var groupId= $(this).attr("id").split("_")[1];
						
						$("."+type+groupId).val($(this).val());
					
					
				});

		if($("#joomlaDevice").val()!="PC") {
			$(".payTransaction:first").find("tr").each(function() {
				$(this).find(".mappStatus").val("ACTIVE");
				$(this).find(".mappStatus").attr("disabled", "true");
			});
			
			
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/login").text("Android Login"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/deposit").text("Android Deposit"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/referAFriend").text("Android Refer A Friend"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/lobby").text("Android Lobby"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/instantPlay").text("Android Instant Play"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/myProfilePage").text("Android My Profile"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/cashGame").text("Android Cash game"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/practiceGame").text("Android Practice game"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/rateAnApp").text("Android Rate an app"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/shareAnApp").text("Android Share an app"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/inbox").text("Android Inbox"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","kpr://DeepLink/register").text("Android Register"));			
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/login").text("Ios Login"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/register").text("Ios Register"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/referAFriend").text("Ios Refer A Friend"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/lobby").text("Ios Lobby"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/instantPlay").text("Ios Instant Play"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/myProfilePage").text("Ios My Profile"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/inboxPage").text("Ios Inbox"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/feedback").text("Ios Feedback"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/shareApp").text("Ios Share An App"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/cashGame").text("Ios Cash Game"));
				$("[id*='redirectUrl_']").append($("<option></option>").attr("value","khelplay://khelDeepLink/practiceGame").text("Ios Practice Game"));
			
			
			$("[id*='redirectUrl_']").each(function(){
					$(this).val($(this).attr('deepURL'));			
			});
		}else{
			
			$("[id*='redirectUrl_']").each(function(){
					if($(this).val()!=-1){
						$('<a href="#" onclick="javascript:window.open(\'https://'+$('#aliasId option:selected').text()+'/'+$(this).val()+'\'); return false;" ><img src="<%=basePath%>/images/exit-top-right.png" alt="logo" style= "vertical-align: middle; margin-left: 10px; width: 13px; height: 13px;   margin-top: -3px;"></a>').insertAfter(this);
					}			
			});
		}	
		
		$("[id*='contentDetail_']").each(function(){
				if($(this).val()!="" && $(this).val()!=-1){ 
					var count =$(this).attr("id").split("_")[1];
					$("#preview_"+count).html("<a href='#' onclick='javascript: return openImage(\""+($(this).val().split("#")[1])+"\") ;'> Preview </a> " );
				}			
			});
			
		$("div[rel*='facebox']").facebox({
			closeImage : "<%=basePath%>/images/closelabel.png"
		});
		
		var currentValue=0;
			$("[id*='_groupId']").each(function(){			
				if($(this).val()>=currentValue){
					currentValue=$(this).val();
					$("#groupId").val(currentValue);
				}
				
						
			});


			$(".resetClass").bind("click", function(){
					var groupId=$(this).attr("id").split("_")[1];
					$("#startDate_"+groupId).val("");
					$("#endDate_"+groupId).val("");	
					$(".startDate"+groupId).val("");
					$(".endDate"+groupId).val("");
				
			});
			
	});	
</script>
</head>
<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>PlaceHolder-Content Mapping</h4>
		</div>
		<s:iterator value="placeHolderDetailMap" status="phDetailMap">
			<s:set name="lang" value="key" />
			<s:set name="count" value="0" />
			<s:iterator value="%{value}" status="status" var="critMap">
				<s:if test="%{key.equals('default')}">
					<div class="FormSection" style="width: 95%; margin-left: 15px;">
						<div class="greyStrip">
							<h4>Default-Place Holder</h4>
						</div>
						<s:hidden value="%{phCrit}" id="phCrit" />
						<div class="copyDiv">
							<s:iterator value="%{value}" status="phvals">
								<s:set name="groupId" value="key"></s:set>
								<div class="innerBox">
									<table class="payTransaction">										
										<tr>
											<th colspan="6"
												id='lang_<s:property value="#phDetailMap.index"/>'><div align="center">
												Display Start Date &nbsp;&nbsp;<s:textfield id="startDate_%{#groupId}" cssClass="dateField" value="%{value[0].startDate}" readonly="true"  theme="myTheme"></s:textfield>
													&nbsp;&nbsp;&nbsp;&nbsp;Display End Date  &nbsp;&nbsp;<s:textfield id="endDate_%{#groupId}" value="%{value[0].endDate}" readonly="true" cssClass="dateField"   theme="myTheme"></s:textfield>
													&nbsp;&nbsp;&nbsp;&nbsp;   <input type="button" class="resetClass" style="margin-top: 0 !important;" value="Reset Date" id="reset_<s:property value='%{#groupId}'/>" />
													</div>													
											</th>
											
										</tr>
										<tr>
											<th>PH-Name</th>
											<th>Content-Name</th>
											<th>View Content</th>
											<th>Content-Redirect</th>
											<th>Mapping Status</th>
										</tr>
										<s:iterator value="%{value}" var="data">
											<tr>
												<s:hidden cssClass="startDate startDate%{#groupId}" value="%{#data.startDate}"
															name="phCtBean[%{#count}].startDate" />
												<s:hidden cssClass="endDate endDate%{#groupId}" value="%{#data.endDate}"
														name="phCtBean[%{#count}].endDate" />
												<s:hidden cssClass="groupId" value="%{#groupId}"
													name="phCtBean[%{#count}].groupId" />
												<s:hidden name="phCtBean[%{#count}].phId"
													value="%{#data.phId}" cssClass="phId"></s:hidden>
												<td><s:property value="%{#data.phName}" />
												</td>												
												<td width="100px"><s:select
														id="contentDetail_%{#count}" headerKey="-1"
														headerValue="--Please Select--"
														list="%{#data.placeHolderSubDetailList}"
														listKey="%{contentId+'#'+contentPath}"
														listValue="%{contentName}" value="%{#data.contentValue}"
														cssClass="select1 contentId" theme="simple"
														name="phCtBean[%{#count}].ctIdWithValue"
														cssStyle="width:180px;" applyscript="true"></s:select></td>
														
												<td width="60px" class="preview" id="preview_<s:property value='%{#count}'/>">
														No Content Preview	
													</td>		
														
												<td width="360px"><s:select id="redirectUrl_%{#count}" list="reDirectPage" listKey="%{value}" listValue="%{key}"
													cssClass="select1 redirectId" theme="simple"
													 name="phCtBean[%{#count}].redirectUrl"
													 headerValue="--Please Select--"
													 headerKey="-1" value="%{#data.redirectPage}"
													 cssStyle="width:180px;" deepURL="%{#data.redirectPage}"></s:select>
													 
												</td>		
												<td width="100px"><s:select headerKey="-1"
														id="mappStatus_%{#count}"
														headerValue="--Please Select--"
														list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
														value="%{mappingStatus}" cssClass="select1 mappStatus"
														theme="simple" name="phCtBean[%{#count}].mappingStatus"
														cssStyle="width:auto;" applyscript="true"></s:select>
												</td>
											</tr>
											<s:set name="count" value="%{#count+1}"></s:set>
										</s:iterator>
									</table>
								</div>
							</s:iterator>
						</div>
						<div class="box_footer" align="right">
							<input type="button" value="Add More" id="addMore" />
						</div>
					</div>
				</s:if>
				<s:elseif test="%{key.equals('specific')}">
					<s:if test="%{(value.size()>0)}">
						<div class="NewFormSection" id="spCritTb">
							<div class="greyStrip">
								<h4>Specific-Criteria</h4>
							</div>
							<div class="critDiv">
								<s:iterator value="%{value}" status="phvals">
									<s:set name="groupId" value="key"></s:set>
									<div class="innerBox">
										<table class="payTransaction">
											<tr>
												<th colspan="6"
												id='lang_<s:property value="#phDetailMap.index"/>'><div align="center">
													Display Start Date &nbsp;&nbsp;<s:textfield id="startDate_%{#groupId}" cssClass="dateField" value="%{value[0].startDate}" readonly="true"  theme="myTheme"></s:textfield>
													&nbsp;&nbsp;&nbsp;&nbsp;Display End Date &nbsp;&nbsp;<s:textfield id="endDate_%{#groupId}" value="%{value[0].endDate}" cssClass="dateField" readonly="true"  theme="myTheme"></s:textfield>
													&nbsp;&nbsp;&nbsp;&nbsp;   <input type="button" class="resetClass" style="margin-top: 0 !important;" value="Reset Date" id="reset_<s:property value='%{#groupId}'/>" />
													</div>													
											</th>
											</tr>
											<tr>
												<th>PH-Name</th>
												<th>Content-Name</th>
												<th>View Content</th>
												<th>Content-Redirect</th>
												<th>Specific-Criteria</th>
												<th>Mapping Status</th>
												<!--  <th>Preview</th> -->
											</tr>
											
											<s:iterator value="%{value}" var="data">
												<tr>
													<s:hidden cssClass="startDate startDate%{#groupId}" value="%{#data.startDate}"
															name="phCtBean[%{#count}].startDate" />
													<s:hidden cssClass="endDate endDate%{#groupId}" value="%{#data.endDate}"
														name="phCtBean[%{#count}].endDate" />
														
													<s:hidden cssClass="groupId" value="%{#groupId}"
														name="phCtBean[%{#count}].groupId" />
													<s:hidden name="phCtBean[%{#count}].phId"
														value="%{#data.phId}" cssClass="phId"></s:hidden>
													<td><s:property value="%{#data.phName}" />
													</td>
													<td width="60px"><s:select
															id="contentDetail_%{#count}" headerKey="-1"
															headerValue="--Please Select--"
															list="%{#data.placeHolderSubDetailList}"
															listKey="%{contentId+'#'+contentPath}"
															listValue="%{contentName}" value="%{#data.contentValue}"
															cssClass="select1 contentId" theme="simple"
															name="phCtBean[%{#count}].ctIdWithValue"
															cssStyle="width:180px;" applyscript="true"></s:select></td>
															
												<td width="60px" class="preview" id="preview_<s:property value='%{#count}'/>">
														No Content Preview	
													</td>		
															
													<td width="280px"><s:select id="redirectUrl_%{#count}" list="reDirectPage" listKey="%{value}" listValue="%{key}"
															cssClass="select1 redirectId" theme="simple"
															 name="phCtBean[%{#count}].redirectUrl"
															 headerValue="--Please Select--"
															 headerKey="-1" value="%{#data.redirectPage}"
															 cssStyle="width:180px" deepURL="%{#data.redirectPage}"></s:select>
															
															  </td>
														
															 
															
													<td width="60px"><s:select id="phCritSelect_%{#count}"
															headerKey="-1" headerValue="--Please Select--"
															list="%{#data.phCritMap}" listKey="%{key}"
															listValue="%{value}" value="%{#data.phCritId}"
															cssClass="select1 phCritSelect" theme="simple"
															name="phCtBean[%{#count}].phCriteriaId"
															cssStyle="width:180px;" applyscript="true"></s:select></td>
													<td width="60px"><s:select headerKey="-1"
															id="mappStatus_%{#count}"
															headerValue="--Please Select--"
															list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}"
															value="%{mappingStatus}" cssClass="select1 mappStatus"
															theme="simple" name="phCtBean[%{#count}].mappingStatus"
															cssStyle="width:auto;" applyscript="true"></s:select>
													</td>
												</tr>
												<s:set name="count" value="%{#count+1}"></s:set>
											</s:iterator>
										</table>
									</div>
								</s:iterator>
							</div>
							<div class="box_footer" align="right">
								<input type="button" value="Add More" id="addMoreCrit" />
							</div>
						</div>
					</s:if>
					<s:else>
						<div class="NewFormSection" style="display: none;" id="spCriteria">
							<div class="greyStrip">
								<h4>Specific-Criteria</h4>
							</div>
							<div class="critDiv"></div>
							<div class="box_footer" align="right">
								<input type="button" value="Add More" id="addMoreCrit" />
							</div>
						</div>
					</s:else>
				</s:elseif>
			</s:iterator>
		</s:iterator>
		<div class="FormMainBox" style="height: 10px;">
			<p style="float: left;color:black">
				<b style="color: red;"> Note :</b> <b> <span> Specific
						criteria for 'lobbyHeader' and 'gamePlay' should be same.</span> </b></br>
						<b> <span>No date validation for blank date</span>
						 
						
			</p>
		</div>
		<s:hidden name="contentIds" id="contentId"></s:hidden>
		<div class="box_footer" align="right">
			<s:submit value="Submit" id="formSubmit"></s:submit>
			<input type="button" id="spCritBtn" value="Add Criteria" />
		</div>
		<s:hidden id="count" value="%{#count}" />
		<s:hidden id="groupId" value="%{#groupId}" />
	</div>
	<br />
	<div id="imageDisplayDiv" style="display:none;" rel="facebox" style="text-decoration: none">
				<img height="500px" width="800px" id="imageShow">
	</div>
	
</body>
</html>