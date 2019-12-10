<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>
    	Player Registration
    </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/pm/js/pm.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var domainId = $('#domainId').val();
			if(domainId!='' && domainId!=-1){
				loadFields();
			}
			
			$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  			var aliasMap = _ajaxCallJson("<%=path%>"+"/com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		});	
			
		});
		function loadFields(){
			 var domainId = $("#domainId").val();
			 var status = $(':checked[name="status"]').val();
			 if(domainId != "-1"){
			 	_ajaxCallDiv("st_bo_plr_registration_fields_load.action?domainId="+domainId+"&status="+status,"","regDiv");
			 	eval('createBubble()');
			 }else{
			 	$("#regDiv").html("");
			 }
		}
	</script>
  </head>
  	 <body>
  		<s:form action="st_bo_pm_save_plr_registration_fields" theme="simple">
		<div id="container">
			<h2>
				Player Registration
			</h2>
			<div class="innerDiv">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Player Registration Menu
						</h4>
					</div>
					
					<s:if test="%{domainId>1}">
						<s:hidden name="domainId" id="domainId" value="%{domainId}"></s:hidden>
						<div class="FormMainBox">
						<div class="labelDiv">
							<s:label value="Domain Name:" />
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:property value="%{domainName}"/>
						</div>
					</div>
					</s:if>
					<s:else>
						<div class="FormMainBox">
							<div class="labelDiv">
								<s:label value="Domain Name:" />
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<ss:select list="%{domainMap}" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" name="domainId" id="domainId"
										cssClass="select1" theme="myTheme" onchange="loadFields()"
										value="%{bydefaultSelectedDomain}">
									</ss:select>
								</div>
						</div>
					</s:else>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
							<div class="labelDiv">
								<s:label value="Alias Name:" />
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<ss:select list="%{aliasMap}" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" name="aliasId" id="aliasId"
										cssClass="select1" theme="myTheme" onchange="loadFields()" >
									</ss:select>
								</div>
						</div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Registration Type:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:radio name="status" id="status"
								list="#{'MINI':'MINI','FULL':'FULL'}" value="%{'MINI'}" onchange="loadFields()"></s:radio>
						</div>
					</div>
					<div id="regDiv"></div>
				</div>
			</div>
		</div>
		</s:form>
  </body>
</html>
