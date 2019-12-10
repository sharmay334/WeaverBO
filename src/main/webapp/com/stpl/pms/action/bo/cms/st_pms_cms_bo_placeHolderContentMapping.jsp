<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%-- <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> --%>

<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
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
<script src="com/stpl/pms/action/bo/cms/js/cms.js"
	type="text/javascript"></script>
	<script src="js/facebox.js" type="text/javascript"></script>
	<link href="css/facebox.css" media="screen" rel="stylesheet"
	type="text/css" />
<SCRIPT type="text/javascript">
	$(document).ready(function() {
		$('#domainId').change(function(){
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			if($(this).val()!=-1) {
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		}	
	  		$("#menuDiv").attr('style','display: none');
	  		$("#menuTitleDiv").attr('style','display: none');
	  		$("#joomlaPageTypeDiv").hide();
	  		$("#joomlaDeviceDiv").hide();
	  		$("[id*='_bubbleTable']").hide();
	  		$("#phDetailsDiv").text('');
	  	});
		
		$("#aliasId").change(function(){
			if($(this).val()!=-1) {
				var valueMap = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_cms_getAliasTypeData.action?aliasId="+$('#aliasId').val()+"&domainId="+$("#domainId").val(),"");
				
				if(typeof valueMap!="undefined" && valueMap=="JOOMLA") {
					$("#portalType").val(valueMap);
					$("#joomlaPageTypeDiv").show();
					$("#menuTitleDiv").hide();
					$("#menuDiv").hide();
				} else {
					$("#portalType").val("");
					$("#joomlaPageTypeDiv").hide();
					$("#menuDiv").attr("style","display: block");
					$("#menuTitleDiv").attr("style","display:none");
					$('#language').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(valueMap, function(index, value) {
						$('#language').append($('<option></option>').val(value.languageId).html(value.languageName));
					});
					$('form').attr("action","/WeaverBO/com/stpl/pms/action/bo/cms/st_pms_submitPlaceHolder.action");
					$("#pageName, #pageType, #language, #device").each(function(){
						//$(this).attr("required",true);
						$(this).attr("applyscript",true);
					});
					//$("#menuId").removeAttr("required");
					$("#menuId").removeAttr("applyscript");
					$("#joomlaPageType").removeAttr("applyscript");
					$("#joomlaDevice").removeAttr("applyscript");
				}
			}	
			$("[id*='_bubbleTable']").hide();
			$("#phDetailsDiv").text('');
			$("#joomlaDeviceDiv").hide();
		});
		
		$("#joomlaPageType").change(function(){
			if($(this).val()!=-1) {
			 
			  $("#pageName, #pageType, #language, #device").each(function(){
						$(this).removeAttr("applyscript");
				});
			  if($(this).val()=="WEB"){	
			  		$("#joomlaDeviceDiv").hide();	
			  		$("#menuTitleDiv").show();
			  		$("#joomlaDevice").removeAttr("applyscript");
			  		$("#menuLabel").text("Menu Title :");
					var valueMap = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_cms_getContentDeatil.action?aliasId="+$('#aliasId').val()+"&domainId="+$("#domainId").val()+"&pageType="+$("#joomlaPageType").val(),"");
					
					if(valueMap!=null){
						var value = valueMap["contentUrl"];
							if(typeof value!="undefined") {													
								$('#menuId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					 	 		$.each(valueMap["menus"], function(index, value) {
					 	 				$('#menuId').append($('<option></option>').val(value.id).html(value.title));
								});
								$("#joomlaContent").val(JSON.stringify(valueMap));
								
								//$("#menuId").attr("required",true);
								$("#menuId").attr("applyscript",true);
								$('form').attr("action","/WeaverBO/com/stpl/pms/action/bo/cms/st_pms_submitPhMapping.action");
							}
					   }
				}else{
					$('form').attr("action","/WeaverBO/com/stpl/pms/action/bo/cms/st_pms_submitPlaceHolder.action");
					$("#menuTitleDiv").hide();
					$("#joomlaDeviceDiv").show();
					$("#joomlaDevice").attr("applyscript",true);
					//getPhPages();
				}
			}else{
				$('#menuId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				$("#menuTitleDiv").hide();
			}
			$("[id*='_bubbleTable']").hide();
			$("#phDetailsDiv").text('');
		});
		
		
		
		$("#menuId").change(function(){
			var val  =  $("#menuId").val();
				if(val!=-1) {
					if($("#joomlaPageType").val()=="WEB"){			
				
						var joomlaContent  = encodeURIComponent($("#joomlaContent").val());
						_ajaxCallDiv(
						'com/stpl/pms/action/bo/cms/st_pms_getPlrContentMapping.action?', 'aliasId='+$('#aliasId').val()+'&menuId='+val+'&joomlaContent='+joomlaContent,
						'phDetailsDiv');
					}
					else{
						getPhDetail(val);
					}
				}else{
					$("#phDetailsDiv").text('');
				}	
		});
		
		$("#phForm").submit(function(e){
			$('Select').removeAttr("disabled");
			if($("#portalType").val()== "JOOMLA" && $("#joomlaPageType").val()=="EXTERNAL_LOBBY")
					$("#pageType").val($("#joomlaPageType").val());
					
			if($("[id*='moduleId_']").length>0) {
				$("[id*='moduleId_']").each(function(){
					var moduleId = $(this).attr("id");
					if(moduleId.indexOf("bubbleTable")==-1 && moduleId.indexOf("errorDiv")==-1)
						var count = moduleId.split('_')[1];
						var id  = "#moduleTitle_"+count;
						$(id).val($(this).find('option:selected').text());
				});
			}
		});
	});
	
	$(document).on('click','#addMore',function(){
		$("#groupId").val(parseInt($("#groupId").val())+1);
		var count = $("#count").val();
		$($(".copyDiv").find(".innerBox:first")).clone().appendTo( ".copyDiv" );
		$(".copyDiv").find(".payTransaction:last").find("tr").each(function() {
			if($(this).find(".groupId").attr("class")=="groupId"){
				setUpdatedVale(this, count, $("#groupId").val());
				count++;
			}else{
				if($(this).find(".dateField").length!=0){
					addDateField($(this));		
				}		
				
			}
			
		}); 
		$("#count").val(count);
		createBubble();
	});
	
	$(document).on("click","#spCritBtn,#addMoreCrit", function(){
		$("#groupId").val(parseInt($("#groupId").val())+1);
		var count = $("#count").val();
		//if($("#spCritBtn").length>0) {
			$("#spCriteria").attr('style','display: block');
			$($(".copyDiv").find(".innerBox:first")).clone().appendTo( ".critDiv" );
			$(".critDiv").find(".payTransaction:last").find('tr').each(function(){
				$(this).find('th').eq(3).after('<th>Specific Criteria</th>');
				if($(this).find('td').eq(3).length>0) {
       				$(this).find('td').eq(3).after('<td><select id ="phCritSelect_'+count+'" name="phCtBean['+count+'].phCriteriaId" class="select1 phCritSelect" style="width:180px;" applyscript="true"> <option value="-1">----Please Select----</option></select> </td>');
       		 		var phJson = $.parseJSON($('#phCrit').val());
       		 		$.each(phJson, function(index, value) {
						$('#phCritSelect_'+count).append($('<option></option>').val(index).html(value));
					});
					setUpdatedVale(this, count, $("#groupId").val());
					count++;
				}else{
					if($(this).find(".dateField").length!=0){
						addDateField($(this));		
					}	
				}	
			});
			if($(this).attr("id")=="spCritBtn")	 	
				$(this).remove();
		/* } else {
			$($(".critDiv").find(".innerBox:last")).clone().appendTo( ".critDiv" );
   			$(".critDiv").find(".payTransaction:last").find('tr').each(function(){
   				if($(this).find('td').eq(3).length>0) {
   					setUpdatedVale(this, count, $("#groupId").val());
   					$(this).find(".phCritSelect").attr("id",$(this).find(".phCritSelect").attr("id").split('_')[0]+"_"+count);
					$(this).find(".phCritSelect").attr("name","phCtBean["+count+"].phCriteriaId");
					$(this).find(".phCritSelect").val(-1);
					count++;
				}	
			});	
   		} */
		$("#count").val(count);
		createBubble();
	});


	function addDateField(obj){		

			obj.find('input[id*="reset_"]').attr("id",obj.find('input[id*="reset_"]').attr("id").split('_')[0]+"_"+$("#groupId").val());

			obj.find('input[id*="reset_"]').bind("click", function(){
				var groupId=$(this).attr("id").split("_")[1];
				$("#startDate_"+groupId).val("");
				$("#endDate_"+groupId).val("");	
				$(".startDate"+groupId).val("");
				$(".endDate"+groupId).val("");
			
			});
		
			obj.find('input[id*="startDate_"]').val("");
			obj.find('input[id*="startDate_"]').attr("id",obj.find('input[id*="startDate_"]').attr("id").split('_')[0]+"_"+$("#groupId").val());			
			obj.find('input[id*="startDate_"]').removeClass("hasDatepicker");
			obj.find('input[id*="startDate_"]').datetimepicker(
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


			


			obj.find('input[id*="endDate_"]').val("");
			obj.find('input[id*="endDate_"]').attr("id",obj.find('input[id*="endDate_"]').attr("id").split('_')[0]+"_"+$("#groupId").val());
			obj.find('input[id*="endDate_"]').removeClass("hasDatepicker");
			obj.find('input[id*="endDate_"]').datetimepicker(
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
		
	}
	
		
	function setUpdatedVale(id, count, groupId){
		$(id).find(".groupId").attr("name","phCtBean["+count+"].groupId");
		$(id).find(".phId").attr("name","phCtBean["+count+"].phId");
		$(id).find(".contentId").attr("name","phCtBean["+count+"].ctIdWithValue");
		$(id).find(".redirectId").attr("name","phCtBean["+count+"].redirectUrl");
		$(id).find(".groupId").val(groupId);
		$(id).find(".contentId").val(-1);
		$(id).find(".mappStatus").removeAttr("disabled");
		$(id).find(".mappStatus").attr("name","phCtBean["+count+"].mappingStatus"); 
		$(id).find(".mappStatus").val(-1);
		$(id).find(".redirectId").val(-1);
		$(id).find(".contentId").attr("id",$(id).find(".contentId").attr("id").split('_')[0]+"_"+count);
		$(id).find(".redirectId").attr("id",$(id).find(".redirectId").attr("id").split('_')[0]+"_"+count);
		$(id).find(".mappStatus").attr("id",$(id).find(".mappStatus").attr("id").split('_')[0]+"_"+count);
		$(id).find(".preview").attr("id",$(id).find(".preview").attr("id").split('_')[0]+"_"+count);
		$(id).find(".endDate").attr("name","phCtBean["+count+"].endDate");
		$(id).find(".startDate").attr("name","phCtBean["+count+"].startDate"); 
		$(id).find(".startDate").attr("id",$(id).find(".startDate").attr("id").split('_')[0]+"_"+count);
		$(id).find(".endDate").attr("id",$(id).find(".endDate").attr("id").split('_')[0]+"_"+count);
		$(id).find(".endDate").val("");
		$(id).find(".startDate").val("");
		var startDateObj=$(id).find(".startDate");
		$(id).find(".startDate").removeClass();
		startDateObj.addClass("startDate");
		startDateObj.addClass("startDate"+groupId);
		var endDateObj=$(id).find(".endDate");
		$(id).find(".endDate").removeClass();
		endDateObj.addClass("endDate");
		endDateObj.addClass("endDate"+groupId);
		
			$("#preview_"+count).text("No Content Preview");
		if($("#joomlaDevice").val()=="PC")	
			$(id).find("a").remove();	
			
		
	}
	
	$(document).on("click","[id*='spCrit_']", function(){
		var table = $(this).parent().parent(".FormSection").find('table');
		$(table).find('tr:last').after(
			$(table).find('tr:last').clone());
		var count = $("#count").val();
		updatevalues($(table).find('tr:last'), count );
		$("#count").val(++count);
		createBubble();
	});

		
	function updatevalues(id, count ) {
		$(id).find(".position").attr("name","critBean["+count+"].position");
		$(id).find(".critId").attr("name","critBean["+count+"].id");
		$(id).find(".critId").attr("value","0");
		$(id).find(".moduleId").attr("name","critBean["+count+"].moduleId");
		$(id).find(".moduleId").attr("id",$(id).find(".moduleId").attr("id").split('_')[0]+"_"+count);
		$(id).find(".phCritSelect").attr("name","critBean["+count+"].phCritId"); 
		$(id).find(".mappStatus").attr("name","critBean["+count+"].status");
		$(id).find(".moduleTitle").attr("name","critBean["+count+"].moduleTitle");
		$(id).find(".moduleTitle").attr("id",$(id).find(".moduleTitle").attr("id").split('_')[0]+"_"+count);
		$(id).find(".phCritSelect").val(-1);
		$(id).find(".moduleId").val(-1);
		$(id).find(".mappStatus").val(-1);
	}
	
	$(document).on("change","[id*='contentDetail_']", function(){
		var count=$(this).attr('id').split("_")[1];
		if($(this).val()!=-1){
			$("#preview_"+count).html("<a href='#' onclick='javascript: return openImage(\""+($(this).val().split("#")[1])+"\") ;'> Preview </a> " );
			
		}else{
			
			$("#preview_"+count).empty();
			$("#preview_"+count).text("No Content Preview");
		}
		
	});
	
	
	$(document).on("change","[id*='redirectUrl_']", function(){
		if($("#joomlaDevice").val()=="PC"){ 
			if($(this).val()!=-1){
				$(this).next().remove();
				$('<a href="#" onclick="javascript: window.open(\'https://'+$('#aliasId option:selected').text()+'/'+$(this).val()+'\'); return false;" ><img src="<%=basePath%>/images/exit-top-right.png" alt="logo" style="vertical-align: middle; margin-left: 10px; width: 13px; height: 13px;   margin-top: -3px;"></a>').insertAfter(this);			
			}else{			
				$(this).next().remove();
			}
		}
	});
	
	$(document).on("change","#joomlaDevice", function(ele){

		var device = this.value;
		if(device === "TAB" || device === "MOBILE"){
			    //$("#joomlaDeviceOSDiv").show();
			}else{
				//$("#joomlaDeviceOSDiv").hide();
				$("#joomlaDeviceOS").val("");
			}
	});
	
	function openImage(imagePath){
		
		imagePath=imagePath+"?temp="+(new Date().getTime());
		$("#imageShow").attr("src",imagePath);
		jQuery.facebox({ div: '#imageDisplayDiv' });
		return false;
	}
		
	 </SCRIPT>
</head>
<body>
	<s:form name="phForm" theme="simple" action="st_pms_submitPlaceHolder"
		id="phForm">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<s:hidden name="joomlaContent" id="joomlaContent"></s:hidden>
		<s:hidden name="portalType" id="portalType"></s:hidden>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>PlaceHolder-Content Mapping</h4>
			</div>
			<div class="innerBox">
				<s:hidden id="contentType" name="contentType"></s:hidden>
				<s:hidden id="phDetails"></s:hidden>
				<s:hidden id="pagePath"></s:hidden>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1}">
							<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="%{domainMap}" name="domainId" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" />
						</s:else>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" applyscript="true"
							list="%{}" name="aliasId" id="aliasId" headerKey="-1"
							headerValue="--Please Select--" />
					</div>
				</div>
				<div id="menuDiv" style="display: none;">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Page Type: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="#{'HOME_PAGE':'HOME_PAGE','STATIC_PAGE':'Static', 'DYNAMIC':'Dynamic','EXTERNAL_LOBBY':'Client'}"
								name="pageType" id="pageType" headerKey="-1"
								headerValue="--Please Select--" onchange="return getPhPages()" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Language: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1"
									list="%{languageBeanList}" listKey="languageId"
									listValue="languageName" name="language" id="language"
									headerKey="-1" headerValue="--Please Select--" applyscript="true"
									onchange="return getPhPages()"></ss:select>
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
							<label> Device: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1"
								list="{'PC','TAB','MOBILE'}" name="device" id="device"
								headerKey="-1" applyscript="true" onchange="return getPhPages()"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Page Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select onchange="return getPhDetail(this.value)"
								applyscript="true" headerKey="-1" headerValue="-- Please Select --"
								cssClass="select1" name="urlId" id="pageName" list="{}"
								theme="myTheme" ></s:select>
						</div>
					</div>
				</div>
				<div id="joomlaPageTypeDiv" style="display: none;">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Page Type: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="#{'WEB':'Web','EXTERNAL_LOBBY':'Client'}"
								name="joomlaPageType" id="joomlaPageType" headerKey="-1"
								headerValue="--Please Select--"/>
						</div>
					</div>
				</div>
				<div id="joomlaDeviceDiv" style="display: none;">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Device: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="{'PC','MOBILE','TAB','Android Cash','Android Lite','IOS'}" onchange="return getPhPages()"
								name="joomlaDevice" id="joomlaDevice" headerKey="-1"
								headerValue="--Please Select--"/>
						</div>
					</div>
				</div>
				<div id="menuTitleDiv" style="display: none;">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label id="menuLabel"> Menu Title: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" list="%{}"
								name="menuId" id="menuId" headerKey="-1"
								headerValue="--Please Select--" applyscript="true"></ss:select>
						</div>
					</div>
				</div>								
			</div>
		</div>
		<div id="phDetailsDiv"></div>
	</s:form>
</body>
</html>
