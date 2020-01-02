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
         <h2>Company Info</h2>
          
 <div class="FormSection">
         
		<div class="greyStrip"><h4>Company Info</h4></div>
		
       <div id="errorDiv"></div>
       <div id="sucessMsg">
       </div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Company_Save.action" name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			 <s:hidden name="companyBean.companyId" value="%{companyBean.companyId}"></s:hidden>
			<s:hidden name="companyBean.fyb" value="%{companyBean.fyb}"></s:hidden>
			<s:hidden name="companyBean.bbf" value="%{companyBean.bbf}"></s:hidden>
			
			<%--<s:hidden name="companyBean.name" value="%{companyBean.name}"></s:hidden>
			<s:hidden name="companyBean.email" value="%{companyBean.email}"></s:hidden>
			<s:hidden name="companyBean.contactNo" value="%{companyBean.contactNo}"></s:hidden>
			<s:hidden name="companyBean.currentAddress" value="%{companyBean.currentAddress}"></s:hidden>
			<s:hidden name="companyBean.country" value="%{companyBean.country}"></s:hidden>
			<s:hidden name="companyBean.state" value="%{companyBean.state}"></s:hidden>
			<s:hidden name="companyBean.pincode" value="%{companyBean.pincode}"></s:hidden>
			<s:hidden name="companyBean.fyb" value="%{companyBean.fyb}"></s:hidden>
			<s:hidden name="companyBean.bbf" value="%{companyBean.bbf}"></s:hidden>
			<s:hidden name="companyBean.gstNo" value="%{companyBean.gstNo}"></s:hidden>
			<s:hidden name="companyBean.panNo" value="%{companyBean.panNo}"></s:hidden>
			<s:hidden name="companyBean.license" value="%{companyBean.license}"></s:hidden>
			<s:hidden name="companyBean.csln" value="%{companyBean.csln}"></s:hidden>
			<s:hidden name="companyBean.cpln" value="%{companyBean.cpln}"></s:hidden>
			<s:hidden name="companyBean.cfln" value="%{companyBean.cfln}"></s:hidden>
			<s:hidden name="companyBean.cinRegNo" value="%{companyBean.cinRegNo}"></s:hidden>
			<s:hidden name="companyBean.bankName" value="%{companyBean.bankName}"></s:hidden>
			<s:hidden name="companyBean.accountNo" value="%{companyBean.accountNo}"></s:hidden>
			<s:hidden name="companyBean.accHolderName" value="%{companyBean.accHolderName}"></s:hidden>
			<s:hidden name="companyBean.ifsc" value="%{companyBean.ifsc}"></s:hidden>
			 --%> 
			 <div class="innerBox">
			
          
         <!--form section first start-->
        	
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Company Name</label></div>
            <div class="InputDiv">
            <ss:textfield name="companyBean.name" id="name" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Company Email</label></div>
            <div class="InputDiv">
             <ss:textfield name="companyBean.email" theme="myTheme" id="email" readonly="true"></ss:textfield>
           <div class="fieldError" id="email_error">
						<s:fielderror ><s:param >email</s:param></s:fielderror>
				</div>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
      
        	<div class="labelDiv"><label>Contact</label></div>
            <div class="InputDiv">
             <ss:textfield name="companyBean.contactNo" id="contactNo" theme="myTheme"  readonly="true"></ss:textfield>
            </div>
        
        </div>
        
        <div class="clearFRM"></div>
				 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Address</label></div>
            <div class="InputDiv">
            <ss:textfield name="companyBean.currentAddress" id="currentAddress" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Country</label></div>
            <div class="InputDiv">
            <ss:textfield name="companyBean.country" id="country" theme="myTheme"  readonly="true"></ss:textfield>
           </div>
        	
        </div>
        
        <div class="clearFRM"></div>
			
			
		 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>State</label></div>
            <div class="InputDiv">
            <ss:textfield name="companyBean.state" readonly="true"  maxlength="40" value="%{companyBean.state}"
					id="state" theme="myTheme" applyscript="true">
				</ss:textfield>
				<div class="fieldError" id="state_error">
						<s:fielderror ><s:param >state</s:param></s:fielderror>
				</div>
            </div>
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Pincode</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.pincode"  id="pincode"
						maxlength="15" readonly="true" value="%{companyBean.pincode}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="pincode_error">
						<s:fielderror ><s:param >pincode</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>GST No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.gstNo"  id="gstNo"
						readonly="true" value="%{companyBean.gstNo}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="gstNo_error">
						<s:fielderror ><s:param >gstNo</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>PAN No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.panNo"  id="panNo"
						 readonly="true" value="%{companyBean.panNo}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="panNo_error">
						<s:fielderror ><s:param >panNo</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>License</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.license"  id="license"
						readonly="true" value="%{companyBean.license}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="license_error">
						<s:fielderror ><s:param >license</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Seed License No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.csln"  id="csln"
						 readonly="true" value="%{companyBean.csln}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="csln_error">
						<s:fielderror ><s:param >csln</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Pesticide License No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.cpln"  id="cpln"
					 readonly="true" value="%{companyBean.cpln}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="cpln_error">
						<s:fielderror ><s:param >cpln</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Fertilizer License No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.cfln"  id="cfln"
						readonly="true" value="%{companyBean.cfln}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="cfln_error">
						<s:fielderror ><s:param >cfln</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>CIN REG No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.cinRegNo"  id="cinRegNo"
						 readonly="true" value="%{companyBean.cinRegNo}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="cinRegNo_error">
						<s:fielderror ><s:param >cinRegNo</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Bank Name</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.bankName"  id="bankName"
						 readonly="true" value="%{companyBean.bankName}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="bankName_error">
						<s:fielderror ><s:param >bankName</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Bank Acc No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.accountNo"  id="accountNo"
						 readonly="true" value="%{companyBean.accountNo}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="accountNo_error">
						<s:fielderror ><s:param >accountNo</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Bank Acc Holder No</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.accHolderName"  id="accHolderName"
						 readonly="true" value="%{companyBean.accHolderName}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="accHolderName_error">
						<s:fielderror ><s:param >accHolderName</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Bank IFSC</label></div>
            <div class="InputDiv">	
  			<ss:textfield name="companyBean.ifsc"  id="ifsc"
						 readonly="true" value="%{companyBean.ifsc}"
						theme="myTheme"></ss:textfield>
				<div class="fieldError" id="ifsc_error">
						<s:fielderror ><s:param >ifsc</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
		
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
							onclick="enableBoxesCompany()" style="float:right;" />
                 
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