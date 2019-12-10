<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
	response.setDateHeader("Expires", System.currentTimeMillis());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Change Password</title>

		<script>
			function isEqual(){
		      document.getElementById("change_pwd_error").innerHTML = "";
		  	if(document.changePass.newPassword.value!=document.changePass.verifynewPassword.value){
				   alert("Please Verify New Password");
				   document.changePass.verifynewPassword.focus();
				   return false;
			  }
			  else if(document.changePass.password.value==document.changePass.newPassword.value)
			  {
			    alert("This is Your Current Password");
			    document.changePass.newPassword.focus();
			    return false;
			   }
			   else
			    alert("Please Enter New Password");
		}
		
		function initialFocus(){
		 document.changePass.password.focus();
		}
		
		function isFilled(){
		  document.getElementById("change_pwd_error").innerHTML = "";
		  var isInValid = false;
		  if(document.changePass.password.value=="")
		  {
			  var msg = document.getElementById("verifyerr5").value;
		       isInValid = true;
		        document.getElementById("oldPass").innerHTML = "<font 2 = 'red'>"+msg+"</font>";
		             
		  }
		   else
		   {
		   
		      if(document.changePass.password.value.length<8)
		        { 
		    	  var errmsg = document.getElementById("verifyerr3").value;
		         document.getElementById("oldPass").innerHTML = "<font color = 'red'>"+errmsg+"</font>";
		         document.changePass.password.value="";
		         document.changePass.newPassword.value="";
		         document.changePass.verifynewPassword.value="";
		         isInValid = true;
		        }
		        else
		        {
		         document.getElementById("oldPass").innerHTML = "";
		        }
		    }
		    
		     if(document.changePass.newPassword.value=="")
		     {
		    	 var errmsg1 = document.getElementById("verifyerr4").value;
		         document.getElementById("newPass").innerHTML = "<font color = 'red'>"+errmsg1+"</font>";
		         isInValid = true;      
		     }
		     else
		     {
		      if(document.changePass.newPassword.value.length<8)
		        { 
		    	  var errmsg = document.getElementById("verifyerr3").value;
		         document.getElementById("newPass").innerHTML = "<font color = 'red'>"+errmsg+"</font>";
		         document.changePass.password.value="";
		         document.changePass.newPassword.value="";
		         document.changePass.verifynewPassword.value="";
		         isInValid = true;
		        }
		        else
		        {          
		         document.getElementById("newPass").innerHTML = "";
		        } 
		     }
		    
		    
		    if(document.changePass.verifynewPassword.value=="")
		     {
		    	var msg3 = document.getElementById("verifyerr2").value;
		         document.getElementById("verifyPass").innerHTML = "<font color = 'red'>"+msg3+"</font>";
		          document.changePass.password.value="";
		         document.changePass.newPassword.value="";
		         document.changePass.verifynewPassword.value="";
		         isInValid = true;      
		     }
		     else
		     {
		     
		      if(document.changePass.verifynewPassword.value==document.changePass.newPassword.value)
		        {
		          if(document.changePass.password.value==document.changePass.newPassword.value)
		          {
		        	  var msg1 = document.getElementById("verifyerr1").value;
		            document.getElementById("newPass").innerHTML = "<font color='Red'>"+msg1;
		            document.getElementById("verifyPass").innerHTML ="";
		            document.changePass.password.value="";
		         document.changePass.newPassword.value="";
		         document.changePass.verifynewPassword.value="";
		            isInValid = true;
		          }
		          else
		            {
		             document.getElementById("verifyPass").innerHTML = "";
		            }
		        }
		    
		       else
		         {
		    	   var msg = document.getElementById("verifyerr").value;
		          document.getElementById("verifyPass").innerHTML = "<font color = 'red'>"+msg+"</font>";
		          document.getElementById("newPass").innerHTML ="";
		           document.changePass.password.value="";
		         document.changePass.newPassword.value="";
		         document.changePass.verifynewPassword.value="";
		          isInValid = true;
		         }
		         
		       
		      }
		    
		    
		    
		    if(isInValid){
				return false;
				}
				
			var passPolicyval = passPolicy.value;
	 		var regexp = new RegExp(passPolicyval);	
			if(!regexp.test(newPassval)){
			 alert("Enter atleast 1 small case, 1 big case, 1 number, 1 special symbol and atleast 8 char in new password");
			 newPassval="";
			 retypeNewPassval="";
			 newPass.focus();
			 return false;
		 }	
				return true;
		}	
</script>
	</head>
	<body onload="initialFocus()">
	<input type="hidden" id="verifyerr" value='<s:text name="global.changepassword.errmsg1"></s:text>'/>
	<input type="hidden" id="verifyerr1" value='<s:text name="global.changepassword.errmsg2"></s:text>'/> 
	<input type="hidden" id="verifyerr2" value='<s:text name="global.changepassword.errmsg3"></s:text>'/> 
	<input type="hidden" id="verifyerr3" value='<s:text name="global.changepassword.errmsg4"></s:text>'/> 
	<input type="hidden" id="verifyerr4" value='<s:text name="global.changepassword.errmsg5"></s:text>'/> 
	
		<h2>
			<s:text name="global.home.changepassword" />
		</h2>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:text name="global.scratchWeaver.info"></s:text>
				</h4>
			</div>

			<s:form onsubmit="return isFilled()" name="changePass"
				action="bo_lm_pass" method="POST" theme="simple" >

				<s:token name="changePass"></s:token>


				<div class="innerBox">

					<input type="hidden"
						value="<%= request.getAttribute("passPolicy") %>" id="passPolicy" />
					<div id="change_pwd_error" class="fieldError">
						<s:actionerror />
						<s:fielderror />
					</div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								<s:text name="global.OLD_PASSWORD"></s:text>
							</label>
						</div>
						<div class="InputDiv">
							<input type="password" name="password" applyscript="true"
								onpaste="return false;" />
							<div id="oldPass" class="fieldError" style="text-align: left;"></div>
						</div>

					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
							<s:text name="global.NEW_PASSWORD"></s:text>
							</label>
						</div>
						<div class="InputDiv">
							<input type="password" name="newPassword" applyscript="true"
								onpaste="return false;" />
							<div id="newPass" class="fieldError" style="text-align: left;"></div>
						</div>

					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								<s:text name="global.chnagepass.reenter"></s:text>
							</label>
						</div>
						<div class="InputDiv">
							<input type="password" name="verifynewPassword" applyscript="true"
								onmousedown="blockcopy(this,event)" onpaste="return false;" />
							<div id="verifyPass" class="fieldError" style="text-align: left;"></div>
						</div>
					</div>

				</div>
				<div class="box_footer" align="right">
					<%-- <s:submit cssClass="button" value='<s:text name="global.changepass.change"/>' targets="down"
						 /> --%>
						<input type="submit" value='<s:text name="global.changepass.change"></s:text>' target="down"  class="button"> 
						

				</div>
			</s:form>
		</div>
		<div id="down"></div>

	</body>
</html>


