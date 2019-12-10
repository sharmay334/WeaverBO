<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =(String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Vendor Games List</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script>
	$(document).ready(
			function() {
				
				$('[id^="selectAll_"]').click(function(){
							var id = $(this).attr('id');
							if ($(this).attr('checked')) {
									$("#"+id).siblings().find('input[type="checkbox"]').each(function(){
										$(this).attr("checked",true);
							});
						} else {
								$("#"+id).siblings().find('input[type="checkbox"]').each(function(){
									$(this).attr("checked",false);
			   			 		});
							}
						$('#rigthDomainGamePanel').find('input[type="checkbox"]').each(function(){
							     	var id = $(this).attr("id");
							     	var count=$("#leftDomainGamePanel").find($("input[id^='"+id+"_']:checked")).length;
							     	if(count>0){
							     	  $(this).attr("checked",true);
							     	}else{
							     	  $(this).attr("checked",false);
							     	}
							     	});
						});
				
				$(function() {
					$("#accordion").accordion( {
						header : "> div >h3"
					}).sortable( {
						axis : "y",
						handle : "h3",
						stop : function(event, ui) {
							ui.item.children("h3").triggerHandler("focusout");
						}
					});
				});

				$("#accordion").accordion( {
					collapsible : true,
					clearStyle : true,
					header : 'div[class*="accordianHeader"]',
					icons : {
						header : "plus1",
						headerSelected : "minus1"
					},
					active : false
				});
				$(function() {
    			$( ".sortable" ).sortable({
    				scroll :false,
    			});
    			$(".sortable").disableSelection();    
				 });

				$('input:checkbox').click(
						function() {
							var id = $(this).attr('id');
							var spiltid = id.split('_');
							var check;
							
							$("#leftDomainGamePanel").find('input:checked').each(function(){
								if(spiltid[0]==$(this).attr('id').split('_')[0]){
									check=($(this).is(':checked'));
								//	alert("check"+check);
								}
							});
							if(check){
										$("#rigthDomainGamePanel").find(
													"input[id='"+spiltid[0]+"']").attr('checked',true);
										}else{
										$("#rigthDomainGamePanel").find(
													"input[id='"+spiltid[0]+"']").removeAttr('checked');
							}
								
						});

				$('.chkAll').change(
						function() {
							alert($(this).val());
							if ($(this).attr('checked')) {
								$('[id*=' + $(this).val() + '_]').attr(
										'checked', true);
							} else {
								$('[id*=' + $(this).val() + '_]').attr(
										'checked', false);
							}
						});
				$(function() {
					var id, spiltid;
					var allcheckbox = $("#leftDomainGamePanel").find(
							'input:checked');
					allcheckbox.each(function() {
						id = $(this).attr('id');
						spiltid = id.split('_');
						$("#rigthDomainGamePanel").find(
								"input[id='" + spiltid[0] + "']").attr(
								'checked', true);
					});
				});

				var gameThemeArr = new Array();
				$('input[id*="domainDisplayName_"]').each(function() {
					gameThemeArr[$(this).attr('id')] = $(this).val();
				});
				$('input[id*="domainDisplayName_"]').blur(
						function() {
							var divId = '#' + $(this).attr('id').replace(
									'domainDisplayName_',
									'domainDisplayNameDiv_');
							var preVal = gameThemeArr[$(this).attr('id')];
							var val = $(this).val();
							$(divId).find('input[type="checkbox"]').each(
									function() {
										$(this).val(
												$(this).val().replace(preVal,
														val));
									});
							gameThemeArr[$(this).attr('id')] = $(this).val();
							
							var value = $(this).val();
							var txtBoxArr = $('input[name="domainDisplayName"]');
							var cnt = 0;
							$('input[name="domainDisplayName"]').each(function(){
								
								if($(this).val()==value)
									cnt++;
									
							});
							if(cnt>1)
							alert("Theme Name Already Define Please Change Another Name ");
							
								
							
						});
						
			});
			
	function chksub(){
		var value = $('input[id*="domainDisplayName_"]').val();
							var txtBoxArr = $('input[name="domainDisplayName"]');
							var cnt = 0;
		$('input[id*="domainDisplayName_"]').each(function(){
			if($(this).val()==value)
									cnt++;
			
		});
		if(cnt>1){
							alert("Theme Name Already Define Please Change Another Name ");
							return false;
							}else{
									return true;
									}
									
								}
			//var divId = '#' + $(this).attr('id').replace(
				//					'domainDisplayName_',
					//				'domainDisplayNameDiv_');
						//	var preVal = gameThemeArr[$(this).attr('id')];
							//alert(preVal.val());
				
							
							
		
    		
	

</script>
	</head>

	<body>
		<div class="FormSection">
			<s:if test="%{gameThemeMap!=null && gameThemeMap.size()>0}">
				<div class="greyStrip">
					<h4>
						Game Theme list
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox1">

						<table id="masterTable" width="100%">
							<tr id="firstRow">

								<td class="rowhandler" valign="top"
									style="padding-top: 5px; width: 65%;">
									<div id="leftDomainGamePanel">
										<s:form id="gameListFrm" action="st_pms_bo_saveGameTheme"
											cssClass="ajaxFrm" theme="simple" onsubmit="return chksub();">
											<s:hidden name="domainId" value="%{domainId}" />
											<s:hidden name="gameGroupType" value="%{gameGroupType}"/>
											<div id="accordion" class="UIaccordian">

												<s:iterator value="gameThemeMap" status="gameKey">
													<div id="tabs-<s:property value="key"/>">
														<div class="accordianHeader" style="width: 98%">
															<h3 style="width: 98%">
																<s:property value="key" />
															</h3>
															<input type="hidden"  value="<s:property value="%{#gameKey.index+1}"/>_<s:property value="%{key}"/>"  name="themeNameOrder"/>
														</div>

														<div
															style="width: 96%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
															<!--<input type="checkbox"
																value="<s:property value="%{key}" />" class="chkAll"  id="chkAll" />
															<font
																style="font-weight: bold; color: #828282; line-height: 30px">
																Select All </font>
															-->
															<fieldset>
																<legend>
																	<s:textfield name="domainDisplayName"
																		id="domainDisplayName_%{value.get(0).themeName}"
																		theme="simple" size="10"
																		value="%{value.get(0).themeName}" />
																</legend>
																<div class="sortable"  style="cursor: pointer;"
																	id="domainDisplayNameDiv_<s:property value="%{value.get(0).themeName}"/>" >
																	<input name="selectAll" id="selectAll_<s:property value="key"/>" type="checkbox" value="Select All" class="checkall" >
																	<font style="font-weight: bold; color: #828282; line-height: 30px">Select All</font>
																	<s:iterator value="value" status="divPriv">
																		<div class="small-text-box-section">
																			<div class="div-1">
																				<div class="small-text-box-div">
																					
																					<s:if test="%{status=='ACTIVE'}">
																						<input name="selectDomainGame" type="checkbox"
																							checked="checked"
																							id="<s:property value="%{gameName}"/>_<s:property value="%{gameId}"/>"
																							value="<s:property value="%{themeName+'_'+themeId+'_'+gameId}"/>" />
																						<font
																							style="font-weight: bold; color: #828282; line-height: 30px">
																							<s:property value="%{gameName}" /> </font>
																						<s:property value="%{gameType}" />
																					</s:if>
																					<s:else>
																						<input name="selectDomainGame" type="checkbox"
																							id="<s:property value="%{gameName}"/>_<s:property value="%{gameId}"/>"
																							value="<s:property value="%{themeName+'_'+themeId+'_'+gameId}"/>" />
																						<font
																							style="font-weight: bold; color: #828282; line-height: 30px">
																							<s:property value="%{gameName}" /> </font>
																						<s:property value="%{gameType}" />

																					</s:else>
																				</div>
																			</div>
																		</div>
																	</s:iterator>
																</div>
															</fieldset>
														</div>
													</div>
												</s:iterator>
											</div>

											<div class="box_footer" align="right">
												<s:submit name="Submit" value="Submit" cssClass="button" ></s:submit>
											</div>
										</s:form>
									</div>
								</td>

								<td style="width: 35%; height: auto;" valign="top">
									<div id="rigthDomainGamePanel">
										<div
											style="margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid; margin-left: 100px;">
											<h2>
												Game List
											</h2>
											<s:iterator value="boVendorGameList">
												<div class="small-text-box-section">
													<div class="div-1">
														<div class="small-text-box-div">
															<input name="selectDomainGame" type="checkbox"
																disabled="disabled"
																id="<s:property value="%{gameName}"/>"
																value="<s:property value="%{gameId}"/>" />
															<font
																style="font-weight: bold; color: #828282; line-height: 30px">
																<s:property value="%{gameName}" /> </font>
														</div>
													</div>
												</div>
											</s:iterator>
										</div>
									</div>
								</td>

							</tr>
						</table>
					</div>
				</div>
			</s:if>
			<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
		</div>

	</body>
</html>
