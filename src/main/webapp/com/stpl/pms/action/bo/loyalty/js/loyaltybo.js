$(document).ready(function() {
	if(render == 'false'){
		showError(_error.split(":")[0],_error.split(":")[1]);
	}
});


function showError(title,_error){
	console.info(_error);
	if(title == null) title = "Error";
	
	var modal = $('<div style="display:none" id="div-dialog-warning" >');
	modal.append($('<p><span style="float:left; margin:0 7px 20px 0;"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>'+_error+'</span></p>'));
	
	$(modal).dialog({
		autoOpen:true,
	    title: title,
	    resizable: false,
	    height: 200,
	    width :360,
	    modal: true,
	    buttons: {
	        "Ok" : function () {
	            $(this).dialog("close");
	        }
	    }
	}).parent().addClass("ui-state-error");
}