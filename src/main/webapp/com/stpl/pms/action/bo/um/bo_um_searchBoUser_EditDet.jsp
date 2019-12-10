<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserDetailsBean"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Edit user Details</title>
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    <script type="text/javascript">
    $(document).ready(function(){
    	$('a[id*=resetPlayerPass_]').click(function(){
 		var isValid = false;
 		var name = $(this).attr('name');
 		if(confirm("Do you want to reset password for User "+name)){
 			isValid=true;
 		}
 		if(isValid){
 			var anchor = $(this);
			var linkArr = $(this).attr('href').split('?');
			$.ajax( {
				type : "POST",
				url : linkArr[0],
				data : linkArr[1],
				async : false,
				success : function(result, arguments, text) {
					alert("Reset Password mail is sent to Your mail ID.");				
				}
			});
 		}
 		return false;
	 });
	 });
    </script>
    </head>
    <body>
<script>
//Weaver/src/main/java/com/stpl/pms/javabeans/UserDetailsBean.java

//  alert("loading.....");
 // var continue_button = document.getElementById('submitButton');
 // alert(document.getElementById('submitButton'));
 // continue_button.style.visibility = 'hidden';   
  




  function chkSub(){
  //alert($('#phoneNbr').val().length);
  var flag = true;
  var errmsg1 = document.getElementById("errmsg1").value;
  var errmsg2 = document.getElementById("errmsg2").value;
  var errmsg3 = document.getElementById("errmsg3").value;
  
  if($('#phoneNbr').val() == ""){
  document.getElementById("phoneNbr_error").className="fieldError";	    	
document.getElementById("phoneNbr_error").innerHTML = errmsg1;
  //alert("please fill the phone no");
  flag = false;
  }
  
  else if($('#phoneNbr').val().length!= 10){
    document.getElementById("phoneNbr_error").className="fieldError";	    	
document.getElementById("phoneNbr_error").innerHTML = errmsg2;
  //alert("Please Enter the 10 digits phone Number");
  flag =  false;
  }
  if($('#email').val() == ""){
 document.getElementById("email_error").className="fieldError";	    	
 document.getElementById("email_error").innerHTML = errmsg3;
 // alert("Please Fill the emailID");
  flag =  false;
  }
  if(flag == false){
  	return false;
  }else{
 	return true;
 	} 
  }
 
 	
	
