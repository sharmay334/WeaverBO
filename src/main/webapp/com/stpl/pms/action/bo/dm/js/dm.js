function checkForm(val) {
	var flag = false;
	$("#secQues").removeAttr("applyscript");
	$(".payTransaction input:checkbox").each(function() {
		if (this.checked) {
			flag = true;
		}
	});
	if (!flag) {
		alert(val);
	}
	return flag;
}

function editField(indx, domainId, newFieldDiv) {
	var res = _ajaxCallDiv('com/stpl/pms/action/bo/dm/st_pms_dm_bo_editReferenceLabels.action?refIndex='
			+ indx + '&domainId=' + domainId, '', newFieldDiv);
	createBubble();
	return false;
}
function setLabel(th, length, setType, lbValuesList, lbValuesList1) {
	$("#label1Error").html("");
	$("#label2Error").html("");
	$("#label3Error").html("");
	var lt = $("#"+lbValuesList);
	var lt1 = $("#"+lbValuesList1);

	if (setType == 'List' || length > 0) {
		if ($(th).val() != 'List') {
			lt.css("display","none");
		} else {
			lt.css("display","block");
		}
	} else if (setType != 'List') {
		if ($(th).val() == 'List') {
			lt1.css("display","block");
		} else {
			lt1.css("display","none");
		}
	}
	createBubble();
	return false;
}
function addNewOption(labelOption, checkbox, labelValue) {
	var flag = false;
	var lastRow = $("#"+labelOption+' tr').length;
	var value = $("#"+labelOption+' tr:last').find('td:eq(1) input[type="text"]').val();
	$("#"+labelOption+' tr').find('td:eq(1) input[type="text"]').each(function(index){
		if($(this).val().trim() == ""){
			alert("Option" + (index+1) + " available..");
			flag = true;
			return false;
		}
		if (index < lastRow - 1 && $(this).val().toLowerCase().trim() == value.toLowerCase().trim()) {
			alert("duplicate option " + value);
			flag = true;
			return false;
		}
	});
    if(flag){
      return false;
	}
	var html = '<tr><td><input type="checkbox" value="'+lastRow+'" name="'+checkbox+'"></td><td><input type="text" patternon="both" maxlength="50" name="'+labelValue+'"></td></tr>';
	$("#"+labelOption).append(html);
	return false;
}

function setLabelAdd(th, lbValuesList) {
	$("#label1TypeError").html("");
	$("#label2TypeError").html("");
	$("#label3TypeError").html("");
	var lt = $("#"+lbValuesList);
	if ($(th).val() == 'List') {
		lt.css("display","block");
	} else {
		lt.css("display","none");
	}
}

