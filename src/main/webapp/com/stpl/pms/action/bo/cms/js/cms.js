var editor;

function checkFormCreatePage() {

	var varboolean = true;
	var pageName = $("#pageName").val();
	var pageTitle = $("#pageTitle").val();
	var pageMetaTag = $("#pageMetaTag").val();
	var pageKeyword = $("#pageKeyword").val();
	var pageDescription = $("#pageDescription").val();
	var pageType = $("#pageType").val();
	if(pageType.indexOf("SMS")!="-1"){
		/*console.log(tinyMCE.activeEditor.getContent().replace(/<[^>]*>/g, ""));*/
		var content = tinyMCE.activeEditor.getContent({format : 'raw'});
		$("#pageHTML0").val(content);
		return varboolean;
	}
	
	if(pageType.indexOf("CLIENT")=="-1")
		if(typeof($("textarea[id*='pageHTML']")[0])!='undefined') {
			$("textarea[id*='pageHTML']").each(function() {
				if ($(this).attr("id").indexOf("_") == "-1") {
					var ele = $($(this).next()).find(
							"#" + $(this).attr("id") + "_ifr");
					var val = $(ele).contents().find(
							"body#tinymce.mceContentBody").html()
							.replace(/<br data-mce-bogus="1">/g, "");
					if (val != "") {
						if(pageType == "PLACE_HOLDER_WEB"){
							val = "<div overflow: scroll'>" +val+"</div>";
							
						}
						$(this).attr("value", val);
						$(this).parent().parent().next().html("");

					} else {
						$(this).parent().parent().next().html(
								"No HTML Found.");
						varboolean = false;
					}

				}
			});
		} else {
			varboolean = false;
		}
	return varboolean;
}

function checkFormEditPage() {

	var varboolean = true;
	var pageName = $("#pageName").val();
	var pageTitle = $("#pageTitle").val();
	var pageMetaTag = $("#pageMetaTag").val();
	var pageKeyword = $("#pageKeyword").val();
	var pageDescription = $("#pageDescription").val();
	var pageType = $("#pageType").val();
	if(pageType.indexOf("CLIENT")=="-1")
		if(typeof($("textarea[id*='pageHTML']")[0])!='undefined') {
			$("textarea[id*='pageHTML']").each(function() {
				if ($(this).attr("id").indexOf("_") == "-1") {
					var ele = $($(this).next()).find(
							"#" + $(this).attr("id") + "_ifr");
					var val = $(ele).contents().find(
							"body#tinymce.mceContentBody").html()
							.replace(/<br data-mce-bogus="1">/g, "");
					if (val != "") {
						/*if(pageType == "PLACE_HOLDER_WEB"){
							val = "<div overflow: scroll'>" +val+"</div>";
							
						}*/
						$(this).attr("value", val);
						$(this).parent().parent().next().html("");

					} else {
						$(this).parent().parent().next().html(
								"No HTML Found.");
						varboolean = false;
					}

				}
			});
		} else {
			varboolean = false;
		}
	return varboolean;
}

function close_facebox() {
	$(document).trigger('close.facebox');
}

function changeCss(ele) {

	if ($(ele).attr("class") != "aHover") {

		$(".aHover").each(function() {

			$(this).css("opacity", "");
			$(this).removeClass("aHover");

		});

		$(ele).css("opacity", "0.4");
		$(ele).addClass("aHover");
	} else {

	}
}

function reloadFaceBox(ele) {

	var anchorElem = $(ele);
	var hrefAttr = anchorElem.attr('href');
	hrefAttr = hrefAttr + "&domainId=" + $("#domainId").val() +"&aliasId="+$("#aliasId").val()+ "&currency="
			+ $("#currency").val() + "&language=" + $("#languageG").val()
			+ "&graphicsType=" + $("#graphicsType").val() + "&size="
			+ $("#size").val()+ "&pageType=" + $("#pageType").val()+"&device="+$('#device').val() ;
	anchorElem.attr('href', hrefAttr);
	return false;

}

function getLinks(value) {
	var pageLinkList = $.parseJSON($("#pageLinkList").val());
	$("#linksDiv").html("");
	for ( var i = 0; i < pageLinkList.length; i++) {
		if (pageLinkList[i].contentType == value)
			$("#linksDiv")
					.append(
							'<div style="float: left;"><a  title="'+pageLinkList[i].description+'" href="#" onclick="insertLinks(this); close_facebox(); return false;" value="<a href=/'
									+ pageLinkList[i].url
									+ '\>'
									+ pageLinkList[i].contentName
									+ '</a>" >'
									+ pageLinkList[i].contentName
									+ '</a> </div><br/>');

	}
}

