<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=path %>/js/commonfunctions.js"></script>-->
	<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
	<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/pm/js/notification.js"></script>
 	<script type="text/javascript">
 		$(function() {
			$('.appOsUsers').click(function() {
				$('#appType' + this.value).toggle();
				$('#appType' + this.value + " select").prop('disabled',function(i, v) {return !v;});
			});
		});
 	/* 	$(function(){
 		
 			 function addCheckbox(name,val) {
			   var container = $('#appTypeStart');
			   var inputs = container.find('input');
			   var id = inputs.length+1;
			   $('<input />', { type: 'checkbox', id: 'cb'+id, value: val,class:'appType',name:'plrNotificationBean.appTypeList' }).appendTo(container);
			   $('<label />', { 'for': 'cb'+id, text: name, class:'appType' }).appendTo(container);
			} 
 			 window.deepLinkMap=_ajaxCallJson("com/stpl/pms/action/bo/pm/st_pms_get_deepLinks.action","aliasId="+$("#aliasId").val());
 			var deepLinkMap=window.deepLinkMap;
 			
 			for (var key in deepLinkMap) {
			  if (deepLinkMap.hasOwnProperty(key)) {
			  addCheckbox(key.split('_').join(' ').toLowerCase(),key);
			  }
			}
			 
			window.deepLinkSet=new Set();
			deepLinkSet=window.deepLinkSet;
			 $(".appType").click(function(){
				var checkedTypes =$(".appType:checked");
				console.log(checkedTypes);
				for(var i =0; i<checkedTypes.length;i++){
						$("#pageName").empty().append($("<option></option>").attr("value",-1).text("--Please Select--"));
						window.deepLinkSet=new Set();
						var appType=$(checkedTypes[i]).val();
						if(window.deepLinkMap && appType!=-1){
							$("#pageName").removeAttr("disabled");
							var deepLinkList=window.deepLinkMap[appType];
							$.each(deepLinkList, function(index,jsonObject){
								console.log(jsonObject.dispCode);
								deepLinkSet.add(jsonObject.dispCode);
							});	
						}
						deepLinkSet.forEach(function(value) {
						  //console.log(value);
						  $("#pageName").append($("<option></option>").attr("value",value).text(value.split('_').join(' ').toLowerCase()));
					});
				};	
	 		});
 		}); */
 	</script>
  </head>
<body>
	<div class="clear2"></div>
	<h2>Send Notification</h2>
	<s:form id="tempFrm"
		action="com/stpl/pms/action/bo/pm/st_pms_sendNotification.action"
		theme="simple">
		<s:hidden id="searchedCriteria" name="searchedCriteria"></s:hidden>
		<s:hidden name="aliasId"></s:hidden>
		<s:token theme="simple"></s:token>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Send Notification</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Player </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv" style="height:auto">
						<s:select theme="myTheme" cssClass="select1" list="%{playerMap}"
							multiple="true" data-placeholder="Select Player Here"
							name="playerIdArr" id="playerIdArr" cssStyle="height:auto"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<!-- Beta stuff -->
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select appUser type: </label><em class="Req">*</em>
					</div>
					<div class="InputDiv" >
						<s:iterator value="%{deeplinkMap}">
							<input type="checkbox"  id="label_<s:property value='%{key}'/>" class="appOsUsers" 
							name="plrNotificationBean.appTypeList" value='<s:property value='%{key}'/>'  />
							<label for="label_<s:property value='%{key}'/>"><s:property value='%{key.replace("_"," ")}' /> </label>
						</s:iterator> 
					</div>
				</div>
				<s:iterator value="deeplinkMap">
					<div id="appType<s:property value='%{key}' />"
						style="display:none;">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv" style="width:30%">
								<label><s:property value='%{key.toLowerCase().replace("_"," ")}' />
									version: </label><em class="Req">*</em>
							</div>
							<div class="InputDiv" style="width:68%">
								<s:select theme="myTheme" disabled="true" headerKey="-1" 
									headerValue="--Please Select--" cssClass="select1 pageName"
									list="%{value}" listKey='%{deepLink}' listValue='%{dispCode.replace("_"," ")}'
									name="plrNotificationBean.deeplinkList">
								</s:select>
							</div>
						</div>
					</div>
				</s:iterator>
				<!--beta stuff ends / -->
				<%-- <div class="FormMainBox">
					<div class="labelDiv">
						<label> App Type </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div id="appTypeStart" style="text-transform: capitalize;">
							<s:select theme="myTheme" cssClass="select1"
								list="#{}"
								name="plrNotificationBean.appType" id="appType" headerKey="-1"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Page Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1" list="#{}"
								name="plrNotificationBean.pageName" id="pageName" headerKey="-1"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div> --%>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Send Notification </label>
					</div>
					<div class="InputDiv">

						<s:checkbox name="plrNotificationBean.sentToAll" id="sentToAll"
							value="sentToAll"></s:checkbox>
						<label for="sentToAll">All Players</label>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div id="contentDiv">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Message : </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv" style="height: auto">
							<s:textarea name="plrNotificationBean.message" id="pageHTML"
								cols="93" placeholder="Type push message here" rows="5"
								cssStyle="width:98%;"></s:textarea>

						</div>
					</div>
				</div>
				<div id="page_new_div"></div>
				<div id="phAttr"></div>
			</div>
			<div class="box_footer" align="right">
				<s:submit theme="simple" id="submitBtn" value="Send"></s:submit>
			</div>
		</div>
	</s:form>
</body>
</html>