function addToRefList(type) {
	$('div[id*="error"]').html("");
	$('div[id*="Error"]').html("");
	var refNmae = $('#refNmae').val();
	var label1 =  $('#label1').val();
	var label1Type =  $('#label1Type').val();
	var label2 =  $('#label2').val();
	var label2Type =  $('#label2Type').val();
	var label3 =  $('#label3').val();
	var label3Type =  $('#label3Type').val();
	var regExp = new RegExp("^[A-Za-z ]*$");
	if (label2.trim() != ""
			&& label1.toLowerCase().trim() == label2.toLowerCase().trim()) {
		$("#label2Error").html("Duplicate value of Label");
		return false;
	}
	if (label3.trim() != ""
			&& (label1.toLowerCase().trim() == label3.toLowerCase().trim() || label2
					.toLowerCase().trim() == label3.toLowerCase().trim())) {
		$("#label3Error").html("Duplicate value of Label");
		return false;
	}
	
	var returnFunctn = false;
	$('div[id^="lbValues"]').each(function() {
		var flag1 = true;
		var flag2 = true;
		var flag3 = false;
		var duplicateValue;
		var list = $(this).attr('id');
		if ($("#" + list).css("display") == "block") {
			$("#" + list + " input").each(function() {
				if ($(this).attr('type') == "text") {
					if ($(this).val().trim() != "") {
						flag1 = false;
					}
					var val = $(this).val().trim();
					var count = 0;
					$("#"+ list+ " input:text").each(function() {
						if ($(this).val().trim() != ""&& $(this).val().trim().toLowerCase() == val.toLowerCase()) {
							count++;
						}
					});
					if (count > 1) {
						flag3 = true;
						duplicateValue = $(this).val();
						return false;
					}
				}
				if ($(this).attr('type') == "checkbox"&& $(this).is(':checked')) {
					flag2 = false;
				}
		    });
		if (flag1) {
			$("#error" + list).html("List must have atlest one value");
			returnFunctn = true;
			return false;
		}
		if (flag2) {
			$("#error" + list).html("List must have atlest one value checked");
			returnFunctn = true;
			return false;
		}
		if (flag3) {
			$("#error" + list).html("duplicate value of " + duplicateValue+ " in list");
			returnFunctn = true;
			return false;
		}
	}
		});
	if (returnFunctn) {
		return false;
	}
	if (refNmae.trim() == "") {
		return false;
	}
	if (label1Type == "-1" || label1.trim() == "") {
		return false;
	}
	
	if (label2Type != "-1" && label2.trim() == "") {
		$("#label2").attr("applyscript","true");;
		return false;
	}
	
	if (label2Type == "-1" && label2.trim() != "") {
		$("#label2Type").attr("applyscript","true");;
		return false;
	}
	if (label3Type != "-1" && label3.trim() == "") {
		$("#label3").attr("applyscript","true");
		return false;
	}
	if (label3Type == "-1" && label3.trim() != "") {
		$("#label3Type").attr("applyscript","true");
		return false;
	}
	if (label2Type == "-1" && label2.trim() == "") {
		$("#label2").removeAttr("applyscript");
		$("#label2Type").removeAttr("applyscript");;
	}
	if (label3Type == "-1" && label3.trim() == "") {
		$("#label3").removeAttr("applyscript");
		$("#label3Type").removeAttr("applyscript");
	}
	// var uId = document.getElementById('userId').value;
	if(label1Type == "-1"){
		label1Type = "";
	}
	if(label2Type == "-1"){
		label2Type = "";
	}
	if(label3Type == "-1"){
		label3Type = "";
	}
	if(type == "add")	{
		var lastRow = ($("#payTransaction tr").length)-1;
		var action = "com/stpl/pms/action/bo/dm/st_pms_dm_bo_removeFromReferralsList.action?refIndex=" + lastRow+",''";
		var html = '<tr><td><input id="refId" type="checkbox" name="refId" value="'+lastRow+'" checked="checked"></td><td>'+refNmae+'</td><td>'+label1+'</td><td>'+label1Type+'</td><td>'+label2+'</td><td>'+label2Type+'</td><td>'+label3+'</td><td>'+label3Type+'</td><td><a style="cursor: pointer" onclick="return removeRow('+lastRow+')">Remove </a></td></tr>';
		$("#payTransaction").append(html);
	}else{
		var index = $("#refIndex").val();
		index++;
		var row = $("#payTransaction tr").eq(index);
		row.find("td:eq(1)").html(refNmae);
		row.find("td:eq(2)").html(label1);
		row.find("td:eq(3)").html(label1Type);
		row.find("td:eq(4)").html(label2);
		row.find("td:eq(5)").html(label2Type);
		row.find("td:eq(6)").html(label3);
		row.find("td:eq(7)").html(label3Type);
	}
	createBubble();
	

}

function removeRow(iteration) {
	_ajaxCallText('com/stpl/pms/action/bo/dm/st_pms_dm_bo_removeFromReferralsList.action?refIndex=' + iteration,'');
	$("#payTransaction tr").eq(iteration).remove();
	return false;
}

