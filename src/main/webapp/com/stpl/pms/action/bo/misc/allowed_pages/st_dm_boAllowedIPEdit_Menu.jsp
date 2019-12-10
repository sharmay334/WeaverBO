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
		<title>ALlowed IP</title>
		
		<script>
	$(document).ready(function(){
		var domainId = '<s:property value="%{bydefaultSelectedDomain}"/>';
				if (domainId != null && domainId != 0 && domainId != '' && $('#domainId').val()!=-1 ) {
					$('#bo_misc_allowedIpEdit_menu').submit();
				}
		$('#domainId').change(function() {
					$('#ipSearch').val('');
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
	
	$(document).on("submit", "#bo_misc_allowIpSearchResult", function(){
				$("input[name='domainIpList']").each(function(){
					if(typeof($(this).attr('disabled')) == 'undefined' && (typeof($(this).attr('readonly')) !== 'undefined' || $(this).val()=='')){
						$(this).attr("disabled", true);
					} else {
						$(this).removeAttr("disabled");
					}
				});
			});
	
		$(document).on("click","#addToBlock",function(){
			if($(this).children('img').attr('name')=='maximize'){
				$("#reasonDiv").attr('style','display: block');
				$("#editIP").attr('style','visibility: visible');
				$("#addIP").attr('style', 'display: block');
				$(this).children('img').attr('src', '<%=path%>/images/minimize.png');
				$(this).children('img').attr('name', 'minimize');
			} else {
				if($('#allowedIpAddresses').val()<=0){
					$("#reasonDiv").attr('style','display: none');
					$("#editIP").attr('style','visibility: none');
				}
				$("#addIP").attr('style', 'display: none');
				$(this).children('img').attr('src', '<%=path%>/images/add.png');
				$(this).children('img').attr('name', 'maximize');
			}
			
		})
	
	
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

		<s:form theme="simple" action="bo_misc_allowIp_SearchResult"
			target="searchDiv" id="bo_misc_allowedIpEdit_menu">
			<s:token name="strutsToken" id="strutsToken"></s:token>

			<div class="clear2"></div>
			<h2>

				Allowed IP Edit
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
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId"
									name="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<s:select name="domainId" cssClass="select1" id="domainId"
									headerKey="-1" headerValue="-Please Select-"
									list="%{domainMap}" theme="myTheme" applyscript="true"
									value="%{bydefaultSelectedDomain}" />
							</s:else>
						</div>
					</div>

					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								IP Address
							</label>
						</div>
						<div class="InputDiv">

							<ss:textfield name="ipSearch" theme="myTheme" maxlength="16"
								id="ipSearch"
								pattern="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
								errorMassage="Please insert correct ip address" value="%{value}"
								patternOn="blur" />

						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit name="IpSearch" value="Search" cssClass="button"
						id="IpSearch">
					</s:submit>
				</div>
			</div>
		</s:form>
		<div id="searchDiv"></div>
	</body>
</html>


