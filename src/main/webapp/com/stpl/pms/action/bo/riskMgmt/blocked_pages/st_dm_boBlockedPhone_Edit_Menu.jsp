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
		<title>Block Phone Search</title>

		<script>
	$(document).ready(function(){
		var domainId = '<s:property value="%{bydefaultSelectedDomain}"/>';
		if(domainId != null && domainId!=0 && domainId != '' && $('#domainId').val()!=-1){
			$('#bo_Risk_blockPhoneEdit_menu').submit();
		}
	
		$('#domainId').change(function(){
			$('#searchPhone').val('');
			$('#searchDiv').html('');
			createBubble();
		});
	});	
	
	$(document).on("click", "a[id*='link_phoneNo_']", function(){
				var id = $(this).attr('id').replace('link_','');
				if(typeof($('#'+id).attr('disabled')) == 'undefined'){
					$('#'+id).attr("disabled", true);
					$(this).children('img').attr('src', '<%=path%>/images/right.gif');
				} else {
					$('#'+id).removeAttr("disabled");
					$(this).children('img').attr('src', '<%=path%>/images/cross.gif');
				}
			});
			$(document).on("submit", "#bo_Risk_blockPhoneSearchResult", function(){
				$("input[name='phoneNoList']").each(function(){
					if(typeof($(this).attr('disabled')) == 'undefined'  && (typeof($(this).attr('readonly')) !== 'undefined' || $(this).val()=='')){
						$(this).attr("disabled", true);
					} else {
						$(this).removeAttr("disabled");
					}
				});
			});
			
			$(document).on("click","#addToBlock",function(){
				if($(this).children('img').attr('name')=='maximize') {				
					$("#reasonDiv").attr('style','display: block');
					$("#editPhone").attr('style','visibility: visible');
					$("#addPhone").attr('style', 'display: block');
					$(this).children('img').attr('src', '<%=path%>/images/minimize.png');
					$(this).children('img').attr('name', 'minimize');
				} else {
					if($('#blockPhoneNos').val()<=0){
						$("#reasonDiv").attr('style','display: none');
						$("#editPhone").attr('style','visibility: hidden');
					}
					$("#addPhone").attr('style', 'display: none');
					$(this).children('img').attr('src', '<%=path%>/images/add.png');
					$(this).children('img').attr('name', 'maximize');
				}
			})
			$(document).on("blur","input[id*='phoneNo']",function(){
			var id = $(this).attr('id');
				var val = $(this).val();
				if(val != ""){
					$("input[id*='phoneNo']").each(function(){
						var idAll = $(this).attr('id');
						var value = $(this).val();
						if(value != "" && id != idAll && val == value){
							$("#"+id).val("");
							alert("Duplicate Phone No");
							$("#"+id).focus();
							alert(id);
							return false;
							}
					});
				}
			})
			
			
		</script>
	</head>
	<body>

		<div>
			<s:form id="bo_Risk_blockPhoneEdit_menu" theme="simple"
				action="bo_dm_blockPhone_SearchResult" target="searchDiv">
				<div class="clear2"></div>
				<h2>
					Block Phone Edit
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
										<s:hidden name="domainId" value="%{domainId}"
											id="domainId"></s:hidden>
										<s:property value="%{domainName}" />
									</s:if>
									<s:else>
										<s:select name="domainId" cssClass="select1" headerKey="-1"
											headerValue="-Please Select-" id="domainId"
											value="%{bydefaultSelectedDomain}" list="%{domainMap}" theme="myTheme"
											applyscript="true" />
									</s:else>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Phone Number
								</label>
							</div>
							<div class="InputDiv">

								<ss:textfield name="searchPhone" theme="myTheme" maxlength="10"
									id="searchPhone" pattern="^[7-9]{1}[0-9]{9}$" patternOn="blur"
									errorMassage="Please enter correct Phone No" value="%{value}" />
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
						<ss:submit name="phoneSearch" value="Search" cssClass="button"
							id="phoneSearch" theme="myTheme"></ss:submit>
					</div>

				</div>
			</s:form>
			<div id="searchDiv"></div>
		</div>

	</body>
</html>