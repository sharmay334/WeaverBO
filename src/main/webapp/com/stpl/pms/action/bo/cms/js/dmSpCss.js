$(document).ready(function(){
	var cssJson=$("#dmCssMap").val();
	var cssMap=JSON.parse(cssJson);
	var selectAliasId;
		$("#domainId").change(function(){
			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			$.each(aliasMap,function(index, value) {
				$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
		});
	
		$("#aliasId").change(function(){
			selectAliasId=$(this).val();
			$.each(cssMap, function(key,value){
			$("#dmSelectCss").empty().append($('<option></option>').val("-1").html("--Please Select--"));
				if(selectAliasId == key){
		   				 $.each(value,function(k,v){
		   				 	$("#dmSelectCss").append($('<option></option>').val(v.cssId).html(v.cssName)); 
		   				 });
	   				  };
				});
		});	
		
	
	$("#dmSelectCss").change(function(){
		selectCssId = $(this).val();
		 $("#cssName").val(cssMap[selectAliasId][selectCssId].cssName);
		 $("#cssPath").val(cssMap[selectAliasId][selectCssId].cssPath);
	});			
});