function checkUncheckAll(evt, cId, sId) {
	evt.stopPropagation();
	var flag = true;
	$(".accordianHeader input:checkbox").each(function() {
		if (!this.checked) {
			flag = false;
		}
	});
	if (flag == true) {
		$("#selectAll").attr('checked', true);
	} else {
		$("#selectAll").attr('checked', false);
	}
	if ($('#'+cId+' input[type="checkbox"]').attr('checked')) {
		$("#"+sId+' input[type="checkbox"]').each(function(){
			$(this).attr("checked",true);
		});
	} else {
		$("#"+sId+' input[type="checkbox"]').each(function(){
			$(this).attr("checked",false);
		});
	}

}

function check(th, cId, aId) {
	var flag = true;
	if ($(th).attr('checked')) {
		$('#'+cId+' input[type="checkbox"]').attr('checked',true);
		$("#"+aId+' input[type="checkbox"]').each(function(){
			if(!$(this).attr("checked")){
				flag = false;
			}
		});
		if (flag) {
			$("#selectAll").attr('checked',true);
		} else {
//			$('#'+cId+' input[type="checkbox"]').attr('checked',false);
			$("#selectAll").attr('checked',false);
		}
	} else {
//		$('#'+cId+' input[type="checkbox"]').attr('checked',false);
		$("#selectAll").attr('checked',false);
		$("#"+aId+' input[type="checkbox"]').each(function(){
			if($(this).attr("checked")){
				flag = false;
			}
		});
		if (flag) {
			$('#'+cId+' input[type="checkbox"]').attr('checked',false);
		} else {
			$('#'+cId+' input[type="checkbox"]').attr('checked',true);
		}
	}

}

function selectAllCon(th) {
	var con = document.getElementsByTagName("INPUT");
	if ($(th).attr('checked')) {
		$('input[type="checkbox"]').each(function(){
				$(this).attr("checked",true);
		});
	} else {
		$('input[type="checkbox"]').each(function(){
			$(this).attr("checked",false);
	    });
	}

}

function submitfrm() {
	var flag = false;
	$('input[type="checkbox"]').each(function(){
		if($(this).attr("checked")){
			flag = true;
		}
    });
	if (!flag) {
		alert("All countries and states can not be blocked");
		return false;
	}

}

function chkvaliEmail() {
	var c = false;
	document.getElementById('reason_error').innerHTML = "";
	if ($('#reason').val() == "") {
		document.getElementById('reason_error').className = "fieldError";
		document.getElementById('reason_error').innerHTML = "Reason for Block E-mail cannot be blank";
		return false;
	}
	$("#Container :text").each(function() {
			if ($(this).val() != "") {
				if (ValidateEmail($(this).val()) == false) {
					c = "correct";
				}
				else {
					c = true;
					return false;
				}
			}
		});
	if (c == "correct") {
		return false;
	}
	if (c == false) {
		alert("please insert new E-mail address");
		return false;
	}
}
function chkvali() {
	var c = false;
	document.getElementById('reason_error').innerHTML = "";
	if ($('#reason').val() == "") {
		document.getElementById('reason_error').className = "fieldError";
		document.getElementById('reason_error').innerHTML = "Reason for Block IP cannot be blank";
		return false;
	} else
		$("#Container :text").each(function() {
			//
				if ($(this).val() != "") {
					if (fnValidateIPAddress($(this).val()) == false) {
						// $(this).focus();
						c = "correct";
					}
					// }
					else {
						c = true;
						return false;
					}
				}
			});
	if (c == "correct") {
		return false;
	}
	if (c == false) {
		alert("please insert new ip address");
		return false;
	}
}
function chkvaliNo() {
	var c = false;
	document.getElementById('reason_error').innerHTML = "";
	if ($('#reason').val() == "") {
		document.getElementById('reason_error').className = "fieldError";
		document.getElementById('reason_error').innerHTML = "Reason for Block Number cannot be blank";
		return false;
	}
	$("#Container :text").each(function() {
			if ($(this).val() != "") {

				c = true;
				return false;
			}
		});
	if (c == "correct") {
		return false;
	}
	if (c == false) {
		alert("please insert new Phone Number");
		return false;
	}
}



