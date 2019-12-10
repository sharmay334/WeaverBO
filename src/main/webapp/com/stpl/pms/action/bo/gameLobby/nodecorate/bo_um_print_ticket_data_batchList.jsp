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
$('#roleId').change(function(){
    var batchNo=$('#roleId :selected').val();
		if(batchNo!= -1){
    $.ajax({
		type : "GET",
		url : "/WeaverBO/com/stpl/pms/action/bo/gl/ticket_generate.action?batchNo="+batchNo,
		success : function(itr) {
			
		},
		error : function(itr) {
			
		}
	});
	
		}
		else
			{
			alert('Select batch no. first');
			}
		
    
    });
		});
</script>
</head>
<body>
	<div class="labelDiv">
					<label><s:text name="global.generatetestreadydata.SelectBatchNo"/></label>
				</div>
				<div class="InputDivHalf">
					  <s:select id="roleId" name="roleId" list="batchNoList" 
								cssClass="select1" theme="myTheme" target="result"
								headerKey="-1" headerValue="%{getText('global.SELECTHEADER')}" applyscript="true"></s:select>
			
				</div>
		
</body>
</html>