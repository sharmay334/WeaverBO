<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	  <base href="<%=basePath%>">
	
	
		<title>Main</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>

		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Add New Reference
				</h4>
			</div>

			<s:form cssStyle="width:100%" id="formAdd"
				theme="simple" action="st_pms_dm_bo_addToReferralsList" target="newFieldDiv">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Reference Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield theme="myTheme"
								action="com/stpl/pms/action/bo/dm/checkReferenceName.action"
								errorMassage="Reference Name already exists" name="refNmae"
								id="refNmae" maxlength="25" applyscript="true"></ss:textfield>
							<div id="checkAvailability" class="fieldError">
								<s:fielderror name="fielderror" id="fielderror"></s:fielderror>
							</div>
						</div>
			
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Label1:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="label1" id="label1" maxlength="50"
								cssStyle="width: 30%" theme="myTheme" applyscript="true"></ss:textfield>
							<s:select list="#{'-1':'Select Type Of Label','Text':'Text','Date':'Date','List':'List'}" cssStyle="width: 37%" id="label1Type" cssClass="select1"
								name="label1Type" onchange="setLabelAdd(this,'lbValuesList1')" theme="myTheme" applyscript="true"></s:select>
							<div id="label1Error" class="fieldError"></div>
							<div align="center" id="label1TypeError" class="fieldError"></div>
						</div>
					</div>
					<div id="lbValuesList1" align="center" class="scrollDiv"
						style="display: none;">
						 <table id="label1Options">
						 <tr><td>											
						 	<input type="checkbox" value="0" name="checkbox1" />
						 </td>
						<td><ss:textfield theme="myTheme"  maxlength="50" name="label1Values"></ss:textfield></td></tr>
						 </table>
						 <input id="addButton" name="addButton" class="button" type="button" onclick="return addNewOption('label1Options','checkbox1','label1Values')"
						            value="Add" >
						</div>
					<div style="margin-left: 52%" id="errorlbValuesList1"
						class="fieldError"></div>
					<br />
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Label2:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="label2" maxlength="50" id="label2"
								cssStyle="width: 30%" theme="myTheme"></ss:textfield>
							<s:select list="#{'-1':'Select Type Of Label','Text':'Text','Date':'Date','List':'List'}" cssStyle="width: 37%" id="label2Type" cssClass="select1"
								name="label2Type" onchange="setLabelAdd(this,'lbValuesList2')" theme="myTheme"></s:select>
							<div id="label2Error" class="fieldError"></div>
							<div align="center" id="label2TypeError" class="fieldError"></div>
						</div>
					</div>
					<div id="lbValuesList2" align="center" class="scrollDiv"
						style="display: none;">
						<table id="label2Options">
							<tr>
								<td>
									<input type="checkbox" value="0"
										name="checkbox2" />
								</td>
								<td>
									<ss:textfield theme="myTheme" maxlength="50"
										name="label2Values" ></ss:textfield>
								</td>
							</tr>
						</table>
						<input id="addButton" name="addButton" class="button"
							type="button"
							onclick="return addNewOption('label2Options','checkbox2','label2Values')"
							value="Add">
					</div>
					<div style="margin-left: 52%" id="errorlbValuesList2"
						class="fieldError"></div>
					<br />
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Label3:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="label3" id="label3" maxlength="50"
								cssStyle="width: 30%" theme="myTheme"></ss:textfield>
							<s:select list="#{'-1':'Select Type Of Label','Text':'Text','Date':'Date','List':'List'}" cssStyle="width: 37%" id="label3Type" cssClass="select1"
								name="label3Type" onchange="setLabelAdd(this,'lbValuesList3')" theme="myTheme"></s:select>
							<div id="label3Error" class="fieldError"></div>
							<div align="center" id="label3TypeError" class="fieldError"></div>
							<input type="hidden" name="refIndex" id="refIndex" value="-1">
						</div>
					</div>
					<div id="lbValuesList3" align="center" class="scrollDiv"
						style="display: none;">
						<table id="label3Options">
							<tr>
								<td>
									<input type="checkbox" value="0"
										name="checkbox3" />
								</td>
								<td>
									<ss:textfield theme="myTheme" maxlength="50"
										name="label3Values" ></ss:textfield>
								</td>
							</tr>
						</table>
						<input id="addButton" name="addButton" class="button"
							type="button"
							onclick="return addNewOption('label3Options','checkbox3','label3Values')"
							value="Add">
					</div>
					<div style="margin-left: 52%" id="errorlbValuesList3"
						class="fieldError"></div>

				</div>
				<div class="box_footer" align="right">
					<s:submit id="addButton" cssClass="button" value="Add To List" onclick="return addToRefList('add');"></s:submit>
				</div>

			</s:form>
		</div>
	</body>
</html>