function setupLink(obj,actionName,param){
		obj.focus();
		editor = obj;
		$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/"+actionName+".action?"+param);
		$("#TinyMCEwidgetLink").click();
}
	
function prepareContent() {
	    var formStr;
		var fieldsBeanList = $.parseJSON($("#fieldsBeanList").val());
		var ele = $($("textarea[id='content']").next()).find(
							"#" + $("textarea[id='content']").attr("id") + "_ifr");
		var requestHTML = $(ele).contents().find(
							"body#tinymce.mceContentBody").html()
							.replace(/<br data-mce-bogus="1">/g, "");
							
		    var widgetName= $("#widgetName").val();
			var matchedStringArray = requestHTML
						.match(/{(.*?)}/gi);
			var redirectUrl = $("#redirectUrl").val();
			if($("#widgetType").val()!="LOGIN_WIDGET"){
				requestHTML = ' s:hidden name="status" value="MINI" /s:hidden>'+requestHTML;
			}
			if(redirectUrl!="-1"){
				requestHTML = ' s:hidden name="redirectUrl" value="'+redirectUrl+'" /s:hidden> '+requestHTML;
			}
			
			if (matchedStringArray != null) {
				for ( var i = 0; i < matchedStringArray.length; i++) {
					var field = matchedStringArray[i].replace("{","").replace("}","");
					var arr = field.split(':');
					var titel = arr[0].trim();
					var fieldName = arr[1].trim();
					var str = "";
					if (fieldsBeanList != null) {
						for ( var j = 0; j < fieldsBeanList.length; j++) {
							if (fieldName == fieldsBeanList[j].fieldName) {
							 	if(fieldsBeanList[j].fieldInputType=="Text"){
							 		if($("#widgetType").val()!="LOGIN_WIDGET"){
							 			str = 'pattern="'+fieldsBeanList[j].validationExp+'" isUnique="'+fieldsBeanList[j].isUnique+'"';
							 		}
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:textfield name="'+fieldName+'" id="'+fieldName+"_"+widgetName+'" '+str+' placeholder="'+titel+'" theme="simple" /s:textfield>');
							 	}else if(fieldsBeanList[j].fieldInputType=="Password"){
							 		if($("#widgetType").val()!="LOGIN_WIDGET"){
							 			str = 'pattern="'+fieldsBeanList[j].validationExp+'"';
							 		}
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:password name="'+fieldName+'" id="'+fieldName+"_"+widgetName+'" '+str+' placeholder="'+titel+'" theme="simple" /s:password>');
							 	}else if(fieldsBeanList[j].fieldInputType=="Select"){
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:select name="'+fieldName+'" id="'+fieldName+"_"+widgetName+'" list="{}" headerKey="-1" headerValue="'+titel+'" theme="simple"  /s:select>');
							 	}else if(fieldsBeanList[j].fieldInputType=="Radio"){
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:radio name="'+fieldName+'" id="'+fieldName+"_"+widgetName+'" list="{}" theme="simple" /s:radio>');
							 	}else if(fieldsBeanList[j].fieldInputType=="Checkbox"){
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:checkbox name="'+fieldName+'" id="'+fieldName+"_"+widgetName+'" theme="simple" /s:checkbox>');
							 	}else if(fieldsBeanList[j].fieldInputType=="Button"){
							 		requestHTML = requestHTML.replace(matchedStringArray[i],' s:submit id="'+fieldName+"_"+widgetName+'" value="'+titel+'" theme="simple" /s:submit> ');
							 	}
							}
	
						}
					 }
				}
			}
			requestHTML = encodeURI(requestHTML);
			requestHTML = requestHTML.replace(/\+/g, '%2B');
			$("#widgetContent").val(requestHTML);
}

function hideValidationStyle(){
	/*if($("#domainId").val()!="-1" && $("#aliasId").val()!="-1"){
		$("#buttonDiv").css("display","block");
	}else{
		$("#buttonDiv").css("display","none");
	}*/
	$("#buttonDiv").css("display","block");
	if($('#device').val()=='MOBILE'){
		$('#validstyle').css('display','none');
		$("#validationStyle").val('downValidate');
	}
	else{
		$('#validstyle').css('display','block');
		//$("#validationStyle").val( '-1');
	}
}



//function getWidgerEditor(){
//	 var cssMap = $.parseJSON($("#specificCssMap").val());
//	 var specificCss = $("#specificCssId").val();
//	 var specificCssPath;
//	 if(specificCss!="0"){
//		 specificCssPath = "&specificCssPath="+(cssMap[specificCss]).cssPath;
//	 }
//	_ajaxCallDiv("com/stpl/pms/action/bo/cms/st_pms_page_getWidgeteditor.action?domainId="+$("#domainId").val()+"&widgetType="+$("#widgetType").val()+"&isCommonCSS="+$('input[name="isCommonCSS"]:checked').val()+"&isCustomCSS="+$('input[name="isCustomCSS"]:checked').val()+specificCssPath,"","editorDiv");
//	$("#buttonDiv").html('<input type="submit" id="submitBtn" value="Submit">');
//	
//}

