$(function() {
	var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>", tabCounter = 1;
	var tabs = $("#tabs").tabs();	
	$('div[id*="tabs-"]').hide();
	$("#tabs-1").show();	
	$( "div[id='paymentProviderDiv'] li,div[id*='podmCharge-'] li" ).draggable({
		appendTo: "body",
		helper: "clone",
	});
	$( "div[id*='podmCharge-'],div[id='paymentProviderDiv']" ).droppable({
		activeClass: "ui-state-default hovering",
		hoverClass: "ui-state-hover",
		accept: ":not(.ui-sortable-helper)",
		drop: function( event, ui ) {
			// alert(ui.draggable.attr('id'));
			shiftMainToExisting($(this).children("ul"),ui.draggable);
		}
	});

	
	function addTab() {
		var id = "tabs-new-" + tabCounter;
		var li = $(tabTemplate
				.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, "Process Charge New " + tabCounter));
		var tabContentHtml = '<table> <input type="hidden" id="processingChargeId" value="-'+tabCounter+'" name=""> <tbody>';
		tabContentHtml += '<tr><td class="tdLabel"><label class="label" for="charge1Type">Charge Type 1:</label></td> <td><select id="charge1Type" name=""> <option value="-1">--Please Select--</option> <option value="FIXED">FIXED</option> <option value="PERCENT">PERCENT</option> <option value="-">-</option> </select> </td> </tr>';
		tabContentHtml += '<tr><td class="tdLabel"><label class="label" for="charge1Value">Charge Value 1:</label></td> <td><input type="text" id="charge1Value" value="" name=""></td> </tr>';
		tabContentHtml += '<tr><td class="tdLabel"><label class="label" for="charge2Type">Charge Type 2:</label></td> <td><select id="charge2Type" name=""> <option value="-1">--Please Select--</option> <option value="FIXED">FIXED</option> <option value="PERCENT">PERCENT</option> <option value="-">-</option> </select> </td> </tr>';
		tabContentHtml += '<tr> <td class="tdLabel"><label class="label" for="charge2Value">Charge Value 2:</label></td> <td><input type="text" id="charge2Value" value="" name=""></td> </tr>';
		tabContentHtml += '<tr> <td class="tdLabel"><label class="label" for="relation">Relation:</label></td> <td><select id="relation" name=""> <option value="-1">--Please Select--</option> <option value="MAX">MAX</option> <option value="SUM">SUM</option> <option value="-">-</option> </select> </td> </tr>';
		tabContentHtml += '<tr> <td class="tdLabel"><label class="label" for="maxValue">Max Value:</label></td> <td><input type="text" id="maxValue" value="" name=""></td> </tr>';
		tabContentHtml += '</tbody></table><div class="css-treeview" id="podmChargeNew-'+tabCounter+'"> <h1 class="ui-widget-header"> Payment Options </h1> <ul id="payTypeUL"></ul> </div>';
		tabs.find(".ui-tabs-nav").append(li);
		tabs.append("<div id='" + id + "'>" + tabContentHtml + "</div>");
		tabs.tabs("refresh");
		$('#podmChargeNew-'+tabCounter).draggable({
			appendTo: "body",
			helper: "clone",
		}).droppable({
			activeClass: "ui-state-default hovering",
			hoverClass: "ui-state-hover",
			accept: ":not(.ui-sortable-helper)",
			drop: function( event, ui ) {
				// alert(ui.draggable.attr('id'));
				shiftMainToExisting($(this).children("ul"),ui.draggable);
			}
		});
		tabCounter+=1;
	}

	// addTab button: just opens the dialog
	$("#add_tab").click(function() {
		addTab();
	});

	// close icon: removing the tab on click
	tabs.delegate("span.ui-icon-close", "click", function() {
		var panelId = $(this).closest("li").remove().attr("aria-controls");
		$("#" + panelId).remove();
		tabs.tabs("refresh");
	});

	tabs.bind("keyup", function(event) {
		if (event.altKey && event.keyCode === $.ui.keyCode.BACKSPACE) {
			var panelId = tabs.find(".ui-tabs-active").remove().attr(
					"aria-controls");
			$("#" + panelId).remove();
			tabs.tabs("refresh");
		}
	});
});

$(function() {
	
});

function shiftMainToExisting(existingUL,draggedObj){
	// alert(existingUL.find('#'+draggedObj.attr('id')).length+'*********'+draggedObj.attr('id'));
	var objId=existingUL.find('#'+draggedObj.attr('id'));
	if(objId.length>0){
		draggedObj.children('ul').children('li').each(function(){
			var mainLI=$(this);
			isLiExist=true;
			objId.children('ul').children('li').each(function(){
				if(mainLI.attr('id')==$(this).attr('id')){
					shiftMainToExisting(existingUL,mainLI);
					isLiExist=false;
				}
			});
			if(isLiExist){
				objId.children('ul').append(mainLI);
			}
		});
		draggedObj.remove();
	}else{
		objId=existingUL.find('#'+draggedObj.parent().attr('id'));
		if(objId.length>0){
			objId.append(draggedObj);
		}else{
			objId=existingUL.find('#'+draggedObj.parent().parent().parent().attr('id'));
			if(objId.length>0){
				objId.append(draggedObj.parent().parent().clone());
				objId=existingUL.find('#'+draggedObj.parent().attr('id'));
				objId.empty();
				shiftMainToExisting(existingUL,draggedObj);
			}else{
				if(draggedObj.attr('id').indexOf('providerLi')!=-1){
					existingUL.append(draggedObj.parent().parent().parent().parent().clone());
					objId=existingUL.find('#'+draggedObj.parent().parent().parent().attr('id'));
					objId.empty();
					shiftMainToExisting(existingUL,draggedObj);
				}else if(draggedObj.attr('id').indexOf('paySubTypeLi')!=-1){
					existingUL.append(draggedObj.parent().parent().clone());
					objId=existingUL.find('#'+draggedObj.parent().attr('id'));
					objId.empty();
					shiftMainToExisting(existingUL,draggedObj);
				}else if(draggedObj.attr('id').indexOf('payTypeLi')!=-1){
					existingUL.append(draggedObj);
				}
			}
		}
		
	}
}

function prepareData(){
	var tabsDiv=$("#tabs").find("[id^='tabs-']");
	
	var str='[{';
	tabsDiv.each(function(){		
		//alert($(this).attr('id'));
		var objArr;
		//if($(this).is(':visible')){
			objArr=$(this).find('table').find('input,select');
			objArr.each(function(){
				str+='"'+$(this).attr('id')+'":"'+$(this).val()+'",';
			});
			
			
		/*}else{
			return false;
		}*/
		
		var ulPodm=$(this).find('.css-treeview').find('input[name="podmId"]');
			if(ulPodm.length>=1){
			str+='"podmId":[';
			ulPodm.each(function(){
				str+=$(this).val()+',';
			});
			str=str.substring(0,str.length-1);
			str+=']';
		}else{
			str=str.substring(0,str.length-1);
			
		}
		str+='},{';
	});
	str=str.substring(0,str.length-2)+']';
	
	$('#podmProcessingChargeStr').val(str);
	
	return true;
			
}