function fnValidateIPAddress(e) {
	// Remember, this function will validate only Class C IP.
	// change to other IP Classes as you need
	var ipaddr = e;
	if (ipaddr == "") {
		alert("please insert the ip Address");
		// e.focus();
		return false;
	} else {
		ipaddr = ipaddr.replace(/\s/g, ""); // remove spaces for checking
		var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/; // regex. check for
															// digits and in
		// all 4 quadrants of the IP
		if (re.test(ipaddr)) {
			// split into units with dots "."
			var parts = ipaddr.split(".");
			// if the first unit/quadrant of the IP is zero
			if (parseInt(parseFloat(parts[0])) == 0) {
				alert("Please insert correct ip address");

				return false;
			}
			// if the fourth unit/quadrant of the IP is zero
			if (parseInt(parseFloat(parts[3])) == 0) {
				alert("Please insert correct ip address");
				return false;
			}
			// if any part is greater than 255
			for ( var i = 0; i < parts.length; i++) {
				if (parseInt(parseFloat(parts[i])) > 255) {
					alert("Please insert correct ip address");
					return false;
				}
			}
			return true;
		} else {
			alert("Please insert correct ip address ");
			return false;
		}
	}
}
function fetchState(param) {
	var action = 'fetchState.action?countryCode = ' + param;
	var stateArr = _ajaxCallText(action, param).replace('{', '').replace('}',
			'').split(',');

	var stateList = document.getElementById("stateList");
	// var stateList = _id.o('stateList');
	stateList.options.length = 0;
	stateList.options[0] = new Option('--Please Select--', '-1');
	for ( var i = 1; i <= stateArr.length; i += 1) {
		var state = stateArr[i - 1].split('=');
		stateList.options[i] = new Option(state[1], state[0]); // new
																// Option(value,key);
	}
}

function getList() {
	var given = document.getElementById('plrPassword').value;
	var sendList = document.getElementById("sendPassword");
	var firstList = document.getElementById("firstAutoVeri");
	var some = document.getElementById('UserGiven')
	if (given == "PLAYER_GIVEN") {
		some.style.display = 'none';
		sendList.options[0] = new Option(' ');
		firstList.options[0] = new Option(' ');
	} else if (given == "RANDOM") {
		some.style.display = 'block';
		sendList.options[0] = new Option('EMAIL');
		sendList.options[1] = new Option('MOBILE');
		firstList.options[0] = new Option('Email');
		firstList.options[1] = new Option('MOBILE');
	}
}

function getVerification() {

	var given = document.getElementById('firstAutoVeri').value;
	var firstList = document.getElementById("VeriThrough");
	if (given == "EMAIL") {
		// firstList.removeChild(select[value]);
		firstList.options[0] = new Option("CODE");
		firstList.options[1] = new Option("LINK");
	} else if (given == "MOBILE") {

		// alert("hwello");
		// firstList.removeChild(firstList[given]);
		// alert($('#VeriThrough').val());
		$('#VeriThrough').empty();
		firstList.options[0] = new Option("CODE");
	}
}

function defLanguage(e, values, key) {
	var firstList = document.getElementById("DefLanguage");

	if (e.checked) {
		// $("#Language").show();

		firstList.appendChild(new Option(values, key));

	} else {

		for (i = firstList.options.length - 1; i >= 0; i--) {
			// alert(firstList.options[i].value);
			if (firstList.options[i].value == key) {
				firstList.remove(i);
			}

		}

	}
}

function checkcurrency(e, values, key) {
	var firstList = document.getElementById("DefCurrency");

	if (e.checked) {
		// $("#Currency").show();
		firstList.appendChild(new Option(values, key));

	} else {

		for (i = firstList.options.length - 1; i >= 0; i--) {
			// alert(firstList.options[i].value);
			if (firstList.options[i].value == key) {
				firstList.remove(i);
			}

		}

	}
}