function getVariables(value) {
	var variablesBeanList = $.parseJSON($("#variablesBeanList").val());
	$("#variablesDiv").html("");
	var contentType = $("#pageType").val();
	for ( var i = 0; i < variablesBeanList.length; i++) {
		if (variablesBeanList[i].variableType == value){
			var pst;
			if(contentType == "SMS" || contentType == "EMAIL"){
				pst = variablesBeanList[i].variableReplaceValue;
			}else{
				pst = " s:property value='%{variableEmailMap."+variablesBeanList[i].variableTag+"}' /s:property";
			}
			$("#variablesDiv")
					.append(
							'<a href="#" onclick="insertVariable(this); close_facebox(); return false;" value="'
									+ pst
									+ '" >'
									+ variablesBeanList[i].variableName
									+ '</a><br/>');
		}
	}
}

function getPlaceHolder(value) {

	var placeHolderListJson = $.parseJSON($("#placeHolderListJson").val());
	for ( var i = 0; i < placeHolderListJson.length; i++) {
		if (placeHolderListJson[i].id == value) {
			$("#ph_height").val(placeHolderListJson[i].height);
			$("#ph_width").val(placeHolderListJson[i].width);
			$("#ph_code").val(placeHolderListJson[i].placeHolderCode);
		}

	}
}
function getWidget() {
	var widgetListJson = $.parseJSON($("#widgetListJson").val());
	$('#widgetName').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	$.each(widgetListJson, function(i, value) {
		if(value.widgetType==$("#widgetType").val())
		$("#widgetName").append(
				$('<option></option>').val(value.widgetName).html(
						value.widgetName));
	});
}

function insertVariable(ele) {

	var value = $(ele).attr("value");
	editor.selection.setContent(value);
	$("#variablesBeans").val($("#variablesBeanList").val());
	
}

function insertGraphics() {

	var value = "";
	var tag;
	$(".aHover").each(function() {
		if($("#graphicsType").val()=="Image"||$("#graphicsType").val()=="Image_Gif"){
			tag = "<img src=" + $(this).attr("value") + " alt="+ $("#altTag").val() +" title="+ $("#titleTag").val() +"></img>";
		}else{
			if($(this).attr("value").indexOf(".mp4")!="-1")
				tag = '<object classid="clsid:02BF25D-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab"> \
						<param name="src" value="'+$(this).attr("value")+'">\
						<param name="controller" value="true">\
						</object>';
			else
				tag = '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/\
						pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0">\
						<param name="SRC" value="'+$(this).attr("value")+'">\
						<embed src="'+$(this).attr("value")+'" >\
						</embed>\
						</object>';
		}
		if($("#imgLink").val()=="")
			value = tag;
		else
			value = "<a href=\""+ $('#imgLink').val() +"\" >"+tag+"</a>";
			
	});
	editor.selection.setContent(value);

}

function insertLinks(ele) {

	var value = $(ele).attr("value");
	editor.selection.setContent(value);

}

function insertPlaceHolder(language) {
	
	var size = $("#ph_size").val();
	var dimensions =  size.split("X");
	var height = dimensions[1];
	var width = dimensions[0];
	var code = $("#ph_code").val();
	var name = $("#ph_name").val();
	editor.selection
			.setContent('<div id="pH_'
					+ language
					+ '" align="center" style="height: '
					+ height
					+ 'px; width: '
					+ width
					+ 'px; border: 1px solid;" lang="'
					+ language
					+ '" height="'
					+ height
					+ '" width="'
					+ width
					+ '" title="'
					+ name
					+ '" action_name="portal/placeholder"> This is the Place Holders space. \
											</div>');

}

function insertWidget() {
 var widgetName = $("#widgetName").val();
		editor.selection
				.setContent('<div id="'+widgetName+'_widgetDiv" widget_name="'+widgetName+'" widget_type="'+$("#widgetType").val().toLowerCase()+'">'+widgetName+'</div>');
}

