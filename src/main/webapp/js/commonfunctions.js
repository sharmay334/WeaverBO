/*
 * author: Nitish Bansal
 * Desc : It is use to check min amount enter in field. 
 */

function chkMin(minVal,txtVal,divId,idValue){
	var chk=true;
	if(!isNaN(txtVal)){
		chk=parseInt(txtVal)>=parseInt(minVal);
		$('#'+divId+' ul').append(chk?'':'<p>Please provide at least ' +minVal+ '</p>');
		_Show($('#'+divId),$('#'+idValue));
		return chk;
	}else{
		$('#'+divId+' ul').append('<p>Please provide Numeric Value Only</p>');
		_Show($('#'+divId),$('#'+idValue));
		return false;
	}
}

/*
 * author: Nitish Bansal
 * Desc:  It is use to check max amount enter in the field. 
 */

function chkMax(maxVal,txtVal,divId,idValue){
	var chk=true;
	if(!isNaN(txtVal)){
		chk=parseInt(txtVal)<=parseInt(maxVal);
		$('#'+divId+' ul').append(chk?'':'<p>Please provide at most ' +maxVal+ '</p>');
		_Show($('#'+divId),$('#'+idValue));
		return chk;
	}else{
		$('#'+divId+' ul').append('<p>Please provide Numeric Value Only</p>');
		_Show($('#'+divId),$('#'+idValue));
		return false;
	}
}

/*
 * author: Nitish Bansal
 * Desc:  It is use to check max and min amount enter in the field. 
 */

function chkMinMax(minVal,maxVal,txtVal,divId,idValue){
	var chk=true;
	if(!isNaN(txtVal)){
		chk=parseInt(txtVal)>=parseInt(minVal) && parseInt(txtVal)<=parseInt(maxVal);
		$('#'+divId +' ul').append(chk?'':'<p>Please provide value between ' +minVal+ ' to ' +maxVal+ '</p>');
		_Show($('#'+divId),$('#'+idValue));
		return chk;
	}else{
		$('#'+divId +' ul').append('<p>Please provide Numeric Value Only</p>');
		_Show($('#'+divId),$('#'+idValue));
		return false;
	}
}
/*
 * author: Nitish Bansal
 * Desc:  It is use to check pattern enter in the field. 
 */

function chkPattern(pattern,txtVal,massage,divId,showClass,idValue,obj){
	var iChars = new RegExp(pattern);
	if(txtVal!=""){
		var check=iChars.test(txtVal)?"":$('#'+divId+" ul").html("<p>"+massage+"</p>");
		_Show($('#'+divId),$('#'+idValue));
		return iChars.test(txtVal);
	}else if( obj.attr('applyscript')=="true" ){
	$('#'+divId +' ul').append('<p>Field cannot be blank</p>');
	_Show($('#'+divId),$('#'+idValue));
	}
}

var createBubble=function(){
	//$('table.bubbletip').each(function(){$(this).remove()});
	$('table.bubbletip').remove();
	$('input,textarea,select').not('input[type=button], input[type=submit], input[type=reset],input[type=hidden]').each(function(){
		var id=$(this).attr('id');
		var divId = id+"_errorDiv";
		$(this).bubbletip($('#'+divId),{
			deltaDirection: 'up',
			bindShow: 'keypress'
		});
		
	});
};

/*
 * author: Nitish Bansal
 * Desc:  It is use to checkmin character length enter in the field. 
 */

function chkMinLength(minLenVal,txtVal,divId,idValue){
	var chk;
	//alert("inside min lemgth");
		chk=txtVal.length>=minLenVal;
		$('#'+divId+' ul').append(chk?'':'<p>Please provide at least ' +minLenVal+ ' Character</p>');
		_Show($('#'+divId),$('#'+idValue));
		return chk;
	
}