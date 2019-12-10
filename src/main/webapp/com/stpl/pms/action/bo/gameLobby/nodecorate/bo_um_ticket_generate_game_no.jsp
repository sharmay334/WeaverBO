<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script>
$(document).ready(function() {
$('#roleId1').change(function(){
    var gameNo=$('#roleId1 :selected').val();
	var ticketStatus = document.getElementById("ticketStatus").value;
		if(gameNo!= -1){
    $.ajax({
		type : "GET",
		url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_batch_status_gameUploadGeneration.action?gameNo="+gameNo+"&ticketStatus="+ticketStatus,
		success : function(itr) {
			$("#batch_no_div").show();
			$("#batch_no_div1").show();
			$("#batch_no_div").html(itr);
		},
		error : function(itr) {
			$("#batch_no_div").hide();
			$("#game_no_div").hide();
			$("#batch_no_div1").hide();
			$("#game_no_div1").hide();
			
		}
	});
	
		}
		else
			{
			$("#batch_no_div").hide();
			$("#game_no_div").hide();
			$("#batch_no_div1").hide();
			$("#game_no_div1").hide();
			}
		
    
    });
		});
</script>
</head>
<body>

	<div class="labelDiv">
					<label><s:text name="global.generatetestreadydata.SelectGameNumber"/></label>
				</div>
				<div class="InputDivHalf">
					  <s:select id="roleId1" name="roleId1" list="gameNoList" 
								cssClass="select1" theme="myTheme" target="result"
								headerKey="-1" headerValue="%{getText('global.SELECTHEADER')}"  applyscript="true"></s:select>
			
				</div>
		
</body>
</html>