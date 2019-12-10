<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	<body>
		<s:form id="bo_Risk_blockIpSearchResult" theme="simple"
			action="bo_dm_blockIpEdit_Save">
			<s:token name="strusTokenSearchResult" id="strutsTokenSearchResult"></s:token>
			 <s:hidden id="domainId" name="domainId"></s:hidden>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						<s:text name="global.networkaccessmanagement.AllowedIPAddresses"/>
					</h4>
				</div>
				<s:hidden id="ipAddressCount" value="%{ipAddresses.size()}"></s:hidden>
				<s:if test="%{(ipAddresses.size()!=0)}">
					<div class="innerBox">
						<div class="FormMainBox1">
						   
							<table width="100%" cellpadding="0" cellspacing="0" border="0"
								id="plrTxnDayWiseTable">
								<tbody>
									<tr>
										<td>
											<s:set name="count" value="0"></s:set>
											<s:iterator value="%{ipAddresses}">
												<s:if test="%{#count==4}">
													<br />
													<br />
													<s:set name="count" value="0"></s:set>
												</s:if>
												<ss:textfield name="domainIpList" theme="simple"
													maxlength="15" id="domainIp_%{key}" pattern="^[0-9.]*$"
													errorMassage="Only Numeric Characters allowed"
													cssStyle="width:18%" readonly="true" value="%{value}" />
												<s:a id="link_domainIp_%{key}" theme="simple"
													href="javascript:void(0)">
													<img src="<%=path%>/images/cross.gif" />
												</s:a>
												<s:set name="count" value="%{#count+1}"></s:set>&nbsp; &nbsp;
											</s:iterator>
										</td>
									</tr>
								</tbody>

							</table>
						</div>
					</div>
				</s:if>
				<s:else>
					<div class="innerBox">
						<div class="FormMainBox1">
							<h3 align="center" style="vertical-align: middle;">
								<s:text name="global.searchuser.NoRecordsFound"/>
							</h3>
						</div>
					</div>
				</s:else>
				
				<div id="addIP" style="display: none;">
					<div class="clearFRM" style="padding-top: 18px"></div>
					<div class="FormSection" style=" width:96%; margin: 10px">
						<div class="greyStrip">
							<h4>
								<s:text name="global.networkaccessmanagement.AddNewIP"></s:text>
							</h4>
						</div>
						<div class="innerBox" style="height: 130px">
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>
										<s:text name="global.networkaccessmanagement.IPAddress"></s:text>
									</label>
								</div>
								<div id="Container" style="height: auto;">
									<s:set name="count" value="1"></s:set>
									<s:iterator begin="1" end="3">
										<div class="InputDiv">
											<s:iterator begin="1" end="4">
												<ss:textfield name="domainIpList" id="Ip%{#count}"
													theme="myTheme" maxlength="15"
													pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
													patternOn="blur" errorMassage="Enter a valid IP Address"
													cssStyle="width:20%"></ss:textfield>
														&nbsp;&nbsp;
												<s:set name="count" value="#count+1" />
											</s:iterator>
										</div>
										<br />
										<br />
									</s:iterator>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="clearFRM" style="padding-top: 18px"></div>
				<div class="FormMainBox"  <s:if test="%{(ipAddresses.size()==0)}"> style="display: none;" </s:if> id="reasonDiv" >
					<div class="labelDiv">
						<label>
							<s:text name="global.networkaccessmanagement.Reason"></s:text>
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="reason" id="reason" theme="myTheme"
							maxlength="50" pattern="^[a-zA-Z ]*$"
							errorMassage="Number and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="reason_error" class="fieldError">
							<s:fielderror>
								<s:param>reason</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="box_footer">
					<table width="100%">
						<tr>
							<td align="left" width="88%">
								<s:a title="Add to Block IP" 
									 id="addToBlock" href="">
									<img alt="Add to Block IP" Class=""
										Style="margin: 15px 0px 0px 20px"
										src="<%=path%>/images/add.png" name="maximize"/>
								</s:a>
							</td>
							
								<td align="right" width="50%" <s:if test="%{(ipAddresses.size()==0)}"> style="visibility: hidden; float: right;" </s:if>>
									<%-- <s:submit align="right" name="EditIP" value="Submit"
										cssClass="button" id="editIP" theme="simple"></s:submit> --%>
									<input type="submit" value='<s:text name="global.login.submit"/>' class="button" id="editIP" align="right" name="EditIP"/>
								</td> 
							
						</tr>
					</table>
				</div>
			</div>
		</s:form>
		<br/>
	</body>
</html>