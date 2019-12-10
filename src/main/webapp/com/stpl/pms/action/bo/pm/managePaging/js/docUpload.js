function editUploadPlrDocs() {
	$('div[rel*="facebox"]').facebox({
		closeImage : '/WeaverBO/images/closelabel.png'
	});
	$('input[type="file"]').change(function(){
		var id = $(this).attr("id").replace("Image", "");
		$('#'+id+'DocType').attr("applyscript", "true");
		$('#'+id+'DocVerified').attr("applyscript", "true");
	});
	$('#uploadId').click(function() {
		$('select[id*="DocType"]').removeAttr("applyscript");
		$('select[id*="DocVerified"]').removeAttr("applyscript");
		$('input[id*="DocUniqueNo"]').removeAttr("applyscript");
	});
	$('#uploadandSave').submit(function() {
		var isOk = true;
		$('select[id*="DocType"]').each(function(index) {
			console.log("--------"+index+"----------"+$(this).attr("id"));
			if ($(this).val() != -1) {
				console.log("----"+$(this).val()+"----");
				var id = $(this).attr("id").replace("DocType", "");
				if($("#" + id + "DocVerified").val() == -1 && !(typeof($("#"+id+"View"))=='undefined' && $("#" + id + "Image").val()!='')){
					$("#" + id + "DocVerified").attr("applyscript", "true");
					$("#" + id + "DocVerified_errorDiv").html('<ul></ul>');
					$("#" + id + "DocVerified_errorDiv" + ' ul').append('<p>Please select one option.</p>');
					_Show($("#" + id + "DocVerified_errorDiv"), $("#" + id + "DocVerified"));
					console.log("--true--"+$(this).val()+"----");
					isOk = false;
				}else{
					$("#" + id + "DocVerified").removeAttr("applyscript");
				}
			}
		});
		$('select[id*="DocVerified"]').each(function(index) {
			console.log("--------"+index+"----------"+$(this).attr("id"));
			if ($(this).val() != -1) {
				console.log("----"+$(this).val()+"----");
				var id = $(this).attr("id").replace("DocVerified", "");
				if( $("#" + id + "DocType").val() == -1 && !(typeof($("#"+id+"View"))=='undefined' && $("#" + id + "Image").val()!='')){
					$("#" + id + "DocType").attr("applyscript", "true");
					$("#" + id + "DocType_errorDiv").html('<ul></ul>');
					$("#" + id + "DocType_errorDiv" + '> ul').append('<p>Please select one option.</p>');
					_Show($("#" + id + "DocType_errorDiv"), $("#" + id + "DocType"));
					isOk = false;
					console.log("--true--"+$(this).val()+"----");
				}else{
					$("#" + id + "DocType").removeAttr("applyscript");
				}
			}
		});
		$('input[id*="DocUniqueNo"]').each(function(index) {
			var id = $(this).attr("id").replace("DocUniqueNo", "");
			if($("#" + id + "DocUniqueNo").val()==''  && ($("#" + id + "DocVerified").val() != -1 || $("#" + id + "DocType").val()!= -1)){
				$("#" + id + "DocUniqueNo").attr("applyscript", "true");
				$("#" + id + "DocUniqueNo_errorDiv").html('<ul></ul>');
				$("#" + id + "DocUniqueNo_errorDiv" + ' ul').append('<p>Please Enter unique Number.</p>');
				_Show($("#" + id + "DocUniqueNo_errorDiv"), $("#" + id + "DocUniqueNo"));
				isOk = false;
				console.log("---true--"+$(this).val()+"----");
			}else{
				$("#" + id + "DocUniqueNo").removeAttr("applyscript");
			}
		});
		$('input[id*="Image"]').each(function(index) {
			var id = $(this).attr("id").replace("Image", "");
			var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp', 'tiff', 'tif', 'wav', 'jpeg(2000)', 'jxr', 'hdp', 'wdp','exif', 'bpg', 'pdf', 'rtf'];
			if($("#" + id + "Image").val()!=''){
								
				if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
					
					$("#" + id + "Image").attr("applyscript", "true");
					$("#" + id + "Image_errorDiv").html('<ul></ul>');
					$("#" + id + "Image_errorDiv" + ' ul').append('<p>Upload image or PDF file only.</p>');
					_Show($("#" + id + "Image_errorDiv"), $("#" + id + "Image"));
					console.log("true-- ");
					isOk = false;
				}
				var frontId= id.replace("BackSide","");
				if(id.indexOf("BackSide")!=-1  && $("#" + frontId + "Image").val()==''){
					
					
					$("#" + id + "Image").attr("applyscript", "true");
					$("#" + id + "Image_errorDiv").html('<ul></ul>');
					$("#" + id + "Image_errorDiv" + ' ul').append('<p>Upload front image or PDF file.</p>');
					_Show($("#" + id + "Image_errorDiv"), $("#" + id + "Image"));
					console.log("true-- ");
					isOk = false;
				}
			}
			else{
				$("#" + id + "Image").removeAttr("applyscript");
			}
			
		});
		$('p[class="fieldError"]').each(function(index){
			if($(this).html()=='Not Available'){
				isOk=false;
				return false;
			}
		});
		console.log("--isOk--"+isOk+"----");
		return isOk;
	});
	
	$("#ageDocVerified").change(function(){
		checkVerifyStatus("age");
	});
	$("#addDocVerified").change(function(){
		checkVerifyStatus("add");
	});
	$("#taxIdDocVerified").change(function(){
		checkVerifyStatus("taxId");
	});
	
	checkVerifyStatus("age");
	checkVerifyStatus("add");
	checkVerifyStatus("taxId");

	createBubble();
}
$(function() {
	$(".dateField").datetimepicker(
			{
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				onClose : function(dateText, inst) {
					if ($(this).attr('id').indexOf('uploadStartDate') != -1) {
						$('#uploadEndDate').datetimepicker("option", "minDate",
								dateText);
						$('#uploadEndDate').datetimepicker("option", "minDateTime",
								new Date(dateText));
					} else if ($(this).attr('id').indexOf('uploadEndDate') != -1) {
						$('#uploadStartDate').datetimepicker("option", "maxDate",
								dateText);
						$('#uploadStartDate').datetimepicker("option", "maxDateTime",
								new Date(dateText));
					}
				}
		});
	});
function checkVerifyStatus(docType){
		if($("#"+docType+"DocVerified").val()=="-1"){
			$("#"+docType+"DocType").val("-1");
			$("#"+docType+"DocUniqueNo").val("");
			$("#"+docType+"DocUniqueNo_errorDiv").hide();
		}
}

function setDefaultDate() {
	var date = new Date();
	var currDate = $.datepicker.formatDate('dd/mm/yy', new Date(date));
	hour = "" + date.getHours();
	if (hour.length == 1) {
		hour = "0" + hour;
	}
	minute = "" + date.getMinutes();
	if (minute.length == 1) {
		minute = "0" + minute;
	}
	second = "" + date.getSeconds();
	if (second.length == 1) {
		second = "0" + second;
	}
	var currTime = hour + ":" + minute + ":" + second;
	var lastDate = $.datepicker.formatDate('dd/mm/yy', new Date(date
			.getFullYear(), date.getMonth(), date.getDate() - 6));
	var lastTime = $.datepicker
			.formatTime('HH:mm:ss', new Date(date.getTime()));
	$('#uploadEndDate').val(currDate + ' ' + currTime);
	$('#uploadStartDate').val(lastDate + ' ' + lastTime);
}