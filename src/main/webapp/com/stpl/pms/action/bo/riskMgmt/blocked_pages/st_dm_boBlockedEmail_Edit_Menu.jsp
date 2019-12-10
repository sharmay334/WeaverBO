<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
	<head>
	<title>Block Email Search</title>
		<script>
			$(document).ready(function(){
				var domainId = '<s:property value="%{bydefaultSelectedDomain}"/>';
				if(domainId != null && domainId!=0 && domainId != '' && $('#domainId').val()!=-1){
					$('#bo_Risk_blockEmailEdit').submit();
				}
		
				$('#domainId').change(function(){
					$('#searchEmail').val('');
					$('#searchDiv').html('');
					createBubble();
				});
			});	
	
			$(document).on("click", "a[id*='link_email_']", function(){
				var id = $(this).attr('id').replace('link_','');
				if(typeof($('#'+id).attr('disabled')) == 'undefined'){
					$('#'+id).attr("disabled", true);
					$(this).children('img').attr('src', '<%=path%>/images/right.gif');
				} else {
					$('#'+id).removeAttr("disabled");
					$(this).children('img').attr('src', '<%=path%>/images/cross.gif');
				}
			});
			$(document).on("submit", "#bo_Risk_blockEmailSearchResult", function(){
				$("input[name='emailIdList']").each(function(){
					if(typeof($(this).attr('disabled')) == 'undefined' && (typeof($(this).attr('readonly')) !== 'undefined' || $(this).val()=='')){
						$(this).attr("disabled", true);
					} else {
						$(this).removeAttr("disabled");
					}
				});
			});
			$(document).on("click","#addToBlock", function(){
				if('maximize'==$(this).children('img').attr('name')){
					$("#addEmail").attr('style','display: block');
					$("#submit").attr('style','visibility: visible');
					$("#reasonDiv").attr('style','display: block');
					$(this).children('img').attr('src','<%=path%>/images/minimize.png');
					$(this).children('img').attr('name','minimize');
				} else {
					$("#addEmail").attr('style','display: none');
					if($("#emailCount").val()<=0){
						$("#submit").attr('style','visibility: hidden');
						$("#reasonDiv").attr('style','display: none');
					}
					$(this).children('img').attr('src','<%=path%>/images/add.png');
					$(this).children('img').attr('name','maximize');					
				}				
			})
			
			$(document).on("blur","input[id*='email']", function(){
				var id = $(this).attr('id');
				var val = $(this).val();
				if(val != ""){
					$("input[id*='email']").each(function(){
						var idAll = $(this).attr('id');
						var value = $(this).val();
						if(value != "" && id!=idAll && val==value){
							$("#"+id).val("");
							alert("Duplicate Email Address");
						}
					});
				}
			});
		</script>
	</head>
	<body>
		<div>
			<s:form id="bo_Risk_blockEmailEdit" theme="simple"
				action="bo_dm_blockEmail_SearchResult" target="searchDiv">
				<div class="clear2"></div>
				<h2>
					Block E-mail Edit
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
									E-mail
								</label>
							</div>
							<div class="InputDiv">

								<ss:textfield name="searchEmail" theme="myTheme"
									id="searchEmail"
									pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$"
									patternOn="blur"
									errorMassage="Please enter correct Email address"
									value="%{value}" />
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
						<ss:submit name="emailSearch" value="Search" cssClass="button"
							id="emailSearch" theme="myTheme"></ss:submit>
					</div>

				</div>

			</s:form>
			<div id="searchDiv"></div>
		</div>
	</body>
</html>