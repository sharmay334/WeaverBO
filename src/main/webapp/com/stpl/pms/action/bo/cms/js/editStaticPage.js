var editor;
$(document).ready(function() {

	$('a[rel*="facebox"]').facebox({
		closeImage : 'images/closelabel.png',
	});
	 
	$("#tempDIv").find('div[id*="pH_"]').each(function(){
		$(this).css("border","1px solid");
	});
	
  	$("#tempDIv").find('div[id*="Widget"]').each(function(){
  	 	$(this).css("border","1px solid");
  	});
  	
  	 $("#pageHTML0").val($("#tempDIv").html());
  	 $("#tempDIv").html('');
  	 
  	 	
  	 tinyMCE.init({
         mode : "specific_textareas",
        editor_deselector : "mceNoEditor",
        theme : "advanced",
        height : "320",
         convert_urls : false,
   	    forced_root_block : false,
        // plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

        // Theme options
        theme_advanced_buttons1 : "addVariable,anchor,addGraphics,widget,placeHolder,|,save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect",
        theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor,|,fontsizeselect",
        //theme_advanced_buttons3 : "hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,|,addVariable,addGraphics,anchor",
        //theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage,|,addVariable,addGraphics,anchor",
        
        //save_callback : "moveContents",
        submit_patch : false,
        init_instance_callback: "prepareJsp",
        schema:"html5",
		setup : function(ed) {
        // Add a custom button
        editor = ed;
        ed.addButton('addVariable', {
            title : 'Insert Variables',
            image : 'images/var.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?domainId="+$('#domainId').val()+"&pageType="+$('#pageType').val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });  
        
        ed.addButton('addGraphics', {
            title : 'Insert Graphics',
            image : 'images/img-icon.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val()+"&pageType="+$('#pageType').val()+"&device="+$('#device').val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });  
        ed.addButton('anchor', {
            title : 'Insert Links',
            //image : 'images/link.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?aliasId="+$("#aliasId").val()+"&language="+$("#language").val()+"&device="+$('#device').val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });
        ed.addButton('placeHolder', {
            title : 'Insert Place Holder',
            image : 'images/place-holder.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertPlaceHolder.action?domainId="+$("#domainId").val()+"&language="+$("#language").val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });
        ed.addButton('widget', {
            title : 'Insert a widget',
            image : 'images/widget-icon.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertWidget.action?aliasId="+$('#aliasId').val()+"&device="+$("#device").val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        }); 
        }    
       });
  	 
		if($('#device').val()=='MOBILE'){
			$("#isCommonCSSY").attr("disabled","disabled");
			$("#isCommonCSSN").attr("disabled","disabled");
		}
		else{
			$("#isCommonCSSY").removeAttr("disabled");
			$("#isCommonCSSN").removeAttr("disabled");
		}
	
			var value=$("#device").val();
			if(value=="MOBILE" || value=="TAB")
				$("#Preview").hide();
			else
				$("#Preview").show();
			if(value=="PC"){
				$("#requiredInfoPHClient option[value='Android']").remove();
				$("#requiredInfoPHClient option[value='iOS']").remove();
			}else{
				var pageUrl = $("#pageUrl1").val();
				if($('#contentTypeClient').val()=="Android"){
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
					$('select[name^="pageUrl"] option[value="'+pageUrl+'"]').attr("selected","selected");
					
				}else if($('#contentTypeClient').val()=="iOS"){
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
					$('select[name^="pageUrl"] option[value="'+pageUrl+'"]').attr("selected","selected");
				}	
			}
		
       
});
	var cssMap=JSON.parse( $("#domainSpCss").val());

	$("#specificCssId").change(function(){
		if($(this).val()!='-1'){
			$("#specificCssPath").val(cssMap[$(this).val()].cssPath);
		}else{
			$("#specificCssPath").val("");
		}
		refreshEditorCss();
	});
	
	function prepareJsp(editor){
		if($("#pageType").val()=="LANDING_PAGE"){
			tinyMCE.activeEditor.dom.loadCSS($("#editorCss").val());
		}else{
			tinyMCE.activeEditor.dom.loadCSS($("#defaultContentPath").val()+"css/default/pc/LR/common.css");
		}
		$("#page_new_div").html("");
		var value = $("#pageType").val();
		
		$("#content_web").css('display','block');
		$("#content_web").parent().parent().css('height','360px');
		$("#content_client").css('display','none');
		
		var toolbar = ["toolbar1","toolbar2"];
		 for(var j in toolbar){
			 var ct =  editor.controlManager.get(toolbar[j]).controls;
		 	 for(var i in ct)
		 		 ct[i].setDisabled(false);
		 }
		//editor.controlManager.setDisabled('addVariable', true);
		 if(value == "-1"){
			 $("#pageType").parent().next().html("No Page Type Selected !");
			 $("#requiredInfoPHClient").hide();
		 }
		 else if(value=="STATIC_PAGE" || value=="LANDING_PAGE"){
			$("#pageType_error").html("");
			tinymce.execCommand('mceAddControl',true,'pageHTML0');
			editor.controlManager.setDisabled('placeHolder', false);
			if(value=="LANDING_PAGE"){
				editor.controlManager.setDisabled('placeHolder', true);
				$("#nonLandingContent").hide();
				$('#helpString').show();
			}
			else{
				editor.controlManager.setDisabled('widget', true);
				$("#nonLandingContent").show();
				$('#helpString').hide();
			}
			$("#description").show();
			$('#pageDescription').applyScript();
			editor.controlManager.setDisabled('addVariable', true);
			$("#requiredInfoPHClient").hide();
		 }
		else if(value == "SMS" || value=="EMAIL"){
			$("#pageType_error").html("");
			$('#helpString').hide();
			$("#description").hide();
			$('#pageDescription').removeScript();
			addNewEditor(editor);
			$("#requiredInfoPHClient").hide();
		}
		 else if(value.indexOf("PLACE_HOLDER")!="-1" || value == "AFFILIATE_BANNER"){
			 	$('#helpString').hide();
			 	$("#description").show();
			 	$('#pageDescription').applyScript();
			 	$("#pageType_error").html("");
				 if (value == "PLACE_HOLDER_CLIENT") {
				//tinymce.execCommand('mceRemoveControl',true,'pageHTML');
				$("#content_web").css('display','none');
				$("#content_web").parent().parent().css('height','50px');
				$("#content_client").css('display','block');
				//if($("#device").val()=="PC")
				$("#requiredInfoPHClient").show();
				if($("#device").val()=='PC'){
					$("#requiredInfoPHClient option[value='Android']").remove();
					$("#requiredInfoPHClient option[value='iOS']").remove();
				}
			}else{
			tinymce.execCommand('mceAddControl', true, 'pageHTML0');
			editor.controlManager.setDisabled('placeHolder', true);
			editor.controlManager.setDisabled('widget', true);
			editor.controlManager.setDisabled('addVariable', true);
			$("#requiredInfoPHClient").hide();
			}
		 }
		 createBubble();
	}
	
	function refreshEditorCss(){
		 var domainName = $("#domainId option:selected").text();
		 var aliasName = $("#aliasId option:selected").text();
		 var specificCssPath = $("#specificCssPath").val();
		 var editorCss = "";
		 tinymce.execCommand('mceRemoveControl',true,'pageHTML0');
		 if ("Y"==$('input[name="isCommonCSS"]:checked').val()) {
				editorCss = $("#defaultContentPath").val()+"css/default/pc/LR/common.css,";
			}
			if ("Y"==$('input[name="isCustomCSS"]:checked').val()) {
				editorCss = editorCss +$("#defaultContentPath").val()
						+ domainName +"/"+aliasName+ "/default/pc/LR/css/custom.css,";
			}
			if (specificCssPath != "") {
				editorCss = editorCss +$("#defaultContentPath").val()
						+ domainName +"/"+aliasName+ "/default/pc/LR/css/"+ specificCssPath;
			}
		 $("#editorCss").val(editorCss);
//		 tinyMCE.settings.style_formats="/PortalContent/portalContent/css/default/pc/LR/common.css";
		 tinymce.EditorManager.execCommand('mceAddControl',true, 'pageHTML0');
		
	}
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
				$('#pageUrl').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				//$('#pageUrl').empty();		
	});
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
