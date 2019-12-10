<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
<title>Sub User Registration</title></head>
<body>
<div class="clear2"></div>
<h2> 
	<s:text name="global.scratchWeaver.subuserreg"/> 
</h2>

<!--form section first start-->
<div class="FormSection">

	<div class="greyStrip">
		<h4>
			<s:text name="global.scratchWeaver.info"/>
		</h4>
	</div>

	<s:form name="newsubuser" action="/com/stpl/pms/action/bo/um/bo_um_addBoSubUser_Save.action"
		theme="simple"  novalidate="true" >
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.searchuser.firstname" />
					</label><em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield maxlength="30" name="firstName" id="firstName"
						theme="myTheme" pattern="^[a-zA-Z]*$"
						errorMassage="Numeric and Special Character not allowed"
						applyscript="true"></ss:textfield>
					<div id="firstName_error" class="fieldError">
						<s:fielderror>
							<s:param>firstName</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.LastName" />
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield maxlength="30" name="lastName" id="lastName"
						theme="myTheme" pattern="^[a-zA-Z]*$"
						errorMassage="Numeric and Special Character not allowed"
						applyscript="true"></ss:textfield>
					<div id="lastName_error" class="fieldError">
						<s:fielderror>
							<s:param>lastName</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>

			<div class="clearFRM"></div>

			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.Gender"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<%-- <ss:select name="gender" headerKey="-1"
						headerValue="%{getText('global.SELECTHEADER')}" cssClass="select1" id="gender"
						list="#{'M':'Male','F':'Female'}" theme="myTheme" applyscript="true" />
					 --%>	
						<select name="gender" id="gender" applyscript="true" class="select1">
						<option value="-1"><s:text name="global.SELECTHEADER"/></option>
						<option value="M"><s:text name="global.408"/></option>
						<option value="F"><s:text name="global.409"/></option>
						</select>
						
					<div id="gender_error" class="fieldError">
						<s:fielderror>
							<s:param>gender</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.UserName"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield maxlength="30" name="userName" id="userName"
						theme="myTheme" pattern="^[a-zA-Z._]*$"
						errorMassage="Numeric and Special Character not allowed"
						action="bo_um_validateusername.action" minLength="6"
						applyscript="true"></ss:textfield>
					<div id="userName_error" class="fieldError">
						<s:fielderror>
							<s:param>userName</s:param>
						</s:fielderror>
					</div>


				</div>
			</div>

			<div class="clearFRM"></div>

			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.E-mail"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield maxlength="42" name="email" id="email"
						theme="myTheme" onpaste="return false;"
						pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id" patternOn="blur"  action="bo_um_validateemail.action"
						applyscript="true" />
					<div id="email_error" class="fieldError">
						<s:fielderror>
							<s:param>email</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>

			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.PhoneNumber"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield maxlength="10" name="phone" id="phone"
						pattern="^[0-9]{9,10}$" patternOn="blur" errorMassage="Please Enter Valid Phone Number"
						theme="myTheme"  applyscript="true"></ss:textfield>
					<div id="phone_error" class="fieldError">
						<s:fielderror>
							<s:param>phone</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
			<s:hidden label="Status" name="status" value="ACTIVE" />
			<div class="clearFRM"></div>


			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.SecretQuestion"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<%-- <ss:select name="secQues" cssClass="select1" headerKey="-1"
						headerValue="%{getText('global.SELECTHEADER')}" id="secQues" theme="myTheme"
						list="{'What is Your Pets Name?','Which is your favourite game?','What is your college name?'}"
						value="gameType" applyscript="true" /> --%>
						
						<select name="secQues" class="select1" id="secQues" theme="myTheme" applyscript="true" >
						<option value="-1"><s:text name="global.SELECTHEADER"/></option>
						<option value="What is Your Pets Name?"><s:text name="global.subuserregistration.whatisyourpetsname"/></option>
						<option value="Which is your favourite game?"><s:text name="global.subuserregistration.whichisyourfavouritegame"/></option>
						<option value="What is your college name?"><s:text name="global.subuserregistration.whatisyourcollegename"/></option>
						
						</select>
						
					<div id="secQues_error" class="fieldError">
						<s:fielderror>
							<s:param>secQues</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>


			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						<s:text name="global.subuserregistration.SecretAnswer"/>
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield name="secAns" id="secAns" maxlength="30"
						pattern="^[a-zA-Z ]*$" patternOn="blur"
						errorMassage="Numeric and Special character not allowed"
						theme="myTheme" applyscript="true"></ss:textfield>
					<div id="secAns_error" class="fieldError">
						<s:fielderror>
							<s:param>secAns</s:param>
						</s:fielderror>
					</div>
				</div>
			</div>
		</div>

		<div class="box_footer" align="right">
			<%-- <s:submit value="Register" align="left" cssClass="button"
				theme="simple" /> --%>
				<input type="submit" value='<s:text name="global.subuserregistration.Register"/>' align="left" class="button"/>
		</div>
	</s:form>
</div>
</body>
</html>