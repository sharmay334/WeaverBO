<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
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
		
		<script type="text/javascript">
		 $(document).ready(function(){
		    $('div[id*="lbValues"]').scrollTop($('div[id*="lbValues"]')[0].scrollHeight);
		});
		
		</script>
	</head>
<body>
<div class="FormSection">
	<div class="greyStrip">
		<h4>
			Edit Reference
		</h4>
	</div>

	<s:form id="formEdit" name="formEdit" cssStyle="width:100%" theme="simple" action ="com/stpl/pms/action/bo/dm/st_pms_dm_bo_editToReferralsList.action" target="newFieldDiv">
		<s:set name="referenceInfo" value="#request.referenceInfo"></s:set>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						Reference Name:
					</label>
				</div>
				<div class="InputDiv">
					<input type="text" name="refNmae" id="refNmae"
						value="<s:property value="%{resource.getProperty('global.'+#request.referenceInfo.referenceName)}" />"
						disabled="disabled">
					<input type="hidden" id="refIndex" name="refIndex"
						value="<s:property value="refIndex"/>">
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">

				<div class="labelDiv">
					<label>
						Label1:
					</label>
				</div>

				<div class="InputDiv">
					<input type="text" name="label1" id="label1" style="width: 30%" patternon="both"
						<s:property value="#request.referenceInfo.refTxtLabel1 == null?'':'disabled=disabled'" />"
						value="<s:if test="#request.referenceInfo.refTxtLabel1 != null"><s:property value="%{resource.getProperty('global.'+#request.referenceInfo.refTxtLabel1)}" /></s:if>">
					<select style="width: 37%" id="label1Type" class="select1"
						name="label1Type"
						onchange="return setLabel(this,'<s:property value="#request.referenceInfo.labelInfoBean1.valueList.size"/>','<s:property value="#request.referenceInfo.refTxtLabel1Type"/>','lbValues1','lbValuesList1')">
						<option value="-1">
							Select Type Of Label
						</option>
						<s:if
							test="#request.referenceInfo.refTxtLabel1Type.equals('Text')">
							<option value="Text" selected="selected">
								Text
							</option>
						</s:if>
						<s:else>
							<option value="Text">
								Text
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel1Type.equals('Date')">
							<option value="Date" selected="selected">
								Date
							</option>
						</s:if>
						<s:else>
							<option value="Date">
								Date
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel1Type.equals('List')">
							<option value="List" selected="selected">
								List
							</option>
						</s:if>
						<s:else>
							<option value="List">
								List
							</option>
						</s:else>

					</select>
					<div id="label1Error" class="fieldError"></div>
					<div align="center" id="label1TypeError" class="fieldError"></div>
				</div>
			</div>
			<s:if test="#request.referenceInfo.refTxtLabel1Type.equals('List') || #request.referenceInfo.labelInfoBean1.valueList.size > 0">
				<div id="lbValues1" align="center" class="scrollDiv" <s:property value="%{(!#request.referenceInfo.refTxtLabel1Type.equals('List'))?'style=display:none':''}" />>
					<table id="label1Options">
						<s:iterator
							value="#request.referenceInfo.labelInfoBean1.valueList"
							status="values">
							<tr>
								<td>
									<s:if
										test="#request.referenceInfo.labelInfoBean1.statusList.get(#values.index).equals('ACTIVE')">
										<input type="checkbox" checked="checked"
											value="<s:property value="#values.index"/>" id="checkbox1"
											name="checkbox1" />
									</s:if>
									<s:else>
										<input type="checkbox"
											value="<s:property value="#values.index"/>" id="checkbox1"
											name="checkbox1" />
									</s:else>
								</td>
								<td>
									<input type="text" id="label1Values" maxlength="50"
										name="label1Values" disabled="disabled" value="<s:property/>" />
								</td>

							</tr>

						</s:iterator>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label1Options','checkbox1','label1Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValues1" class="fieldError"></div>
			</s:if>
			<s:else>

				<div id="lbValuesList1" align="center" class="scrollDiv"
					style="display: none;">
					<table id="label1Options">
						<tr>
							<td>
								<input type="checkbox" value="0" id="checkbox1" name="checkbox1" />
							</td>
							<td>
								<ss:textfield theme="myTheme" id="label1Values" maxlength="50"
									name="label1Values" ></ss:textfield>
							</td>
						</tr>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label1Options','checkbox1','label1Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValuesList1"
					class="fieldError"></div>
			</s:else>
			<br />



			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						Label2:
					</label>
				</div>
				<div class="InputDiv">
					<input type="text" id="label2" name="label2" style="width: 30%" patternon="both"
						<s:property value="#request.referenceInfo.refTxtLabel2 == null?'':'disabled=disabled'" />
						value="<s:if test="#request.referenceInfo.refTxtLabel2 != null"><s:property value="%{resource.getProperty('global.'+#request.referenceInfo.refTxtLabel2)}" /></s:if>">
					<select style="width: 37%" id="label2Type" class="select1"
						name="label2Type"
						onchange="return setLabel(this,'<s:property value="#request.referenceInfo.labelInfoBean2.valueList.size"/>','<s:property value="#request.referenceInfo.refTxtLabel2Type"/>','lbValues2','lbValuesList2')">
						<option value="-1">
							Select Type Of Label
						</option>
						<s:if
							test="#request.referenceInfo.refTxtLabel2Type.equals('Text')">
							<option value="Text" selected="selected">
								Text
							</option>
						</s:if>
						<s:else>
							<option value="Text">
								Text
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel2Type.equals('Date')">
							<option value="Date" selected="selected">
								Date
							</option>
						</s:if>
						<s:else>
							<option value="Date">
								Date
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel2Type.equals('List')">
							<option value="List" selected="selected">
								List
							</option>
						</s:if>
						<s:else>
							<option value="List">
								List
							</option>
						</s:else>
					</select>
					<div id="label2Error" class="fieldError"></div>
					<div align="center" id="label2TypeError" class="fieldError"></div>
				</div>
			</div>
			<s:if test="#request.referenceInfo.refTxtLabel2Type.equals('List') || #request.referenceInfo.labelInfoBean2.valueList.size > 0">
				<div id="lbValues2" align="center" class="scrollDiv" <s:property value="%{(!#request.referenceInfo.refTxtLabel2Type.equals('List'))?'style=display:none;':''}" />>
					<table id="label2Options">
						<s:iterator
							value="#request.referenceInfo.labelInfoBean2.valueList"
							status="valueList2">
							<tr>
								<td>
									<s:if
										test="#request.referenceInfo.labelInfoBean2.statusList.get(#valueList2.index).equals('ACTIVE')">
										<input type="checkbox"
											value="<s:property value="#valueList2.index"/>"
											checked="checked" id="checkbox2" name="checkbox2" />
									</s:if>
									<s:else>
										<input type="checkbox"
											value="<s:property value="#valueList2.index"/>"
											id="checkbox2" name="checkbox2" />
									</s:else>
								</td>
								<td>
									<input type="text" id="label2Values" maxlength="50"
										name="label2Values" disabled="disabled" value="<s:property/>" />
								</td>
							</tr>

						</s:iterator>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label2Options','checkbox2','label2Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValues2" class="fieldError"></div>

			</s:if>
			<s:else>

				<div id="lbValuesList2" align="center" class="scrollDiv"
					style="display: none;">
					<table id="label2Options">
						<tr>
							<td>
								<input type="checkbox" value="0" id="checkbox2" name="checkbox2" />
							</td>
							<td>
								<ss:textfield theme="myTheme" id="label2Values" maxlength="50"
									name="label2Values" ></ss:textfield>
							</td>
						</tr>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label2Options','checkbox2','label2Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValuesList2"
					class="fieldError"></div>
			</s:else>
			<br />
			<div class="clearFRM"></div>
			
			
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						Label3:
					</label>
				</div>
				<div class="InputDiv">
					<input type="text" id="label3" name="label3" style="width: 30%" patternon="both"
						<s:property value="#request.referenceInfo.refTxtLabel3 == null?'':'disabled=disabled'" />
						value="<s:if test="#request.referenceInfo.refTxtLabel3 != null"><s:property value="%{resource.getProperty('global.'+#request.referenceInfo.refTxtLabel3)}"  /></s:if>">
					<select style="width: 37%" id="label3Type" class="select1"
						name="label3Type"
						onchange="return setLabel(this,'<s:property value="#request.referenceInfo.labelInfoBean3.valueList.size"/>','<s:property value="#request.referenceInfo.refTxtLabel3Type"/>','lbValues3','lbValuesList3')">
						<option value="-1">
							Select Type Of Label
						</option>
						<s:if
							test="#request.referenceInfo.refTxtLabel3Type.equals('Text')">
							<option value="Text" selected="selected">
								Text
							</option>
						</s:if>
						<s:else>
							<option value="Text">
								Text
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel3Type.equals('Date')">
							<option value="Date" selected="selected">
								Date
							</option>
						</s:if>
						<s:else>
							<option value="Date">
								Date
							</option>
						</s:else>
						<s:if
							test="#request.referenceInfo.refTxtLabel3Type.equals('List')">
							<option value="List" selected="selected">
								List
							</option>
						</s:if>
						<s:else>
							<option value="List">
								List
							</option>
						</s:else>
					</select>
					<div id="label3Error" class="fieldError"></div>
					<div align="center" id="label3TypeError" class="fieldError"></div>
				</div>
			</div>
			<s:if test="#request.referenceInfo.refTxtLabel3Type.equals('List') || #request.referenceInfo.labelInfoBean3.valueList.size > 0">
				<div id="lbValues3" align="center" class="scrollDiv" <s:property value="%{(!#request.referenceInfo.refTxtLabel3Type.equals('List'))?'style=display:none;':''}" />>
					<table id="label3Options">
						<s:iterator
							value="#request.referenceInfo.labelInfoBean3.valueList"
							status="valueList3">
							<tr>
								<td>
									<s:if
										test="#request.referenceInfo.labelInfoBean3.statusList.get(#valueList3.index).equals('ACTIVE')">
										<input type="checkbox" <s:property value="#valueList3.index"/>
											checked="checked" id="checkbox3" name="checkbox3" />
									</s:if>
									<s:else>
										<input type="checkbox"
											value="<s:property value="#valueList3.index"/>"
											id="checkbox3" name="checkbox3" />
									</s:else>
								</td>
								<td>
									<input type="text" id="label3Values" maxlength="50"
										name="label3Values" disabled="disabled" value="<s:property/>" />
								</td>
							</tr>
						</s:iterator>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label3Options','checkbox3','label3Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValues3" class="fieldError"></div>
			</s:if>
			
			<s:else>
				<div id="lbValuesList3" align="center" class="scrollDiv"
					style="display: none;">
					<table id="label3Options">
						<tr>
							<td>
								<input type="checkbox" value="0" id="checkbox3" name="checkbox3" />
							</td>
							<td>
								<ss:textfield theme="myTheme" id="label3Values" maxlength="50"
									name="label3Values" ></ss:textfield>
							</td>
						</tr>
					</table>
					<input id="addButton" name="addButton" class="button" type="button"
						onclick="return addNewOption('label3Options','checkbox3','label3Values')"
						value="Add">
				</div>
				<div style="margin-left: 52%" id="errorlbValuesList3"
					class="fieldError"></div>
			</s:else>
		</div>
		<div class="box_footer" align="right">
		<s:submit id="addButton" cssClass="button" value="Save" onclick="addToRefList('edit');"></s:submit>
		</div>


	</s:form>
</div>
</body>
</html>