function formSubmitEditPage(formId, divId) {
	var form = $('#' + formId);
	var formData = new FormData(form[0]);
	$
			.ajax( {
				type : "POST",
				url : form.attr('action'),
				async : false,
				data: formData,
		         cache: false,
		         contentType: false,
		         processData: false,
				success : function(result, arguments, text) {
					if (text.responseText == "SUCCESS")
						$("#decoBody")
								.html(
										' <div class="alert saved_msg"><span class="alert_close"></span><strong>Saved:</strong>Saved Successfully..</div>');
					else
						$("#" + divId).html(result);
				}
			});
	return false;
}

function prepareVariableContent() {
	var currTime  = new Date($.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr)).getTime();
	var variablesBeans = $.parseJSON($("#variablesBeans").val());
	var contentType = $("#pageType").val();
	if(contentType.indexOf("SMS") != "-1"){
		return true;
	}
	var jsonObj = {};
	var matchedStringArray;
	$("textarea")
			.each(
					function(index, value) {
						var requestHTML = $(this).val();
						var textArea = this;
							if (variablesBeans != null) {
								
								if (contentType.indexOf("SMS") != "-1") {
									matchedStringArray = requestHTML
									.match(/{sms: [a-z_]+/gi);
								}else if (contentType.indexOf("EMAIL") != "-1") {
									var matchedStringArray = requestHTML
									.match(/{[a-zA-Z]+, *fallback=}/gi);
								   }else {
										var matchedStringArray = requestHTML
										.match(/code:[ A-Z]+/gi);
								        }
								if (matchedStringArray != null) {
									jsonObj[index] = "";
									for ( var i = 0; i < matchedStringArray.length; i++) {
										for ( var j = 0; j < variablesBeans.length; j++) {
											if (matchedStringArray[i] == variablesBeans[j].variableReplaceValue) {
												jsonObj[index] = jsonObj[index] + variablesBeans[j].variableReplaceValue+":"+variablesBeans[j].variableTag+"|";
												break;
											}

										}
											}
									}

								$(this).attr('value', requestHTML);
							}
						var lang, height, width,name;
						var count = 1;
						$("#phAttr").empty();
						$('#tempDIv').html(requestHTML);
						$('#tempDIv')
								.find('div[id*="pH_"]')
								.each(
										function() {
											height = $(this).css("height");
											width = $(this).css("width");
											lang = $(this).attr("lang");
											name = $(this).attr("title");
											phCode = "ph_"
													+ $("#pageName").val()
													+ "_" + lang + ":"
													+ count;
											
												$("#phAttr")
														.append(
																'<input type="hidden" name="phCode" value="'
																		+ phCode
																		+ '">\
								 <input type="hidden" name="phHeight" value="'
																		+ height.replace("px","")
																		+ '">\
								 <input type="hidden" name="phName" value="'
																		+ name
																		+ "_"+count+'">\
																		<input type="hidden" name="phWidth" value="'
																		+ width.replace("px","")
																	+ '">');
											$(this).css("border","none");
											$(this).attr("widget_name",phCode);
											$(this).attr("param_name",phCode);
											$(this).attr("id","pH_"+currTime+"_"+count);
											$(this).html(phCode);
											count++;
										});
						
						$('#tempDIv')
						.find('div[id*="Widget"]')
						.each(
								function() {
									$(this).css("border","none");
								});
						
						$(this).val($('#tempDIv').html());
							var ele = $($(this).next()).find(
									"#" + $(this).attr("id") + "_ifr");
							$(ele).contents().find(
									"body#tinymce.mceContentBody").html($('#tempDIv').html())
						$('#tempDIv').html('');
					});
	if(!jQuery.isEmptyObject(jsonObj))
		$("#jsonObjVariableId").val(JSON.stringify(jsonObj));
	$("#device").removeAttr("disabled");
	
}

function checkPageAvailability(value) {

	if (value == "") {
		$("#pageName_error").html("No Name Found.");
		return false;
	}
	var response = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_page_checkAvailability.action?pageName="
			+ value
			+ "&domainId="
			+ $('#domainId').val()
			+ "&pageType="
			+ $('#pageType').val());
	if (response == "Available") {
		$("#pageName_error").attr("class", "fieldSucess");
	} else
		$("#pageName_error").attr("class", "fieldError");

	$("#pageName_error").html(response);

}

function refreshLangList(ele) {

	var value = $(ele).val();
	var id = $(ele).attr("id");

	$('select[id*="languageList"]').each(function() {
		if ($(this).attr("id") != id) {
			if ($(this).val() == value)
				$(this).val("-1");

		}

	});
}

