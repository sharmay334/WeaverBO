<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<script type="text/javascript">
$(document).ready(function(){

});

</script>
<h3>Field Form</h3>
<s:form action="bo_pm_save_modulefieldlist" onsubmit="" id="frm">

<table>
<tr>
<td width="40%" align="right" class="label">Enable:
</td>
<td><input type="checkbox" name="isShow" id="isShow" class=""
						<s:if test='%{#request.isShow == "Y"}'> checked="checked"</s:if> value="<s:if test='%{#request.isShow == "Y" }'>Y</s:if><s:else>N</s:else>"
						onclick="manageCheckBox(this)" /></td></tr>
						<s:hidden value="%{fieldId}" id="fieldId" name="fieldId"></s:hidden>
						<s:hidden value="%{moduleName}" id="moduleName" name="moduleName"></s:hidden>
<tr>
<s:textfield readonly="false" name="fieldName" label="Field Name"
						size="" id="fieldName" value="%{fieldName}"></s:textfield>
					<s:hidden value="%{fieldName}" id="fieldName_org"></s:hidden></tr>
<tr>
<s:textfield readonly="false" name="fieldDispName" label="Field Display Name"
						size=""  id="fieldDispName" value="%{fieldDispName}"></s:textfield>
					<s:hidden value="%{fieldDispName}" id="fieldDispName_org"></s:hidden></tr>
<tr>
<s:textfield readonly="false" name="pageNumber" label="Page No."
						 id="pageNumber" value="%{pageNumber}"></s:textfield>
					<s:hidden value="%{pageNumber}" id="pageNumber_org"></s:hidden></tr>
<tr>
<s:textfield name="fieldSequenceNo" id="fieldSequenceNo" size="" label="Field Sequence"
						value="%{fieldSequenceNo}" ></s:textfield>
					<s:hidden value="%{fieldName}" id="fieldName_org"></s:hidden></tr>
<tr>
<s:select list="#{'Optional':'Optional','Mandatory':'Mandatory'}"
						name="fieldType" label="Field Type" id="fieldType"
						value="%{fieldType}" cssClass="option"></s:select>
					<s:hidden value="%{fieldName}" id="fieldName_org"></s:hidden></tr>
<tr>
<s:textfield name="minLen" id="minLen" size="" value="%{minLen}" label="Min Length"
						></s:textfield>
					<s:hidden value="%{minLen}" id="minLen_org"></s:hidden></tr>
<tr>
<s:textfield value="%{maxLen}" name="maxLen" id="maxLen" label="Max Length"
						value="%{maxLen}" ></s:textfield>
					<s:hidden value="%{maxLen}" id="maxLen_org"></s:hidden></tr>
<tr>
<s:select list="#{'varchar':'String','int':'Integer'}" value="%{fieldDataType}" name="fieldDataType" label="Data Type" id="fieldDataType"
						value="%{fieldDataType}" cssClass="option"></s:select>
					<s:hidden value="%{fieldDataType}" id="fieldDataType_org"></s:hidden></td></tr>
<tr>
<s:textfield name="validationExp" id="validationExp" size=""
						value="%{validationExp}" label="Validation Exp"></s:textfield>
					<s:hidden value="%{fieldName}" id="fieldName_org"></s:hidden></tr>
<tr>
<s:textfield name="alertStr" id="alertStr" size=""
						value="%{alertStr}" label="Alert String"></s:textfield>
					<s:hidden value="%{alertStr}" id="alertStr_org"></s:hidden></tr>
<tr>
<s:select name="fieldInputType" label="Field Input Type" id="fieldInputType" list="#{'text':'text','radio':'radio','checkbox':'checkbox','select':'select','password':'password'}"
						value="%{fieldInputType}" onchange="manageInputType(this)" cssClass="option"></s:select>
					<s:hidden value="%{fieldInputType}" id="fieldInputType_org"></s:hidden></tr>
<tr id="option" style="<s:if test='%{fieldInputType==("radio"||"checkbox"||"select")}'></s:if><s:else>display: none;</s:else>">
<td width="40%" align="right" class="label">Option Values:</td>
<td><input type="text" name="optionValues" value="<s:property value='%{optionValues}'/>"></td><i>*(comma separated)</i></tr>
<tr>
<s:select name="isUnique" id="isUnique"list="#{'Y':'Y','N':'N'}"
						value="%{isUnique}" label="Is Unique" cssClass="option"></s:select>
					<s:hidden value="%{isUnique}" id="isUnique_org"></s:hidden></tr>
					<tr>
<s:select name="isNull" id="isNull" list="#{'Y':'Y','N':'N'}"
						value="%{isNull}" label="Is Null" cssClass="option"></s:select>
					<s:hidden value="%{isNull}" id="isNull_org"></s:hidden></tr>
<tr><td></td><td><s:submit action="bo_pm_save_modulefieldlist" align="center" theme="simple" cssClass="button"></s:submit></td></tr>
</table>

</s:form>