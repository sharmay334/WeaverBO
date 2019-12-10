<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
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

.preImage,.nextImage {
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
  background-color: rgba(0,0,0,0.8);
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
    $("#ageDocType").change(function() {
		var docType=$('#addDocType');

		if(this.value==docType.val()){
		    if($('#addDocUniqueNo').val() !='') {
                $('#ageDocUniqueNo').val($('#addDocUniqueNo').val());
            }else if($('#ageDocUniqueNo').val!=''){
                $('#addDocUniqueNo').val($('#ageDocUniqueNo').val());
			}
		}
		else if (this.value==($('#taxIdDocType').val()) ){
		    if($('#taxIdDocUniqueNo').val() !='') {
                $('#ageDocUniqueNo').val($('#taxIdDocUniqueNo').val());
            }else if($('#ageDocUniqueNo').val!=''){
                $('#taxIdDocUniqueNo').val($('#ageDocUniqueNo').val());
			}
		}
		else{

		}



    });
    $("#addDocType").change(function() {
        var docType=$('#ageDocType');

        if(this.value==docType.val())
        {
            if($('#ageDocUniqueNo').val()!='')
            $('#addDocUniqueNo').val($('#ageDocUniqueNo').val());
            else if($('#addDocUniqueNo').val()!=''){
                $('#ageDocUniqueNo').val($('#addDocUniqueNo').val());
			}
        }
        else if (this.value==($('#taxIdDocType').val()) ){
            if($('#taxIdDocUniqueNo').val() !='') {
                $('#addDocUniqueNo').val($('#taxIdDocUniqueNo').val());
            }else if($('#addDocUniqueNo').val()!=''){
                $('#taxIdDocUniqueNo').val($('#addDocUniqueNo').val());
            }

        }

    });
    $("#taxIdDocType").change(function() {
        var docType=$('#ageDocType');

        if(this.value==docType.val()){
            if($('#ageDocUniqueNo').val()!='') {
                $('#taxIdDocUniqueNo').val($('#ageDocUniqueNo').val());
            }
            else if($('#taxIdDocUniqueNo').val()!=''){
                $('#ageDocUniqueNo').val($('#taxIdDocUniqueNo').val());
			}
        }
        else if (this.value==($('#addDocType').val()) ){
            if($('#addDocUniqueNo').val()!='') {
                $('#taxIdDocUniqueNo').val($('#addDocUniqueNo').val());
            }
            else if($('#taxIdDocUniqueNo').val()!=''){
                $('#addDocUniqueNo').val($('#taxIdDocUniqueNo').val());
            }
        }

    });
    $("#ageDocUniqueNo").change(function() {
        if($("#ageDocType").val()==$('#addDocType').val()&&$("#ageDocType").val()==$('#taxIdDocType').val() ){
            $('#addDocUniqueNo').val($('#ageDocUniqueNo').val());
            $('#taxIdDocUniqueNo').val($('#ageDocUniqueNo').val());
		}
        else if( $("#ageDocType").val()==$('#addDocType').val()){
            $('#addDocUniqueNo').val($('#ageDocUniqueNo').val());
		}
		else if( $("#ageDocType").val()==$('#taxIdDocType').val()){
            $('#taxIdDocUniqueNo').val($('#ageDocUniqueNo').val());
		}
    });
    $("#addDocUniqueNo").change(function() {
        if($("#addDocType").val()==$('#ageDocType').val()&&$("#addDocType").val()==$('#taxIdDocType').val() ){
            $('#ageDocUniqueNo').val($('#addDocUniqueNo').val());
            $('#taxIdDocUniqueNo').val($('#addDocUniqueNo').val());
        }
        else if( $("#addDocType").val()==$('#ageDocType').val()){
            $('#ageDocUniqueNo').val($('#addDocUniqueNo').val());
        }
        else if( $("#addDocType").val()==$('#taxIdDocType').val()){
            $('#taxIdDocUniqueNo').val($('#addDocUniqueNo').val());
        }
    });
	
</script>

</head>

<body>
	<div id="editUploadPlrDiv" class="FormSection">
		<div class="greyStrip">
			<h4>
				Player Document Upload For
				<s:property value="%{userName}" />
			</h4>
		</div>
		<s:form id="uploadandSave" action="bo_pm_updateAndSave_plr_doc"
			theme="simple" method="POST" enctype="multipart/form-data">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden id="playerId" name="plrDocumentMaster.playerId"
				value="%{playerId}"></s:hidden>
			<s:set name="imagePath"
				value="%{defaultContentPath+'playerDocument/'}" />
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" style="width:99%">
					<tr>
						<th width="15%">Verification</th>
						<th width="30%">Document Type</th>
						<th width="15%">Unique Number</th>
						<th width="10%">View Image</th>
						<th width="10%">Upload Image</th>
						<th width="20%" nowrap="nowrap">Set as verified</th>
					</tr>
					<tr>
						<td width="15%"><label> Age </label>
						</td>
						<td width="30%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.ageDocType"
								list="#{'PASSPORT':'Passport','DRIVING_LICENSE':'Driving License','VOTER_ID':'Voter Id','AADHAR_CARD':'Aadhar Card','PAN_CARD':'Pan Card'}"
								id="ageDocType" headerKey="-1"
								headerValue="--Select Document Type--"
								value="%{plrDocumentMaster.ageDocType}"></s:select>
						</td>
						<td width="15%"><ss:textfield id="ageDocUniqueNo" width="95%"
								name="plrDocumentMaster.ageDocUniqueNo" theme="myTheme"
								pattern="^[a-zA-Z0-9]*$" maxlength="20"
								errorMassage="Invalid Sequence" patternOn="blur"
								action="com/stpl/pms/action/bo/pm/bo_pm_check_unique_plr_doc.action"
								ajaxParam="ageDocUniqueNo,domainId,playerId"
								value="%{plrDocumentMaster.ageDocUniqueNo}"></ss:textfield>
						</td>
						<td width="10%" style="text-align:center" id="agetd"><s:if
								test="plrDocumentMaster.ageDocPath!=null && plrDocumentMaster.ageDocPath!='' && ageVerified.trim()!='PENDING'">


								<div class="dataTbl_top" style="border-bottom:none">
									<p>
										<s:hidden name="plrDocumentMaster.ageDocPath"
											value="%{plrDocumentMaster.ageDocPath}" />
									 	<s:if
											test="%{plrDocumentMaster.ageDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')!=-1 || plrDocumentMaster.ageDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')!=-1}">
											<a id="ageview" style="cursor: pointer;" onclick="javascript: return openDocument('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.ageDocPath.split('[,]')[0]}"/>','<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.ageDocPath.split('[,]')[1]}"/>','<s:property value="#imagePath"/>','Age');">VIEW</a>
										</s:if>
										<s:else>
											<a id="ageview"
												href="#" onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.ageDocPath.split('[,]')[0]}"/>','Age');"
												>VIEW</a>
									 	</s:else>
									</p>
								</div>

							<s:else>
								--No File--
							</s:else>
							</s:if> <s:else>
									--No File--
								</s:else></td>
						<td width="10%">
							<s:if test="%{ageVerified.equals('VERIFIED')}">
								<s:file  disabled="true"></s:file>
								<s:file  disabled="true"></s:file>
							</s:if>
							<s:else>
								<s:file name="plrDocumentMaster.ageImage"
									size="8" id="ageImage"></s:file>
									<s:file name="plrDocumentMaster.ageImageBackSide"
									size="8" id="ageBackSideImage"></s:file>
							</s:else>
						</td>
						<td width="20%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.ageDocVerified"
								list="#{'-1':'Pending','UPLOADED':'Uploaded','VERIFIED':'Verified'}"
								id="ageDocVerified" value="%{ageVerified.trim()}"></s:select></td>
					</tr>
					<tr>
						<td width="15%"><label> Address </label>
						</td>
						<td width="30%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.addDocType"
								list="#{'PASSPORT':'Passport','DRIVING_LICENSE':'Driving License','VOTER_ID':'Voter Id','AADHAR_CARD':'Aadhar Card','E_BILL':'Electricity Bill','T_BILL':'Telephone Bill'}"
								id="addDocType" headerKey="-1"
								headerValue="--Select Document Type--"
								value="%{plrDocumentMaster.addDocType}"></s:select>
						</td>
						<td width="15"><ss:textfield id="addDocUniqueNo" width="95%"
								name="plrDocumentMaster.addDocUniqueNo" theme="myTheme"
								pattern="^[a-zA-Z0-9]*$" maxlength="20"
								errorMassage="Invalid Sequence" patternOn="blur"
								action="com/stpl/pms/action/bo/pm/bo_pm_check_unique_plr_doc.action"
								ajaxParam="addDocUniqueNo,domainId,playerId"
								value="%{plrDocumentMaster.addDocUniqueNo}"></ss:textfield>
						</td>
						<td width="10%" style="text-align:center" id="addtd"><s:if
								test="plrDocumentMaster.addDocPath!=null && plrDocumentMaster.addDocPath!='' && addressVerified.trim()!='PENDING'">
								<div class="dataTbl_top" style="border-bottom:none">
									<p>
										<s:hidden name="plrDocumentMaster.addDocPath"
											value="%{plrDocumentMaster.addDocPath}" />
										<s:if
											test="%{plrDocumentMaster.addDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')!=-1 || plrDocumentMaster.addDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')!=-1}">
											<a id="addview" style="cursor: pointer;" onclick="javascript: return openDocument('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.addDocPath.split('[,]')[0]}"/>','<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.addDocPath.split('[,]')[1]}"/>','<s:property value="#imagePath"/>','Add');">VIEW</a>
										</s:if>
										<s:else>
										<a id="addview"
												href="#" onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.addDocPath.split('[,]')[0]}"/>','Add');"
												>VIEW</a>
										</s:else>
										
									</p>
								</div>
							</s:if> <s:else>
								--No File--
								</s:else>
						</td>
						<td width="10%">
							<s:if test="%{addressVerified.equals('VERIFIED')}">
								<s:file  disabled="true"></s:file>
								<s:file  disabled="true"></s:file>
							</s:if>
							<s:else>
								<s:file name="plrDocumentMaster.addImage"
								size="8" id="addImage"></s:file>
								<s:file name="plrDocumentMaster.addImageBackSide"
								size="8" id="addBackSideImage"></s:file>
							</s:else>
						</td>
						<td width="20%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.addDocVerified"
								list="#{'-1':'Pending','UPLOADED':'Uploaded','VERIFIED':'Verified'}"
								id="addDocVerified" value="%{addressVerified.trim()}"></s:select>
						</td>
					</tr>
					<tr>
						<td width="15%"><label> Tax Id </label>
						</td>
						<td width="30%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.taxIdDocType"
								list="#{'PASSPORT':'Passport','DRIVING_LICENSE':'Driving License','PAN_CARD':'Pan Card'}"
								id="taxIdDocType" headerKey="-1"
								headerValue="--Select Document Type--"
								value="%{plrDocumentMaster.taxIdDocType}"></s:select>
						</td>
						<td width="15"><ss:textfield id="taxIdDocUniqueNo"
								name="plrDocumentMaster.taxIdDocUniqueNo" theme="myTheme"
								width="95%" pattern="^[a-zA-Z0-9]*$" maxlength="20"
								errorMassage="Invalid Sequence" patternOn="blur"
								action="com/stpl/pms/action/bo/pm/bo_pm_check_unique_plr_doc.action"
								ajaxParam="taxIdDocUniqueNo,domainId,playerId"
								value="%{plrDocumentMaster.taxIdDocUniqueNo}"></ss:textfield>
						</td>
						<td width="10%" style="text-align:center" id="taxtd"><s:if
								test="plrDocumentMaster.taxIdDocPath!=null && plrDocumentMaster.taxIdDocPath!='' && taxationIdVerified.trim()!='PENDING'">
								<div class="dataTbl_top" style="border-bottom:none">
									<p>
										<s:hidden name="plrDocumentMaster.taxIdDocPath"
											value="%{plrDocumentMaster.taxIdDocPath}" />
										<s:if
											test="%{plrDocumentMaster.taxIdDocPath.split('[.]')[1].toLowerCase()=='pdf'}">
											<a id="taxIdView" style="cursor: pointer;"
												onclick="window.open('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.taxIdDocPath}"/>','')";>VIEW
											</a>
										</s:if>
										<s:else>
											<a id="taxIdView"
												href="#" onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.taxIdDocPath}"/>','Txn');">VIEW</a>
										</s:else>
									</p>
								</div>
							</s:if> <s:else>
								--No File--
								</s:else>
						</td>
						<td width="10%">
							<s:if test="%{taxationIdVerified.equals('VERIFIED')}">
									<s:file  disabled="true"></s:file>
							</s:if>
							<s:else>
								<s:file name="plrDocumentMaster.taxIdImage"
											id="taxIdImage" size="8" ></s:file>
							</s:else>
						</td>
						<td width="20%"><s:select theme="myTheme" cssClass="select1"
								style="width:98%" name="plrDocumentMaster.taxIdDocVerified"
								list="#{'-1':'Pending','UPLOADED':'Uploaded','VERIFIED':'Verified'}"
								id="taxIdDocVerified" value="%{taxationIdVerified.trim()}"></s:select>
						</td>
					</tr>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:submit id="uploadId" name="Upload" value="Upload"
					cssClass="button"></s:submit>
			</div>
		</s:form>
	</div>
	<div id="imageDisplayTxnDiv" style="display:none;" rel="facebox" style="text-decoration: none">
				<img height="500px" width="800px" id="imageShowTxn">
	</div>
	<div id="imageDisplayAgeDiv" style="display:none;" rel="facebox" style="text-decoration: none">
			<s:if test="plrDocumentMaster.ageDocPath.split('[,]')[1]!=null && plrDocumentMaster.ageDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')==-1 && plrDocumentMaster.ageDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')==-1 ">
				<a class="preImage"  href="#" onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.ageDocPath.split('[,]')[0]}"/>','Age');">&#10094;</a>
			</s:if>	
				<img height="500px" width="800px" id="imageShowAge">
			<s:if test="plrDocumentMaster.ageDocPath.split('[,]')[1]!=null && plrDocumentMaster.ageDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')==-1 && plrDocumentMaster.ageDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')==-1 ">		
				<a class="nextImage"  onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.ageDocPath.split('[,]')[1]}"/>','Age');">&#10095;</a>
				
			</s:if>	 
	</div>
	<div id="imageDisplayAddDiv" style="display:none;" rel="facebox" style="text-decoration: none">
			<s:if test="plrDocumentMaster.addDocPath.split('[,]')[1]!=null && plrDocumentMaster.addDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')==-1 && plrDocumentMaster.addDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')==-1 ">
				<a class="preImage" href="#" onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.addDocPath.split('[,]')[0]}"/>','Add');">&#10094;</a>
			</s:if>	
				<img height="500px" width="800px" id="imageShowAdd">
			<s:if test="plrDocumentMaster.addDocPath.split('[,]')[1]!=null && plrDocumentMaster.addDocPath.split('[,]')[1].toLowerCase().indexOf('.pdf')==-1  && plrDocumentMaster.addDocPath.split('[,]')[0].toLowerCase().indexOf('.pdf')==-1 ">		
				<a class="nextImage"  onclick="javascript: return openImage('<s:property value="#imagePath"/><s:property value="%{plrDocumentMaster.addDocPath.split('[,]')[1]}"/>','Add');">&#10095;</a>
				
			</s:if>	 
	</div>
				
		
</body>
</html>
