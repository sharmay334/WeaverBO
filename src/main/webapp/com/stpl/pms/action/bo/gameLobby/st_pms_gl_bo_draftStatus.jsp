<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
        
		<title>Edit Role Privileges</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		</head>
		<script>
		$(document).ready(function() {

			
		

		$('#roleId').change(function(){
		    var gameNo=$('#roleId :selected').val();


				if(gameNo!= -1){
		    $.ajax({
				type : "GET",
				url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_lm_get_draft_data.action?gameNo="+gameNo,
				success : function(itr) {
					 $('#showJspResult').html(itr);
				},
				error : function(itr) {
					
				}
			});
			
				}
				else
					{
					$('#showJspResult').html('');
					}
				
		    
		    });
		});
		</script>
		<body>
     <h2>Complete Draft Information</h2>
          
         <!--form section first start-->
         <div class="FormSection">
         
		<div class="greyStrip"><h4>Required Information</h4></div>

        <div class="innerBox">	
        <div class="FormMainBox">
			<div class="labelDiv"><label>Select Game No.</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <s:select id="roleId" name="roleId" list="draftselectboxdata" 
								cssClass="select1" theme="myTheme" target="result"
								headerKey="-1" headerValue="-- Please Select --" applyscript="true"></s:select>
			
			</div>
			</div>
			
				<div id="showJspResult">
				
				</div>
			


				
			</div>
			</div>
	
		</body>
</html>