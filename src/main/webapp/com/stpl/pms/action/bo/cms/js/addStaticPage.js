var editor;
var css ; 
var languageMap;
var count =1;
var cssMap ;
var contentSizeArray=["120X600","160X600","200X200","227X250","227X694","230X318","250X250",
                      "300X250","300X600","320X50","336X280","300X155","436X183","460X636","468X60",
                      "500X70","520X80","550X146","550X480","650X400","728X90","800X464","970X90","1000X80","1000X118",
                      "1000X120","1000X140","1000X410"];
$(document).ready(function() {
//	css = "/PortalContent/portalContent/css/default/pc/LR/common.css";
	
	$("#domainId").change(function(){
		var domainId = $(this).val();
		$("#createPageFrm")[0].reset();	
		$(this).val(domainId);
		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
		$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		$.each(aliasMap,function(index, value) {
			$('#aliasId').append($('<option></option>').val(index).html(value));
	  	}); 
	});
	
	$('#aliasId').change(function(){
		var aliasId = $(this).val();
		var domainId = $("#domainId").val();
		$("#createPageFrm")[0].reset();	
		$(this).val(aliasId);
		$("#domainId").val(domainId);
  		var jsonList = '["languageList"]';
  		var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+$("#domainId").val()+"&jsonList="+jsonList,"");
  		$('#languageList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  		$.each(map["languageList"], function(index, value) {
  			$('#languageList').append($('<option></option>').val(value.languageId).html(value.languageName));
  		});
  	});
	
	
	initTinyMCE(0);
	//$("#pageHTML").addClass("mceNoEditor");
	$('a[rel*="facebox"]').click(function(event){
		if($("#domainId").val() == "-1"){
			alert("No Domain Selected !");
			event.stopImmediatePropagation();
			return;
		}
		if($("#aliasId").val() == "-1"){
			alert("No Alias Name Selected !");
			event.stopImmediatePropagation();
			return;
		}
		if($("#languageList").val() == "-1"){
			alert("No Language Selected !");
			event.stopImmediatePropagation();
		}
	});
	$('a[rel*="facebox"]').facebox({closeImage : 'images/closelabel.png',});
	
	$('#device').change(function(){
		var value=$(this).val();
		if($('#pageType').val()=='PLACE_HOLDER_CLIENT'){
			//if(value=="PC"){
				$("#requiredInfoPHClient").show();
			//}
				if(value=="PC"){
					$("#requiredInfoPHClient option[value='Android']").remove();
					$("#requiredInfoPHClient option[value='iOS']").remove();
				}else{
					$("#contentTypeClient").append( $('<option></option>').val("Android").html("ANDROID DEEPLINK"));
					$("#contentTypeClient").append( $('<option></option>').val("iOS").html("IOS DEEPLINK"));
				}
			/*else{
				$("#requiredInfoPHClient").hide();
			}*/
		}
		if(value=="MOBILE" || value=="TAB")
			$("#Preview").hide();
		else
			$("#Preview").show();
		addOptionContentSize();
	});
	
	$('#pageType').change(function() {
		var value=$(this).val();
		tinymce.execCommand('mceRemoveControl',true,'pageHTML0');
		tinymce.EditorManager.execCommand('mceAddControl',true, 'pageHTML0');
		$("#page_new_div").html("");
		editor = tinyMCE.get("pageHTML0");
		$("#content_web").css('display','block');
		$("#content_web").parent().parent().css('height','360px');
		$($("#pageHTML0_ifr").contents().find('link').get(1)).attr("href",css);
		tinymce.execCommand('mceAddControl', true, 'pageHTML0');
		$("#device").removeAttr("disabled");
		//$("#Preview").show();
		
		if (value == "-1") {
			$("#pageType").parent().next().html("No Page Type Selected !");
		} else if (value == "STATIC_PAGE" || value == "LANDING_PAGE") {
			$("#pageNameLabel").text("Content Name:");
			$("#requiredInfoPH").hide();
			$("#requiredInfoPHClient").hide();
			$("#requiredInfoTemplate").hide();
			$("#requiredInfoPage").show();
			$("#pageAndTemplateTitle").show();
			$("#description").show();
			$('#pageDescription').applyScript();
			$("#pageAndTemplateTitleLbl").text("Page Title:");
			$("#content_client").css('display','none');
			if(value == "LANDING_PAGE"){
				$("#nonLandingContent").hide();
				$('#requiredInfoLandingPage').show();
				$('#landingStatus').hide();
				$('#helpString').show();
				 cssMap = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_getSpecificCss.action?aliasId="+$('#aliasId').val(),"");
		        $("#specificCssId").empty().append( $('<option></option>').val("-1").html("--Please Select--"));
				$.each(cssMap, function(k,v ) {
						$("#specificCssId").append(
								$('<option></option>').val(v.cssId).html(v.cssName));
				});
			}else{
				editor.controlManager.setDisabled('widget', true);
				$('#requiredInfoLandingPage').hide();
				$("#nonLandingContent").show();
				$('#helpString').hide();
			}
			$("#pageType_error").html("");
			tinymce.execCommand('mceAddControl', true, 'pageHTML0');
			if(value == "LANDING_PAGE")
				editor.controlManager.setDisabled('placeHolder', true);
			else
				editor.controlManager.setDisabled('placeHolder', false);
			editor.controlManager.setDisabled('addVariable', true);
			
			
			$('#pageTitle,#contentUrl').applyScript();
			$('#contentSize,#templateSubject,#templateFromName,#templateFromEmail').removeScript();
		} else if(value == "SMS" || value=="EMAIL"){
			$($("#pageHTML0_ifr").contents().find('link').get(1)).attr("href","");
			$("#pageNameLabel").text("Template Name:");
			$("#pageAndTemplateTitle").show();
			$("#pageAndTemplateTitleLbl").text("Template Title:");
			$("#requiredInfoPH").hide();
			$("#requiredInfoPHClient").hide();
			$("#requiredInfoPage").hide();
			$('#helpString').hide();
			$("#requiredInfoTemplate").show();
			$("#description").hide();
			$('#pageDescription').removeScript();
			$("#pageType_error").html("");
			editor.controlManager.setDisabled('placeHolder', true);
			editor.controlManager.setDisabled('widget', true);
			$("#content_client").css('display','none');
		
		$('#pageTitle,#templateSubject,#templateFromName,#templateFromEmail').applyScript();
		$('#contentSize,#contentUrl').removeScript();
		} else if (value.indexOf("PLACE_HOLDER")!="-1" || value == "AFFILIATE_BANNER") {
				$("#requiredInfoPage").hide();
				$("#requiredInfoTemplate").hide();
				$("#pageNameLabel").text("Content Name:");
				$("#requiredInfoPH").show();
				$("#pageAndTemplateTitle").hide();
				$('#helpString').hide();
				$("#description").show();
				$('#pageDescription').applyScript();
				$("#pageType_error").html("");
				addOptionContentSize();
				if (value == "PLACE_HOLDER_CLIENT") {
					tinymce.execCommand('mceRemoveControl',true,'pageHTML0');
					$("#content_web").css('display','none');
					$("#content_web").parent().parent().css('height','50px');
					$("#content_client").html('<input type="file" name="contentFile" value="" accept=".swf,.flv,.JPG,.jpg,.jpeg,.gif,.png,.bmp,.tiff" id="contentFile" applyscript="true">');
					$("#content_client").css('display','block');
					//if($("#device").val()=='PC')
						$("#requiredInfoPHClient").show();
						if($("#device").val()=='PC'){
							$("#requiredInfoPHClient option[value='Android']").remove();
							$("#requiredInfoPHClient option[value='iOS']").remove();
						}
					$("#Preview").hide();
					$('#pageHTML0').removeScript();
				}else{
					editor.controlManager.setDisabled('placeHolder', true);
					editor.controlManager.setDisabled('widget', true);
					editor.controlManager.setDisabled('addVariable', true);
					$("#requiredInfoPHClient").hide();
					$("#content_client").css('display','none');
				}
				$('#contentSize').applyScript();
				$('#pageTitle,#templateSubject,#templateFromName,#templateFromEmail,#contentUrl').removeScript();
		}
		
		if(value=="EMAIL"){
				$("#device").val("PC");
				//$("#device").attr("disabled","disabled");
			}else if(value=="SMS"){
				$("#device").val("MOBILE");
				//$("#device").attr("disabled","disabled");
			}else{
				$("#device").removeAttr("disabled");
			}
		
		createBubble();
	});
	
	$("#specificCssId").change(function(){
		if($(this).val()!='-1'){
			$("#specificCssPath").val(cssMap[$(this).val()].cssPath);
		}else{
			$("#specificCssPath").val("");
		}
		refreshEditorCss();
	});
	
	$('#contentTypeClient').change(function(){
		$('#pageUrl').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		if($(this).val()!="-1"){
			if($(this).val()=="Android"){
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/login").text("Login"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/deposit").text("Deposit"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/referAFriend").text("Refer A Friend"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/lobby").text("Lobby"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/instantPlay").text("Instant Play"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/myProfilePage").text("My Profile"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/cashGame").text("Cash game"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/practiceGame").text("Practice game"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/rateAnApp").text("Rate an app"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/shareAnApp").text("Share an app"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplayRummy://khelDeepLink/inbox").text("Inbox"));
				$("#pageUrl").append($("<option></option>").attr("value","kpr://DeepLink/register").text("Register"));
				
			}else if($(this).val()=="iOS"){
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/login").text("Login"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/register").text("Register"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/referAFriend").text("Refer A Friend"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/lobby").text("Lobby"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/instantPlay").text("Instant Play"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/myProfilePage").text("My Profile"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/inboxPage").text("Inbox"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/feedback").text("Feedback"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/shareApp").text("Share An App"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/cashGame").text("Cash Game"));
				$("#pageUrl").append($("<option></option>").attr("value","khelplay://khelDeepLink/practiceGame").text("Practice Game"));
			}	
			else{
				pageLinkList = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_page_getLinks.action","aliasId="+ $('#aliasId').val() +"&pageType="+$('#contentTypeClient').val()+"&language="+$('#languageList').val()+"&device="+$('#device').val());
				$('#pageUrl').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				for ( var i = 0; i < pageLinkList.length; i++) {
					var id = pageLinkList[i].pageUrl;
					$("#pageUrl").append(
						'<option value="' +pageLinkList[i].url  + '">'
						+ pageLinkList[i].contentName + '</option>');
				}
			}
		}else
			$('#pageUrl').empty();		
	});
	
});


