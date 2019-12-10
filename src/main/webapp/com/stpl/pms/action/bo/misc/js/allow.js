/* 
 * author : kamal Jain
 * Desc : It is Use for the disable the text box in block Ip and same module.
 * */
function getedit(e) {
	var ele = '#'+e;
	$(ele).attr("disabled", true);
}
/* 
 * author : kamal Jain
 * Desc : It is Use for the Submit the Form  in block Ip and same module.
 * */
function submitForm() {
	var arr = $(":input[type='text']");
	var ipList = "";
	for ( var i = 0; i < arr.length; i++) {
		if (arr[i].disabled) {
			ipList = ipList+arr[i].value+",";
		}
	}
	 var listIp = ipList.substr(0,ipList.length-1);
	 listIp = listIp + "";
	 $('#ipAddressObject').val(listIp);
	 return false;
}