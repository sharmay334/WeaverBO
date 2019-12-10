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
		<title>
			ADD EDIT LOCATIONS
		</title>
       <SCRIPT type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/dm/js/dm.js"></SCRIPT>
		<script>
			$(document).ready(function(){
				var domainId = $("#domainId").val();
				if(domainId!=-1 && domainId!=""){
					_ajaxCallDiv('st_dm_fetch_locations.action?domainId='+domainId,'','frmBox');
				}
					$("#domainId").change(function(){
						var domainId = $("#domainId").val();
					if(domainId!=-1 && domainId!=""){
						_ajaxCallDiv('st_dm_fetch_locations.action?domainId='+domainId,'','frmBox');
					}else{
						$("#frmBox").empty();
					}
				});
				paramArr=window.location.search.replace("?","").split("=");
		  		if(paramArr.length==2 && ""!=paramArr[1].trim() && paramArr[0]==="lastView"){
		  			$("#domainId").val(paramArr[1]);
		  			_ajaxCallDiv('st_dm_fetch_locations.action?domainId='+$("#domainId").val(),'','frmBox');
		  		}
			});
			
			$(document).on("click", "[id*='edit_']", function(){
				if($(this).val()=="edit") {
					$("#display").attr('style','display: block');
					$("#locId").val($(this).attr("id").split("_")[1]);
					$(this).parent().parent().find("td").each(function(){
						if($(this).attr("class")=="text"){
							$("#"+$(this).attr('id').split('_')[0]).val($(this).text().trim());
						} 					
					});
				}
 			});
 		
 			$(document).on("click", "[id='addMore']", function(){
				$("#display").attr('style','display: block');
				$("#locId").val(null);
				$("#addLocation")[0].reset();
			});
			
			$(document).on("click","[id='cancel']", function(){
				$("#display").attr('style','display: none');
				$(".bubbletip").hide();
			});
		
			$(document).on("click", "[id='active'],[id='inactive']", function(){
				var isChecked = false;
				$("[id*='chkBox_']:checked").each(function() {
					isChecked = true;
					return false;
 				});	  
 				if(!isChecked)
 					alert ("Please select at least one Checkbox");
 				return isChecked;
			});
		</script>
	</head>
	<body>
		<div id="container">
			<h2>ADD EDIT LOCATIONS</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Add Edit Locations</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:label value="Domain Name:" /> </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId" name="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select name="domainId" headerKey="-1" applyscript="true"
									headerValue="-- Please Select --" cssClass="select1"
									id="domainId" list="%{domainMap}" listKey="%{key}"
									listValue="%{value}" theme="myTheme"
									value="%{bydefaultSelectedDomain}" />
							</s:else>
						</div>
					</div>
				</div>
			</div>
			<div id="frmBox"></div>
		</div>
	</body>
</html>