function addNewEditor(inst) {
	var pageType = $("#pageType").val();
	var css=$("#css").val();
	editor = inst;
	//editor.controlManager.setDisabled('addVariable', true);
	if (pageType == "SMS") {
		var toolbar = [ "toolbar1", "toolbar2" ];
		for ( var j in toolbar) {
			var ct = inst.controlManager.get(toolbar[j]).controls;
			for ( var i in ct)
				ct[i].setDisabled(true);
		}
		$($("#"+editor.editorId+"_ifr").contents().find('link').get(1)).attr("href","");
		editor.controlManager.setDisabled('addVariable', false);
		/*editor.controlManager.setDisabled('anchor', false);*/

	}else if($("#pageType").val()=="EMAIL"){
		$($("#"+editor.editorId+"_ifr").contents().find('link').get(1)).attr("href","");
		editor.controlManager.setDisabled('widget', true);
		editor.controlManager.setDisabled('placeHolder', true);
		editor.controlManager.setDisabled('addVariable', false);
     }else if(pageType.indexOf("FOOTER") != "-1"){
    	 $($("#"+editor.editorId+"_ifr").contents().find('link').get(1)).attr("href",css);
 		editor.controlManager.setDisabled('widget', true);
 		editor.controlManager.setDisabled('placeHolder', true);
 		editor.controlManager.setDisabled('addVariable', true);
      }else if (pageType.toUpperCase().indexOf("PAGE") != "-1") {
    	  $($("#"+editor.editorId+"_ifr").contents().find('link').get(1)).attr("href",css);
		//editor.controlManager.setDisabled('placeHolder', true);
		editor.controlManager.setDisabled('addVariable', true);
	}
}

function getPhPages() {
	
	var domainId = $("#domainId").val();
	var aliasId = $("#aliasId").val();
	if($("#portalType").val()=="JOOMLA"){
		$('#menuId').empty().append(
				$('<option></option>').val("-1").html("----Please Select----"));		
		var pageType = $("#joomlaPageType").val();
		var lang = "1";
		var device = $("#joomlaDevice").val();		
	}else{
		$('#pageName').empty().append(
				$('<option></option>').val("-1").html("----Please Select----"));		
		var pageType = $("#pageType").val();
		var lang = $("#language").val();
		var device = $("#device").val();
	}
	if (domainId != "-1" && pageType!="-1" && lang!="-1" && device!="-1" && aliasId!="-1") {
		var pageList = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_cms_fetchPlaceHolderPagesList.action?","aliasId="+aliasId+"&device="+device+"&pageType="+pageType);
		$("#phDetails").val(pageList);
		if($("#portalType").val()=="JOOMLA"){
			$("#menuTitleDiv").show();
			$.each(pageList, function(i, value) {
				$("#menuTitleDiv").show();
				$("#menuLabel").text("Page Name :");
				//if (value.contentType == pageType && value.language==lang && value.device==device) {
					$("#menuId").append(
							$('<option></option>').val(value.contentId).html(
									value.contentName));
				//}
			});
			
		}else{
			$.each(pageList, function(i, value) {
				//if (value.contentType == pageType && value.language==lang && value.device==device) {
					$("#pageName").append(
							$('<option></option>').val(value.contentId).html(
									value.contentName));
				//}
			});
		}
	}
	return false;
}

