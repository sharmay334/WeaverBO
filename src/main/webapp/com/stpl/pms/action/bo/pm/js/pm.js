
		
		  function manageField(currElem){
		           var chkBox =  $(currElem);
		           var trelem = chkBox.closest("tr");
		           if(chkBox.is(":checked")){
                         $(trelem).find('input').removeAttr('disabled');
                         $(trelem).find('select').removeAttr('disabled');
                      }
                   else{
                         $(trelem).find('input[type!="checkbox"]').attr('disabled','disabled');
                         $(trelem).find('select').attr('disabled','disabled'); 
                   } 
		  }

		  function deleteField(fieldId,currentElement){
								
	    	    			
	    	    					
	    	    					
	    	    				var len = $('.addedRows').find("td#fieldName").length;
	    	    				
	    	    				var currntEle ;
	    	    				for(var i=0; i<len ;i++)
	    	    					if($($('.addedRows').find("td#fieldName").get(i)).html()=="")
	    	    						$($('.addedRows').find("td#fieldName").get(i)).parent().attr("id","");
	    	    						
	    	    						
	    	    				currntEle = $('tr#'+currentElement);
	    	    				var row = $(currntEle).html();
	    	    				
	    	    				$(currntEle).find("#fieldDispName").hide();
								$(currntEle).find("#selectFieldType").hide();
								$(currntEle).find("#selectMini").hide();
								$(currntEle).find("a").parent().hide();
								var row1 = $(currntEle).html();
								 $(currntEle).find("#fieldDispName").show();
								$(currntEle).find("#selectFieldType").show();
								$(currntEle).find("#selectMini").show();
								$(currntEle).find("a").parent().show();
	    	    				//alert(row);
	    	    				var parent = $(currntEle).parent().parent();
	    	    				
	    	    				if($(currntEle).siblings().length == 1){
	    	    					
	    	    				
	    	    				 for(var i=0; i<$(currntEle).children().length; i++)
	    	    				 $($(currntEle).children().get(i)).empty();
	    	    				 
	    	    				 if(!$(parent).hasClass("deletedRows")){
	    	    				 
	    	    				
	    	    				$('<tr id="'+currentElement+'">'+row1+'</tr>').appendTo('.deletedRows');
	    	    					    	    				$(".deletedRows").removeClass("nolayout");
	    	    				}
	    	    				else{
	    	    				$('<tr id="'+currentElement+'">'+row+'</tr>').appendTo('.addedRows');
	    	    				$(currntEle).find("a").html("Delete");
	    	    				}
	    	    				 
	    	    				}
	    	    				else{
	    	    				
	    	    				$(currntEle).remove();
	    	    				if(!$(parent).hasClass("deletedRows")){
	    	    				$('<tr id="'+currentElement+'">'+row1+'</tr>').appendTo('.deletedRows');
	    	    				$(currntEle).find("a").parent().hide();
	    	    				$(".deletedRows").removeClass("nolayout");	    	    				
	    	    				}
	    	    				else{
	    	    				$('<tr id="'+currentElement+'">'+row+'</tr>').appendTo('.addedRows');
	    	    				$(currntEle).find("a").html("Delete");
	    	    				}
	    	    				
	    	    				 $(currntEle).find("#fieldDispName").hide();
								$(currntEle).find("#selectFieldType").hide();
								$(currntEle).find("#selectMini").hide();
	    	    				
	    	    				}
	    	    				
	    	    				
								
								
								
	    	    				redips_init();
	    	    				
								
}		

	
		
		function manageCheckBox(ele){
			if(ele.value=='Y'){
					$(ele).attr("value","N");
					
			}
			else{
				$(ele).attr("value","Y");
				
			}
}
	var regType="" ;
	
	function checkRegTypeRadio(value,domain){
		
		regType=value;
				if(domain!="-1")
					_ajaxCallDiv('bo_pm_load_fieldlist.action?domainId='+domain+'&regType='+value,'','loadfieldlist');
					else
						alert("Select a domain name.");
		
	}
	
	function ajax_call(domain){
		regType = $('input:radio[name=regType]:checked').val();
	if(domain!="-1" && regType!="")
		_ajaxCallDiv('bo_pm_load_fieldlist.action?domainId='+domain+'&regType='+regType,'','loadfieldlist');
	else if(domain=="-1")
						alert("Select a domain name.");
	
	else{
		_ajaxCallDiv('bo_pm_load_fieldlist.action?domainId='+domain,'','loadfieldlist');
		$("input:checked[id*='regType']").each(function (){
			regType = $(this).val();
		});
		$("#regTp").val(regType);
		}
	
		}
	
	function createPageTable(ele){
		var value = ele.value;
	var regExp = new RegExp("^[0-9]*$");
	
	var no = $("#masterTable").children().children().length;
	if(!regExp.test(value)){
		alert("Enter a digit only.");
		$(ele).val("");
		return false;
	}
	else if(no<value && value<10){
	for(var i=0;i<value-no;i++){
	var deletedRowsElemnt = $($(".deletedRows").children().children().get(1));
	deletedRowsElemnt.find("#fieldDispName").show();
	deletedRowsElemnt.find("#selectFieldType").show();
	deletedRowsElemnt.find("#selectMini").show();
	deletedRowsElemnt.find("a").parent().show();
	deletedRowsElemnt.find("#isShow").val("Y");
	var newhtml = deletedRowsElemnt.html();
	var newhtmlId = $(deletedRowsElemnt).attr("id");
	var dragIcon1 = $("#dragIcon1").attr("src");
	
	
	
	deletedRowsElemnt.remove();
	if(newhtml!=null){
			if(regType=="MULTIPAGE")
				$("#masterTable").append('<tr id="firstRow">	<td class="rowhandler" valign="top" style="padding-top: 5px;"><div class="drag row" style="float:right; width:16px;margin-right: 5px;" align="center"><img src="'+dragIcon1+'" id="dragIcon1"/></div></td>	<td><table class="nolayout" cellpadding="0" cellspacing="0" width="100%"><tr style="background-color: #E7E7E7; display: block; font-size: 12px;color: black; border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6;"><td colspan="7" class="mark" style="height: 30px; padding-left:6px">Page No. <input type="text" value="'+(i+1+no)+'" id="page" readonly="true" style="background: #ffffff; color:black; border:1px #c6c6c6 solid "></input> &nbsp;Page Name <input type="text" name="sectionName" value="" id="sectionName" maxlength="50" style="background: #ffffff; color:#000; font-size:12px; border:1px #c6c6c6 solid "></input><input type="hidden" name="sectionNameCode" value=""/></td></tr>	<tr><td><table id="managePaging" class="addedRows" ><tr class="mark"><th class="mark"></th><th class="mark">Field Name</th><th class="mark">Field Display Name </th><th class="mark">Mandatory	</th><th class="mark">Part of Mini-Reg</th><th class="mark">	</th></tr><tr id="'+newhtmlId+'">'+newhtml+'	</tr></table>	</td>	</tr></table><br>	</td></tr>');					
			else
				$("#masterTable").append('<tr id="firstRow">	<td class="rowhandler" valign="top" style="padding-top: 5px;"><div class="drag row" style="float:right; width:16px;margin-right: 5px;" align="center"><img src="'+dragIcon1+'" id="dragIcon1"/></div></td>	<td><table class="nolayout" cellpadding="0" cellspacing="0" width="100%"><tr style="background-color: #E7E7E7; display: block; font-size: 12px;color: black; border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6;"><td colspan="7" class="mark" style="height: 30px; padding-left:6px">Section No. <input type="text" value="'+(i+1+no)+'" id="page" readonly="true" style="background: #ffffff; color:black; border:1px #c6c6c6 solid "></input> &nbsp;Section Name <input type="text" name="sectionName" value="" id="sectionName" maxlength="50" style="background: #ffffff; color:#000; font-size:12px; border:1px #c6c6c6 solid "></input><input type="hidden" name="sectionNameCode" value=""/></td></tr>	<tr><td><table id="managePaging" class="addedRows" ><tr class="mark"><th class="mark"></th><th class="mark">Field Name</th><th class="mark">Field Display Name </th><th class="mark">Mandatory	</th><th class="mark">Part of Mini-Reg</th><th class="mark">	</th></tr><tr id="'+newhtmlId+'">'+newhtml+'	</tr></table>	</td>	</tr></table><br>	</td></tr>');					
																
		}
	else{
			if(regType!="MULTIPAGE")
				$("#masterTable").append('<tr id="firstRow">	<td class="rowhandler" valign="top" style="padding-top: 5px;"><div class="drag row" style="float:right; width:16px;margin-right: 5px;" align="center"><img src="'+dragIcon1+'" id="dragIcon1"/></div></td>	<td><table class="nolayout" cellpadding="0" cellspacing="0" width="100%"><tr style="background-color: #E7E7E7; display: block; font-size: 12px;color: black; border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6;"><td colspan="7" class="mark" style="height: 30px; padding-left:6px">Section No. <input type="text" value="'+(i+1+no)+'" id="page" readonly="true" style="background: #ffffff; color:black; border:1px #c6c6c6 solid "></input> &nbsp;Section Name <input type="text" name="sectionName" value="" id="sectionName" maxlength="50" style="background: #ffffff; color:#000; font-size:12px; border:1px #c6c6c6 solid "></input><input type="hidden" name="sectionNameCode" value=""/></td></tr>	<tr><td><table id="managePaging" class="addedRows" ><tr class="mark"><th class="mark"></th><th class="mark">Field Name</th><th class="mark">Field Display Name </th><th class="mark">Mandatory	</th><th class="mark">Part of Mini-Reg</th><th class="mark">	</th></tr><tr id=""><td id="row handler"></td><td id="fieldName"><td id="fieldDispName"><td id="selectFieldtype"></td><td></td>	</tr></table>	</td>	</tr></table><br>	</td></tr>');					
			else	
				$("#masterTable").append('<tr id="firstRow">	<td class="rowhandler" valign="top" style="padding-top: 5px;"><div class="drag row" style="float:right; width:16px;margin-right: 5px;" align="center"><img src="'+dragIcon1+'" id="dragIcon1"/></div></td>	<td><table class="nolayout" cellpadding="0" cellspacing="0" width="100%"><tr style="background-color: #E7E7E7; display: block; font-size: 12px;color: black; border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6;"><td colspan="7" class="mark" style="height: 30px; padding-left:6px">Page No. <input type="text" value="'+(i+1+no)+'" id="page" readonly="true" style="background: #ffffff; color:black; border:1px #c6c6c6 solid "></input> &nbsp;Page Name <input type="text" name="sectionName" value="" id="sectionName" maxlength="50" style="background: #ffffff; color:#000; font-size:12px; border:1px #c6c6c6 solid "></input><input type="hidden" name="sectionNameCode" value=""/></td></tr>	<tr><td><table id="managePaging" class="addedRows" ><tr class="mark"><th class="mark"></th><th class="mark">Field Name</th><th class="mark">Field Display Name </th><th class="mark">Mandatory	</th><th class="mark">Part of Mini-Reg</th><th class="mark">	</th></tr><tr id=""><td id="row handler"></td><td id="fieldName"><td id="fieldDispName"><td id="selectFieldtype"></td><td></td>	</tr></table>	</td>	</tr></table><br>	</td></tr>');					
				
		}															
															
	}
	redips_init();
		$("input[value='"+value+"']").focus();
	return true;
	}
	else{
		alert("No. of Page/Section should be greater than existing no., and less than 10");
		return false;
	}
	}
	
	function setFieldSectionPage(){
			
			var field = $(".addedRows").find("td#fieldName");
			var len = $(field).length;
			if(!validateSection())
				return false;
			
			for(var i=0; i<len;i++){
			var ele = $(field).get(i);
			if($(ele).html()==""){
			$(ele).closest("#firstRow").remove();
			
			}
			}
			

			redips_init();
			
			$("select[id*='fieldType']").each(function(){
			$(this).removeAttr("disabled");
			});
			$("select[id*='isPartOfMiniReg']").each(function(){
				$(this).removeAttr("disabled");
				});
			
			$("#facebox").css("display","none");
			$("#facebox_overlay").css("display","none");
			
			return true;
			}
	
	
	function validateSection(){
	
	if($("#domainName").val() == "-1"){
					alert("No Domain selected !");
					return false;
					}
		
	var field = $(".addedRows").find("input#fieldDispNameId");
			var len = $(field).length;
			if(len==0){
				alert("Atleast one field is required.");
				return false;
			}
			for(var i=0; i<len;i++){
			var ele = $(field).get(i);
			if($(ele).val()==""){
			
			alert("Field Display Name Cannot be blank");
			$(ele).focus();
			return false;
			}
			else if(/[^A-Za-z0-9 -&]/.test($(ele).val())){
			
			alert("Avoid Special Characters in Section/Page Name");
			$(ele).focus();
			return false;
			}
			}
			
			var master = $("#masterTable").find("input#sectionName");
			var len = $(master).length;
			for(var i=0; i<len;i++){
			var ele = $(master).get(i);
			if($(ele).val()==""){
			
			alert("Section Name Cannot be blank");
			$(ele).focus();
			return false;
			}
			else if(/[^A-Za-z0-9 -&]/.test($(ele).val())){
			
			alert("Avoid Special Characters in Section Name");
			$(ele).focus();
			return false;
			}
			}
			
			return true;
	
	}
	
	
	
	
	function showPreview(){
	
	if(!validateSection())
				return false;
	
	var regType = $("#regType").attr("value");
	var len = $(".addedRows").find("td#fieldName").length;
	
	var field = $(".addedRows").find("td#fieldName");
			
			for(var i=0; i<len;i++){
			var ele = $(field).get(i);
			if($(ele).html()==""){
			$(ele).closest("#firstRow").remove();
			
			}
			}
			
			redips_init();
	
	
	var len2 = $("#drag").find("input#sectionName").length;
	var i;
	var fieldDispname=new Array();
	var fieldInputType=new Array();
	var fieldType=new Array();
	var pageNumber=new Array();
	var fieldSequenceNo=new Array();
	var alertStr=new Array();
	var sectionName=new Array();
	var optionValues = new Array();
	for(i=0;i<len;i++){
	fieldDispname[i] = ($($("#frm").find("input#fieldDispNameId").get(i)).val()).replace("&","n");
	fieldInputType[i] = $($("#frm").find("input#fieldInputType").get(i)).val();
	fieldType[i] = $($("#frm").find("select#fieldType").get(i)).val();
	optionValues[i] = $($("#frm").find("input#optionValues").get(i)).val()+";";
	
	pageNumber[i] = $($("#frm").find("input#pageNumber").get(i)).val();
	fieldSequenceNo[i] = $($("#frm").find("input#fieldSequenceNo").get(i)).val();
	alertStr[i] = $($("#frm").find("input#alertStr").get(i)).val();
	if(alertStr[i]=="")
	alertStr[i]="$";
	}
	for(i=0;i<len2;i++){
		sectionName[i] = $($("#frm").find("input#sectionName").get(i)).val();
	}
	window.open("managePaging/nodecorate/bo_pm_previewRegPage.jsp?fieldDispname="+fieldDispname+"&fieldInputType="+fieldInputType+"&fieldType="+fieldType+"&pageNumber="+pageNumber+"&fieldSequenceNo="+fieldSequenceNo+"&alertStr="+alertStr+"&sectionName="+sectionName+"&regType="+regType+"&optionValues="+optionValues,'','width=800,height=400,scrollbars=yes');

	}
	
	function formSubmitRegistrationEdit(formId){
		var form=$('#'+formId);
		$.ajax( {
			type : "POST",
			url : form.attr('action'),
			data : form.serialize(),
			async : false,
			success : function(result,arguments,text) {
			if(text.responseText == "SUCCESS" )
			$("#decoBody").html(' <div class="alert saved_msg">\
			        <span class="alert_close"></span>\
		            <strong>Saved: </strong>\
		             Saved Successfully..\
		      </div>');
		            else{
		            	$(".fieldError").html($($(result).find(".fieldError")).html());
		            }
			}
		});
		return false;
	}
	
	function setMiniSequence(){
		
		var seq=1;
		var mini = false;
		$("#minifieldfaceBox").html('<tr style="height:29px;" class="mark" style="background-color: white; color: #333333;">\
				<th class="mark" style=" border: 1px solid #C6C6C6; color: #333333; font-size: 13.5 px;background-image: url(\'/WeaverBO/images/bg-tr.gif\');"></th>\
				<th class="mark" style="padding-left: 5px; color: #333333; font-size: 13.5 px; border: 1px solid #C6C6C6;background-image: url(\'/WeaverBO/images/bg-tr.gif\');">\
					Field Name\
				</th>\
				</tr>');
		$('select[id*="isPartOfMiniReg"]').each(function (index){
			if(this.value=="Y"){
			$("#minifieldfaceBox").append('<tr myorder="'+$("#"+$(this).attr("accesskey")+"_miniSeqNo").val()+'"><td class="rowhandler" style=" border: 1px solid #C6C6C6;">\
							<div class="drag row mini"><img style="margin: 4px 4px 4px 6px;" src="/WeaverBO/images/dragIcon2.gif"/></div>\
						</td>\
						<td style="padding-left: 5px; border: 1px solid #C6C6C6;" id="mini_'+$(this).attr("accesskey")+'" >'
							+$(this).attr("accesskey")+
						'</td></tr>\
						');
		mini = true;
							

			}
		});
			
		
		if(mini){
			
			var $table=$('#minifieldfaceBox');

			var rows = $table.find('tr').get();
			rows.sort(function(a, b) {
			var keyA = $(a).attr('myorder');
			var keyB = $(b).attr('myorder');
			if (keyA < keyB) return -1;
			if (keyA > keyB) return 1;
			return 0;
			});
			$.each(rows, function(index, row) {
			$table.children('tbody').append(row);
			});
			
			$("#facebox").css("display","block");
			$("#facebox_overlay").css("display","block");
			$(".addedRows").addClass("nolayout");
			redips_init();
			$("#facebox").attr("tabindex",-1).focus();
			return false;
		}else{
			$("#facebox").css("display","none");
			$("#facebox_overlay").css("display","none");
			$(".addedRows").removeClass("nolayout");
			return true;
		}
		
	}
	
	function closeFacebox(){
		
		$("#facebox").css("display","none");
		$("#facebox_overlay").css("display","none");
		$(".addedRows").removeClass("nolayout");
		redips_init();
	}
	
	function enableDate(yearValue, monthValue, dateValue) {
		var year = document.getElementById('year');
		var month = document.getElementById('month');
		var date = document.getElementById('date');
		var dateList = "";

		monthValue = monthValue - 1;
		date.length = 0;
		if (year.value == yearValue && month.value == monthValue) {
			for ( var i = 0; i < dateValue; i++) {
				date.options[i] = new Option(i + 1, i + 1);
			}
			date.value = 1;
			date.disabled = false;
			if (date == "-1") {
				$('#errorDiv_date_of_birth').children('p').attr("class",
						"error-red");
				return false;
			} else {
				$('#errorDiv_date_of_birth').children('p').attr("class",
						"error-green");
			}
		} else {

			if (month.value > -1) {

				if (month.value == 1) {
					if (parseInt(year.value) % 400 == 0) {
						date.length = 0;
						for ( var i = 0; i < 29; i++) {
							date.options[i] = new Option(i + 1, i + 1);

						}
					} else if (parseInt(year.value) % 100 == 0) {
						date.length = 0;
						for ( var i = 0; i < 28; i++) {
							date.options[i] = new Option(i + 1, i + 1);

						}
					} else if (parseInt(year.value) % 4 == 0) {
						date.length = 0;
						for ( var i = 0; i < 29; i++) {
							date.options[i] = new Option(i + 1, i + 1);

						}
					} else {
						date.length = 0;
						for ( var i = 0; i < 28; i++) {
							date.options[i] = new Option(i + 1, i + 1);
						}
					}

				}
				if (month.value == 0 || month.value == 2 || month.value == 4
						|| month.value == 6 || month.value == 7 || month.value == 9
						|| month.value == 11) {
					date.length = 0;
					for ( var i = 0; i < 31; i++) {
						date.options[i] = new Option(i + 1, i + 1);

					}
				}
				if (month.value == 3 || month.value == 5 || month.value == 8
						|| month.value == 10) {
					date.length = 0;
					for ( var i = 0; i < 30; i++) {
						date.options[i] = new Option(i + 1, i + 1);

					}
				}
				date.value = 1;
				date.disabled = false;
				if (date == "-1") {
					$('#errorDiv_date_of_birth').children('p').attr("class",
							"error-red");
					return false;
				} else {
					$('#errorDiv_date_of_birth').children('p').attr("class",
							"error-green");
				}

			} else { 
				date.options[0] = new Option("Date", -1);
				date.disabled = true;
			}

		}

	}

	function enableMonth(yearValue, monthValue) {
		var year = document.getElementById('year');
		var month = document.getElementById('month');
		var date = document.getElementById('date');
		var monthArray;
		date.disabled = true;

		if (year.value == yearValue) {
			switch (monthValue) {
			case 1:
				monthArray = new Array('JAN');
				break;
			case 2:
				monthArray = new Array('JAN', 'FEB');
				break;
			case 3:
				monthArray = new Array('JAN', 'FEB', 'MAR');
				break;
			case 4:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR');
				break;
			case 5:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY');
				break;
			case 6:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN');
				break;
			case 7:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL');
				break;
			case 8:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL', 'AUG');
				break;
			case 9:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL', 'AUG', 'SEP');
				break;
			case 10:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL', 'AUG', 'SEP', 'OCT');
				break;
			case 11:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL', 'AUG', 'SEP', 'OCT', 'NOV');
				break;
			case 12:
				monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
						'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC');
				break;
			}
			month.length = 1;
			for ( var m = 0; m < monthArray.length; m++) {
				month.options[m + 1] = new Option(monthArray[m], m);
			}
			month.value = -1;
			month.disabled = false;
			$("#month-button").removeClass("ui-state-disabled");
		} else if (year.value > -1) { // alert("else -1") ;
			var monthArray = new Array('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
					'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC');
			month.length = 1;
			for ( var m = 0; m < monthArray.length; m++) {
				month.options[m + 1] = new Option(monthArray[m], m);
			}
			month.value = -1;
			month.disabled = false;
	       } else {
			month.disabled = true;
			date.disabled = true;
			month.value = -1;
		}
	}

	