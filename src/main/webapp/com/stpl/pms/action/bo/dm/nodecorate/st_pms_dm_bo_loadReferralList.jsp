<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	  <base href="<%=basePath%>">
	
	
		<title>Main</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	 <body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Reference Table
				</h4>
			</div>
			<s:form theme="simple" id="refForm" name="refForm"
						action="st_pms_dm_bo_saveReferralsList">
						<s:token id="strutsToken" name="strutsToken"></s:token>
				<s:hidden id="domainId" name="domainId"></s:hidden>
				<div class="innerBox">
					<s:if test="#session.referenceFieldList.size!=0">

						<table id="payTransaction" class="payTransaction" align="center"
							cellspacing="0" cellpadding="4" border="0">
							<tr>
								<th height="28" width="4%" align="left" valign="middle">
									Select
								</th>
								<th height="28" width="15%" align="left" valign="middle">
									Reference Name
								</th>
								<th height="28" width="15%" align="left" valign="middle">
									Label1
								</th>
								<th height="28" width="8%" align="left" valign="middle">
									Label1 Type
								</th>
								<th height="28" width="15%" align="left" valign="middle">
									Label2
								</th>
								<th height="28" width="8%" align="left" valign="middle">
									Label2 Type
								</th>
								<th height="28" width="15%" align="left" valign="middle">
									Label3
								</th>
								<th height="28" width="8%" align="left" valign="middle">
									Label3 Type
								</th>
								<th height="28" width="10%" align="left" valign="middle">
									Edit
								</th>

							</tr>
								<s:iterator value="#session.referenceFieldList"
									status="referenceFieldList">
									<tr>
										<td height="20" align="left" valign="middle">
												<input type="checkbox" <s:property value="%{(status=='ACTIVE')?'checked=checked':''}" />
													value="<s:property value="#referenceFieldList.index" />"
													name="refId" id="refId" />
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!referenceName.equals('null')">
												<s:property
													value="%{resource.getProperty('global.'+referenceName)}" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel1.equals('null')">
												<s:property
													value="%{resource.getProperty('global.'+refTxtLabel1)}" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel1Type.equals('null')">
												<s:property value="refTxtLabel1Type" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel2.equals('null')">
												<s:property
													value="%{resource.getProperty('global.'+refTxtLabel2)}" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel2Type.equals('null')">
												<s:property value="refTxtLabel2Type" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel3.equals('null')">
												<s:property
													value="%{resource.getProperty('global.'+refTxtLabel3)}" />
											</s:if>
										</td>
										<td height="20" align="left" valign="middle">
											<s:if test="!refTxtLabel3Type.equals('null')">
												<s:property value="refTxtLabel3Type" />
											</s:if>
										</td>
										<td>
											<a style="cursor: pointer"
												onclick="return editField('<s:property value="#referenceFieldList.index"/>','<s:property value="domainId"/>','newFieldDiv');">Edit
											</a>
									</tr>
								</s:iterator>
						</table>


					</s:if>

				</div>
				<div class="box_footer" align="right">
					
					
					<ss:button cssClass="button"  theme="simple" value="Add Field" ajaxAction="com/stpl/pms/action/bo/dm/st_pms_dm_bo_addRefferalField.action" target="newFieldDiv"></ss:button>
					
				<s:submit cssClass="button" align="right" theme="simple"
						onclick="return checkForm('Please select atleast one Reference');"></s:submit>
				</div>
				<div class="clear2"></div>
			</s:form>
		</div>
	 <div id="newFieldDiv"></div>
	</body>
</html>