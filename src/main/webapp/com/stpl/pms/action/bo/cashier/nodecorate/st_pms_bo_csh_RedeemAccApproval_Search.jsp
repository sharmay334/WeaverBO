<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Reddem Account Approval</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<script type="text/javascript">
			$(document).ready(function(){
			    $(function() {
					$('#redeemAccForm').submit(function(){
						if($('#redeemAccTbl tbody tr').find('> td:first-child > input[type="checkbox"]:checked').length==0){
							alert("Please select at least one redeem account to change status.");
							return false;
						}
						return true;
					});
					
				});
			    	var executed=true;
				$('a[id*="edit_"]').click(function(){
				    if(executed) {
				        var url = $(this).attr("href");
				        var arr1 = url.split("branchAddress=");
				        var arr2 = arr1[1].split("&ifscCode=");
				        arr2[0] = encodeURIComponent(arr2[0]);
				        url = arr1[0] + "branchAddress=" + arr2[0] + "&ifscCode=" + arr2[1];
				        $(this).attr("href", url);
				    	executed=false;
				     }
					
				});
				
			});
			

</script>
	</head>

	<body>
		<div class="FormSection">
		<s:if test="%{redAccList.size()>0}">
		
			<div class="greyStrip">
				<h4>
					Redeem Account Approval
				</h4>
			</div>
			<s:form id="redeemAccForm" method="post" theme="simple" action="st_pms_bo_csh_RedeemAccApproval_Save" target="searchResult">
			<div class="innerBox">
				<table width="830" cellspacing="0" cellpadding="4" border="0" id="redeemAccTbl" 
					align="center" class="payTransaction">
					<thead>
					<tr>
						<th width="5%" valign="middle" align="left">
						</th>
						<th width="15%" valign="middle" align="left">
							Redeem Account ID
						</th>
						<th width="15%" valign="middle" align="left" >
							Beneficiary Name
						</th>
						<th width="15%" valign="middle" align="left" >
							A/C No
						</th>
						<th width="15%" valign="middle" align="left" >
							Bank Name
						</th>
						<th width="15%" valign="middle" align="left" >
							Branch Location
						</th>
						<th width="15%" valign="middle" align="left" >
							Branch City
						</th>
						<th width="15%" valign="middle" align="left"  >
							Branch Address
						</th>
						<th width="15%" valign="middle" align="left" >
							IFSC Code
						</th>
						<th width="15%" valign="middle" align="left" >
							MICR Code
						</th>
						
						<th width="15%" valign="middle" align="left" >
							Status
						</th>
						<th width="15%" valign="middle" align="left" >
							
						</th>
					</tr>
					</thead>
					<tbody>
					<s:iterator value="%{redAccList}" status="wdrTxn">
						<tr>
							<td>
								<input name="redAccIds" id="redAccId_<s:property value="%{redeemAccId}" />"
									   type="checkbox" value="<s:property value="%{redeemAccId}" />" />
							</td>
							<td>
								<s:property value="%{redeemAccId}" />
							</td>
							<td>
								<s:property value="%{accHolderName}" />
							</td>
							<td>
								<s:property value="%{accNum}" />
							</td>
							<td>
								<s:property value="%{bankName}" />
							</td>
							<td>
								<s:property value="%{branchLocation}" />
							</td>
							<td>
								<s:property value="%{branchCity}" />
							</td>
							<td style="word-break: break-all;">
								<s:property value="%{branchAddress}" />
							</td>
							<td>
								<s:property value="%{ifscCode}" />
							</td>
							<td>
								<s:property value="%{micrCode}" />
							</td>
							<td >
								<s:property value="%{status}" /> 
							</td>
							<td>
								<a id="edit_<s:property value="%{redeemAccId}" />" href="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_RedeemAcc_Edit.action?redeemAccIdEdit=<s:property value="%{redeemAccId}" />&amp;beneficiaryName=<s:property value="%{accHolderName}" />&amp;domainId=<s:property value="%{domainId}" />&amp;aliasId=<s:property value="%{aliasId}" />&amp;accNum=<s:property value="%{accNum}" />&amp;subtypeId=<s:property value="%{subtypeId}" />&amp;branchLocation=<s:property value="branchLocation" />&amp;branchCity=<s:property value="%{branchCity}" />&amp;branchAddress=<s:property value="%{branchAddress}" />&amp;ifscCode=<s:property value="%{ifscCode}" />&amp;micrCode=<s:property value="%{micrCode}" />" target="redeemAcForm" class="view-btn">Edit</a>
							</td>
							
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:token name="redAccToken" id="redAccToken" />
					<s:select list="#{'ACTIVE':'Active','NEW':'New','FREEZE':'Freeze'}" headerKey="-1" headerValue="---Please select---"
						name="status" id="status" theme="myTheme" cssClass="select1" cssStyle="margin-right:15px;margin-top:13px;width:150px;"
						applyscript="true"></s:select>
					<s:submit cssClass="button" id="redeemAccSubmitBtn" theme="simple" value="Change Status" ></s:submit>
			</div>
			</s:form>
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4>
					Error Message
				</h4>
			</div>
			<div class="innerBox">
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</div>
		</s:else>
		
</div>
<div id="redeemAcForm"></div>
	</body>
</html>