function disableCommonCSS(){
	if($('#device').val()=='MOBILE'){
		$("#isCommonCSSY").attr("disabled","disabled");
		$("#isCommonCSSN").attr("disabled","disabled");
	}
	else{
		$("#isCommonCSSY").removeAttr("disabled");
		$("#isCommonCSSN").removeAttr("disabled");
	}
}

function initTinyMCE(count){
	var editorCss = $("#editorCss").val();
	tinyMCE.init({
	    mode : "specific_textareas",
	    editor_deselector : "mceNoEditor",
	    content_css : editorCss,
	    theme : "advanced",
	    height : "320",
	    convert_urls : false,
	    forced_root_block : false,
	    // plugins :
		// "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
	    // Theme options
	    theme_advanced_buttons1 : "addVariable,anchor,addGraphics,widget,placeHolder,|,save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect",
	    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor,|,fontsizeselect",
	    // theme_advanced_buttons3 :
		// "hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,|,addVariable,addGraphics,anchor",
	    // theme_advanced_buttons4 :
		// "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage,|,addVariable,addGraphics,anchor",
	    // save_callback : "moveContents",
	    submit_patch : false,
	    init_instance_callback : "addNewEditor",
	    schema:"html5",
	   
	    setup : function(ed) {
		 	editor=ed;
		 	// Add a custom button
		    ed.addButton('addVariable', {
		        title : 'Insert Variables',
		        image : 'images/var.png',
		        onclick : function() {
		    		setupLink(ed,"st_pms_page_insertVariables","domainId="+$('#domainId').val()+"&pageType="+$('#pageType').val());
		        }
		    });  
		    ed.addButton('addGraphics', {
		        title : 'Insert Graphics',
		        image : 'images/img-icon.png',
		        onclick : function() {
		    		setupLink(ed,"st_pms_page_insertGraphics","domainId="+$('#domainId').val()+"&aliasId="+$("#aliasId").val()+"&pageType="+$('#pageType').val()+"&device="+$('#device').val());
		        }
		    });  
		    ed.addButton('anchor', {
		        title : 'Insert Links',
		        // image : 'images/link.png',
		        onclick : function() {
		    		var lang="";
		    		if(count==0){
//		    			for(var k=0;k<languageMap[dmId].length;k++){
//		    				if(languageMap[dmId][k].languageId==dmDefLangArr[dmId])
//		    					lang=languageMap[dmId][k].languageId;
//		    			}
		    			lang=$('#languageList').val();
		    		}else{
		    			lang=$('#languageList'+count).val();
		    		}
		    		setupLink(ed,"st_pms_page_insertLinks","aliasId="+$("#aliasId").val()+"&language="+lang+"&device="+$('#device').val());
		        }
		    });
		    ed.addButton('placeHolder', {
		        title : 'Insert Place Holder',
		        image : 'images/place-holder.png',
		        onclick : function() {
		    		var lang="";
		    		var dmId=$('#domainId').val();
		    		if(count==0){
//		    			for(var k=0;k<languageMap[dmId].length;k++){
//	    				if(languageMap[dmId][k].languageId==dmDefLangArr[dmId])
//	    					lang=languageMap[dmId][k].languageId;
//	    			}
	    			lang=$('#languageList').val();
		    		}else{
		    			lang=$('#languageList'+count).val();
		    		}
		    		setupLink(ed,"st_pms_page_insertPlaceHolder","domainId="+dmId+"&language="+lang);
		        }
		    });
		    ed.addButton('widget', {
		        title : 'Insert a widget',
		        image : 'images/widget-icon.png',
		        onclick : function() {
		    		setupLink(ed,"st_pms_page_insertWidget","aliasId="+$('#aliasId').val()+"&device="+$('#device').val());
		        }
		    });
		} 
	});	
}
function setupLink(obj,actionName,param){
	obj.focus();
	editor = obj;
	$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/"+actionName+".action?"+param);
	$("#TinyMCEwidgetLink").click();
}