function getPhDetail(val) {
	if (val == "-1") {
		$("#phDetailsDiv").html("");
		return false;
	}
	var aliasId = $("#aliasId").val();
	var phList = $("#phDetails").val();
	if($("#portalType").val()=="JOOMLA"){
		var pageType = $("#joomlaPageType").val();		
		var device = $("#joomlaDevice").val();
		var deviceOS = $("#joomlaDeviceOS").val();
	}else{
		var pageType = $("#pageType").val();		
		var device = $("#device").val();
	}
		$.each(phList, function(i, value) {
			if (value.urlId == val) {
				$("#contentType").val(value.contentType);				
			}
		});
	_ajaxCallDiv(
			'com/stpl/pms/action/bo/cms/st_pms_getPlaceHolderDetails.action?urlId='
					+ val + '&aliasId=' +aliasId+'&pageType='+pageType+'&device='+device+'&deviceOS='+deviceOS, '',
			'phDetailsDiv');
	if($("#spCritTb").length>0){
		$("#spCritBtn").remove();
	}
	
	createBubble();
}
function previewContent(id, phCode, lang) {
	var content = $("#" + id).find("select").val();
	if (content == "-1") {
		alert("Please select content");
		return false;
	}
	var langCode = $("#" + lang).html().trim();
	var urlId = $("#pageName").val();
	var pagePath;
	if (content != "-1") {
		var donainId = $("#domainId").val();
		var phDetails = $.parseJSON($("#phDetails").val());
		var pathList = phDetails[donainId];
		$.each(pathList, function(i, value) {
			if (value.urlId == urlId) {
				var map = value.contentPath;
				pagePath = map[langCode];
			}
		});
		var contentPath = content.split("#");
		var html = _ajaxCallText(
				'com/stpl/pms/action/bo/cms/st_pms_getPlaceHolderPreview.action?pagePath='
						+ pagePath + '&contentPath=' + contentPath[1]
						+ '&phCode=' + phCode, '');
		if(html == "error"){
			html = '<h4 style="color: #FFA200;font-family: Candara;font-size: 17px;margin: 0;text-transform: uppercase;">Preview not aVilable</h4>';
			
		}
		newwindow = window.open('#', 'newWindow',
				'resizable=no,width=970,height=730,status=no');
		newdocument = newwindow.document;
		newdocument
				.write('<html><head></head> <body style="background-color:rgb(153, 0, 0);"> <div style="width: 100%;height: auto;margin-top: 5px;">' + html + '</div> </body></html>');
		newdocument.close();
	}
	return false;
}

function addCamp(){
	
		if($("#campType").val()=="-1"){
		alert("Please select any Campaign Type");
		return false;
	}
		
	var count = $("#count").val();
	count++;
	$("#count").val(count);

	var html1 = '<div id="subCamp_'+count+'" class="FormSectionMenu">\
	<div class="greyStrip">\
	<h4> Sub Campaign Information </h4>\
	</div>\
	<div class="innerbox">\
	<input id="subCampaignId_'+count+'" type="hidden" value="0" >\
	<div class="FormMainBox">\
	<div class="labelDiv">\
	<label> Sub Campaign Name: </label>\
	<em class="Req">*</em>\
	</div>\
	<div class="InputDiv">\
	<input id="subCampName_'+count+'" type="text" patternon="both" applyscript="true">\
	</div>\
	</div>\
	<div class="clearFRM"></div>\
	<div class="FormMainBox">\
	<div class="labelDiv">\
	<label id="deepRummyUrl_">Rummy Url:</label>\
	</div>\
	<div class="InputDiv" style="height: 55px;">\
	<input id="deepRummyUrl_'+count+'" type="text" name="deepRummyUrl_'+count+'">\
	<div><b>Note:</b> - Please Specify With # KeyWord</div>\
	</div>\
	</div>\
	<div class="clearFRM"></div>\
	<div class="FormMainBox">\
	<div class="labelDiv">\
	<label id="addCapmaignForm_">Landing Page:</label>\
	<em class="Req">*</em>\
	</div>\
	<div class="InputDiv">\
	<select id="landingPage_'+count+'" class="select1" applyscript="true">\
	<option value="-1">-- Please Select --</option>\
	</select>\
	</div>\
	</div>\
	<div class="clearFRM"></div>\
	<div class="FormMainBox">\
	<div class="labelDiv">\
	<label>Valid From Date </label>\
	<em class="Req">*</em>\
	</div>\
	<div class="InputDivHalf">\
	<input id="fromDate_'+count+'" type="text" patternon="both" readonly="readonly" applyscript="true">\
	</div>\
	</div>\
	<div class="clearFRM"></div>\
	<div class="FormMainBox">\
	<div class="labelDiv">\
	<label>Valid To Date </label>\
	<em class="Req">*</em>\
	</div>\
	<div class="InputDivHalf">\
	<input id="toDate_'+count+'" type="text" patternon="both" readonly="readonly" applyscript="true">\
	</div>\
	</div></div></div>';

	 	$("#camp").append(html1);
	
		 $( "#fromDate_"+count ).datetimepicker({
					dateFormat : 'dd/mm/yy',
					timeFormat : 'HH:mm:ss',
					showSecond: true,
					changeMonth : true,
					numberOfMonths : 1,
					minDate:'+0',
					onClose: function( selectedDate ) {
						$( "#toDate_"+count ).datetimepicker( "option", "minDate", selectedDate );
					}
				});
				$( "#toDate_"+count ).datetimepicker({
					dateFormat : 'dd/mm/yy',
					timeFormat : 'HH:mm:ss',
					showSecond: true,
					changeMonth : true,
					numberOfMonths : 1,
					minDate:'+0',
					onClose: function( selectedDate ) {
						$( "#fromDate_"+count ).datetimepicker( "option", "maxDate", selectedDate );
					}
				}); 
				var result = $("#landingPageDetail").val();
				var landingPageDetail = $.parseJSON(result);
				if(landingPageDetail!=null){
					$('#landingPage_'+count).empty().append(
					$('<option></option>').val("-1").html("----Please Select----"));
					$.each(landingPageDetail, function(i, value) {
							$('#landingPage_'+count).append(
									$('<option></option>').val(i).html(
											value));
					});
				}
				createBubble();
				fetchLandingPage4addMore();
	}
		
