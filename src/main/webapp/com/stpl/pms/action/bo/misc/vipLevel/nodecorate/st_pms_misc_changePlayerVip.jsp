<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Change Vip Level</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
		<SCRIPT type="text/javascript">
			$(document).ready(function(){
				$('#playerIdArr').chosen('{}');
				
				$('#submitvip').click(function(){
					if($('#changePlrVipLevel').val()== '-1'){
							alert("Please select vip level.");	
							return false;				
						}
					if($('#playerIdArr').val()==null){
						alert("Please select atleast one player.");	
						return false;				
					}
					
				});
			});
		</SCRIPT>
	</head>

	<body>
		<div class="clear2"></div>
			<s:form id="changeVipFrm" action="st_pms_misc_changePlayerVip_save" theme="simple">
		    <s:token name="strutsToken" id="strutsToken" theme="simple"></s:token>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Change Vip Level
						</h4>
					</div>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Vip Level
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select theme="simple" cssClass="select1" list="%{vipLevelList}"
									 id="changePlrVipLevel" headerKey="-1" name="vipLevel"
									headerValue="--Please Select--" listKey="%{vipLevel}"
									listValue="%{vipCode}" ></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Player
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1" list="%{playerMap}"
									multiple="true" data-placeholder="Select Player Here"
									name="playerIdArr" id="playerIdArr" ></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
					</div>
					<div class="box_footer" align="right">
						<s:submit name="vipChangeAction"  value="Set Manual" id="submitvip"></s:submit>
						<s:submit name="vipChangeAction" value="Reset First VIP" id="changeAutoVip"></s:submit>
						<s:submit name="vipChangeAction" value="Reset Last VIP" id="changeOldVip"></s:submit>
					</div>
					</div>
			</s:form>
	</body>
</html>
