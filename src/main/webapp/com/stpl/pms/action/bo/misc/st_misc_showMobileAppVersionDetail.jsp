<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
	<head>
	<base href="<%=basePath%>">
	<title>Mobile App Details</title>
	<script type="text/javascript">
	var control = {};
	control.modal=function(message,type){
		var type = type||"info";
		$.facebox(" <div class='FormSection'>"+
		"<div class='greyStrip'>"+
		"<h4>"+"Message"+"</h4>"+
		"</div>"+
			"<div class='innerBox'>"
				+"<div class='alert info_msg' style='width: auto'>"
					+"<span class='alert_close'></span><strong>"+type+": </strong>"+
						message
				+"</div>"
			+"</div>"
			+"<button onclick='$.facebox.close()'>close</button>"
		+"</div>"
		);
	};

	$(document).ready(function() { 
		$('#domainId').change(function() {
			var domainId = $(this).val();
			if(domainId!="-1"){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("--Please Select--"));
				var jsonList = '["aliasList"]';
				var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
				$.each(map["aliasList"], function(index, value) {
					$('#aliasId').append($('<option></option>').val(value.aliasId).html(value.aliasName));
				});
			}
			$("#appVerHistory").empty();
			$("#os").val(-1);
			$("#aliasId").val(-1);
			$("table[id*=bubbleTable]").hide();
		});
		
		$("#aliasId").change(function (){
			$("#os").val(-1);
			$("#appVerHistory").empty();
			$("table[id*=bubbleTable]").hide();
		});
		
		$("#os").change(function() {
			if (this.value == "-1"){
				$("table[id*=bubbleTable]").hide();
				$("#appVerHistory").empty();
			}					
		});
		
		$("#searchApps").submit(function(){
			var domainId = $('#domainId').val();
			var aliasId = $('#aliasId').val();
			var os = $('#os').val();
			if (domainId !== "-1" && aliasId !== "-1" && os !== "-1")
				_ajaxCallDiv(
						'com/stpl/pms/action/bo/misc/bo_mis_mobile_fetchAppList.action',
						"domainId=" + domainId + "&aliasId=" + aliasId + "&os="
								+ os, 'appVerHistory');
			return false;				
		});
	});
	</script>
	<link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
			type="text/css" />
	<script src="js/facebox.js" type="text/javascript"></script>
	</head>
	<body>
	<div class="clear2"></div>
	<h2>Mobile App Version Update</h2>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Mobile App Version Search</h4>
		</div>
		<s:form theme="simple" name="rootCritForm" id="searchApps">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" list="%{domainMap}"
							applyscript="true" name="domainId" id="domainId" headerKey="-1"
							headerValue="--Please Select--" listKey="%{key}"
							listValue="%{value}"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" list="#{}"
							name="aliasId" applyscript="true" id="aliasId" headerKey="-1"
							headerValue="--Please Select--"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> OS: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1"
							list="#{'Android':'Android','IOS':'IOS'}" name="os" id="os"
							headerKey="-1" headerValue="--Please Select--" applyscript="true"></s:select>
					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
					<s:submit id="serachSubmit" name="serachSubmit" value="search" theme="simple"
						cssClass="button"></s:submit>
				</div>
		</s:form>
	</div>
	<div class="clear2"></div>
	<div id="appVerHistory" style="margin-bottom: 50px;"></div>
	<div class="clear2"></div>
</body>
</html>