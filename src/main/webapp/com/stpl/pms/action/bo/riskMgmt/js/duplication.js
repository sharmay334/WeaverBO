var actNotiList;
var actionNewChkList='';
var notiNewChkList='';
var actionOldChkList='';
var notiOldChkList='';

var duplicationReady=(function() {
	$('.makeEnable').attr('disabled', true);
			actNotiList=$.parseJSON($('#actionNotiList_hidden').val());
			var txtBoxArr = $('input[name="weightageArr"]');
			var sum = 0;
			for ( var i = 0; i < txtBoxArr.length; i++) {
				if (parseInt(txtBoxArr[i].value) != 'NaN' && txtBoxArr[i].value!="") {
					sum = sum + parseInt(txtBoxArr[i].value);
				}
			}
			$('#totWeightage').html(sum);

	
		var count = $("#scoreTable tr").length;
		
		var inc = 1;
		$.each(actNotiList,function(index,value) {
			if(value.type=='ACTION'){
				actionNewChkList+='<input id="actionNewArr_'+count+'_'+inc+'" type="checkbox" name="actionNewArr" class="checkOne makeEnable chkSerial" value="'+count+'-'+value.name+'"/>'+value.name+'<br/>';
				actionOldChkList+='<input id="actionOldArr_'+count+'_'+inc+'" type="checkbox" name="actionOldArr" class="checkOne makeEnable chkSerial" value="'+count+'-'+value.name+'"/>'+value.name+'<br/>';
			}
			if(value.type!='ACTION'){
				notiNewChkList+='<input id="notifiNewArr_'+count+'_'+inc+'" type="checkbox" name="notifiNewArr" class="checkOne makeEnable chkSerial" value="'+count+'-'+value.name+'" />'+value.name+'<br/>';
				notiOldChkList+='<input id="notifiOldArr_'+count+'_'+inc+'" type="checkbox" name="notifiOldArr" class="checkOne makeEnable chkSerial" value="'+count+'-'+value.name+'"/>'+value.name+'<br/>';
			}
			inc++;
		});
		
		$('#edit').click(function() {
			$('.makeEnable').attr('disabled', false);
		});

		$('input[id*="weightageArr_"]').blur(function(){
				var txtBoxArr = $('input[name="weightageArr"]');
				var sum=0.0;
				$('input[name="weightageArr"]').each(function(){
					if(!isNaN($(this).val()) && $(this).val()!="")
						sum+=parseFloat($(this).val());
				});
				$('#totWeightage').html(sum);
		});
		


	$('#delete').click(function() {
		$('input[name=deleteIt]').each(function(){
			if($(this).attr('checked')){
				$('#makeEnable_tr_'+$(this).attr('id').split('_')[1]).remove();
			}
		});
		createBubble();
	});


	$('#add').click(function() {
		var dataTable =  $('#scoreTable tr:last').clone();
		
		if($("#scoreTable tr").length==1){
			dataTable='<tr id="makeEnable_tr_'+count+'"> <td valign="middle" height="10" align="left" 	style="display: none;"><input type="text" name="idScoreArr" id="idScoreArr_'+count+'" value="'+count+'" /> </td> <td valign="middle" height="10" align="left"><input id="deleteIt_'+count+'" type="checkbox" name="deleteIt" class="checkOne" value="1"/> </td> <td valign="middle" height="20" align="left"> <input id="fromScoreArr_'+count+'" maxlength="4" patternon="blur" pattern="^[0-9]*$" errorMassage="Value Should Be Positive Numeric" applyscript="true" type="text" name="fromScoreArr" value="" class="makeEnable" style="width: 40px;"/> </td> <td valign="middle" height="20" align="left"> 	<input id="toScoreArr_'+count+'" maxlength="4" patternon="blur" pattern="^[0-9]*$" errorMassage="Value Should Be Positive Numeric" applyscript="true" type="text" class="makeEnable" name="toScoreArr" value="" style="width: 40px;"/> </td> <td valign="middle" height="20" align="left"> <select name="isRecordArr" class="makeEnable" id="isRecordArr_'+count+'"><option value="Y">Y</option><option selected="selected" value="N">N</option></select> </td><td valign="middle" height="20" align="left">'+actionNewChkList+'</td><td valign="middle" height="20" align="left">'+actionOldChkList+'</td><td valign="middle" height="20" align="left">'+notiNewChkList+'</td><td valign="middle" height="20" align="left">'+notiOldChkList+'</td> </tr>';
		}else{
			dataTable.attr({
		    	id: "makeEnable_tr_" + count,
			});
			dataTable.find("input").each(function(){
				   var newId = $(this).attr("id").split('_');
				   if(newId.length==2){
					   newId = newId[0]+'_'+ count;
				   }else if(newId.length==3){
					   newId = newId[0] + '_' + count + '_' + newId[2];
				   }
				   $(this).attr({
					   id: newId
				   });
			});
			dataTable.find("input:text").each(function(){
			    if($(this).attr("id").split('_')[0]=='idScoreArr'){
			       	$(this).val(''+count);
			    }else{
			    	 $(this).val('');
			    }
			});
			dataTable.find("input:checkbox").each(function(){
				var chkVal = $(this).val().split('-');
				if(chkVal.length==2){
					$(this).val(count+'-'+chkVal[1]);
				}
			});
		}
		$("#scoreTable tbody").append(dataTable);
		count = count+1;
		createBubble();
	});
});
var serialChkBox=function(){
	var isChk=$(this).attr('checked');
	var num=$(this).attr('id').split("_");
	$('input[name="'+num[0]+'"]').each(function(){
		var idArr = $(this).attr('id').split("_");
		if (idArr[2] == num[2]) {
			if (isChk=='checked') {
				if (num[1] < idArr[1]) {
					$(this).attr('checked',true);
				}
			}else {
				if (num[1] > idArr[1]) {
					$(this).attr('checked',false);
				}
			}
		}
	});
};

$(document).on("click", ".chkSerial", serialChkBox);