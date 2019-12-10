<%@ taglib uri="/struts-tags" prefix="s" %>
<link href="<%=request.getContextPath()%>/css/multiselect/chosen.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/multiselect/chosen.jquery.js" type="text/javascript" ></script>
<script >
	$(function(){
		$(".boListSelect").chosen({
			no_results_text:"Oops, nothing found!"
		}).change(function(){
				var result =_ajaxCallText("<%=request.getContextPath()%>/com/stpl/pms/action/bo/um/trigger_bo_impersonation.action","impersonateeId="+$("#impersonateeList").val());
				if(result==="done"){
					document.location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()%>"+"/com/stpl/pms/action/bo/lm/bo_home_page.action?serviceName=MGMT";
				}else
					alert("impersonation failed!");
			});
	});
</script>
<p style=" margin-top: 4px;margin-bottom: 7px;">Select bo user to initiate:</p>
<s:select id="impersonateeList" headerKey="-1" headerValue="Select User" list="boUserMap" cssClass="boListSelect" listKey="key" listValue="value"></s:select>
