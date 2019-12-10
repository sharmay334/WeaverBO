<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<SCRIPT type="text/javascript" src="com/stpl/pms/action/bo/reports/js/playerDetailsEdit.js"></SCRIPT>
  </head>
  
  <body>
  <s:form action="st_pms_bo_rep_playerDetailsEdit"  id="formSave" theme="simple">
  <s:hidden value="%{#parameters.playerId1}" name="playerId1" id="playerId1"></s:hidden>
  <s:hidden value="%{#parameters.domainId1}" name="domainId1" id="domainId1"></s:hidden>
  <s:hidden value="%{#parameters.ageVerifed}" name="ageVerified" id="ageVerified"></s:hidden>
  <s:hidden id="dobToDate"
					value="%{@com.stpl.pms.utility.Utility@getServerDate(0,0,-18,'dd/MM/yyyy')}" />
   <div id="plrPersonalInfo" >
	<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Personal Information
					</h4>
				</div>
				<table width="95%" cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px" >
				<tr></tr>
				<tr>
				<td width="25%" align="center">Title :</td>
				<td width="25%" align="center"><s:select list="#{'-1':'Please select','Mr':'Mr','Miss':'Miss','Mrs':'Mrs','Dr':'Dr','Er':'Er'}" value="%{#parameters.title}"  cssStyle="width: 178px; "  cssClass="select1" name="title" id="title"></s:select></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">First Name :</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.fName}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="fName" id='fName' patternScript="^[a-zA-Z]{1,50}$" ></s:textfield></td>
				<td width="25%" align="center">Last Name :</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.lName}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="lName" id="lName" patternScript="^[a-zA-Z]{1,50}$" ></s:textfield></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Date of Brith :</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.dob}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="dob" id="dob" readonly="true"></s:textfield></td>
				<!--<td width="25%" align="center">Age Verified : </td>
				<td width="25%" align="center"><s:select list='#{"-1":"Please select","Y":"Yes","N":"No"}' value="%{#parameters.ageVerifed}"  cssStyle="width: 178px; " cssClass="select1" name="ageVerifed" id="ageVerifed"></s:select></td>
				--></tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Email :</td>
				<td width="25%" align="center">
				<ss:textfield value="%{#parameters.emailId}"  cssStyle="width: 178px; height: 25px; border: none; background:none; color:#2b2b2b;" name="emailId"  id="emailId" readonly="true" ></ss:textfield>
				</td>
				<td width="25%" align="center">Email Verified :</td>
				<td width="25%" align="center"><s:select list='#{"-1":"Please select","Y":"Yes","N":"No"}' value="%{#parameters.emailVerified}"  cssStyle="width: 178px; " cssClass="select1" name="emailVerified" id="emailVerified"></s:select></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">House No.  :</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.houseNum}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="houseNum" id="houseNum"></s:textfield></td>
				<!--<td width="25%" align="center">Address Verified : </td>
				<td width="25%" align="center"><s:select list='#{"-1":"Please select","Y":"Yes","N":"No"}' value="%{#parameters.addressVerified}"  cssStyle="width: 178px; "  cssClass="select1" name="addressVerified" id="addressVerified"></s:select></td>
				
				
				--></tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Address Line1 :</td>
				<td width="25%" align="center"><s:textarea value="%{#parameters.add1}"  cssStyle="width: 178px; height: 25px; border-width: 1px;font-size:12.6px" name="add1" id="add1" maxlength="200"></s:textarea></td>
				<td width="25%" align="center">Address Line2 :</td>
				<td width="25%" align="center"><s:textarea value="%{#parameters.add2}"  cssStyle="width: 178px; height: 25px; border-width: 1px;font-size:12.6px" name="add2" id="add2" maxlength="200"></s:textarea></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Country</td>
				<td width="25%" align="center"><s:select list="#{}" headerKey="-1"
								headerValue="----Please Select----" cssStyle="width: 178px; "  cssClass="select1" name="plrCountry" id="plrCountry"
								  value="%{#parameters.plrCountry}"
								></s:select>
				<s:hidden value="%{#parameters.plrCountry}" id="plrCountryHidden"></s:hidden>
				<s:hidden value="%{#parameters.plrState}" id="plrStateHidden"></s:hidden></td>
				<td width="25%" align="center">State</td>
				<td width="25%" align="center"><s:select list="#{}" headerKey="-1"
								headerValue="----Please Select----" cssStyle="width: 178px; "  cssClass="select1" name="plrState" id="plrState" value="%{#parameters.plrState}"
								></s:select>
				</tr>
				
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">City</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.plrCity}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="plrCity" id="plrCity" maxlength="50"></s:textfield></td>
				<td width="25%" align="center">Pin Code</td>
				<td width="25%" align="center"><s:textfield value="%{#parameters.plrPostalCode}"  cssStyle="width: 178px; height: 25px; border-width: 1px;" name="plrPostalCode" id="plrPostalCode" maxlength="50"></s:textfield>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Gender :</td>
				<td width="25%" align="center"><s:select list='#{"M":"Male","F":"Female"}' value="%{#parameters.gender1}"  cssStyle="width: 178px; " cssClass="select1" name="gender" id="gender"></s:select></td>
				<td width="25%" align="center">Profile Status :</td>
				<td width="25%" align="center"><s:select list="#{'-1':'Please select','MINI':'Mini','FULL':'Full'}" id="profileStatus" name="profileStatus" value="%{#parameters.profileStatus}" cssClass="select1" cssStyle="width: 178px; "/>  </td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Mobile No :</td>
				<td width="25%" align="center"><ss:textfield value="%{#parameters.mobileNo}" cssStyle="width: 178px; height: 25px; border: none; background:none; color:#2b2b2b" name="mobileNo" id="mobileNo" readonly="true"></ss:textfield></td>
				<td width="25%" align="center">Mobile Verified :</td>
				<td width="25%" align="center"><s:select list='#{"-1":"Please select","Y":"Yes","N":"No"}' value="%{#parameters.phoneVerified}"  cssStyle="width: 178px; " cssClass="select1" name="phoneVerified" id="phoneVerified"></s:select></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Player Status :</td>
				<td width="25%" align="center"><s:select list="#{'-1':'Please select','INACTIVE':'InActive','ACTIVE':'Active'}" id="regStatusInActive" name="regStatus1" value="%{#parameters.regStatus1}" cssClass="select1" cssStyle="width: 178px; "/>  </td>
				<td width="25%" align="center">Reason :</td>
				<td width="25%" align="center"><s:textfield id="reason" name="reason" readonly="true" cssStyle="width: 178px; height: 25px; " value="%{#parameters.reason}" maxlength="100"></s:textfield> </td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Subscribe Promo Mail : </td>
				<td width="25%" align="center"><s:select list='#{"-1":"Please select","Y":"Yes","N":"No"}' value="%{#parameters.commPromo1}"  cssStyle="width: 178px; " cssClass="select1" name="commPromo" id="commPromo"></s:select></td>
				</tr>
				<tr class="clearFRM"></tr>
				</table>

<div class="box_footer" align="right">

<ss:button name="save" value="Save" cssClass="button" id="saveEditData" ></ss:button>
<!--<ss:button name="cancel" value="Cancel" cssClass="button" id="cancelData" ajaxAction="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action"  target="plrDataResult" ajaxParam="playerId1"></ss:button>

--><!--<s:reset name="cancel" value="Cancel" cssClass="button"></s:reset>
-->
	<!--<a class="button"
										href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action"
										id="editPlayerDetails" targetPlr="plrDataResult">Cancel</a>
										-->
										<input type="button" name="cancel" value="Cancel" cssClass="button" id="editPlayerDetails" href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action?playerId=<s:property value="%{#parameters.playerId1}" />"  targetPlr="replaceEditField" />

</div>
</div>
</div>

</s:form>

  </body>
</html>
