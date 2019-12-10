<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>VIP Level Setup</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/colorpicker.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/listnav.css" rel="stylesheet" type="text/css" />
		
		<script src="<%=path%>/js/jQuery/colorpicker.min.js" type="text/javascript" ></script>
		<script src="<%=path%>/js/jQuery/jquery.listnav.min-2.1.js" type="text/javascript" ></script>
		<script src="<%=path%>/com/stpl/pms/action/bo/misc/vipLevel/js/vipMgmt.js" type="text/javascript" ></script>
		
		<script type="text/javascript" >
			$(document).ready(function() {
				$('#domainId').change(function() {
					$('#vipSearchResult').html('');
					createBubble();
				});
				$('#levelType').change(function() {
					$('#vipSearchResult').html('');
					createBubble();
				});
				$('#vipGroup').change(function() {
					$('#vipSearchResult').html('');
					createBubble();
				});
				
				$('input[id*="vipLevelBtn_"]').click(function(e){
					var action = 'com/stpl/pms/action/bo/misc/'+$(this).attr('action');
					$('#searchVipFrm').attr('action',action);
					if($(this).attr('id') == 'vipLevelBtn_add'){
						$('#searchVipFrm').attr('callBack','onReadyVip()');
					}
				});
			});
		</script>
	</head>
	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>VIP Level Search </h4>
			</div>
					
			<s:form id="searchVipFrm" theme="simple" target="vipSearchResult" method="post" >
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
									name="vipMaster.domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select theme="simple" cssClass="select1" list="%{domainMap}"
									name="vipMaster.domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true"></ss:select>
							</s:else>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Level Type:
							</label>
						</div>
						<div class="InputDiv">
							<ss:select theme="simple" cssClass="select1"
								list="#{'AUTO':'Auto','MANUAL':'Manual'}"
								name="vipMaster.levelType" id="levelType" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Group:
							</label>
						</div>
						<div class="InputDiv">
							<ss:select theme="simple" cssClass="select1"
								list="#{'ALL':'--All Group--','BRONZE':'Bronze','SILVER':'Silver','GOLD':'Gold','PLATINUM':'Platinum','DIAMOND':'Diamond'}"
								name="vipMaster.vipGroup" id="vipGroup" applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
				</div>
				<div class="box_footer" align="right">
					<input type="submit"   id="vipLevelBtn_search" value="Search"  action="st_pms_misc_searchVipLevel.action" />
					<input type="submit"  id="vipLevelBtn_add" value="Add VIP Level" action="st_pms_misc_addVipLevel.action" />
				</div>
			</s:form>
		</div>
		<div class="clear2"></div>
		<div id="vipSearchResult" >

		</div>
	</body>
</html>
