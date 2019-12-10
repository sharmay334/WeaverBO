function getVipLevel(){
	var vipList = _ajaxCallJson("com/stpl/pms/action/bo/rg/st_pms_rg_bo_fetchRgData.action?domainId="+$("#domainId").val(),"");
	$('#vipLevel').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	if($("#domainId").val() != -1){
		$.each(vipList, function(index, value) {
			$('#vipLevel').append($('<option></option>').val(value.vipLevel).html(value.vipCode));
		});
	 }
}

function operatorBean(criteriaId,limit,status){
	this.criteriaId =criteriaId;
	this.limit = limit;
	this.status = status;
}



$(document).on("submit","#operatorLimitSubmit",function (){
	var row=$("#opCriteria").find('tbody > tr');
	var array = new Array();
	row.each(function(){
		var criteriaId = $(this).find('[id*=criteriaId_]');
		var limit = $(this).find('[id*=limit_]');
		var status = $(this).find('[id*=status_]');
		array.push(new operatorBean(criteriaId.val(),limit.val(),status.val()));
	});
	$("#criteriaJson").val(JSON.stringify(array));
	return true;
});