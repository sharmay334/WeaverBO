<%@page import="java.util.ArrayList"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	String path = request.getContextPath();
	/*String basePath =  (String)request.getAttribute("basePathURL") ;*/
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<title>Edit Registration Page</title>
		<meta name="author" content="Darko Bunic"/>
		<meta name="description" content="Drag and drop table rows with JavaScript"/>
		<meta name="viewport" content="width=device-width, user-scalable=no"/><!-- "position: fixed" fix for Android 2.2+ -->
		<link href="<%=path%>/css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="<%=path%>/js/redips-drag.js"></script>
		<script type="text/javascript" src="<%=path%>/js/script.js"></script>
		<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/pm/js/pm.js"></script>
		
		
		<script>
			$(document).ready(function(){
				var domainId = $('#domainName').val();
				if(domainId != 0 && domainId != -1){
					ajax_call(domainId);
				}
			});
		</script>
	</head>
	<body>

		<div id="container">
			<h2>
				Manage Registration Page
			</h2>
			<div class="FormSection">

				<div class="greyStrip">
					<h4>
						Registration Form
					</h4>
				</div>
				<div class="innerBox">
					<s:form cssStyle="width:100%" theme="simple">
						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									<s:label value="Domain Name:" />
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden name="domainName" value="%{domainId}" id="domainName"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<s:select list="%{domainMap}" name="domainName" id="domainName"
										listKey="%{key}" listValue="%{value}" cssClass="select1"
										onchange="ajax_call(this.value)" headerKey="-1"
										headerValue="Please Select" theme="myTheme" value="%{bydefaultSelectedDomain}"></s:select>
								</s:else>
							</div>
						</div>
						<div class="clearFRM"></div>



						<!--  <tr>
										<td class="tdLabel">
											<s:label value="Password Management:" cssClass="label" />
										</td>
										<td>
											<s:checkboxlist list="#{'isPasswordMgmt':'Password Management'}" name="regType"></s:checkboxlist>
										</td>
									</tr>-->
						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									<s:label value="Registration Type:" />
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<span class="inpSpan"> <s:radio
										list="#{'SINGLEPAGE':'Single Page','MULTIPAGE':'Multiple Page'}"
										name="regType" id="regType"
										onchange="checkRegTypeRadio(this.value,domainName.value)" value="%{regType}"></s:radio>
								</span>
								<ss:textfield name="noOfPages" id="noOfPages"
									cssStyle="width:20px; height: 18px;" maxlength="1"
									onkeyup="ajax_call(domainName.value);return createPageTable(this);"
									theme="myTheme"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div id="loadfieldlist"></div>

					</s:form>
				</div>
			</div>
		</div>
	</body>
</html>