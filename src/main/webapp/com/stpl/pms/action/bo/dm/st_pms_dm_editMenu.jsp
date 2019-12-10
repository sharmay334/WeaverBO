<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Edit Menu</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 	<script type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		});	
		});
	</script>
  </head>
  
  
  <body>
  <s:form id="menuEdit" theme="simple"  action="st_pms_dm_saveEditMenuDetail">
  <s:token name="strutsToken" id="strutsToken" />
		<div id="container">
			<h2>
				Edit Menu
			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Domain Information
					</h4>
				</div>
				<div class="innerbox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									<s:label value="Domain Name:" theme="simple" />
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden value="%{domainId}" id="domainId"
										name="domainId"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<ss:select theme="myTheme" cssClass="select1" applyscript="true"
										list="%{domainMap}" name="domainId" id="domainId"
										headerKey="-1" headerValue="--Please Select--"
										listKey="%{key}" listValue="%{value}"/>
								</s:else>
							</div>
						</div>

						<div class="clearFRM"></div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									<s:label value="Alias Name:" theme="simple" />
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<ss:select theme="myTheme" cssClass="select1" applyscript="true"
										list="%{}" name="aliasId" id="aliasId"
										headerKey="-1" headerValue="--Please Select--"/>
							</div>
						</div>

						<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								<s:label value="Device:" cssStyle="margin-left: 30px"
									theme="simple" />
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select name="device" headerKey="-1" applyscript="true"
								headerValue="-- Please Select --" cssClass="select1"
								id="device" list="{'PC','TAB','MOBILE'}"
								onchange="return getMenuDiv()"
								theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<s:label value="Main Menu:" cssStyle="margin-left: 30px"
								theme="simple" />
						</div>

						<div class="InputDiv">
							<ss:select headerKey="-1" headerValue="-- Please Select --" ajaxAction="com/stpl/pms/action/bo/dm/st_pms_dm_showEditMenu.action"
								cssClass="select1" id="menu" name="menu" list="{}" theme="myTheme" applyscript="true"
								ajaxParam="aliasId,device,menu" target="menuDiv"/>
						</div>
					</div>
				</div>
			</div>
			<div id="menuDiv"></div>
		</div>
</s:form>

 <div id="addContent" style="display: none;">
			   
								<div class="FormMainBox"><div class="labelDiv"><label>Display Name:</label></div>
									<div class="InputDiv"><s:hidden id="menuId_"></s:hidden>
									
									<s:textfield theme="myTheme" id="displayName_" applyscript="true"/></div></div>
                                  <div class="clearFRM"></div>
								<div class="FormMainBox"><div class="labelDiv"><label> Show On Page:</label></div>
					                <div class="InputDiv">
						              <s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}" name="status_" cssClass="inpSpan" theme="simple" onchange="checkStatus(this.name)"></s:radio>
					                </div>
					            </div>
					            <div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv"><label>Content Type:</label></div>
									<div class="InputDiv"><s:select headerKey="-1" onchange="getContentNameList(this.id)" headerValue="-- Please Select --" cssClass="select1" id="contentType_" list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','HOME_PAGE'}"
										 theme="myTheme" applyscript="true" cssStyle="font-size:14px" />
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Content Name:
										</label>
									</div>
									<div class="InputDiv">
										<s:select cssStyle="font-size:14px"
											headerKey="-1" headerValue="-- Please Select --"
											cssClass="select1" id="contentName_" list='{}'
											theme="myTheme" applyscript="true" />
									</div>
								</div>
								<div class="FormMainBox"><div class="labelDiv"><label> Highlight Option:</label></div>
					                <div class="InputDiv">
						              <s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}" name="highLightOpt_" cssClass="inpSpan" theme="simple"></s:radio>
					                </div>
					            </div>
					            <div class="clearFRM"></div>
							
			   </div>
			
	</body>
</html>