function getWidgetName(){
	$('#widgetName').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	if($("#widgetType").val()!="-1" && $("#domainId").val()!="-1" && $("#aliasId").val()!="-1" && $("#device").val()!="-1"){
		$("#contentDiv").html('');
		$("#buttonDiv").css("display","none");
		var widgetList = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_page_getWidgets.action?aliasId="+$("#aliasId").val()+"&widgetType="+$("#widgetType").val()+"&device="+$("#device").val(),"");
		var widgetListJson =  $.parseJSON(widgetList);
		$.each(widgetListJson, function(i, value) {
			$("#widgetName").append(
					$('<option></option>').val(value.widgetName).html(
							value.widgetName));
		});
		$("#widgetList").val(widgetList);
	}
	
}
function getWidgetContent(){
	if($("#widgetName").val()!="-1"){
		var widgetList = $("#widgetList").val();
		var widgetListJson =  $.parseJSON(widgetList);
		var editorCss="";
		var specificCss="";
		$.each(widgetListJson, function(i, value) {
			if(value.widgetName == $("#widgetName").val()){
				$("#widgetId").val(value.widgetId);
				if("Y"==value.commonCss){
					editorCss = $("#defaultContentPath").val()+"css/default/pc/LR/common.css,";
				}
				if("Y"==value.customCss){
					editorCss = editorCss+$("#defaultContentPath").val()+$("#domainId option:selected").text()+"/"+$("#aliasId option:selected").text()+"/default/pc/LR/css/custom.css,";
				}
				if(value.specificCss!=null){
					specificCss="&specificCssId="+value.specificCss;
				}
				_ajaxCallDiv("com/stpl/pms/action/bo/cms/st_pms_page_getWidgetContent.action?aliasId="+$("#aliasId").val()+"&widgetType="+$("#widgetType").val()+"&widgetName="+$("#widgetName").val()+"&device="+$("#device").val()+"&isCommonCSS="+value.commonCss+"&isCustomCSS="+value.customCss+specificCss+"&editorCss="+editorCss,"","contentDiv");
				return false;
			}
		});
	}
	hideValidationStyle();
	createBubble();
}


function getLinkType(){
	var value = $("#linkContentType").val();
	$('#linkType').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	
	if(value=="STATIC_PAGE"){
		$("#linkType").append(
				$('<option></option>').val("WINDOW").html(
						"Window"));
		$("#linkType").append(
				$('<option></option>').val("POPUP").html(
						"Pop Up"));
	}else{
		$("#linkType").append(
				$('<option></option>').val("POPUP").html(
						"Pop Up"));
		$("#linkType").append(
				$('<option></option>').val("WIDGET").html(
						"Widget"));
	}
	$("#linksDiv").html("");
}
function getPageLinks() {
	var value = $("#linkContentType").val();
	var linkType = $("#linkType").val();
	var pageLinkList = $.parseJSON($("#pageLinkList").val());
	$("#linksDiv").html("");
	var str ='';
	if(value!="-1" && linkType!="-1"){
		if(linkType=="POPUP"){
			str = 'rel=\'widget_facebox\'';
		}else if(linkType=="WIDGET"){
			str = 'onclick=\'replaceWidgetContent(this);return false;\' id=\''+$("#widgetName").val()+'\'';
		}
		for ( var i = 0; i < pageLinkList.length; i++) {
			if (pageLinkList[i].contentType == value)
				$("#linksDiv")
						.append(
								'<div style="float: left;"><a  title="'+pageLinkList[i].description+'" href="#" onclick="insertLinks(this); close_facebox(); return false;" value="<a '+str+' href=\'/'
										+ pageLinkList[i].url
										+'?isPopup=facebox'
										+ '\'>'
										+ pageLinkList[i].contentName
										+ '</a>" >'
										+ pageLinkList[i].contentName
										+ '</a> </div><br/>');

		}
	}
}

function insertField(ele) {
	var titel = $(ele).html();
	var value = $(ele).attr("value");
	if(value=='forgot_password'){
		editor.selection.setContent('<a href="portal/forgot-password">Forgot Password</a>');
	}else
	editor.selection.setContent("{"+titel.trim()+" : "+value+"}");
}
function insertLinks(ele) {

	var value = $(ele).attr("value");
	editor.selection.setContent(value);

}

/*function showButtonDiv() {
	
}*/

function close_facebox() {
	$(document).trigger('close.facebox');
}

function refreshEditorCss(){
	 var domainName = $("#domainId option:selected").text();
	 var aliasName =  $("#aliasId option:selected").text();
	 var specificCssPath = $("#specificCssPath").val();
	 var editorCss = "";
	 tinymce.execCommand('mceRemoveControl',true,'content');
	 if ("Y"==$('input[name="isCommonCSS"]:checked').val()) {
			editorCss = $("#defaultContentPath").val()+"css/default/pc/LR/common.css,";
		}
		if ("Y"==$('input[name="isCustomCSS"]:checked').val()) {
			editorCss = editorCss +$("#defaultContentPath").val()
					+ domainName +'/'+ aliasName + "/default/pc/LR/css/custom.css,";
		}
		if (specificCssPath != "") {
			editorCss = editorCss +$("#defaultContentPath").val()
					+ domainName +'/'+ aliasName + "/default/pc/LR/css/"+ specificCssPath;
		}
	 $("#editorCss").val(editorCss);
//	 tinyMCE.settings.style_formats="/PortalContent/portalContent/css/default/pc/LR/common.css";
	 tinymce.EditorManager.execCommand('mceAddControl',true, 'content');
	
}