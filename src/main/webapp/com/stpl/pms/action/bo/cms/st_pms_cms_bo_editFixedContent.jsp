<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Edit Fixed Pages</title>
    <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
	<script src="js/facebox.js" type="text/javascript"></script>
	<script src="com/stpl/pms/action/bo/cms/js/cms.js" type="text/javascript"></script>
	<script src="js/tiny_mce/tiny_mce_src.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
	$(document).ready(function(){
		$('#domainId').change(function(){
			$("#pageName").prop('selectedIndex', 0);
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  		$.each(aliasMap,function(index, value) {
	  			$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
	  	});	
	  	  
  	$('#aliasId').change(function(){
	  		$("#pageName").prop('selectedIndex', 0);
	  		var jsonList = '["languageList"]';
	  		var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+$('#domainId').val()+"&jsonList="+jsonList,"");
	  		$('#language').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		$.each(map["languageList"], function(index, value) {
	  			$('#language').append($('<option></option>').val(value.languageId).html(value.languageName));
	  		});
	  	});
	 			
	 	$("#language").change(function(){
	 		$("#pageName").prop('selectedIndex', 0);
	 	});		
	 			
	    $("#device").change(function(){
			var value=$(this).val();
			/*if(value=="MOBILE" || value=="TAB")
				$("#Preview").hide();
			else
				$("#Preview").show();*/
		    var fixedPageJson = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_cms_fetchPageName.action?device="+$(this).val()+"&aliasId="+$("#aliasId").val(),"");
	  	 	fixedPageJson = $.parseJSON(fixedPageJson);
	  	 	$('#pageName').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			/* $.each(fixedPageJson, function(i, value) {
				$("#pageName").append($('<option contentPath="'+value[1]+'" pageType="'+value[3]+'"></option>').val(i).html(value[0]));
			}); */
			if($(this).val() == 'PC' || $(this).val() == 'TAB') {
				$('#pageName').append($('<option></option>').val("SMS").html("SMS TEMPLATE"));
			//	$('#pageName').append($('<option></option>').val("EMAIL").html("EMAIL TEMPLATE"));
			}
	    });
	    
	    
	    
	});
	
	function getDetails(){
		if($("#domainId").val()=="-1" || $("#aliasId").val()=="-1" || $("#language").val()=="-1" || $("#device").val()=="-1"){
			return false;
		}
		
		$("#detailDiv").html("");
		$("#contentDiv").html("");
	   	if($("#pageName").val().indexOf("SMS")!="-1" || $("#pageName").val().indexOf("EMAIL")!="-1"){
	   		var isSmsTemp= ($("#pageName").val().indexOf("SMS")!="-1");
	   		var templateMapJson = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchFixedTempletes.action?aliasId='+$("#aliasId").val()+'&templateMod='+$("#pageName").val(),'');
	   		templateMapJson = $.parseJSON(templateMapJson);
	   		$("#pageType").val($("#pageName").val());
	   		$("#detailDiv").append('<div class="clearFRM"></div> <div class="FormMainBox"><div class="labelDiv">\
	   								<label> Template Subject: </label><em class="Req">*</em></div><div class="InputDiv">\
	           						<select id="templateType" class="select1" applyscript="true" name="templateType"  ajaxAction="com/stpl/pms/action/bo/cms/st_pms_cms_fetchFixedContent.action" ajaxParam="aliasId,pageType,device,language,templateType" target="contentDiv" >\
									</select></div>\</div>'); 
		    $('#templateType').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			$.each(templateMapJson, function(i, value) {
				if(isSmsTemp){
					$("#templateType").append($('<option></option>').val(value[2]).html(value[0]));
				} else{
					$("#templateType").append($('<option></option>').val(value[1]).html(value[0]));
				}
			});      
        } else {
			var id= $("#pageName").val();
         	$("#contentPath").val($("#pageName").find('option:selected').attr('contentPath'));
          	$("#pageType").val($("#pageName").find('option:selected').attr('pageType'));
         	_ajaxCallDiv('com/stpl/pms/action/bo/cms/st_pms_cms_fetchFixedContent.action?aliasId='+$("#aliasId").val()+'&pageType='+$("#pageType").val()+'&device='+$("#device").val()+'&contentPath='+$("#contentPath").val()+'&language='+$("#language").val(),'','contentDiv');
	  	}
	  	createBubble();
	}  
	
	function getLinkType(){
	var value = $("#linkContentType").val();
	$('#linkType').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	
	$("#linkType").append(
			$('<option></option>').val("WINDOW").html(
					"Window"));
	$("#linkType").append(
			$('<option></option>').val("POPUP").html(
					"Pop Up"));
	$("#linksDiv").html("");
}

function getLinks() {
	var value = $("#linkContentType").val();
	var linkType = $("#linkType").val();
	var pageLinkList = $.parseJSON($("#pageLinkList").val());
	$("#linksDiv").html("");
	var str ='';
	var popupStr ='';
	if(value!="-1" && linkType!="-1"){
		if(linkType=="POPUP"){
			str = 'rel=\'widget_facebox\'';
			popupStr = '?isPopup=facebox';
		}
	for ( var i = 0; i < pageLinkList.length; i++) {
		if (pageLinkList[i].contentType == value)
			$("#linksDiv")
					.append(
							'<div style="float: left;"><a  title="'+pageLinkList[i].description+'" href="#" onclick="insertLinks(this); close_facebox(); return false;" value="<a '+str+' href=/'
									+ pageLinkList[i].url
									+popupStr
									+ '\>'
									+ pageLinkList[i].contentName
									+ '</a>" >'
									+ pageLinkList[i].contentName
									+ '</a> </div><br/>');

		}
	}
}

	
	</SCRIPT>
  </head>
	<body>
	
		<s:form name="editFooter" id="editFooter" theme="simple"
			action="st_pms_cms_saveFixedContent" enctype="multipart/form-data">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<%-- <s:hidden name="fixedPageJson" id="fixedPageJson"></s:hidden> --%>
			<s:hidden name="contentPath" id="contentPath"></s:hidden>
			<s:hidden name="pageType" id="pageType"></s:hidden>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Edit Fixed Content
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select theme="myTheme" cssClass="select1"
									list="%{domainMap}" name="domainId" id="domainId"
									headerKey="-1" headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true"></ss:select>
							</s:else>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Alias Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1"
									list="%{}" name="aliasId" id="aliasId"
									headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Language:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1"
									list="%{languageBeanList}" listKey="languageId"
									listValue="languageName" name="language" id="language"
									headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
							</div>
							<div id="error" class="fieldError">
								<s:fielderror>
									<s:param>language</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

				<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Device:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1"
									list="{'PC','TAB','MOBILE'}"
									name="device" id="device" headerKey="-1" applyscript="true" 
									headerValue="--Please Select--"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Page Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="{}" name="pageName" id="pageName" headerKey="-1"
								headerValue="--Please Select--" onchange="getDetails()"></ss:select>
						</div>
					</div>
					<div id="detailDiv"></div>
					<div id="contentDiv"></div>
				</div>


				<div class="box_footer" align="right">
					<input id="saveContent" name="saveContent" class="button"
						type="submit" value="Submit"
						onclick="if(checkFormCreatePage()){ prepareVariableContent() }else{ return false}">
					<%--<input id="Preview" name="saveContent" class="button" type="button"
						value="Preview"
						onclick="if(checkFormCreatePage()){ getPreview('editFooter') }else{ return false}">
			--%>
				</div>
			</div>
		</s:form>
	</body>
</html>
