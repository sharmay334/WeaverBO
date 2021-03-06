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
		<title>Block IP Search</title>
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
					Block IP Edit
				</h2>

				<div class="FormSection">

					<div class="greyStrip">
						<h4>
							Required Information
						</h4>
					</div>

					<div class="innerBox">

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div class="small-text-box-div">
									<s:if test="%{domainId>1}">
										<s:hidden value="%{domainId}" id="domainId"
											name="domainId"></s:hidden>
										<s:property value="%{domainName}" />
									</s:if>
									<s:else>
										<ss:select name="domainId" cssClass="select1" headerKey="-1"
											headerValue="-Please Select-" id="domainId"
											list="%{domainMap}" theme="myTheme" applyscript="true" value="%{bydefaultSelectedDomain}" />
									</s:else>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									IP Address
								</label>
							</div>
							<div class="InputDiv">

								<ss:textfield name="ipAdd" theme="myTheme" maxlength="16"
									id="ipAdd"
									pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
									patternOn="blur" errorMassage="Please enter correct IP address"
									value="%{value}" />
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
						<s:submit name="IpSearch" value="Search" cssClass="button"
							id="IpSearch"></s:submit>
					</div>
				</div>
			</s:form>
			<div id="searchDiv"></div>
		</div>
	</body>
</html>