//menu management
function prepareData() {
$('div[class*="UIaccordian"]').accordion( {
        
        active : 0
    });
	var data = '{';
	var tlb1 = $("#main");
	if($("#menuType").val().trim()=="edit"){
	  data = getFieldEditData(tlb1, data, "");
	}else{
		data = getFieldData(tlb1, data, "");
	}
	if ($('div[id^="sub_"]').length != 0) {
		data += ',"subMenuList":[{';
		$('div[id^="sub_"]').each(function(i) {
							var subTlbId = $(this).attr('id').split('_');
							if($("#menuType").val().trim()=="edit"){
							   data = getFieldEditData($(this), data, "_"+ subTlbId[1]);
							}else{
								data = getFieldData($(this), data, "_"+ subTlbId[1]);
							}
							if ($('div[id^="level3_' + subTlbId[1] + '_"]').length != 0) {
								data += ',"subMenuList":[{';
								$('div[id^="level3_' + subTlbId[1]+ '_"]').each(function() {
									var level3 = $(this).attr('id').split('_');
									if($("#menuType").val().trim()=="edit"){
										data = getFieldEditData($(this), data, "_"+ level3[1]+ "_"+ level3[2]) + '},{';
									}else{
										data = getFieldData($(this), data, "_"+ level3[1]+ "_"+ level3[2]) + '},{';
									}
									
												});
								data = data.substring(0, data.length - 2);
								data += ']';
							}
							data += '},{';
						});
		data = data.substring(0, data.length - 2);
		data += ']';

		
	}
	data += '}';
   $("#menuString").val(data);
	return data;
}
	

function fetchIdVal(obj,name,id){
		return '"'+name+'":"'+obj.find(id).val()+'",';
	}
function getFieldEditData(obj,data,val){
	data=data+fetchIdVal(obj,'displayName','input[id="displayName'+val+'"]');
	//data=data+fetchIdVal(obj,'showBeforeLogin','input[name="showBeforeLogin'+val+'"]:checked');
	data=data+fetchIdVal(obj,'status','input[name="status'+val+'"]:checked');
	data=data+fetchIdVal(obj,'contentType','select[id="contentType'+val+'"]');
	data=data+fetchIdVal(obj,'contentName','select[id="contentName'+val+'"]');
	data=data+fetchIdVal(obj,'menuId','input[id="menuId'+val+'"]');
	data=data+fetchIdVal(obj,'highLightOpt','input[name="highLightOpt'+val+'"]:checked');
	data=data.substring(0,data.length-1);
	return data;
}

function getFieldData(obj,data,val){
	data=data+fetchIdVal(obj,'displayName','input[id="displayName'+val+'"]');
//	data=data+fetchIdVal(obj,'showBeforeLogin','input[name="showBeforeLogin'+val+'"]:checked');
	data=data+fetchIdVal(obj,'contentType','select[id="contentType'+val+'"]');
	data=data+fetchIdVal(obj,'contentName','select[id="contentName'+val+'"]');
	data=data.substring(0,data.length-1);
	return data;
}

