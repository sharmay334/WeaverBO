<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
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
	$(document).ready(function() {

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

		$('.chkAll').change(function() {
			if ($(this).attr('checked')) {
				$('[id*=' + $(this).val() + '_]').attr('checked', true);
			} else {
				$('[id*=' + $(this).val() + '_]').attr('checked', false);
			}
		});
	});
</script>
	</head>

	<body>
		<div class="FormSection">
			<s:if test="%{vendorGameMap!=null && vendorGameMap.size()>0}">
				<div class="greyStrip">
					<h4>
						Vendor Games
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox1">

						<s:form id="gameListFrm" action="st_pms_bo_saveDomainGame"
							cssClass="ajaxFrm" theme="simple">
							<s:hidden name="domainId" value="%{domainId}" />
							<div id="accordion" class="UIaccordian">

								<s:iterator value="vendorGameMap">
									<div id="tabs-<s:property value="key"/>" style="width: 98%">
										<div class="accordianHeader" style="width: 98%;">
											<h3>
												<s:property value="key" />
											</h3>
										</div>
										<div
											style="width: 96%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
											<input type="checkbox" value="<s:property value="%{key}" />"
												class="chkAll" />
											<font
												style="font-weight: bold; color: #828282; line-height: 30px">
												Select All </font>
											<s:iterator value="value" status="divPriv">
												<div class="small-text-box-section">
													<div class="div-1">
														<div class="small-text-box-div">
															<s:if test="%{status=='ACTIVE'}">
																<input name="selectDomainGame" type="checkbox"
																	checked="checked"
																	id="<s:property value="%{key}"/>_<s:property value="%{gameId}"/>"
																	value="<s:property value="%{gameId}"/>" />
																<font
																	style="font-weight: bold; color: #828282; line-height: 30px">
																	<s:property value="%{gameName}" /> </font>
															</s:if>
															<s:else>
																<input name="selectDomainGame" type="checkbox"
																	id="<s:property value="%{key}"/>_<s:property value="%{gameId}"/>"
																	value="<s:property value="%{gameId}"/>" />
																<font
																	style="font-weight: bold; color: #828282; line-height: 30px">
																	<s:property value="%{gameName}" /> </font>
																	
															</s:else>
															<s:property value="%{gameGroupName}"/>
															<s:property value="%{gameType}" />
															<s:property value="%{gamePrice}" />
														</div>
													</div>
												</div>
											</s:iterator>
										</div>
									</div>
								</s:iterator>
							</div>

							<div class="box_footer" align="right">
								<s:submit name="Submit" value="Submit" cssClass="button"></s:submit>
							</div>
						</s:form>
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
