<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/extended-struts2-tags" prefix="ss" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript">
	 $("#passError").hide();
	$("#c_passError").hide(); 
	/* function matchPass() {
		 $("#c_passError").hide();
		var pass = $("#pass").val();
		var c_pass = $("#cnfrm_pass").val();
		if (pass != c_pass) {
			$("#c_passError").text("password and confirm password does not match");
			$("#c_passError").show();
		} 
		
	} */
	function check()
	{
	    var pass = $("#pass").val();
		var c_pass = $("#cnfrm_pass").val();
		
		if(pass.length === 0){
			$("#passError").text("field cannot be empty");
			$("#passError").fadeIn('fast').delay(1500).fadeOut('slow');
			return false; 
		}
		 if(c_pass.length === 0){
			$("#c_passError").text("field cannot be empty")
			$("#c_passError").fadeIn('fast').delay(1500).fadeOut('slow');
			return false;
		}
		if(pass.length > 6){
			$("#passError").text("Max length should not be more than 6")
			$("#passError").fadeIn('fast').delay(1500).fadeOut('slow');
			return false;
			}
		if (pass != c_pass) {
			$("#c_passError").text("password and confirm password does not match");
			$("#c_passError").fadeIn('fast').delay(1500).fadeOut('slow');
			return false;
		} 
		
			$("#changePlrInfoFrm").submit();
			 
	}
</script>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script>
		$(document).ready(function(){
			$("#newData").applyScriptWithBubble();
			$("#newData_bubbleTable").css("z-index","101");
		});
	</script>
	
  </head>
  
  <body>
  	<div id="changePlrInfoFrmDiv">
  	<s:form id="changePlrInfoFrm" name="changePlrInfoFrm"
							method="post" target="changePlrInfoFrmDiv" theme="simple"
							action="bo_pm_plr_change_pass">
	 	
		<s:hidden name="requestPlayerId" value="%{requestPlayerId}"/>
		<%-- <s:hidden name="changeReq" value="%{changeReq}"/>
		<s:hidden name="currentData" value="%{currentData}"/>  --%>
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Change Password </h4>
			</div>
			<div class="innerBox">
				<div>
					<s:fielderror theme="simple" fieldName="newData"/>
				</div>
				<div class="clearFRM">
				
				</div><div class="FormMainBox">
					<div class="labelDiv">
						<label> 	Password  : </label>
					</div>
					<div class="InputDivHalf"> 
					<ss:password name="pass" id="pass" applyscript="true" maxlength="10"
										theme="myTheme" pattern="/^[^ ]+$/" patternOn="blur"
										errorMassage="Please enter password"></ss:password>
										<div id="passError" style="color:#FF0000 ;"></div>
								 </div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Change Password : </label>
					</div>
					<div class="InputDivHalf">
						
									<ss:password name="cnfrm_pass" id="cnfrm_pass" applyscript="true" maxlength="10"
										theme="myTheme"  pattern="/^[^ ]+$//"  applyscript="true" patternOn="blur"
										errorMassage="Please enter password"></ss:password>
								<div id="c_passError" style="color:#FF0000 ;"></div>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
			<div class="box_footer" align="right">
<%-- 				<s:submit value="Submit" onclick="check();" id="submitPlrInfo"></s:submit>
 --%>				<a  id="submitPlrInfo"  onclick="check();" class="button" 
					style="float:none;vertical-align: baseline;">Submit</a>
			</div>
		</div>
	</s:form>
	</div>
  </body>
</html>