function previewData(){
	createBubble();
	var data1 = prepareData();
	var data = '['+data1+']';
		var jsonMap = $.parseJSON(data);
		var mainMenu = '<ul style="background-color: #161616;-moz-border-radius:6px 6px 0px 0px;-webkit-border-radius:6px 6px 0px 0px;background-position: left top;background-repeat: repeat-x;border: 0 solid white;font-size: 13px;font-weight: bold;height: 30px;overflow: hidden;position: relative;text-align: left;width: 100%;z-index: 99;">';
        var subMenu = '';
        for ( var i = 0; i < jsonMap.length; i++) {
        	if(typeof(jsonMap[i].status)=="undefined" || jsonMap[i].status=="ACTIVE")
           		mainMenu = mainMenu + '<li style="background: none repeat scroll 0 0 transparent;display: inline;padding: 0 8px;position: relative;text-transform: uppercase;top: 7px;"><a style="padding-left: 13px;color: #9c9c9c;text-decoration: none !important;outline: none;">' + jsonMap[i].displayName+ '</a></li>';
                var menuBeanList1 = jsonMap[i].subMenuList;
                if(menuBeanList1!=null){
                 for ( var j = 0; j < menuBeanList1.length; j++) {
                	 if(typeof(menuBeanList1[j].status)=="undefined" || menuBeanList1[j].status=="ACTIVE") {
	                    containSubMenu = true;
	                    subMenu = subMenu + '<h3 style="font: bold 12px Verdana, Arial;color: white;background:#d10000;margin-bottom: 4px;text-transform: capitalize;padding: 4px 0 4px 10px;" class="menuheader expandable">';
	                    subMenu = subMenu+ menuBeanList1[j].displayName + '</h3><ul style="list-style-type: none;margin: 0;padding: 0;margin-bottom: 8px;">';
	                }
                    if (menuBeanList1[j].subMenuList) {
                        var menuBeanList2 = menuBeanList1[j].subMenuList;
                        if(menuBeanList2!=null){
                        	  for ( var k = 0; k < menuBeanList2.length; k++) {
                        		  if(typeof(menuBeanList2[k].status)=="undefined" || menuBeanList2[k].status=="ACTIVE") 
                        		 subMenu = subMenu + '<li style="padding-bottom: 2px;"><a style="color: #ffffff;display: block;padding: 4px 0;padding-left: 12px; text-decoration: none;font-weight: bold;border-bottom: 1px solid #dadada;font-size: 11px;">'+ '<span style="margin-left:8px; font-weight:normal; color:#000; color:#FFF; display:block;" class="mininav">'+ menuBeanList2[k].displayName+ '</span></a></li>';
                        	}
                        }
                      
                        subMenu = subMenu + '</ul>'
                    }
                }
                }
               
                subMenu = subMenu + '</ul>';
        }
        mainMenu = mainMenu + '</ul>';
        
	   var html = '<html><head></head> <body style="background-color:rgb(153, 0, 0);"> <div style="width: 100%;height: auto;margin-top: 5px;">'+mainMenu+'</div><div style="width: 173px;" id="subNavbox">'+subMenu+'</div> </body></html>';
	   newwindow=window.open('#', 'newWindow', 'resizable=no,width=970,height=730,status=no');
       newdocument=newwindow.document;
       newdocument.write(html);
       newdocument.close();
	        
}

function getContentNameList(id){
	var contentType = $("#"+id).val();
	if(contentType == "-1"){
	return false;
	}
	var contentMap = $("#contentMap").val();
    var contentMapJSON = $.parseJSON(contentMap);
    var contentBeanList = contentMapJSON[contentType];
	var contentNameId=id.replace('contentType','contentName');
	$('#'+contentNameId).empty().append($('<option></option>').val("-1").html("----Please Select----"));;
	if(contentBeanList!=null){
	  $.each(contentBeanList, function(i,value) {
		  $('#'+contentNameId).append(
				  $('<option></option>').val(value.contentId).html(value.contentName));
	  });
	}
	return false;
}


function checkStatus(name) {
    var countAll = name.split("_");
	    if(name == "status" && $('input[name="status"]:checked').val()=='ACTIVE'){
	    	$("input[name*='status']").each(function(){
	    	 var levels = $(this).attr("name").split("_");
	    	 if(levels.length == 2){
	    	  $(this).removeAttr("disabled");
	    	 }
	    	}) ;
	    }
	    else if(name == "status" && $('input[name="status"]:checked').val()=='INACTIVE'){
	    	$("input[name*='status_']").attr('checked', 'INACTIVE').attr('disabled', 'disabled');
	    }
	  if(countAll.length==2){
	    var count = countAll[1];
	    if($('input[name="status_'+count+'"]:checked').val()=='ACTIVE'){
	    	$('input[name*="status_'+count+'_"]').removeAttr("disabled"); 
	    }
	    else if($('input[name="status_'+count+'"]:checked').val()=='INACTIVE'){
	    	$('input[name*="status_'+count+'_"]').attr('checked', 'INACTIVE').attr('disabled', 'disabled');
			$('input[name="status_'+count+'"]').removeAttr('disabled');
	    
	    }
    }
}

