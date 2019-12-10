<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Player Search</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/facebox.css" media="screen" rel="stylesheet"
	type="text/css" />
<script src="js/facebox.js" type="text/javascript"></script>
<style type="text/css">
.preImage, .nextImage {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: black;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
}

.nextImage {
	right: 0;
	border-radius: 3px 0 0 3px;
}

.preImage:hover, .nextImage:hover {
	background-color: rgba(0, 0, 0, 0.8);
}
</style>

<script>

	function openImage(imagePath ,callType){
		
		imagePath=imagePath+"?temp="+(new Date().getTime());
		$("#imageShow"+callType).attr("src",imagePath);
		jQuery.facebox({ div: '#imageDisplay'+callType+'Div' });
		return false;
	} 


	function openDocument(frontSidePath,backSidePath,imagePath,callType){
		var frontImage=frontSidePath.replace(imagePath,'');
		var backImage=backSidePath.replace(imagePath,'');
		frontImage=frontImage.toLowerCase();
		backImage=backImage.toLowerCase();
		if(frontImage.indexOf(".pdf")!=-1 )
			window.open(frontSidePath,'');
		else if(frontImage)
			openImage(frontSidePath,callType);

		console.log(frontImage);
		console.log(backImage); 
		
		if(backSidePath.indexOf(".pdf")!=-1)
			window.open(backSidePath,'');
		else if(backImage)
			openImage(backSidePath,callType);
		
		return false;
	}
	
</script>

</head>