window.onbeforeunload = function(){
	 _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_page_closePreview.action");
}
function addNewEditor(editor){
	if($("#pageType").val()=="LANDING_PAGE"){
		tinyMCE.activeEditor.dom.loadCSS($("#editorCss").val());
	}else{
		tinyMCE.activeEditor.dom.loadCSS($("#defaultContentPath").val()+"css/default/pc/LR/common.css");
	}
	var toolbar = [ "toolbar1", "toolbar2" ];
	if ($('#pageType').val() == "SMS") {
		for ( var j in toolbar) {
			var ct = editor.controlManager.get(toolbar[j]).controls;
			for ( var i in ct)
				ct[i].setDisabled(true);
		}
		$($("#"+editor.editorId+"_ifr").contents().find('link').get(1)).attr("href","");
		editor.controlManager.setDisabled('addVariable', false);
		editor.controlManager.setDisabled('anchor', false);

	}else{
		for ( var j in toolbar) {
			var ct = editor.controlManager.get(toolbar[j]).controls;
			for ( var i in ct)
				ct[i].setDisabled(false);
		}
	}
		
}

function refreshEditorCss(){
	 var domainName = $("#domainId option:selected").text();
	 var aliasName =  $("#aliasId option:selected").text();
	 var layout = '';
	 if($("#device").val()=="MOBILE") {
		 layout = "/gold/mobile/LR";
	 } else {
		 layout = "/default/pc/LR";
	 }
	 var specificCssPath = $("#specificCssPath").val();
	 var editorCss = "";
	 tinymce.execCommand('mceRemoveControl',true,'pageHTML0');
	 if ("Y"==$('input[name="isCommonCSS"]:checked').val()) {
			editorCss = $("#defaultContentPath").val()+"css"+layout+"/common.css,";
		}
		if ("Y"==$('input[name="isCustomCSS"]:checked').val()) {
			editorCss = editorCss +$("#defaultContentPath").val()
					+ domainName +'/'+ aliasName + layout + "/css/custom.css,";
		}
		if (specificCssPath != "") {
			editorCss = editorCss +$("#defaultContentPath").val()
					+ domainName +'/'+ aliasName + "/default/pc/LR/css/"+ specificCssPath;
		}
	 $("#editorCss").val(editorCss);
//	 tinyMCE.settings.style_formats="/PortalContent/portalContent/css/default/pc/LR/common.css";
	 tinymce.EditorManager.execCommand('mceAddControl',true, 'pageHTML0');
	 if($("#pageType"== "LANDING_PAGE")){
		 editor.controlManager.setDisabled('placeHolder', true);
		 editor.controlManager.setDisabled('addVariable', true);}
	 else{
		 editor.controlManager.setDisabled('placeHolder', false);
		 editor.controlManager.setDisabled('addVariable', false);}
}