function getMenuDiv(){
    var device = $("#device").val();
	    if($("#domainName").val()!="-1" && device!="-1")
	    {
	    var menuList = _ajaxCallText('com/stpl/pms/action/bo/dm/st_pms_dm_loadEditMenu.action?device='+device+'&aliasId='+$("#aliasId").val()+'', '');
	    var menuListJSON = $.parseJSON(menuList);
	    $('#menu').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		  for(var i = 0;i<menuListJSON.length;i++){
			$('#menu').append(
								$('<option></option>').val(
										menuListJSON[i].menuId).html(
										menuListJSON[i].menuDisplayName));
			}
	    }
		    
		   return false;
  }
  
function addLevel3(id){
	createBubble();
	  var arr = id.split('_');
	  var count1 = arr[1];
	  var count2 = $('div[id*="level3_'+arr[1]+'"]').length;
	  var content = $("#addContent").html();
	  var html = '<div style="width: 95%;" class="FormSection UIaccordian" id="level3_'+count1+'_'+count2+'"><div class="accordianHeader greyStrip" style="margin-top: -3px;width:780px"><h4>Add Menu Level3 Detail:</h4></div><div  class="accordian_content" id="accordian_content_'+count1+'_'+count2+'" style="width: 750px">'+content+'</div></div>';
	  $("#level3Content_"+arr[1]).append(html);
	  $('#level3_'+count1+'_'+count2+' input[id="displayName"]').attr("id","displayName_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' select[id="contentType"]').attr("id","contentType_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' select[id="contentName"]').attr("id","contentName_"+count1+"_"+count2);

	 $(".UIaccordian").accordion( {
                     collapsible : true,
                     clearStyle : true,
                     header : 'div[class*="accordianHeader"]',
                     icons : {header : "plus1",headerSelected : "minus1"
                     },
                     active : 0
             });
	 $(".accordianHeader").click(function( event ) {
	        createBubble();
       });
}

function addLevel2(){
	
	var count = $("#count").val();
	 var content = $("#addContent").html();
	 var html = '<div style="width: 95%;" class="FormSection UIaccordian" id="sub_'+count+'"><div class="accordianHeader greyStrip" style="margin-top: -3px;width:850px"><h4>Add Menu Level2 Detail:</h4></div><div  class="accordian_content" id="accordian_content_'+count+'" style="width: 820px">'+content+'<div id="level3Content_'+count+'"></div><div class="box_footer" align="right" style="background: #f2f2f2; border: none;font-size: 11px"><input id="addSubMenu3_'+count+'" class="button" type="button" value="Add Level3" onclick="addLevel3(this.id)"/></div></div></div>';
	 $("#level2Content").append(html);
	 $('#sub_'+count+' input[id="displayName"]').attr("id","displayName_"+count);
	 $('#sub_'+count+' select[id="contentType"]').attr("id","contentType_"+count);
	 $('#sub_'+count+' select[id="contentName"]').attr("id","contentName_"+count);
	 createBubble();
	    count++;
	    $("#count").val(count);
	    $(".UIaccordian").accordion( {
                      collapsible : true,
                      clearStyle : true,
                      header : 'div[class*="accordianHeader"]',
                      icons : {header : "plus1",headerSelected : "minus1"
                      },
                      active : 0
              });	
              
              $(".accordianHeader").click(function( event ) {
		        createBubble();
              });
}