function prepareCampData(){
	var data = '[';
	if ($('div[id^="subCamp_"]').length != 0) {
	data += '{';
	$('div[id^="subCamp_"]').each(function(i) {
	  var subTlbId = $(this).attr('id').split('_');
	  data = getFieldData($(this), data, "_"+ subTlbId[1]);
	  data += '},{';
	});
	data = data.substring(0, data.length - 2);
	data += ']';
	$("#campDetailString").val(data);
	}
}
function fetchIdVal(obj,name,id){
	return '"'+name+'":"'+obj.find(id).val()+'",';
}

function getFieldData(obj,data,val){
	data=data+fetchIdVal(obj,'subCampaignName','input[id="subCampName'+val+'"]');
	data=data+fetchIdVal(obj,'fromDate','input[id="fromDate'+val+'"]');
	data=data+fetchIdVal(obj,'deepRummy','input[id="deepRummyUrl'+val+'"]');
	data=data+fetchIdVal(obj,'toDate','input[id="toDate'+val+'"]');
	data=data+fetchIdVal(obj,'content','select[id="landingPage'+val+'"]');
	data=data+fetchIdVal(obj,'subCampaignId','input[id="subCampaignId'+val+'"]');
	data=data.substring(0,data.length-1);
	return data;
}
function removeAddMoreButton(){
	if($("#campType").val()=='PPC'){
		$("#addParam").css("display","block");
	}else{
		$("#addParam").css("display","none");
	}
	if($("#campType").val()=='REFER_FRIEND'){
		$("#addMoreCamp").hide();
		$('div[id^="subCamp_"]').each(function(){
			if($(this).attr("id")!="subCamp_1"){
				$(this).remove();
			}
		});
	} else{
	 	$("#addMoreCamp").show();
	}
}
function addParams(){
	 var count = parseInt($("#paramCount").val());
	 if(count<10){
	 	$("#paramDiv").append('<div class="clearFRM"></div><div class="FormMainBox"><div class="labelDiv"><label>Param'+(count+1)+':</label></div><div class="InputDiv"><input type="text" id="param'+(count+1)+'" name="campParams['+count+']" /></div></div>');
	 	$("#paramCount").val(count+1);
	 }
}
function fetchLandingPageDetail(){
	if($("#device").val()!=-1 && $("#device").val()!="") {
		var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchLandingPageDetail.action?aliasId='+$("#aliasId").val()+'&device='+$("#device").val(),'');
		var landingPageDetail = $.parseJSON(result);
		$("#landingPageDetail").val(result);
		$('select[id*="landingPage_"]').each(function(){
		var id = $(this).attr("id");
			$("#"+id).empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
			$.each(landingPageDetail, function(i, value) {
					$("#"+id).append(
							$('<option></option>').val(i).html(
									value));
			});
		});
	}	
}

function fetchContentType(pageType){
	var aliasId = $("#aliasId").val();
	if($("#domainId").val()!=-1 && aliasId!=-1) {
		var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchContentType.action?aliasId='+$("#aliasId").val(),'');
		if(result!="PortalContent" && result!="PORTALCONTENT") {
			$("#device").val("ALL");
			$("#deviceDiv").attr("style","display:none;");
			if(pageType=="addCamp")
				fetchLandingPage();
		} else {
			$("#device").val("-1");
			$("#deviceDiv").attr("style","display:block");
			$('select[id*="landingPage_"]').each(function(){
				$(this).empty().append($('<option></option>').val("-1").html("----Please Select----"));
			});
			$("#contentType").val("PORTALCONTENT");
		}
	} 
}

