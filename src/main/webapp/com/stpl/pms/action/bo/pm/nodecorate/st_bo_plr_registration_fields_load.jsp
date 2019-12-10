<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/pm/js/pm.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("[id*='_mandatory']").each(function(){
				if($(this).text()=='*'){
					var id=$(this).attr('id').replace("_mandatory",'');
					//$("#"+id).attr("required","true");
					$("#"+id).attr("applyscript","true");
				}
			});
			createBubble();
			$("input[type='text']").each(function(){
			var fieldName = $(this).attr("id");
			if(fieldName=="user_name" || fieldName=="email_id" || fieldName=="mobile_no"){
				$(this).attr("action","st_bo_pm_check_plr_regisfields_unique.action");
				$(this).attr("ajaxParam",fieldName+",domainId");
				
			}
		});
			
		$("#date_of_birth").datepicker({
			 changeMonth: true,
		     changeYear: true,
		     yearRange: "1900:+0"
		}); 	
		
		});
	</script>
  </head>
  
  <body>
		<s:iterator value="%{domainWiseFieldList}" status="fieldListMap">
			<s:if test="%{(fieldInputType=='Text') && (fieldName!='j_captcha_response')}">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
							<s:label
								value="%{resource.getProperty('global.'+fieldDispCode)+':'}" />
						<s:if test='%{isMandatory=="Y"}'>
						<em class="Req" id="<s:property value='%{fieldName}' />_mandatory">*</em>
						</s:if>
					</div>
					<div class="InputDiv">
						<ss:textfield theme="myTheme" 
							pattern="%{validationExp}" errorMassage="%{resource.getProperty('global.'+helpStringCode)}" patternOn="blur"
							name="%{fieldName}"
							id="%{fieldName}"></ss:textfield>
					</div>
				</div>
			</s:if>
			<s:elseif test="%{fieldInputType=='Radio'}">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
							<s:label
								value="%{resource.getProperty('global.'+fieldDispCode)+':'}" />
						<s:if test='%{isMandatory=="Y"}'>
						<em class="Req" id="<s:property value='%{fieldName}' />_mandatory">*</em>
						</s:if>
					</div>
					<div class="InputDiv">
						<s:radio name="%{fieldName}" id="%{fieldName}" theme="myTheme"
							list="%{optionValuesMap}" listKey="%{key}"
							listValue="%{resource.getProperty('global.'+value)}"></s:radio>
					</div>
				</div>
			</s:elseif>
			<s:elseif test="%{fieldInputType=='Select'}">
				<s:if test='%{fieldName.contains("date")}'>
					<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
									<s:label
										value="%{resource.getProperty('global.'+fieldDispCode)+':'}" />
								<s:if test='%{isMandatory=="Y"}'>
								<em class="Req">*</em>
								</s:if>
							</div>
							<div class="InputDiv">
								<ss:textfield name="date_of_birth"  cssClass="dateField" id="date_of_birth" readonly="true"  theme="myTheme"></ss:textfield>
							</div>
							<%-- <div class="InputDiv">
													<%
														Date date1 = new Date();
																				int year = 1900 + date1.getYear() - 18;
																				int month = date1.getMonth() + 1;
																				int date = date1.getDate();
													%>
													<select name="year" id="year" class="selectors"
														onchange="enableMonth(<%=year%>,<%=month%>)"
														onkeydown="enableMonth(<%=year%>,<%=month%>)"
														applyscript="true"
														>
														<option value="-1">
															
															<s:property value="%{resource.getProperty('global.424')}"></s:property>
															
														</option>

														<%
															Object o1 = request.getAttribute("year");
																					Integer y1;
																					if (o1 == null) {
																						y1 = 0;
																					} else {
																						y1 = (Integer) o1;
																					}
																					for (int i = 1900; i <= year; i++) {
														%>
														<%
															if (y1 == i) {
														%>
														<option value="<%=i%>" selected="selected"><%=i%></option>
														<%
															} else {
														%>
														<option value="<%=i%>"><%=i%></option>
														<%
															}
																					}
														%>
													</select>
													<%
														String[] monthArr = {"JAN", "FEB", "MAR",
																						"APR", "MAY", "JUN", "JUL", "AUG",
																						"SEP", "OCT", "NOV", "DEC"};
																				o1 = request.getAttribute("month");
																				if (o1 == null) {
																					y1 = -1;
																				} else {
																					y1 = (Integer) o1;
																				}
													%>
													<select name="month" id="month"
														onchange="enableDate(<%=year%>,<%=month%>,<%=date%>)" 
														onkeydown="enableDate(<%=year%>,<%=month%>,<%=date%>)"
														<%if (y1 == -1) {%> disabled="disabled" <%}%>
														class="selectors" applyscript="true">
														<option value="-1">
															<s:property value="%{resource.getProperty('global.425')}"></s:property>
														</option>
														<%
															for (int m = 0; m < monthArr.length; m++) {
																						if (y1 == m) {
														%>
														<option value="<%=m%>" selected="selected">
															<%=monthArr[m]%>
														</option>
														<%
															} else {
														%>
														<option value="<%=m%>">
															<%=monthArr[m]%>
														</option>
														<%
															}
																					}
														%>
													</select>

													<%
														o1 = request.getAttribute("date");
																				if (o1 == null) {
																					y1 = -1;
																				} else {
																					y1 = (Integer) o1;
																				}
													%>

													<select name="date" id="date" <%if (y1 == -1) {%>
														disabled="disabled" <%}%> class="selectors"
														applyscript="true"
														>
														<option value="-1">
															<s:property value="%{resource.getProperty('global.426')}"></s:property>
														</option>
														<%
															for (int d = 1; d < 32; d++) {
																						if (y1 == d) {
														%>
														<option value="<%=d%>" selected="selected"><%=d%></option>
														<%
															} else {
														%>
														<option value="<%=d%>"><%=d%></option>
														<%
															}
																					}
														%>

													</select>
						</div> --%>
						
					</div>
				</s:if>
				<s:else>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
								<s:label
									value="%{resource.getProperty('global.'+fieldDispCode)+':'}" />
							<s:if test='%{isMandatory=="Y"}'>
							<em class="Req" id="<s:property value='%{fieldName}' />_mandatory">*</em>
							</s:if>
						</div>
						<div class="InputDiv">
							<s:select name="%{fieldName}" id="%{fieldName}"
								cssClass="select1" theme="myTheme" list="%{optionValuesMap}"
								headerKey="-1" headerValue="Please Select" listKey="%{key}"
								listValue="%{(fieldName=='country_code' || fieldName=='state_code')?value:resource.getProperty('global.'+value)}"></s:select>
						</div>
					</div>
				</s:else>
			</s:elseif>
		</s:iterator>
		<div class="box_footer" align="right">
				<ss:submit id="submit" cssClass="button" value="submit"></ss:submit>
		</div>
	</body>
</html>