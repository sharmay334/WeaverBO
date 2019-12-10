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
	$(document).ready(function() {
		$('#waitDiv').hide();
  		$('#searchButtons').show();
  		$('#searchButtons').attr("disabled",false);
  		if("REFER_FRIEND"==$("#campType").val()) {
 			$("#deviceType").val("ALL");
 			$("#deviceType").attr("disabled",true);
		 } 
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
						Refer Friend Tracking Report For Domain : <s:property value="%{domainName}"/>
					</h4>
					 <h4 class="dateData" style="text-align: right;background: none">
					</h4>
				</div>
				
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction">
						  <tr class="headerRow">
						  		 
								<th width="5%" valign="middle" style="text-align: center;" id="th_0" is_link="true" json_param="domainId,aliasId,campId,subCampId,fromDate,toDate,campType,device,startIndex,recordTofetch" data_column="sum">
								<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=StCmsReferFriendInvitedTracking&reportData=#domainId,#aliasId,.td_4,.td_5,#fromDate,#toDate,#campType,#deviceType,#startIndex,#recordTofetch'  target="expandIt" callBack="attachEvent('expandIt')"></a>
										Total Invited
								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_1" is_link="true" json_param="domainId,aliasId,campId,subCampId,fromDate,toDate,campType,device,startIndex,recordTofetch" data_column="sum">
								<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=StCmsReferFriendVisitedTracking&reportData=#domainId,#aliasId,.td_4,.td_5,#fromDate,#toDate,#campType,#deviceType,#startIndex,#recordTofetch'  target="expandIt" callBack="attachEvent('expandIt')"></a>
											Total Visitor
								</th>
							 
								<th width="5%" valign="middle" style="text-align: center;" id="th_2" is_link="true" json_param="domainId,aliasId,campId,subCampId,fromDate,toDate,campType,device,startIndex,recordTofetch" data_column="sum">
								<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsReferFriendPlrRegReport&reportData=#domainId,#aliasId,.td_4,.td_5,#fromDate,#toDate,#campType,#deviceType,#startIndex,#recordTofetch'  target="expandIt" callBack="attachEvent('expandIt')"></a>
											Total Registered
								</th>
								<th width="5%" valign="middle" style="text-align: center;" id="th_3" is_link="true" json_param="domainId,aliasId,campId,subCampId,fromDate,toDate,campType,device,startIndex,recordTofetch" data_column="sum">
								<a href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsReferFriendPlrDepReport&reportData=#domainId,#aliasId,.td_4,.td_5,#fromDate,#toDate,#campType,#deviceType,#startIndex,#recordTofetch'  target="expandIt" callBack="attachEvent('expandIt')"></a>
											Total Deposited
								</th>
								<th id="th_4"   is_link="false" data_column="sum"  is_hidden="true" style="display: none;">
											Campaign Id
								</th>
								 <th width="5%" valign="middle" is_hidden="true" style="display: none;" id="th_5" is_link="false" data_column="sum" >
											Sub Campaign Id
								</th>
							 </tr>
						<s:iterator value="%{resultList}" status="resultList"
							var="resultListVar">
							<tr class="<s:property value="#resultListVar[#resultListVar.length-1] "/>">
								<s:iterator value="%{#resultListVar}" status="indexvalue" var="varValue">	
										<td width="5%" valign="middle" style="text-align: center" class='tdclass td_<s:property value="%{#indexvalue.index}"/>' >
											<s:property />
										</td>
								</s:iterator>
							</tr>
						</s:iterator>
						
					</table>
				</div>
				<div class="box_footer">
				
			 	<div id="startIndex" name="startIndex" style="display:none"><s:property value="0" /></div>
			 	<div id="recordTofetch"  name="recordTofetch" style="display:none"><s:property value="101" /></div>
			  	<div id="nextPageStart" style="display:none"></div> 
			  	<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
				<div class="animated-striped">Wait</div>
				</div>
				<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
				<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				
				
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
   <div id="expandIt">
   </div>
	</body>
</html>