</script>
<input type="hidden" value='<s:text name="global.update.err1"/>' id="errmsg1"/>
<input type="hidden" value='<s:text name="global.update.err2"/>' id="errmsg2"/>
<input type="hidden" value='<s:text name="global.update.err3"/>' id="errmsg3"/>
         <h2><s:text name="global.scratchWeaver.search"/> <s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">BO</s:if> <s:else>Domain</s:else> <s:text name="global.scratchWeaver.Users"/>: 
			<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">BO</s:if> <s:else>Domain</s:else> <s:text name="global.scratchWeaver.Usrdet"></s:text>
		</h2>
          
 <div class="FormSection">
         
		<div class="greyStrip"><h4><s:text name="global.scratchWeaver.info"/></h4></div>
		
       <div id="errorDiv"></div>
       <div id="sucessMsg">
       </div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_searchBoUser_Save.action" name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden id="user_id" name="user_id" value="%{userDetailsBean.UserId}"></s:hidden>
			<s:hidden id="domainId" name="domainId" value="%{userDetailsBean.domainId}"></s:hidden>
			<s:hidden name="type" value="%{userDetailsBean.boUserType}"></s:hidden>
			<s:hidden name="firstName" value="%{userDetailsBean.firstName}"></s:hidden>
			<s:hidden name="lastName" value="%{userDetailsBean.lastName}"></s:hidden>
			<s:hidden name="userName" value="%{userDetailsBean.userName}"></s:hidden>
			 
			 <div class="innerBox">
			
          
         <!--form section first start-->
        	
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.searchuser.firstname"/></label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.firstName" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.subuserregistration.LastName"/></label></div>
            <div class="InputDiv">
             <ss:textfield name="userDetailsBean.lastName" value="%{userDetailsBean.lastName}" theme="myTheme" pattern="^[a-zA-Z]*$" errorMassage="Only alphabets are allowed." name="lastnameedit"  id="lastnameedit" maxlength="25" readonly="true"></ss:textfield>
           <div class="fieldError" id="lastnameedit_error">
						<s:fielderror ><s:param >lastnameedit</s:param></s:fielderror>
				</div>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
      
        	<div class="labelDiv"><label><s:text name="global.subuserregistration.UserName"></s:text></label></div>
            <div class="InputDiv">
             <ss:textfield name="userDetailsBean.userName" theme="myTheme"  readonly="true"></ss:textfield>
            </div>
        
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.searchuser.department"/></label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.department" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.scratchWeaver.info"/></label></div>
            <div class="InputDiv">
            <ss:textfield name="type" theme="myTheme"  readonly="true"></ss:textfield>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			
		 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.scratchWeaver.email"/></label></div>
            <div class="InputDiv">
            <ss:textfield name="email"  maxlength="40" value="%{userDetailsBean.emailId}"
					id="email" disabled="true"  theme="myTheme"
				 pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id" applyscript="true" patternOn="blur"  action="bo_um_validateemail.action?prevEmailId=%{userDetailsBean.emailId}" ajaxParam="user_id,email">
				</ss:textfield>
				<div class="fieldError" id="email_error">
						<s:fielderror ><s:param >emailId</s:param></s:fielderror>
				</div>
            </div>
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.subuserregistration.PhoneNumber"/></label></div>
            <div class="InputDiv">	
  			<ss:textfield name="phoneNbr"  id="phoneNbr"
						maxlength="15" readonly="true" value="%{userDetailsBean.phoneNbr}"
						pattern="^[0-9]*$" errorMassage="Only Numeric character allowed." theme="myTheme"></ss:textfield>
				<div class="fieldError" id="phoneNbr_error">
						<s:fielderror ><s:param >phoneNbr</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
		 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.searchgames.status"/></label></div>
            <div class="InputDiv">	
				
					<%-- <s:select name="status" theme="simple" id="statId" disabled="true"
						value="%{userDetailsBean.status}"
						list="{'ACTIVE','INACTIVE','TERMINATE'}" cssClass="select1"></s:select> --%>
						<s:set name="webFramework" value="%{userDetailsBean.status}"/>
						<select name="status" id="statId" disabled="true" class="select1"> 
						<option selected="selected"  disabled="disabled">
						<s:if test="%{#webFramework=='ACTIVE'}">
						<s:text name="global.searchuser.statusActive"/>
						</s:if>
						<s:elseif test="%{#webFramework=='INACTIVE'}">
						<s:text name="global.searchuser.statusInactive"/>
						</s:elseif>
						<s:elseif test="%{#webFramework=='TERMINATE'}">
						<s:text name="global.searchuser.statusTerminate"/>
						</s:elseif>
						
						<option value="ACTIVE"><s:text name="global.searchuser.statusActive"/></option>
						<option value="INACTIVE"><s:text name="global.searchuser.statusInactive"/></option>
						<option value="TERMINATE"><s:text name="global.searchuser.statusTerminate"/></option>
						</select>
						
			</div>
			</div>
		
</div>
	<div class="box_footer" align="right">
		<%-- <a style="color: #000000; font-size:12px;font-weight:bold;float:left;margin-left:15px;margin-top:12px" href="bo_um_searchBoUser_ResetPassBO.action?user_id=<s:property value="userDetailsBean.UserId"/>&&emailId=<s:property value="userDetailsBean.emailId"/>&&firstName=<s:property value="userDetailsBean.firstName"/>&&lastName=<s:property value="userDetailsBean.lastName"/>&&userName=<s:property value="userDetailsBean.userName"/>"
			id="resetPlayerPass_<s:property value="userDetailsBean.firstName"/>"
					name="<s:property value="userDetailsBean.userName"/>">Reset Password</a>	 --%>
	<!--<a href="javaScript:void(0);" class="reset_password"  style="color: #000000; font-size:12px;font-weight:bold;float:left;margin-left:15px;margin-top:12px"
							onclick="resetPasswordBO('bo_um_searchBoUser_ResetPassBO.action?user_id=<s:property value="userDetailsBean.UserId"/>&&emailId=<s:property value="userDetailsBean.emailId"/>&&firstName=<s:property value="userDetailsBean.firstName"/>&&lastName=<s:property value="userDetailsBean.lastName"/>&&userName=<s:property value="userDetailsBean.userName"/>','<s:property value="userDetailsBean.emailId"/>')">Reset
							Password</a>
	-->
	<input class="button" type="button" value='<s:text name="global.EDIT"/>' id="editButton"
							onclick="enableBoxes()" style="float:right;" />
                 
                 <%-- <s:submit value="Submit" id="submitButton"
							cssStyle="display: none;width:73px;" cssClass="button" 
							theme="simple" />
				 --%>
				 <input type="submit" value='<s:text name="global.login.submit"/>' id="submitButton"
							style="display: none;width:73px;" class="button" 
							/>
							
							
			<a style="color: #000000; font-size:12px;font-weight:bold;float: right;margin-right: 30px;margin-top: 15px;" href="bo_um_searchBoUser_Menu.action">
					<s:text name="global.scratchWeaver.BackToSearch"/></a>	
            </div>
							
		</s:form>
		
	</div>
</body>
</html>