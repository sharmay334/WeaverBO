<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Email Provider List</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function(){
				var domainId = $("#domainId").val();
				if(domainId!=-1 && domainId != "") {
					domainChangeActivity(domainId);
				}
			
				$('#domainId').change(function() {
					domainChangeActivity($(this).val());
				});
				
				function domainChangeActivity(domainId){
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  				var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
	  				$.each(aliasMap,function(index, value) {
	  					$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
				
				}
			});
			/* $(document).on("click", "#submit", function(){
				var str = "{";
				$('#activeMisReport tr').each(function() {
				    $(this).find('td').each(function() {
				    	if($(this).attr('id')=='misName') {
				    		str += '"' + $(this).text().trim();
					    } else {
					    	str += '":"' +$(this).children('select').val().trim()+ '",';
					    }
					});
				});
			 str =str.substring(0, str.length - 1) + "}";
			 $('#newActiveReportList').val(str);
			}); */
		</script>
	</head>
	<body>
		<s:form id="activeEmailProviderList" action="st_dm_email_provider_Search" target="searchResult" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div id="container">
				<h2>
					SMS and Email Provider Options List
				</h2>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							SMS and Email Provider Search
						</h4>
					</div>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<s:label value="Domain Name:" />
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden id="domainId" name="domainId" value="%{domainId}"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<ss:select name="domainId" headerKey="-1" applyscript="true"
										headerValue="-- Please Select --" cssClass="select1"
										id="domainId" list="%{domainMap}" listKey="%{key}"
										listValue="%{value}" theme="myTheme" value="%{bydefaultSelectedDomain}" />
								</s:else>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Alias Name
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<s:select theme="myTheme" cssClass="select1"
										list="%{aliasMap}" applyscript="true"
										name="aliasId" id="aliasId" headerKey="-1"
										headerValue="--Please Select--" listKey="%{key}"
										listValue="%{value}"  ></s:select>
								
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Provider Type
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<s:select theme="myTheme" cssClass="select1"
										list="#{'EMAIL':'EMAIL','SMS':'SMS'}" applyscript="true"
										name="providerType" id="providerType" headerKey="-1"
										headerValue="--Please Select--"  ></s:select>
								
							</div>
						</div>
					</div>
				
				<div class="box_footer" align="right">
					<ss:submit theme="simple" id="submitBtn" value="Search" ></ss:submit>
				</div></div>
			</div>
		</s:form>
		
		
		<div id="searchResult">

		</div>
	</body>
</html>