function fetchLandingPage() {
	var aliasId = $("#aliasId").val();
	if($("#domainId").val()!=-1 && aliasId!=-1) {
		var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchLandingPageDetail.action?aliasId='+aliasId,'');
		var landingPageDetail = $.parseJSON(result);
		if("0"==landingPageDetail["errorCode"]) {
			var map = landingPageDetail["pages"];
			$('select[id*="landingPage_"]').each(function(){
			var id = $(this).attr("id");
				$("#"+id).empty().append(
				$('<option></option>').val("-1").html("----Please Select----"));
				$.each(map, function(i, value) {
						$("#"+id).append(
								$('<option></option>').val(value.publicUrl).html(
										value.name));
				});
			});
		}	
	}	
}

function fetchLandingPage4addMore() {
	var aliasId = $("#aliasId").val();
	if($("#domainId").val()!=-1 && aliasId!=-1) {
		var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchLandingPageDetail.action?aliasId='+aliasId,'');
		var landingPageDetail = $.parseJSON(result);
		if("0"==landingPageDetail["errorCode"]) {
			var map = landingPageDetail["pages"];
			$('select[id*="landingPage_"]').each(function(){
			var id = $(this).attr("id");
				
				$.each(map, function(i, value) {
						$("#"+id).append(
								$('<option></option>').val(value.publicUrl).html(
										value.name));
				});
			});
		}	
	}	
}
 
function fetchCampNames(){
	$("#campDiv").html("");
    if($("#domainId").val()=="-1" || $("#campType").val()=="-1" || $("#device").val()=="-1" || $("#aliasId").val()=="-1"){
       $("#campId").empty().append(
        $('<option></option>').val("-1").html("----Please Select----"));
    }else{
        var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchCampNames.action?aliasId='+$("#aliasId").val()+'&campType='+$("#campType").val()+'&device='+$("#device").val(),'');
        var campNames = $.parseJSON(result);
        $("#campId").empty().append(
        $('<option></option>').val("-1").html("----Please Select----"));
		$.each(campNames, function(i, value) {
				$("#campId").append(
						$('<option></option>').val(i).html(
								value));
		});
    }
    
  }