//functions added for adding pop up in link tab on 2/12/2014
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

//issue No:- 13780
function addOptionContentSize(){
	$('#contentSize').empty().append($('<option></option>').val("-1").html("--Please Select--"));
	if($("#pageType").val()=="PLACE_HOLDER_CLIENT"){		
		for(i=0;i<contentSizeArray.length;i++){
			if($("#device").val()=='MOBILE' && (contentSizeArray[i]=='500X70' || contentSizeArray[i]=='230X318'))
				$('#contentSize').append($('<option></option>').val(contentSizeArray[i]).html(contentSizeArray[i]));
			else if($("#device").val()=='TAB' && (contentSizeArray[i]=='1000X140' || contentSizeArray[i]=='460X636'))
				$('#contentSize').append($('<option></option>').val(contentSizeArray[i]).html(contentSizeArray[i]));
			else if($("#device").val()=='PC' && !(contentSizeArray[i]=='500X70' || contentSizeArray[i]=='230X318' || contentSizeArray[i]=='1000X140' || contentSizeArray[i]=='460X636'))
				$('#contentSize').append($('<option></option>').val(contentSizeArray[i]).html(contentSizeArray[i]));
		}
	}
	else{
		for(i=0;i<contentSizeArray.length;i++)
			$('#contentSize').append($('<option></option>').val(contentSizeArray[i]).html(contentSizeArray[i]));
	}
}
	