<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Role Head Registration</title>
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    </head>
    <body>
<script>
function getSelectedRoleValue(roleId,roleName){
var val = $("#"+roleId+" option:selected").text();
//alert(val);
$("#"+roleName).attr("value",val);

}
function onUserFocus()
{
	$("#userName_error").hide();
}
function onEmailFocus()
{
	$("#email_error").hide();
}
</script>

 <div class="clear2"></div>
         <h2>Back Office Role Head Registration</h2>
          
         <!--form section first start-->
         <div class="FormSection">
        
		<div class="greyStrip"><h4>Information</h4></div>
        <s:form name="newuser" action="/com/stpl/pms/action/bo/um/bo_um_boUserReg_Save.action" onsubmit="return checkUserRegfrm('newuser');"  theme="simple">
        <s:token name="strutsToken" id="strutsToken"></s:token>
        <div class="innerBox">	
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>First Name</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield pattern="^[a-zA-Z]*$" errorMassage="Numeric and Special Character not allowed" theme="myTheme" maxlength="30" id="firstName" name="firstName" applyscript="true"></ss:textfield>
            <div id="firstName_error" class="fieldError">
             <s:fielderror ><s:param >firstName</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
        
        <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Last Name</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield maxlength="30" id="lastName" applyscript="true" theme="myTheme" name="lastName" pattern="^[a-zA-Z]*$" errorMassage="Numeric and Special Character not allowed" theme="myTheme"></ss:textfield>
              <div id="lastName_error" class="fieldError">
				 <s:fielderror ><s:param >lastName</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
         <div class="clearFRM"></div>
          <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Gender</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <s:select name="gender" headerKey="-1"
					headerValue="-- Please Select --" cssClass="select1" id="gender"
					list="#{'M':'Male','F':'Female'}" theme="myTheme" applyscript="true"/>
             <div id="gender_error" class="fieldError">
				 <s:fielderror ><s:param >gender</s:param></s:fielderror>
				</div>
            </div>
        </div>
         <div class="clearFRM"></div>
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>User Name</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield theme="myTheme" maxlength="30" name="userName" id="userName"  pattern="^[0-9A-Za-z]*$" errorMassage="Special Character not allowed" action="bo_um_validateusername.action" minLength="6" applyscript="true" onfocus="onUserFocus()"></ss:textfield>
				<div id="userName_error" class="fieldError">
				 <s:fielderror ><s:param >userName</s:param></s:fielderror>
				  </div>
            </div>
            
        </div>
         <div class="clearFRM"></div>
          <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Email</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield maxlength="50" theme="myTheme"  name="email" id="email"  pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id" applyscript="true" patternOn="blur"  action="bo_um_validateemail.action" onfocus="onEmailFocus()"/>
            <div  id="email_error" class="fieldError">
			 <s:fielderror ><s:param >email</s:param></s:fielderror>
			</div>
            </div>
        </div>
         <div class="clearFRM"></div>
         <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Phone Number</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield  maxlength="15" name="phone" theme="myTheme"
					id="phone" pattern="^[0-9]*$" errorMassage="Only Numeric Character allowed" applyscript="true"></ss:textfield>
			<div id="phone_error" class="fieldError">
				 <s:fielderror ><s:param >phone</s:param></s:fielderror>
				</div>
            </div>
        </div>
         <div class="clearFRM"></div>
          <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Role</label><em class="Req">*</em></div>
            <div class="InputDiv">
           <s:select name="role" id="roleid" headerKey="-1" onchange="getSelectedRoleValue('roleid','roleName')"
					headerValue="-- Please Select --" list="%{#session.roleMap}" cssClass="select1" theme="myTheme" applyscript="true"></s:select>
           <s:hidden name="roleName" id="roleName"></s:hidden>
           <div id="roleid_error" class="fieldError">
				 <s:fielderror ><s:param >role</s:param></s:fielderror>
			</div>
            </div>
        </div>
         <div class="clearFRM"></div>
        <div class="FormMainBox">
        	<div class="labelDiv"><label>Secret Question</label><em class="Req">*</em></div>
            <div class="InputDiv">
           <s:select name="secQues" headerKey="-1"
				headerValue="-- Please Select --" cssClass="select1" id="secQues" theme="myTheme"
				list="{'What is Your Pets Name?','Which is your favourite game?','What is your college name?'}"
				value="gameType" applyscript="true"/>
				<div id="secQues_error" class="fieldError">
				 <s:fielderror ><s:param >secQues</s:param></s:fielderror>
				</div>
            </div>
        </div>
         <div class="clearFRM"></div>
         
         <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Secret Answer</label><em class="Req">*</em></div>
            <div class="InputDiv">
            <ss:textfield name="secAns" id="secAns" theme="myTheme" maxlength="30" pattern="^[a-zA-Z ]*$" errorMassage="Numeric and Special character not allowed" applyscript="true"></ss:textfield>
            <div id="secAns_error" class="fieldError">
			 <s:fielderror ><s:param >secAns</s:param></s:fielderror>	
			</div>
            </div>
        </div>
        
</div>
<div class="box_footer" align="right">
        <s:submit theme="simple" value="Register" cssClass="button"  cssStyle="margin-left:0px"/>        
                
            </div>
</s:form>
</div>

</body>
</html>