function fetchCustomCSSDetail(){
	if($("#domainId").val()=="-1"){
		alert("Please select any Domain");
		$("#device").val("-1");
		return false;
	}
	$("#cssArea").css("display", "block");
	var result = _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_cms_fetchcustomCSSDetail.action?domainId='+$("#domainId").val()+'&device='+$("#device").val(),'');
	$("#customCSS").val(result);
}
 
 function moreTags(ele,tag){
	 
	 var html;
	 if(tag=="Meta"){
		 html = '<div class="clearFRM"></div>\
				<div class="FormMainBox">\
				<div class="labelDiv">\
					<label>\
						Meta-Name :\
					</label>\
				</div>\
				<div class="InputDiv">\
				<div>\
				    <input type="text" name="metaNames" id="pageMetaTag" applyscript="true"></input>\
					</div>\
						<div id="pageMetaTag_error" class="fieldError"></div>\
				</div>\
			</div>\
			<div class="FormMainBox">\
				<div class="labelDiv">\
					<label>\
						Meta-Content:\
					</label>\
				</div>\
				<div class="InputDiv" style="height:50px">\
					<div>\
					<input type="text" name="metaContents" value="" id="pageKeyword" applyscript="true"></input>\
					</div>\
						<div id="pageKeyword_error" class="fieldError"></div>\
						<div id="moreTags"><a onclick="moreTags(this,\'Meta\')">Add More Meta Tags</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="removeTags(this,\'Meta\')">Remove</a></div>\
				</div>\
			</div>'
	 }else{
		 html = '<div class="clearFRM"></div>\
				<div class="FormMainBox">\
				<div class="labelDiv">\
					<label>\
						Link-Type :\
					</label>\
				</div>\
				<div class="InputDiv">\
				<div>\
				    <input type="text" name="linkTypes" id="pageMetaTag" ></input>\
					</div>\
						<div id="pageMetaTag_error" class="fieldError"></div>\
				</div>\
			</div>\
			<div class="FormMainBox">\
				<div class="labelDiv">\
					<label>\
						Link-Rel:\
					</label>\
				</div>\
				<div class="InputDiv" style="height:50px">\
					<div>\
					<input type="text" name="linkRels" value="" id="pageKeyword" applyscript="true"></input>\
					</div>\
						<div id="pageKeyword_error" class="fieldError"></div>\
				</div>\
			</div>\
			<div class="FormMainBox">\
			<div class="labelDiv">\
				<label>\
					Link-Href:\
				</label>\
			</div>\
			<div class="InputDiv" style="height:50px">\
				<div>\
				<input type="text" name="linkHrefs" value="" id="pageKeyword" applyscript="true"></input>\
				</div>\
					<div id="pageKeyword_error" class="fieldError"></div>\
					<div id="moreTags"><a onclick="moreTags(this,\'Link\')">Add More Links</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="removeTags(this,\'Link\')">Remove</a></div>\
			</div>\
		</div>';
	 }
	 
	 $(ele).parent().parent().parent().after(html);
	 //$(ele).next().remove();
	 $(ele).remove();
	 
 }
 
 function removeTags(ele,tag){
	 var parent = $(ele).parent().parent().parent();
	 if(tag=="Meta"){
		 $(parent).prev().remove();
		 $(parent).prev().remove();
		 if($(ele).prev().html()!=undefined)
		 	$($(parent).prev().find('#moreTags').get(0)).html('<a onclick="moreTags(this,\'Meta\')">Add More Meta Tags</a>'+ $($(parent).prev().find('#moreTags').get(0)).html());
		 $(parent).remove();
	 }else{
		 $(parent).prev().remove();
		 $(parent).prev().remove();
		 $(parent).prev().remove();
		 if($(ele).prev().html()!=undefined)
			 $($(parent).prev().find('#moreTags').get(0)).html('<a onclick="moreTags(this,\'Link\')">Add More Links</a>'+$($(parent).prev().find('#moreTags').get(0)).html());
		 $(parent).remove();
	 }
	 
 }
 
 var countG =1;
 function addGraphicsNew(){
	  var domainId = $("#domainId").val();
	  var jsonList = '["languageList","currencyList"]';
	  var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
	  var html = '<div class="FormSectionMenu innerBox"><div class="FormMainBox"><div class="labelDiv"><label>Language:</label><em class="Req">*</em></div><div class="InputDiv"><select class="select1" name="languageList" applyscript="true" id="languageList'+countG+'"></select></div></div><div class="FormMainBox"><div class="labelDiv"><label>Currency:</label><em class="Req">*</em></div><div class="InputDiv"><select class="select1" applyscript="true" name="currencyList" id="currencyList'+countG+'"></select></div></div><div class="FormMainBox"><div class="labelDiv"><label>Graphics:</label><em class="Req">*</em></div><div class="InputDiv"><input type ="file" applyscript="true" name="graphicsPath" id="path'+countG+'"/></div></div></div>';
	  $("#graphics_new_div").append(html);
	  $('#languageList'+countG).empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  $('#currencyList'+countG).empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  
	  $.each(jsonmap["currencyList"], function(index, value) {
			$('#currencyList'+countG).append($('<option></option>').val(value.currencyId).html(value.currName));
	  });
		
	  $.each(jsonmap["languageList"], function(index, value) {
			$('#languageList'+countG).append($('<option></option>').val(value.languageId).html(value.languageName));
	  });
	  
  countG++;
  createBubble();
 }

 
function getPreview(id){
	var domainId = $("#domainId").val();
	var resp;	
	$.post("com/stpl/pms/action/bo/cms/st_pms_page_showPreview.action", $(
				"#" + id).serialize(), function(result, arguements, text) {
			resp = text.responseText;
			var resparray = resp.split("~");
			var url;
			var domainName = $("#domainId > option[value='" + domainId + "']")
					.html();
			url =  "/portal/cms-preview/"+resparray[1]+domainName+ "/"+resparray[2]+"/LR/"+resparray[3]+"/temp/"
			+ resparray[0];
			window.open(url, '', 'width=800,height=400,scrollbars=yes');
		}); 
			
}
function closePreview(){
	var domainId=$("#domainId").val();
	var device=$("#device").val();
	var pageType=$("#pageType").val();
	_ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_page_closePreview.action?domainId="+domainId+"&device="+device+"&pageType="+pageType);
}
 