<body>
	<div id="editUploadPlrDiv" class="FormSection">
		<div class="greyStrip">
			<h4>
				Player Bank Document Upload For
				<s:property value="%{userName}" />
			</h4>
		</div>
		<s:form id="uploadandSave" action="bo_pm_updateAndSave_plr_bank_doc"
			theme="simple" method="POST" enctype="multipart/form-data">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden id="playerId1" name="plrBankDocumentMaster.playerId"
				value="%{plrBankDocumentMaster.playerId}"></s:hidden>
			<s:hidden id="redeemAccId1" name="plrBankDocumentMaster.redeemAccId"
				value="%{plrBankDocumentMaster.redeemAccId}"></s:hidden>
			<s:hidden name="plrBankDocumentMaster.bankIdDocType"
				id="bankIdDocType" value="BANK_DOC_ID"></s:hidden>
			<s:hidden name="plrBankDocumentMaster.identityIdDocType"
				id="identityIdDocType" value="BANK_DOC_IDENTITY"></s:hidden>
			<s:set name="imagePath"
				value="%{defaultContentPath+'playerDocument/'}" />
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" style="width: 99%">
					<tr>
						<th width="15%">Verification</th>
						<th width="15%">Unique Number</th>
						<th width="10%">View Image</th>
						<th width="10%">Upload Image</th>
						<th width="20%" nowrap="nowrap">Set as verified</th>
					</tr>
					<tr>
						<td width="15%"><label> Bank ID </label></td>
						<td width="15%"><ss:textfield id="bankIdUniqueNo" width="95%"
								name="plrBankDocumentMaster.bankIdUniqueNo" theme="myTheme"
								pattern="^[a-zA-Z0-9]*$" maxlength="20"
								errorMassage="Invalid Sequence" patternOn="blur"
								action="com/stpl/pms/action/bo/pm/bo_pm_check_unique_plr_bank_doc.action"
								ajaxParam="bankIdUniqueNo,domainId,playerId1,redeemAccId1"
								value="%{plrBankDocumentMaster.bankIdUniqueNo}"></ss:textfield>
						</td>
						<td width="10%" style="text-align: center" id="taxtd"><s:if
								test="plrBankDocumentMaster.bankIdPath!=null && plrBankDocumentMaster.bankIdPath!='' && plrBankDocumentMaster.bankIdVerification.trim()!='PENDING'">
								<div class="dataTbl_top" style="border-bottom: none">
									<p>
										<s:hidden name="plrBankDocumentMaster.bankIdPath"
											value="%{plrBankDocumentMaster.bankIdPath}" />
										<s:if
											test="%{plrBankDocumentMaster.bankIdPath.split('[.]')[1].toLowerCase()=='pdf'}">
											<a id="bankIdView" style="cursor: pointer;"
												onclick="window.open('<s:property value="#imagePath"/><s:property value="%{plrBankDocumentMaster.bankIdPath}"/>','')";>VIEW
											</a>
										</s:if>
										<s:else>
											<a id="bankIdView" href="#"
												onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrBankDocumentMaster.bankIdPath}"/>','Bank');">VIEW</a>
										</s:else>
									</p>
								</div>
							</s:if> <s:else>
								--No File--
								</s:else></td>
						<td width="10%"><s:if
								test="%{plrBankDocumentMaster.bankIdVerification.equals('VERIFIED')}">
								<s:file disabled="true"></s:file>
							</s:if> <s:else>
								<s:file name="plrBankDocumentMaster.bankIdImage" size="8"
									id="bankIdImage"></s:file>
							</s:else></td>
						<td width="20%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%"
								name="plrBankDocumentMaster.bankIdVerification"
								list="#{'-1':'Pending','UPLOADED':'Uploaded','VERIFIED':'Verified'}"
								id="bankIdVerification"
								value="%{plrBankDocumentMaster.bankIdVerification}"></s:select></td>
					</tr>
					<tr>
						<td width="15%"><label> Identity ID </label></td>
						<td width="15"><ss:textfield id="identityIdUniqueNo"
								width="95%" name="plrBankDocumentMaster.identityIdUniqueNo"
								theme="myTheme" pattern="^[a-zA-Z0-9]*$" maxlength="20"
								errorMassage="Invalid Sequence" patternOn="blur"
								action="com/stpl/pms/action/bo/pm/bo_pm_check_unique_plr_bank_doc.action"
								ajaxParam="identityIdUniqueNo,domainId,playerId1,redeemAccId1"
								value="%{plrBankDocumentMaster.identityIdUniqueNo}"></ss:textfield>
						</td>
						<td width="10%" style="text-align: center" id="addtd"><s:if
								test="plrBankDocumentMaster.identityIdPath!=null && plrBankDocumentMaster.identityIdPath!='' && plrBankDocumentMaster.identityIdVerification!='PENDING'">
								<div class="dataTbl_top" style="border-bottom: none">
									<p>
										<s:hidden name="plrBankDocumentMaster.identityIdPath"
											value="%{plrBankDocumentMaster.identityIdPath}" />
										<s:if
											test="%{plrBankDocumentMaster.identityIdPath.split('[.]')[1].toLowerCase()=='pdf'}">
											<a id="identityIdView" style="cursor: pointer;"
												onclick="window.open('<s:property value="#imagePath"/><s:property value="%{plrBankDocumentMaster.identityIdPath}"/>','')";>VIEW
											</a>
										</s:if>
										<s:else>
											<a id="identityIdView" href="#"
												onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrBankDocumentMaster.identityIdPath}"/>','Identity');">VIEW</a>
										</s:else>

									</p>
								</div>
							</s:if> <s:else>
								--No File--
								</s:else></td>
						<td width="10%"><s:if
								test="%{plrBankDocumentMaster.identityIdVerification.equals('VERIFIED')}">
								<s:file disabled="true"></s:file>
							</s:if> <s:else>
								<s:file name="plrBankDocumentMaster.identityIdImage" size="8"
									id="identityIdImage"></s:file>
							</s:else></td>
						<td width="20%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%"
								name="plrBankDocumentMaster.identityIdVerification"
								list="#{'-1':'Pending','UPLOADED':'Uploaded','VERIFIED':'Verified'}"
								id="identityIdVerification"
								value="%{plrBankDocumentMaster.identityIdVerification}"></s:select>
						</td>
					</tr>

				</table>
			</div>
			<div class="box_footer" align="right">
				<s:submit id="uploadId" name="Upload" value="Upload"
					cssClass="button"></s:submit>
			</div>
		</s:form>
		<div id="imageDisplayBankDiv" style="display: none;" rel="facebox"
			style="text-decoration: none">
			<img height="500px" width="800px" id="imageShowBank">
		</div>
		<div id="imageDisplayIdentityDiv" style="display: none;" rel="facebox"
			style="text-decoration: none">
			<img height="500px" width="800px" id="imageShowIdentity">
		</div>
	</div>




</body>
</html>
