<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>VIP Level Search</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script>
			$(document).ready(
				function() {
					$('#criteriaCodeList').listnav({ 
					    includeAll: false,  
					    noMatchText: 'No criteria found.' 
					  });
					
					$("#vipHelpDiv").accordion( {
						collapsible : true,
						clearStyle : true,
						header : 'div[class*="accordianHeader"]',
						icons : {
							header : "plus1",
							headerSelected : "minus1"
						},
						active : true
					});
					$('input[id*=editVipRule_]').click(function(){
						var vipLevel = $(this).attr('id').replace('editVipRule_','');
						$('#editVipLevel').val(vipLevel);
						$('#editDomainId').val($('#domainId').val());
						$('#editVipForm').submit();
					});
					
			});
		</script>
	</head>

	<body>
		<s:if test="%{vipLevelList.size()>0}">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						VIP Level
					</h4>
				</div>
				<s:form action="st_pms_misc_editVipLevel" id="editVipForm" theme="simple" target="vipInfoDiv" callBack="onReadyVip()">
					<s:hidden name="vipMaster.domainId" value="%{vipMaster.domainId}" id="editDomainId"/>
					<s:hidden name="vipMaster.levelType" value="%{vipMaster.levelType}" id="editLevelType"/>
					<s:hidden name="vipMaster.vipLevel" id="editVipLevel"/>
					
				</s:form>	
					<div class="innerBox">
						<table width="830" cellspacing="0" cellpadding="4" border="0" id="editVipTbl" 
							align="center" class="payTransaction">
							<thead>
							<tr>
								<th width="10%" valign="middle" align="left">
									VIP Level
								</th>
								<th width="15%" valign="middle" align="left">
									VIP Code
								</th>
								<th width="10%" valign="middle" align="left" >
									VIP Group
								</th>
								<th width="10%" valign="middle" align="left" >
									VIP Color
								</th>
								
								<s:if test="%{vipMaster.levelType=='AUTO'}">
									<th width="35%" valign="middle" align="left" >
										Rule
									</th>
								</s:if>
								<th width="10%" valign="middle" align="left" >
									Status
								</th>
								<th width="10%" valign="middle" align="left" >
									Edit
								</th>
							</tr>
							</thead>
							<tbody>
							<s:iterator value="%{vipLevelList}" status="vipLevel">
								<tr>
									<td>
										<s:property value="%{vipLevel}" />
									</td>
									<td>
										<s:property value="%{vipCode}" />
									</td>
									<td>
										<s:property value="%{vipGroup}" />
									</td>
									<td>
										<s:property value="%{vipColor}" />
									</td>
									<s:if test="%{vipMaster.levelType=='AUTO'}">
										<td>
											<s:property value="%{vipRule}" />
										</td>
									</s:if>
									
									
									<td>
										<s:property value="%{status}" />
									</td>
									<td>
										<input type="button" id="editVipRule_<s:property value="%{vipLevel}"/>" value="Edit"> 
									</td>
									
								</tr>
							</s:iterator>
							</tbody>
						</table>
					</div>
			
					<div class="box_footer" align="right">
					
					</div>
			</div>
			<s:if test="%{vipMaster.levelType=='AUTO'}">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Help
						</h4>
					</div>
					<div class="innerBox">
						<div id="vipHelpDiv" class="UIaccordian">
							<div class="accordianHeader">
									<h3 class="headerBlock">
										Criteria List 
									</h3>
							</div>
						 	
							<div class="accordian_content">
								
								<div id="criteriaCodeList-nav"></div> 
								<ul id="criteriaCodeList" class="navList">
									<s:iterator value="%{activeVipCriteria}" >
										<li><s:property value="%{key}"/>  -  <s:property value="%{value.criteriaName}"/></li>
									</s:iterator>
								</ul>
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
					</div>
				</div>
			</s:if>
		</s:if>
		<s:else>
			<div class="FormSection">
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
			</div>
		</s:else>
		<div class="clear2"></div>
		<div id="vipInfoDiv" >

		</div>
		
		<br/>
		<br/>
	</body>
</html>



