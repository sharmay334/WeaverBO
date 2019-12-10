<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<title>Network Access Management</title>
		<script>
			$(document).ready(function() {
				var domainId = '<s:property value="%{bydefaultSelectedDomain}"/>';
				if (domainId != null && domainId != 0 && domainId != '' && $('#domainId').val()!=-1) {
					$('#bo_Risk_blockIpEdit_menu').submit();
				}
		
				$('#domainId').change(function() {
					$('#ipAdd').val('');
					$('#searchDiv').html('');
					createBubble();
				});
		
			});
			$(document).on("click", "a[id*='link_domainIp_']", function(){
				var id = $(this).attr('id').replace('link_','');
				if(typeof($('#'+id).attr('disabled')) == 'undefined'){
					$('#'+id).attr("disabled", true);
					$(this).children('img').attr('src', '<%=path%>/images/right.gif');
				} else {
					$('#'+id).removeAttr("disabled");
					$(this).children('img').attr('src', '<%=path%>/images/cross.gif');
				}
			});
			$(document).on("submit", "#bo_Risk_blockIpSearchResult", function(){
				$("input[name='domainIpList']").each(function(){
					if(typeof($(this).attr('disabled')) == 'undefined' && (typeof($(this).attr('readonly')) !== 'undefined' || $(this).val()=='')){
						$(this).attr("disabled", true);
					} else {
						$(this).removeAttr("disabled");
					}
				});
			});
			
			$(document).on("click","#addToBlock",function(){
				if($(this).children("img").attr('name')=="maximize") {
					$("#addIP").attr('style','display: block');
					$("#reasonDiv").attr('style','display: block');
					$("#editIP").attr('style','visibility: visible');
					$(this).children('img').attr('src', '<%=path%>/images/minimize.png');
					$(this).children('img').attr('name', 'minimize');
				} else {
					$("#addIP").attr('style','display: none');
					if(($("#ipAddressCount").val())<=0) {
						$("#reasonDiv").attr('style','display: none');
						$("#editIP").attr('style','visibility: hidden');
					}
					$(this).children('img').attr('src', '<%=path%>/images/add.png');
					$(this).children('img').attr('name', 'maximize');
					createBubble();
				}
			});
			
			$(document).on("blur","input[id*='Ip']",function(){ 
				var id = $(this).attr('id');
				var val = $(this).val();
				if(val!=""){
					$("input[id*='Ip']").each(function(){
						var idAll = $(this).attr('id');
						var value = $(this).val();
						if(value != "" && id!=idAll && val==value){
							$("#"+id).val("");
							alert("Duplicate IP Address");
						}
					});
				}
			});
		</script>
	</head>
	<body>
		<div>
			<s:form id="bo_Risk_blockIpEdit_menu"
				action="bo_dm_blockIp_SearchResult" target="searchDiv"
				theme="simple">
				<div class="clear2"></div>
				<h2>
					<s:text name="global.scratchWeaver.networkaccess"/>
				</h2>

				<div class="FormSection">

					<div class="greyStrip">
						<h4>
							<s:text name="global.searchuser.requiredinformation"/>
						</h4>
					</div>

					<div class="innerBox">

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									<s:text name="global.subuserregistration.UserName"/>
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div class="small-text-box-div">
									<ss:select  id="userName" name="userName" theme="myTheme"
							cssClass="select1" list="%{#session.subUserList}"
							 headerKey="-1" ajaxAction="com/stpl/pms/action/bo/um/bo_um_editNetwork_Access.action" target="result"
							headerValue="%{getText('global.SELECTHEADER')}" applyscript="true"></ss:select>
								</div>
							</div>
						</div>
						
						
					</div>
					<div class="box_footer" align="right">
						<%-- <s:submit name="IpSearch" value="Search" cssClass="button"
							id="IpSearch"></s:submit> --%>
							<input type="submit" name="IpSearch" value='<s:text name="global.searchuser.search"/>' class = "button" id = "IpSearch" />
					</div>
				</div>
			</s:form>
			<div id="searchDiv"></div>
		</div>
	</body>
</html>

