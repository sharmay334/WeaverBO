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
  <title>Edit Group Details</title>
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
         <h2>Company Info</h2>
          
 <div class="FormSection">
         
		<div class="greyStrip"><h4>Group Info</h4></div>
		
       <div id="errorDiv"></div>
       <div id="sucessMsg">
       </div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Group_Save.action" name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			 <s:hidden name="groupMaster.groupId" value="%{groupMaster.groupId}"></s:hidden>
			 <div class="innerBox">
			
          
         <!--form section first start-->
        	
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Group Name</label></div>
            <div class="InputDiv">
            <ss:textfield name="groupMaster.groupName" id="groupName" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Group Under</label></div>
            <div class="InputDiv">
             <ss:textfield name="groupMaster.groupUnderName" theme="myTheme" id="groupUnderName" readonly="true"></ss:textfield>
           <div class="fieldError" id="groupUnderName_error">
						<s:fielderror ><s:param >groupUnderName</s:param></s:fielderror>
				</div>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
      
        	<div class="labelDiv"><label>Sub Ledger(YES/NO)</label></div>
            <div class="InputDiv">
             <ss:textfield name="groupMaster.subLedger" id="subLedger" theme="myTheme"  readonly="true"></ss:textfield>
            </div>
        
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Deb/Cred Balance Report(YES/NO)</label></div>
            <div class="InputDiv">
            <ss:textfield name="groupMaster.blncForRep" id="blncForRep" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Calculations(YES/NO)</label></div>
            <div class="InputDiv">
            <ss:textfield name="groupMaster.forCalc" id="forCalc" theme="myTheme"  readonly="true"></ss:textfield>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			
		 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Purchase Invoice(APPLICABLE/NOT APPLICABLE)</label></div>
            <div class="InputDiv">
            <ss:textfield name="groupMaster.purInvoice" readonly="true"  maxlength="40" value="%{groupMaster.purInvoice}"
					id="purInvoice" theme="myTheme" applyscript="true">
				</ss:textfield>
				<div class="fieldError" id="purInvoice_error">
						<s:fielderror ><s:param >purInvoice</s:param></s:fielderror>
				</div>
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
							onclick="enableBoxesGroup()" style="float:right;" />
                 
                 <%-- <s:submit value="Submit" id="submitButton"
							cssStyle="display: none;width:73px;" cssClass="button" 
							theme="simple" />
				 --%>
				 <input type="submit" value='<s:text name="global.login.submit"/>' id="submitButton"
							style="display: none;width:73px;" class="button" 
							/>
							
							
			<a style="color: #000000; font-size:12px;font-weight:bold;float: right;margin-right: 30px;margin-top: 15px;" href="bo_um_viewCompany.action">
					<s:text name="global.scratchWeaver.BackToSearch"/></a>	
            </div>
							
		</s:form>
		
	</div>
</body>
</html>